Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261510AbVBRUZU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261510AbVBRUZU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Feb 2005 15:25:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261508AbVBRUZU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Feb 2005 15:25:20 -0500
Received: from gprs215-250.eurotel.cz ([160.218.215.250]:62868 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S261510AbVBRUZC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Feb 2005 15:25:02 -0500
Date: Fri, 18 Feb 2005 21:24:43 +0100
From: Pavel Machek <pavel@suse.cz>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: dtor_core@ameritech.net, Oliver Neukum <oliver@neukum.org>,
       Richard Purdie <rpurdie@rpsys.net>,
       James Simmons <jsimmons@pentafluge.infradead.org>,
       Adrian Bunk <bunk@stusta.de>,
       Linux Input Devices <linux-input@atrey.karlin.mff.cuni.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6: drivers/input/power.c is never built
Message-ID: <20050218202443.GB1403@elf.ucw.cz>
References: <20050213004729.GA3256@stusta.de> <047401c515bb$437b5130$0f01a8c0@max> <20050218132651.GA1813@elf.ucw.cz> <200502181436.01943.oliver@neukum.org> <20050218160153.GC12434@elf.ucw.cz> <20050218170036.GA1672@ucw.cz> <d120d50005021810195f16ac0d@mail.gmail.com> <20050218183936.GA2242@ucw.cz> <d120d5000502181120392a9a0f@mail.gmail.com> <20050218200502.GA2556@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050218200502.GA2556@ucw.cz>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > > But input layer shoudl not be used as a generic transport. I mean
> > > > battery low, docking requests, etc has nothing to do with input.
> > > 
> > > Well, plugging in a power cord is a physical user action much like
> > > closing the lid is, much like pressing the power button is, much like
> > > pressing a key is.
> > 
> > What about power dying and my UPS switing on? I think it is out of
> > input layer,
> 
> Yes, I was thinking about this, too. An UPS is pretty much the same
> thing to a desktop as a battery is to a notebook. And I also got to the
> conclusion that this is a bad idea.

Well, I'm not sure if input layer is suitable for batteries... Modern
battery has quite a lot of parameters. It can tell you current
voltage, current capacity (either mAh or mWh), design capacity, last
capacity at full charge, current current, battery's estimate of run
time (which may be better than system's estimate), ... But some
batteries only know percentage of energy left, and some batteries only
know current voltage (you can estimate %left from that). I'm not sure
if input system can handle all that complexity...

								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
