Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280714AbRKJUnq>; Sat, 10 Nov 2001 15:43:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280717AbRKJUng>; Sat, 10 Nov 2001 15:43:36 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:59152 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S280714AbRKJUnV>; Sat, 10 Nov 2001 15:43:21 -0500
Date: Sat, 10 Nov 2001 21:43:21 +0100
From: Pavel Machek <pavel@suse.cz>
To: Riley Williams <rhw@MemAlpha.cx>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: PROBLEM: Linux updates RTC secretly when clock synchronizes
Message-ID: <20011110214321.G19664@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20011110210441.B19664@atrey.karlin.mff.cuni.cz> <Pine.LNX.4.21.0111102030150.12260-100000@Consulate.UFP.CX>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.21.0111102030150.12260-100000@Consulate.UFP.CX>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >> Just out of curiosity, what is wrong with the idea of having the
> >> kernel at iopl(0), any kernel modules at either iopl(1) or iopl(2)
> >> and apps at iopl(3) ??? There is obviously something, but I've no
> >> idea what.
> 
> > It ... just is not that way. Kernel + modules run at ring 0,
> > userland at ring 3.
> 
> I know that much. I was just curious whether there was any particular
> reason why it was that way.
> 
> Somebody suggested that it was because of "scheduling hooplas" causing a
> serious loss of performance if modules were moved to ring 1. I've no
> idea whether such is the case

Yep, it would be slower that way, and it would be nightmare to implement.

> >>> No. Aim is to leave /dev/rtc in kernel, but make kernel never write
> >>> to RTC at its own will.
> 
> >> I've no problem with that at all, but the bulk of the comments I've
> >> seen in this thread have been very clear about taking /dev/rtc out
> >> of the kernel and into a userspace daemon, with the kernel just
> >> providing access to the relevant ports to the first app to claim
> >> them.
> 
> > I do not think so.
> > 
> > The person who tries to kill /dev/rtc from kernel is going to have
> > some problems with me.
> 
> They've been getting problems from me - I just checked, and the main
> suggestion appears to be to replace /dev/rtc with a sysctl call. I can't
> see the point in that myself, and /dev/rtc makes far more sense to me.
> 
> I will add that I personally see no problem with the kernel reading RTC
> on boot to set the syste clock, although some of the correspondents
> appear to have problems with that idea as well.

So we agree with each other. Good.

								Pavel
-- 
Casualities in World Trade Center: 6453 dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.
