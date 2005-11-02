Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965046AbVKBN4s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965046AbVKBN4s (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 08:56:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965050AbVKBN4s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 08:56:48 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:35976 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S965046AbVKBN4r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 08:56:47 -0500
Date: Wed, 2 Nov 2005 14:56:14 +0100
From: Pavel Machek <pavel@suse.cz>
To: Richard Purdie <rpurdie@rpsys.net>
Cc: vojtech@suse.cz, lenz@cs.wisc.edu,
       kernel list <linux-kernel@vger.kernel.org>,
       Russell King <rmk@arm.linux.org.uk>
Subject: Re: best way to handle LEDs
Message-ID: <20051102135614.GL30194@elf.ucw.cz>
References: <20051101234459.GA443@elf.ucw.cz> <1130891953.8489.83.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1130891953.8489.83.camel@localhost.localdomain>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Led triggers would be kernel sources of led on/off events. Some
> examples:
> 
> 2Hz Heartbeat - useful for debugging (and/or Generic Timer)
> CPU Load indicator
> Charging indicator
> HDD activity (useful for microdrive on handheld)
> Network activity
> no doubt many more
> 
> led triggers would be connected to leds via sysfs. Each trigger would
> probably have a number you could echo into an led's trigger attribute.
> Sensible default mappings could be had by assigning a default trigger to
> a device by name in the platform code that declares the led.

Perhaps I'd keep it simple and leave it at

* do hardcoded kernel action for this led

or

* do whatever userspace tells you.

That way you will not be able to remap charger LED onto hard disk
indicator, but we can support that on ibm-acpi too. (Where hw controls
LEDs like "sleep", but lets you control them. You can't remap,
though).
								Pavel
-- 
Thanks, Sharp!
