Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261529AbVBRVib@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261529AbVBRVib (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Feb 2005 16:38:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261527AbVBRVff
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Feb 2005 16:35:35 -0500
Received: from gprs215-250.eurotel.cz ([160.218.215.250]:58519 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S261525AbVBRVe5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Feb 2005 16:34:57 -0500
Date: Fri, 18 Feb 2005 22:34:28 +0100
From: Pavel Machek <pavel@suse.cz>
To: Oliver Neukum <oliver@neukum.org>
Cc: Vojtech Pavlik <vojtech@suse.cz>, dtor_core@ameritech.net,
       Richard Purdie <rpurdie@rpsys.net>,
       James Simmons <jsimmons@pentafluge.infradead.org>,
       Adrian Bunk <bunk@stusta.de>,
       Linux Input Devices <linux-input@atrey.karlin.mff.cuni.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6: drivers/input/power.c is never built
Message-ID: <20050218213428.GD1403@elf.ucw.cz>
References: <047401c515bb$437b5130$0f01a8c0@max> <20050218202443.GB1403@elf.ucw.cz> <20050218204018.GA2760@ucw.cz> <200502182223.19896.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200502182223.19896.oliver@neukum.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > I wouldn't want to pass all the battery info (UPSes can be even more
> > complex, able to switch on/off individual sockets, etc) through input,
> > just the basic events:
> > 
> > 	AC power on/off
> > 	battery full/normal/low/critical/(fail)
> > 
> > Then the other power-related events
> > 
> > 	Lid open/closed
> > 	Power button
> > 	Sleep button
> 
> What is the benefit of splitting the flow of information so?

Well, if you have power button on usb keyboard -- why should it be
handled differently from built-in button?

> > I think that's all you need to trigger actions. You don't need the exact
> > percentage of the battery, and you don't need the exact AC voltage at
> > input. 
> 
> That is very debateable. I might want a quiet mode and would be
> interested in notifications about thermal data and fan status. 

Hmm, yes, some thermal notifications are needed. OTOH I'm not sure if
all the hardware does sent interrupts for temperature changes (you
definitely do not get interrupts for "small" changes that do not cross
trip points), and I do not see how you can do interrupts for fan
status. Either fans are under Linux control (and kernel could tell you
when it turns fan on/off, but...), or they do not exist from Linux's
point of few.
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
