Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280149AbRKIVbZ>; Fri, 9 Nov 2001 16:31:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280154AbRKIVbF>; Fri, 9 Nov 2001 16:31:05 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:11281 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S280149AbRKIVax>; Fri, 9 Nov 2001 16:30:53 -0500
Date: Fri, 9 Nov 2001 22:30:53 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Riley Williams <rhw@MemAlpha.cx>
Cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: PROBLEM: Linux updates RTC secretly when clock synchronizes
Message-ID: <20011109223053.A964@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20011109103254.B2620@atrey.karlin.mff.cuni.cz> <Pine.LNX.4.21.0111092102510.14996-100000@Consulate.UFP.CX>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.21.0111092102510.14996-100000@Consulate.UFP.CX>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >> According to your comments, you prefer (2).
> >>
> >> I most definitely prefer (1).
> 
> > Hmm, and if some malicious software insmods kernel module to work
> > around your printk()?
> 
> ...it gets "Port busy" when it tries to access the RTC ports that the
> RTC driver built into the kernel already has opened exclusively. At
> least, that's my understanding of the situation at present.

It does not work that way. Userland does iopl(0), and then it just
bangs any port it wants to.

> > We are talking root only here.
> 
> Are we?
> 
> Unless I've misunderstood the arguments so far, the aim is to take the
> RTC driver out of the kernel altogether and replace it with a usermode
> driver to do the same thing. As I see it, that opens up far too many

No. Aim is to leave /dev/rtc in kernel, but make kernel never write to
RTC at its own will.
								Pavel
-- 
Casualities in World Trade Center: 6453 dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.
