Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261439AbVBRRr4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261439AbVBRRr4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Feb 2005 12:47:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261426AbVBRRr4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Feb 2005 12:47:56 -0500
Received: from twilight.ucw.cz ([81.30.235.3]:16286 "EHLO suse.cz")
	by vger.kernel.org with ESMTP id S261425AbVBRRrx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Feb 2005 12:47:53 -0500
Date: Fri, 18 Feb 2005 18:48:26 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Oliver Neukum <oliver@neukum.org>
Cc: Pavel Machek <pavel@suse.cz>, Richard Purdie <rpurdie@rpsys.net>,
       James Simmons <jsimmons@pentafluge.infradead.org>,
       Adrian Bunk <bunk@stusta.de>,
       Linux Input Devices <linux-input@atrey.karlin.mff.cuni.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       dmitry.torokhov@gmail.com
Subject: Re: 2.6: drivers/input/power.c is never built
Message-ID: <20050218174826.GA2136@ucw.cz>
References: <20050213004729.GA3256@stusta.de> <20050218160153.GC12434@elf.ucw.cz> <20050218170036.GA1672@ucw.cz> <200502181805.13129.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200502181805.13129.oliver@neukum.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 18, 2005 at 06:05:12PM +0100, Oliver Neukum wrote:
> Am Freitag, 18. Februar 2005 18:00 schrieb Vojtech Pavlik:
> > On Fri, Feb 18, 2005 at 05:01:53PM +0100, Pavel Machek wrote:
> > 
> > > > > It has quite a lot of #ifdefs for CONFIG_APM/CONFIG_ARM/CONFIG_ACPI,
> > > > > and it will not work on i386/APM, anyway. I still believe right
> > > > > solution is to add input interface to ACPI. /proc/acpi/events needs to
> > > > > die, being replaced by input subsystem.
> > > > 
> > > > But aren't there power events (battery low, etc) which are not
> > > > input events?
> > > 
> > > Yes, there are. They can probably stay... Or we can get "battery low"
> > > key.
> >  
> > We even have an event class for that, EV_PWR in the input subsystem.
> 
> Over that route we'd arrive at a situation where power management
> without the input layer is impossible.

All you'd need is input.c. One file, approx 750 lines at the moment, a
big chunk of that can be confugured out if you don't need procfs or
hotplug.

> Think about embedded stuff I wonder whether this is viable.

On most embedded platforms you have some buttons or controls, so it's
likely you'll use input anyway.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
