Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932287AbVKCNcD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932287AbVKCNcD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 08:32:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932472AbVKCNcB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 08:32:01 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:34456 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S932287AbVKCNcA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 08:32:00 -0500
Date: Thu, 3 Nov 2005 10:59:38 +0100
From: Pavel Machek <pavel@suse.cz>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Pavel Machek <pavel@suse.cz>, Robert Schwebel <r.schwebel@pengutronix.de>,
       Vojtech Pavlik <vojtech@suse.cz>, rpurdie@rpsys.net, lenz@cs.wisc.edu,
       kernel list <linux-kernel@vger.kernel.org>,
       Russell King <rmk@arm.linux.org.uk>
Subject: Re: best way to handle LEDs
Message-ID: <20051103095938.GB703@openzaurus.ucw.cz>
References: <20051101234459.GA443@elf.ucw.cz> <20051102202622.GN23316@pengutronix.de> <20051102211334.GH23943@elf.ucw.cz> <Pine.LNX.4.62.0511030937220.30253@numbat.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0511030937220.30253@numbat.sonytel.be>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > > yellow off: 	not charging
> > > > yellow on:	charging
> > > > yellow fast blink: charge error
> > > > 
> > > > I think even slow blinking was used somewhere. I have some code from
> > > > John Lenz (attached); it uses sysfs interface, exports led collor, and
> > > > allows setting different frequencies.
> > > > 
> > > > Is that acceptable, or should some other interface be used?
> > > 
> > > IMHO reducing digital outputs to LEDs goes not far enough. All System-
> > > on-Chip CPUs have General Purpose I/O pins today, which can act as
> > > inputs or outputs and may be used for LEDs, matrix keyboard lines,
> > 
> > We have some leds that are *not* on GPIO pins (like driven by
> > ACPI). We'd like to support those, too.
> 
> I though ACPI was software? These LEDs have to be driven by some hardware,
> right?

Right, but you don't know by *which* hardware. Only ACPI AML code knows.
So from linux POW, they are handled by ACPI.

It may even trap to SMM BIOS.
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

