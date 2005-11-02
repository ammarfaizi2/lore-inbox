Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965054AbVKBOjB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965054AbVKBOjB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 09:39:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965053AbVKBOjB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 09:39:01 -0500
Received: from tim.rpsys.net ([194.106.48.114]:35561 "EHLO tim.rpsys.net")
	by vger.kernel.org with ESMTP id S965054AbVKBOjB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 09:39:01 -0500
Subject: Re: best way to handle LEDs
From: Richard Purdie <rpurdie@rpsys.net>
To: Pavel Machek <pavel@suse.cz>
Cc: vojtech@suse.cz, lenz@cs.wisc.edu,
       kernel list <linux-kernel@vger.kernel.org>,
       Russell King <rmk@arm.linux.org.uk>
In-Reply-To: <20051102135614.GL30194@elf.ucw.cz>
References: <20051101234459.GA443@elf.ucw.cz>
	 <1130891953.8489.83.camel@localhost.localdomain>
	 <20051102135614.GL30194@elf.ucw.cz>
Content-Type: text/plain
Date: Wed, 02 Nov 2005 14:38:41 +0000
Message-Id: <1130942322.8523.15.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-11-02 at 14:56 +0100, Pavel Machek wrote:
> > Led triggers would be kernel sources of led on/off events. Some
> > examples:
> > 
> > 2Hz Heartbeat - useful for debugging (and/or Generic Timer)
> > CPU Load indicator
> > Charging indicator
> > HDD activity (useful for microdrive on handheld)
> > Network activity
> > no doubt many more
> > 
> > led triggers would be connected to leds via sysfs. Each trigger would
> > probably have a number you could echo into an led's trigger attribute.
> > Sensible default mappings could be had by assigning a default trigger to
> > a device by name in the platform code that declares the led.
> 
> Perhaps I'd keep it simple and leave it at
> 
> * do hardcoded kernel action for this led
> 
> or
> 
> * do whatever userspace tells you.
> 
> That way you will not be able to remap charger LED onto hard disk
> indicator, but we can support that on ibm-acpi too. (Where hw controls
> LEDs like "sleep", but lets you control them. You can't remap,
> though).

Then the arguments start about which function should be hardcoded to
which leds and why can't userspace access these triggers?

I'd prefer a totally flexible system and it doesn't really add much
complexity once you have a trigger framework which we're going to need
to handle mutiple led trigger sources sanely anyway.

Richard

