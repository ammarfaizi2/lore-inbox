Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266286AbTAIMn6>; Thu, 9 Jan 2003 07:43:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266363AbTAIMn6>; Thu, 9 Jan 2003 07:43:58 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:20715 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S266286AbTAIMnr>;
	Thu, 9 Jan 2003 07:43:47 -0500
Date: Thu, 9 Jan 2003 12:50:07 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Bill Davidsen <davidsen@tmr.com>
Cc: Robert Love <rml@tech9.net>, Adrian Bunk <bunk@fs.tum.de>,
       "Robert P. J. Day" <rpjday@mindspring.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: observations on 2.5 config screens
Message-ID: <20030109125007.GA17045@codemonkey.org.uk>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Bill Davidsen <davidsen@tmr.com>, Robert Love <rml@tech9.net>,
	Adrian Bunk <bunk@fs.tum.de>,
	"Robert P. J. Day" <rpjday@mindspring.com>,
	Linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <20030108195000.GA670@codemonkey.org.uk> <Pine.LNX.3.96.1030108164157.23971A-100000@gatekeeper.tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.3.96.1030108164157.23971A-100000@gatekeeper.tmr.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 08, 2003 at 05:49:54PM -0500, Bill Davidsen wrote:

 > > No-one other than kernel hackers should be playing with that option,
 > > hence it's in the kernel hacking menu.
 >   Anyone who wants to be able to debug a problem should be playing with
 > that

If someone is debugging a kernel, they are by definition, kernel
hacking. They should know where the kernel hacking menu is.

 > > SMP isn't a processor option ?
 >   Clearly not, it's not processor dependent or even architecture dependent

Of course its arch dependant. Some of the archs we support don't do SMP.
See m68k for one. Sure there may be some boards out there with >1 68k
welded to them, but Linux doesn't run on them.

 > generally. It's a characteristic of the os, unlike microcode, mtrr, and
 > other stuff not on some architectures.

Absolute nonsense. These are _cpu_ features. If you dispute this,
you have no understanding of what you talking about.

 > You can select it for 386/486/P5
 > (and it works in 2.4 at least, for P5, have several).

And thats perfectly valid. Although I've not seen an MP compliant
386/486 personally, there were patches I beleive at one time for
some of the strange 486 implementations.

It's also a valid thing to do to do for code coverage reasons.
Although I doubt anyones testing SMP builds on a 386/486 any more.

 >   I would think that processor options would select the processor and any
 > options which are specific to it rather than generally supported. Serial
 > numbers, firmware loads, that sort of feature.

serial number stuff is done at run time. Firmware loads. Well, you
mentioned above that microcode wasn't a CPU feature, now you change
your mind ?

 >   Preempt and smp, are general, I guess not supported on every possible
 > hardware
 
Again, more contradiction. Above you said of SMP:
"Clearly not, it's not processor dependent or even architecture dependent"
Now you're saying it is arch dependant.

Which Bill am I arguing with here ?

>From x86 POV, a preemptive SMP 386 kernel should boot.
Its the only way to guarantee that you get both features in a kernel
that will run on anything from 386 up.


		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
