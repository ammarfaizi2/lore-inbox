Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261240AbTIKPJl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 11:09:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261291AbTIKPJl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 11:09:41 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:2829 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261240AbTIKPJd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 11:09:33 -0400
Date: Thu, 11 Sep 2003 16:09:29 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Jamie Lokier <jamie@shareable.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Virtual alias cache coherency results (was: x86, ARM, PARISC, PPC, MIPS and Sparc folks please run this)
Message-ID: <20030911160929.A19449@flint.arm.linux.org.uk>
Mail-Followup-To: Jamie Lokier <jamie@shareable.org>,
	linux-kernel@vger.kernel.org
References: <20030910210416.GA24258@mail.jlokier.co.uk> <20030910233951.Q30046@flint.arm.linux.org.uk> <20030910233720.GA25756@mail.jlokier.co.uk> <20030911010702.W30046@flint.arm.linux.org.uk> <20030911123535.GB28180@mail.jlokier.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030911123535.GB28180@mail.jlokier.co.uk>; from jamie@shareable.org on Thu, Sep 11, 2003 at 01:35:35PM +0100
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 11, 2003 at 01:35:35PM +0100, Jamie Lokier wrote:
> Russell King wrote:
> > > Does your fix, which makes pages uncacheable andq disables write
> > > combining (correct?) only fix your test results which intermittently
> > > reported write buffer problems, or does it fix _all_ the ARM test
> > > results I received, including those which don't report write buffer
> > > problems?
> > 
> > It's relatively simple, and I'm not sure why its causing such
> > misunderstanding.  Let me try one more time:
> > 
> > ARM caches are VIVT.  VIVT caches have inherent aliasing issues.  The
> > kernel works around these issues by marking memory uncacheable where
> > appropriate, and will continue to do so for VIVT cached ARM CPUs.
> 
> That I understand fully.

I don't think you do.

> My question arises because I have 3 SA-110 results which report "cache
> not coherent".  They do not report "store buffer not coherent".  All 3
> are Rebel Netwinders, of different bogomips ratings.
> 
> The point is: those results _don't_ indicate write buffer problems.

Maybe those StrongARM chips don't exhibit the write buffer bug?  Remember,
I said _SOME_ StrongARM-110 chips exhibit the problem.  I did not say
_ALL_ StrongARM-110 chips exhibit the problem.

> It means that your VIVT explanation and workaround does not explain
> those results, so I cannot have confidence that your workaround fixes
> those particular ARM devices.

Well, as far as I'm concerned, I completely believe that I have explained
it entirely, and I still don't know why you're trying to make this more
difficult than it factually is.

> Now, if you can assure me that those results are _definitely_ due to
> using very old kernels which don't even mark pages uncacheable, and
> with newer kernels those Netwinders would exhibit coherent virtual
> aliases, that's great.

Well, once you collect the kernel information and forward it to me, I
can have a look.

-- 
Russell King (rmk@arm.linux.org.uk)	http://www.arm.linux.org.uk/personal/
Linux kernel maintainer of:
  2.6 ARM Linux   - http://www.arm.linux.org.uk/
  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
  2.6 Serial core
