Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262082AbUKVMYn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262082AbUKVMYn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 07:24:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262078AbUKVMWr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 07:22:47 -0500
Received: from out007pub.verizon.net ([206.46.170.107]:54211 "EHLO
	out007.verizon.net") by vger.kernel.org with ESMTP id S262067AbUKVMV2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 07:21:28 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: linux-kernel@vger.kernel.org
Subject: Re: Stupid question
Date: Mon, 22 Nov 2004 07:21:26 -0500
User-Agent: KMail/1.7
References: <200411212045.51606.gene.heskett@verizon.net> <Pine.LNX.4.53.0411220932370.12534@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.53.0411220932370.12534@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200411220721.26712.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out007.verizon.net from [151.205.10.220] at Mon, 22 Nov 2004 06:21:27 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 22 November 2004 03:33, Jan Engelhardt wrote:
>>Greetings;
>>
>>Silly Q of the day probably, but what do I set in a Makefile for
>> the -march=option for building on a 233 mhz Pentium 2?
>
>Now that's really stupid, but here's the answer:
>
>You run `make menuconfig` (or whichever you like) and choose
> Processor Type "Pentium II".
>
>
>Jan Engelhardt

If I was building a kernel, then yes my question was stupid.

Except I'm not building a kernel, I'm tryng to compile a module to 
drive some truely dumb hardware, reusing code that was last touched 
in 1999 when the Makefile could use the -mi486 syntax with gcc-2.95.  
Now we have gcc 3.3.3, even on a Brain Dead Install of emc 
(LinuxCNC), which has a 2.4 kernel with the rtai patch kit for real 
time.  I need to put this directly into the Makefile using the 
currently valid  -march= & -mcpu= syntax's.

So far, the closest I've come to getting it right on that box bails 
out because its being mis-interpreted as -march=mips on that box.  
Those includes aren't part of an x86 install.  Hence the 
question. :-)

It appears I've got more problems that this one though, lots of "hey 
you can't do that anymore" warnings when I try to build it on this 
box (bleeding edge kernel 2.6.10-rc2-bk4-kjt1 etc) and it eventually 
bails out or course.  It apparently plays mix-n-match with kernel vs 
glibc headers too.  As a loadable module, I'd assume it should be 
using kernel headers only?

Yeah, I'm stupid.  Virtually all of my original C coding has been done 
on much smaller architectures, and 15 to 20 years ago.  Terminal rust 
has set in on those skills I once had well honed when I was only 55.  
Now I'm 70, semi-retired, and I'd like to drive some stepper motors 
on a micromill.

While composing this, I also read the man page for gcc and while it 
has a bunch of options, it doesn't always list/define the valid ones, 
particularly for x86 stuffs.  Lots of other architectures are covered 
in much better detail. I guess they figure everyone knows x86 stuff.

Sadly, for those of us who came up thru the motorola ranks, such is 
not the case.  Heck, I'd do this in assembly IF I knew intel asm as 
well as I know 6x09 asm.

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.29% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.
