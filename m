Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261555AbVBRXfV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261555AbVBRXfV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Feb 2005 18:35:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261557AbVBRXfV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Feb 2005 18:35:21 -0500
Received: from gprs214-225.eurotel.cz ([160.218.214.225]:31936 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S261555AbVBRXfL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Feb 2005 18:35:11 -0500
Date: Sat, 19 Feb 2005 00:34:43 +0100
From: Pavel Machek <pavel@suse.cz>
To: Oliver Neukum <oliver@neukum.org>
Cc: Vojtech Pavlik <vojtech@suse.cz>, dtor_core@ameritech.net,
       Richard Purdie <rpurdie@rpsys.net>,
       James Simmons <jsimmons@pentafluge.infradead.org>,
       Adrian Bunk <bunk@stusta.de>,
       Linux Input Devices <linux-input@atrey.karlin.mff.cuni.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6: drivers/input/power.c is never built
Message-ID: <20050218233443.GB1628@elf.ucw.cz>
References: <047401c515bb$437b5130$0f01a8c0@max> <200502182223.19896.oliver@neukum.org> <20050218213428.GD1403@elf.ucw.cz> <200502182300.21420.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200502182300.21420.oliver@neukum.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Well, if you have power button on usb keyboard -- why should it be
> > handled differently from built-in button?
> 
> I see no reason. But that tells you that one subsystem should handle
> that, not which subsystem.

If usb keyboard has power button... I do not think we really want to
route that through acpi. And what if acpi is not available? (APM knows
about suspend key in weird way, but not about power key).

> > trip points), and I do not see how you can do interrupts for fan
> > status. Either fans are under Linux control (and kernel could tell you
> > when it turns fan on/off, but...), or they do not exist from Linux's
> > point of few.
> 
> They still can have a readable rate, even if not under os control.
> Nevertheless I don't think you can reasonably define what might
> interest user space or not and in which detail.

Well, we can say that userspace definitely is interested in "power"
key ;-).
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
