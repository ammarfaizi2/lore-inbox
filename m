Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278911AbRKFKSP>; Tue, 6 Nov 2001 05:18:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278722AbRKFKSF>; Tue, 6 Nov 2001 05:18:05 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:44042 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S278890AbRKFKRy>; Tue, 6 Nov 2001 05:17:54 -0500
Date: Tue, 6 Nov 2001 11:17:23 +0100
From: Pavel Machek <pavel@suse.cz>
To: Riley Williams <rhw@MemAlpha.cx>
Cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: PROBLEM: Linux updates RTC secretly when clock synchronizes
Message-ID: <20011106111723.C26034@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20011102121602.A45@toy.ucw.cz> <Pine.LNX.4.21.0111052300490.1693-100000@Consulate.UFP.CX>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.21.0111052300490.1693-100000@Consulate.UFP.CX>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > That seems as very wrong solution.
> 
> > What about just making kernel only _read_ system clock, and never
> > set it? That looks way cleaner to me.
> 
> It is cleaner. However, I feel that the RTC code should printk (at least
> as KERN_DEBUG if not as KERN_NOTICE) whenever the RTC is written to.
> It's too important a subsystem to be left hidden like it currently is.

This can be as well done in userland, enforced by whoever does rtc
writes, no?

[I poropose kernel not to do any writes, so it is only userland
left. And having printk() in kernel or syslog() in hwclock seems
pretty much equivalent, with later prefered as it magically works on
older kernels.]

-- 
Casualities in World Trade Center: 6453 dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.
