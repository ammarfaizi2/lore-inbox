Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261505AbVBRVAN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261505AbVBRVAN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Feb 2005 16:00:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261501AbVBRVAM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Feb 2005 16:00:12 -0500
Received: from gprs215-250.eurotel.cz ([160.218.215.250]:21217 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S261452AbVBRVAE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Feb 2005 16:00:04 -0500
Date: Fri, 18 Feb 2005 21:59:40 +0100
From: Pavel Machek <pavel@suse.cz>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: dtor_core@ameritech.net, Oliver Neukum <oliver@neukum.org>,
       Richard Purdie <rpurdie@rpsys.net>,
       James Simmons <jsimmons@pentafluge.infradead.org>,
       Adrian Bunk <bunk@stusta.de>,
       Linux Input Devices <linux-input@atrey.karlin.mff.cuni.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6: drivers/input/power.c is never built
Message-ID: <20050218205940.GC1403@elf.ucw.cz>
References: <20050218132651.GA1813@elf.ucw.cz> <200502181436.01943.oliver@neukum.org> <20050218160153.GC12434@elf.ucw.cz> <20050218170036.GA1672@ucw.cz> <d120d50005021810195f16ac0d@mail.gmail.com> <20050218183936.GA2242@ucw.cz> <d120d5000502181120392a9a0f@mail.gmail.com> <20050218200502.GA2556@ucw.cz> <20050218202443.GB1403@elf.ucw.cz> <20050218204018.GA2760@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050218204018.GA2760@ucw.cz>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Well, I'm not sure if input layer is suitable for batteries... Modern
> > battery has quite a lot of parameters. It can tell you current
> > voltage, current capacity (either mAh or mWh), design capacity, last
> > capacity at full charge, current current, battery's estimate of run
> > time (which may be better than system's estimate), ... But some
> > batteries only know percentage of energy left, and some batteries only
> > know current voltage (you can estimate %left from that). I'm not sure
> > if input system can handle all that complexity...
> 
> I wouldn't want to pass all the battery info (UPSes can be even more
> complex, able to switch on/off individual sockets, etc) through input,
> just the basic events:
> 
> 	AC power on/off
> 	battery full/normal/low/critical/(fail)
> 
> Then the other power-related events
> 
> 	Lid open/closed
> 	Power button
> 	Sleep button
> 
> I think that's all you need to trigger actions. You don't need the exact
> percentage of the battery, and you don't need the exact AC voltage at
> input. 
> 
> Nice graphics battery monitors in X can gather their information from
> the platform specific sources, since they'll need it all in the greatest
> detail.

Makes sense. Other possibility is to have simple "battery status
changed" event, but that would not be enough for simple UPSes... I
guess battery full/normal/low/critical makes sense, perhaps I'd say
that battery might repeat event if something "interesting" changed.

								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
