Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261497AbUBYRq6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 12:46:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261498AbUBYRon
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 12:44:43 -0500
Received: from gprs151-5.eurotel.cz ([160.218.151.5]:4483 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261490AbUBYRoD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 12:44:03 -0500
Date: Wed, 25 Feb 2004 18:43:27 +0100
From: Pavel Machek <pavel@ucw.cz>
To: dual_bereta_r0x@arenanetwork.com.br, linux-kernel@vger.kernel.org,
       cpufreq@www.linux.org.uk
Subject: Re: 2.6.2: P4 ClockMod speed
Message-ID: <20040225174326.GD1214@elf.ucw.cz>
References: <20040216213435.GA9680@dominikbrodowski.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040216213435.GA9680@dominikbrodowski.de>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> By doing so it becomes easier to enter different frequencies e.g. into
> /sys/devices/system/cpu/cpufreq/scaling_setspeed -- on my desktop, typing in
> 1200000 is easier than 12121224... [*]
... 
> [*] The _actual_ CPU speed should be used on all cpufreq drivers where this
> specific CPU frequency has implications to external components, e.g. LCD,
> memory or pcmcia devices. Where only the _frequency ratio_ is of importance
> [for loops_per_jiffy and friends] such "rounding" is acceptable, as long as
> the ratio is constant.

Hey, that's ugly. Values should be real.

If you have troubles typing real frequency, you can either use
/proc/cpufreq and specify values in percent, or modify
scaling_setspeed to go for nearest lower frequency, or create bash
scripts "hi_speed" and "low_speed"; but please don't break
interface....
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
