Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280690AbRKJUFP>; Sat, 10 Nov 2001 15:05:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280696AbRKJUFF>; Sat, 10 Nov 2001 15:05:05 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:7440 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S280690AbRKJUEx>; Sat, 10 Nov 2001 15:04:53 -0500
Date: Sat, 10 Nov 2001 21:04:41 +0100
From: Pavel Machek <pavel@suse.cz>
To: Riley Williams <rhw@MemAlpha.cx>
Cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: PROBLEM: Linux updates RTC secretly when clock synchronizes
Message-ID: <20011110210441.B19664@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20011109223053.A964@atrey.karlin.mff.cuni.cz> <Pine.LNX.4.21.0111092247070.14996-100000@Consulate.UFP.CX>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.21.0111092247070.14996-100000@Consulate.UFP.CX>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >> ...it gets "Port busy" when it tries to access the RTC ports that the
> >> RTC driver built into the kernel already has opened exclusively. At
> >> least, that's my understanding of the situation at present.
> 
> > It does not work that way. Userland does iopl(0), and then it just
					     ~~~~~~~
					sorry, this was meant
					to be iopl(3).
> > bangs any port it wants to.
> 
> If any user can do that, then Linux is borken solid.

Only root can do that.

> Just out of curiosity, what is wrong with the idea of having the kernel
> at iopl(0), any kernel modules at either iopl(1) or iopl(2) and apps at
> iopl(3) ??? There is obviously something, but I've no idea what.

It ... just is not that way. Kernel + modules run at ring 0, userland
at ring 3.

> >>> We are talking root only here.
> 
> >> Are we?
> >> 
> >> Unless I've misunderstood the arguments so far, the aim is to take
> >> the RTC driver out of the kernel altogether and replace it with a
> >> usermode driver to do the same thing. As I see it, that opens up far
> >> too many
> 
> > No. Aim is to leave /dev/rtc in kernel, but make kernel never write
> > to RTC at its own will.
> 
> I've no problem with that at all, but the bulk of the comments I've seen
> in this thread have been very clear about taking /dev/rtc out of the
> kernel and into a userspace daemon, with the kernel just providing
> access to the relevant ports to the first app to claim them.

I do not think so.

The person who tries to kill /dev/rtc from kernel is going to have
some problems with me.
								Pavel
-- 
Casualities in World Trade Center: 6453 dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.
