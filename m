Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262232AbVCBJDa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262232AbVCBJDa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 04:03:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262233AbVCBJDa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 04:03:30 -0500
Received: from gprs215-145.eurotel.cz ([160.218.215.145]:4028 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262232AbVCBJDP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 04:03:15 -0500
Date: Wed, 2 Mar 2005 09:56:19 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Todd Poynor <tpoynor@mvista.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@osdl.org
Subject: Re: [linux-pm] [PATCH] Custom power states for non-ACPI systems
Message-ID: <20050302085619.GA1364@elf.ucw.cz>
References: <20050302020306.GA5724@slurryseal.ddns.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050302020306.GA5724@slurryseal.ddns.mvista.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Advertise custom sets of system power states for non-ACPI systems.
> Currently, /sys/power/state shows and accepts a static set of choices
> that are not necessarily meaningful on all platforms (for example,
> suspend-to-disk is an option even on diskless embedded systems, and the
> meaning of standby vs. suspend-to-mem is not well-defined on
> non-ACPI-systems).  This patch allows the platform to register power
> states with meaningful names that correspond to the platform's
> conventions (for example, "big sleep" and "deep sleep" on TI OMAP), and
> only those states that make sense for the platform.

Maybe this is a bit overdone?

Of course you can have suspend-to-disk on most embedded systems; CF
flash card looks just like disk, and you should be able to suspend to
it.

If OMAP has "big sleep" and "deep sleep", why not simply map them to
"standby" and "suspend-to-ram"?

[OTOH patch is not that long; but strings in /sys filesystem are not
for human consumption anyway.]
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
