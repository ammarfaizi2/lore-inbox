Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261554AbVBRXcV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261554AbVBRXcV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Feb 2005 18:32:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261555AbVBRXcV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Feb 2005 18:32:21 -0500
Received: from gprs214-225.eurotel.cz ([160.218.214.225]:29632 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S261554AbVBRXcR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Feb 2005 18:32:17 -0500
Date: Sat, 19 Feb 2005 00:31:48 +0100
From: Pavel Machek <pavel@suse.cz>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Oliver Neukum <oliver@neukum.org>, dtor_core@ameritech.net,
       Richard Purdie <rpurdie@rpsys.net>,
       James Simmons <jsimmons@pentafluge.infradead.org>,
       Adrian Bunk <bunk@stusta.de>,
       Linux Input Devices <linux-input@atrey.karlin.mff.cuni.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6: drivers/input/power.c is never built
Message-ID: <20050218233148.GA1628@elf.ucw.cz>
References: <047401c515bb$437b5130$0f01a8c0@max> <20050218202443.GB1403@elf.ucw.cz> <20050218204018.GA2760@ucw.cz> <200502182223.19896.oliver@neukum.org> <20050218213801.GA3544@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050218213801.GA3544@ucw.cz>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > What is the benefit of splitting the flow of information so?
> 
> It's split already. You get some from input (power and sleep keys on
> keyboards, sound volume keys and display brightness on some notebooks),
> some from ACPI events (power keys on notebooks and desktop cases, sound
> volume, display brightness on other notebooks), some from /proc/acpi/*
> (battery status, fan status), some from APM, from platform specific
> devices, from hotplug, from userspace daemons (UPS status).
> 
> The question is how to unify it.
> 
> Using power.c to simply pass power/sleep keys to the ACPI event pipe
> could get the input subsystem out of the loop at least. Maybe we could
> even pass sound keys to it. 

I do not think passing sound keys through acpi is good idea. acpid
does not know how to handle them, and X already know how to get them
from input subsystem.

I believe power and suspend keys should definitely go through
input. I'm not that sure about battery... Lid is somewhere in
between...

> It's probably still the best option, though I argued for doing it the
> other way around - I want to know the pros and cons for all the possible
> approaches.

									Pavel

-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
