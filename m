Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262463AbVCBWSd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262463AbVCBWSd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 17:18:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262503AbVCBWP5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 17:15:57 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:10897 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262500AbVCBWMF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 17:12:05 -0500
Date: Wed, 2 Mar 2005 23:11:50 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Todd Poynor <tpoynor@mvista.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@osdl.org
Subject: Re: [linux-pm] [PATCH] Custom power states for non-ACPI systems
Message-ID: <20050302221150.GE1616@elf.ucw.cz>
References: <20050302020306.GA5724@slurryseal.ddns.mvista.com> <20050302085619.GA1364@elf.ucw.cz> <42263719.7030004@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42263719.7030004@mvista.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >If OMAP has "big sleep" and "deep sleep", why not simply map them to
> >"standby" and "suspend-to-ram"?
> 
> In fact that's more or less what happens (or will happen once drivers 
> like USB stop looking for PM_SUSPEND_MEM, etc.).  There are other 
> platforms with more than 2 sleep states (say, XScale PXA27x), so this 
> will start to get a bit problematic.  And it seens so easy to truly 
> handle the platform's states instead of pretending ACPI S1/S3/S4 are the 
> only methods to suspend any system.
> 
> If it's preferable, how about replacing the /sys/power/state "standby" 
> and "mem" values  to "sleep", and have a /sys/power/sleep attribute that 
> tells the methods of sleep available for the platform, much like 
> suspend-to-disk methods are handled today?  So the sleep attribute would 
> handle "standby" and "mem" for ACPI systems, and other values for 
> non-ACPI systems.  Thanks,

This is userland API. It should not change in random way during stable
series...

...but adding new /sys/power/state might be okay. We should not have
introduced "standby" in the first place [but I guess it is not worth
removing now]. If something has more than 2 states (does user really
want to enter different states in different usage?), I guess we can
add something like "deepmem" or whatever. Is there something with more
than 3 states?
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
