Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030182AbVKCNcB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030182AbVKCNcB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 08:32:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932540AbVKCNcA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 08:32:00 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:34200 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S932472AbVKCNcA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 08:32:00 -0500
Date: Thu, 3 Nov 2005 10:57:26 +0100
From: Pavel Machek <pavel@suse.cz>
To: John Lenz <lenz@cs.wisc.edu>, Robert Schwebel <robert@schwebel.de>,
       Pavel Machek <pavel@suse.cz>,
       Robert Schwebel <r.schwebel@pengutronix.de>, vojtech@suse.cz,
       rpurdie@rpsys.net, kernel list <linux-kernel@vger.kernel.org>
Subject: Re: best way to handle LEDs
Message-ID: <20051103095725.GA703@openzaurus.ucw.cz>
References: <20051101234459.GA443@elf.ucw.cz> <20051102202622.GN23316@pengutronix.de> <20051102211334.GH23943@elf.ucw.cz> <20051102213354.GO23316@pengutronix.de> <38523.192.168.0.12.1130986361.squirrel@192.168.0.2> <20051103081522.GA21663@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051103081522.GA21663@flint.arm.linux.org.uk>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Except the led code that is being proposed CAN sit on top of a generic
> > GPIO layer.
> 
> I also have issues with a generic GPIO layer.  As I mentioned in the
> past, there's serious locking issues with any generic abstraction of
> GPIOs.
> 
> 1. You want to be able to change GPIO state from interrupts.  This
>    implies you can not sleep in GPIO state changing functions.
> 
> 2. Some GPIOs are implemented on I2C devices.  This means that to
>    change state, you must sleep.

Can't you just busywait? Yes, it is ugly in general, but perhaps it
is better than alternatives...


-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

