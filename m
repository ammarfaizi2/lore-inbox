Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261422AbVBRRFk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261422AbVBRRFk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Feb 2005 12:05:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261420AbVBRRFk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Feb 2005 12:05:40 -0500
Received: from mail1.kontent.de ([81.88.34.36]:37034 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S261404AbVBRRFV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Feb 2005 12:05:21 -0500
From: Oliver Neukum <oliver@neukum.org>
To: Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: 2.6: drivers/input/power.c is never built
Date: Fri, 18 Feb 2005 18:05:12 +0100
User-Agent: KMail/1.7.1
Cc: Pavel Machek <pavel@suse.cz>, Richard Purdie <rpurdie@rpsys.net>,
       James Simmons <jsimmons@pentafluge.infradead.org>,
       Adrian Bunk <bunk@stusta.de>,
       Linux Input Devices <linux-input@atrey.karlin.mff.cuni.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       dmitry.torokhov@gmail.com
References: <20050213004729.GA3256@stusta.de> <20050218160153.GC12434@elf.ucw.cz> <20050218170036.GA1672@ucw.cz>
In-Reply-To: <20050218170036.GA1672@ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200502181805.13129.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Freitag, 18. Februar 2005 18:00 schrieb Vojtech Pavlik:
> On Fri, Feb 18, 2005 at 05:01:53PM +0100, Pavel Machek wrote:
> 
> > > > It has quite a lot of #ifdefs for CONFIG_APM/CONFIG_ARM/CONFIG_ACPI,
> > > > and it will not work on i386/APM, anyway. I still believe right
> > > > solution is to add input interface to ACPI. /proc/acpi/events needs to
> > > > die, being replaced by input subsystem.
> > > 
> > > But aren't there power events (battery low, etc) which are not
> > > input events?
> > 
> > Yes, there are. They can probably stay... Or we can get "battery low"
> > key.
>  
> We even have an event class for that, EV_PWR in the input subsystem.

Over that route we'd arrive at a situation where power management
without the input layer is impossible. Think about embedded stuff I wonder
whether this is viable.

	Regards
			Oliver
