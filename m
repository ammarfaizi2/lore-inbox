Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751090AbVKCIid@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751090AbVKCIid (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 03:38:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751149AbVKCIid
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 03:38:33 -0500
Received: from witte.sonytel.be ([80.88.33.193]:7076 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S1751090AbVKCIid (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 03:38:33 -0500
Date: Thu, 3 Nov 2005 09:37:52 +0100 (CET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Pavel Machek <pavel@suse.cz>
cc: Robert Schwebel <r.schwebel@pengutronix.de>,
       Vojtech Pavlik <vojtech@suse.cz>, rpurdie@rpsys.net, lenz@cs.wisc.edu,
       kernel list <linux-kernel@vger.kernel.org>,
       Russell King <rmk@arm.linux.org.uk>
Subject: Re: best way to handle LEDs
In-Reply-To: <20051102211334.GH23943@elf.ucw.cz>
Message-ID: <Pine.LNX.4.62.0511030937220.30253@numbat.sonytel.be>
References: <20051101234459.GA443@elf.ucw.cz> <20051102202622.GN23316@pengutronix.de>
 <20051102211334.GH23943@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Nov 2005, Pavel Machek wrote:
> > > yellow off: 	not charging
> > > yellow on:	charging
> > > yellow fast blink: charge error
> > > 
> > > I think even slow blinking was used somewhere. I have some code from
> > > John Lenz (attached); it uses sysfs interface, exports led collor, and
> > > allows setting different frequencies.
> > > 
> > > Is that acceptable, or should some other interface be used?
> > 
> > IMHO reducing digital outputs to LEDs goes not far enough. All System-
> > on-Chip CPUs have General Purpose I/O pins today, which can act as
> > inputs or outputs and may be used for LEDs, matrix keyboard lines,
> 
> We have some leds that are *not* on GPIO pins (like driven by
> ACPI). We'd like to support those, too.

I though ACPI was software? These LEDs have to be driven by some hardware,
right?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
