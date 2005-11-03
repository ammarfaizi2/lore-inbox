Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030377AbVKCQgN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030377AbVKCQgN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 11:36:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030382AbVKCQgM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 11:36:12 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:52411 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1030377AbVKCQgL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 11:36:11 -0500
Date: Thu, 3 Nov 2005 17:35:32 +0100
From: Pavel Machek <pavel@suse.cz>
To: John Lenz <lenz@cs.wisc.edu>, Robert Schwebel <robert@schwebel.de>,
       Robert Schwebel <r.schwebel@pengutronix.de>, vojtech@suse.cz,
       rpurdie@rpsys.net, kernel list <linux-kernel@vger.kernel.org>
Subject: Re: best way to handle LEDs
Message-ID: <20051103163532.GC24846@elf.ucw.cz>
References: <20051101234459.GA443@elf.ucw.cz> <20051102202622.GN23316@pengutronix.de> <20051102211334.GH23943@elf.ucw.cz> <20051102213354.GO23316@pengutronix.de> <38523.192.168.0.12.1130986361.squirrel@192.168.0.2> <20051103081522.GA21663@flint.arm.linux.org.uk> <20051103095725.GA703@openzaurus.ucw.cz> <20051103144904.GG28038@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051103144904.GG28038@flint.arm.linux.org.uk>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > > Except the led code that is being proposed CAN sit on top of a generic
> > > > GPIO layer.
> > > 
> > > I also have issues with a generic GPIO layer.  As I mentioned in the
> > > past, there's serious locking issues with any generic abstraction of
> > > GPIOs.
> > > 
> > > 1. You want to be able to change GPIO state from interrupts.  This
> > >    implies you can not sleep in GPIO state changing functions.
> > > 
> > > 2. Some GPIOs are implemented on I2C devices.  This means that to
> > >    change state, you must sleep.
> > 
> > Can't you just busywait? Yes, it is ugly in general, but perhaps it
> > is better than alternatives...
> 
> Does the i2c layer support busy waiting or are you suggesting something
> else?

I'm suggesting that adding busy wait support to i2c is probably good
idea. GPIOs are on many small machines, and there are machine
(spitz/akita?) that differ mainly in "where GPIO lines are
connected". That cries for GPIO layer.
							Pavel
-- 
Thanks, Sharp!
