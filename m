Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279684AbRKIJdq>; Fri, 9 Nov 2001 04:33:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279739AbRKIJdh>; Fri, 9 Nov 2001 04:33:37 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:33032 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S279684AbRKIJdW>; Fri, 9 Nov 2001 04:33:22 -0500
Date: Fri, 9 Nov 2001 10:32:54 +0100
From: Pavel Machek <pavel@suse.cz>
To: Riley Williams <rhw@memalpha.cx>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: PROBLEM: Linux updates RTC secretly when clock synchronizes
Message-ID: <20011109103254.B2620@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20011108132639.A14160@atrey.karlin.mff.cuni.cz> <Pine.LNX.4.21.0111082252500.14996-100000@Consulate.UFP.CX>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.21.0111082252500.14996-100000@Consulate.UFP.CX>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >>>> least as KERN_DEBUG if not as KERN_NOTICE) whenever the RTC is
> >>>> written to. It's too important a subsystem to be left hidden like
> >>>> it currently is.
> 
> >>> This can be as well done in userland, enforced by whoever does rtc
> >>> writes, no?
> 
> >> If some idiot writes a hwclock replacement that doesn't do logging...
> 
> > Then it is *his* problem. That's no excuse for putting it into kernel.
> 
> So you believe viruses are a good thing to have? Sorry, I have to
> disagree with you.


> Take the position of a sysadmin who can't understand why the system
> clock on his computer keeps getting randomly changed under Linux, and
> has verified using another operating system that it isn't a hardware
> problem, then ask yourself what said sysadmin would expect from the
> kernel to help him/her track the problem down. Would said sysadmin
> prefer to be told...
> 
>  1. "Look in the system log - you'll get a message every time any
>     program writes to the RTC."
> 
>  2. "Sorry, you'll have to go through every piece of software on
>     your system and find the one that's updating the system clock
>     that shouldn't be."
> 
> According to your comments, you prefer (2). I most definitely prefer
> (1).


Hmm, and if some malicious software insmods kernel module to work
around your printk()?

We are talking root only here. If sofware with uid 0 is malicious, you
have big problems.
								Pavel
-- 
Casualities in World Trade Center: 6453 dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.
