Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261384AbTIKQxJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 12:53:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261397AbTIKQxJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 12:53:09 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:34063 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261384AbTIKQw2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 12:52:28 -0400
Date: Thu, 11 Sep 2003 17:52:24 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Jamie Lokier <jamie@shareable.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Virtual alias cache coherency results (was: x86, ARM, PARISC, PPC, MIPS and Sparc folks please run this)
Message-ID: <20030911175224.A20308@flint.arm.linux.org.uk>
Mail-Followup-To: Jamie Lokier <jamie@shareable.org>,
	linux-kernel@vger.kernel.org
References: <20030910210416.GA24258@mail.jlokier.co.uk> <20030910233951.Q30046@flint.arm.linux.org.uk> <20030910233720.GA25756@mail.jlokier.co.uk> <20030911010702.W30046@flint.arm.linux.org.uk> <20030911123535.GB28180@mail.jlokier.co.uk> <20030911160929.A19449@flint.arm.linux.org.uk> <20030911162510.GA29532@mail.jlokier.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030911162510.GA29532@mail.jlokier.co.uk>; from jamie@shareable.org on Thu, Sep 11, 2003 at 05:25:10PM +0100
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 11, 2003 at 05:25:10PM +0100, Jamie Lokier wrote:
> Russell King wrote:
> > Maybe those StrongARM chips don't exhibit the write buffer bug?  Remember,
> > I said _SOME_ StrongARM-110 chips exhibit the problem.  I did not say
> > _ALL_ StrongARM-110 chips exhibit the problem.
> 
> I never assumed they all have the bug.  Credit me with at least
> reading what you wrote before! :)
> 
> The results indicate some StrongARM-110 systems which _don't_ exhibit
> the write buffer bug _do_ exhibit some _other_ cause of non-coherence.

Sigh.  Let me re-state one more time.  If you don't get it this time
around, I can't help you to understand, and I ask that you drop all
information concerning ARM from your document in case you mislead other
parties who may think you're stating definitive information.

It would appear that you've completely forgotten about my previous
statements:

| ARM caches are VIVT.  VIVT caches have inherent aliasing issues.  The
| kernel works around these issues by marking memory uncacheable where
| appropriate, and will continue to do so for VIVT cached ARM CPUs.

On 1st September, I wrote:
| This looks like an old kernel on your NetWinder.  Later 2.4 kernels
| should get this right (by marking the pages uncacheable in user space.)

So this says that there _are_ old kernels which didn't do any fixup
_and_ I pointed out that you were receiving reports from such kernels.

> ...until we learn what kernel versions the Netwinder folks are
> running, or they kindly run the test on a new kernel.

Absolutely - so what _you_ need to do now is to go off to each person
who responded (only _you_ have those details and therefore only _you_
can do this) and _ask_ them the question.

Now, lets rewind back to the original mail.  You said:

|>    CPUs with incoherent write buffers: PA-RISC 2.0, 68040 and ARMs.

I still claim this is an inaccurate summary, and is misleading - this
says "All ARMs have incoherent write buffers" which is many times removed
from reality.

Continuing:

|>    SHMLBA not valid:           ARM, m68k
|> On the ARM this is
|> believed to be due to a chip bug, and very recent kernels may contain
|> a workaround for it (disabling the write buffer for aliased pages).

I still claim this description is wrong.  You are claiming that all ARMs
contain this bug and the kernel needs to work around it for all ARMs.
This is clearly not the case.  In addition, the fact that a previously
undiscovered bug exists does not determine whether SHMLBA is valid or
not.  The fact that SHMLBA _must_ be defined (it is not optional) _and_
there exists _no_ value for SHMLBA on the buggy _StrongARM_s does not
mean it is invalid as you are claiming.

-- 
Russell King (rmk@arm.linux.org.uk)	http://www.arm.linux.org.uk/personal/
Linux kernel maintainer of:
  2.6 ARM Linux   - http://www.arm.linux.org.uk/
  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
  2.6 Serial core
