Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270373AbRHNEVx>; Tue, 14 Aug 2001 00:21:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270406AbRHNEVm>; Tue, 14 Aug 2001 00:21:42 -0400
Received: from toscano.org ([64.50.191.142]:44500 "HELO bubba.toscano.org")
	by vger.kernel.org with SMTP id <S270295AbRHNEVX>;
	Tue, 14 Aug 2001 00:21:23 -0400
Date: Tue, 14 Aug 2001 00:21:31 -0400
From: Pete Toscano <pete.lkml@toscano.org>
To: Francois Romieu <romieu@cogenit.fr>
Cc: PinkFreud <pf-kernel@mirkwood.net>, linux-kernel@vger.kernel.org
Subject: Re: Are we going too fast?
Message-ID: <20010814002131.A26321@bubba.toscano.org>
Mail-Followup-To: Pete Toscano <pete.lkml@toscano.org>,
	Francois Romieu <romieu@cogenit.fr>,
	PinkFreud <pf-kernel@mirkwood.net>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.20.0108130303120.1037-100000@eriador.mirkwood.net> <20010813105554.A8387@se1.cogenit.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010813105554.A8387@se1.cogenit.fr>
User-Agent: Mutt/1.3.20i
X-Unexpected: The Spanish Inquisition
X-Uptime: 12:12am  up 2 days, 16:55,  2 users,  load average: 0.07, 0.05, 0.25
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm running a SMP (2xPIII 600) on a Tyan Tiger mobo (Via Apollo Pro 133a
chipset) with a G400 and it runs fine, when I do the following:

	- disable APIC ("noapic" as a boot parameter).  Then again, the
	  system won't boot without APIC disabled.
	- use the ALSA drivers for my SoundBlaster Live.  (I haven't
	  tried the kernel-based drivers for a few version now, so this
	  situation might have changes, but up until I switched to ALSA,
	  I had crashes all the time during medium to high I/O.
	- use the uhci USB driver when I'm using a USB printer.  If I
	  use the usb-uhci driver with my USB printer, the whole system
	  locks.  This has been reported a few times on LKML,
	  linux-usb-users, and linux-usb-developers and nobody helped,
	  but a few people wrote back with "me too"s.  It was broken in
	  the trasnition from 2.4.3 to 2.4.4 and only seems to affect
	  SMP systems.  I just gave up on USB printing and went back to
	  my parallel port.

Finally, I'm using RedHat 7.1.  This system has no stability problems
now (after a long series of all kinds of stability problems).  Maybe
it's a load thing, I don't know, but it now runs stable.  

pete

On Mon, 13 Aug 2001, Francois Romieu wrote:

> I'm not convinced that gaining stability on a VIA + G400 + X + smp 
> combo is an easy task anyway.
