Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262062AbVBUSTR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262062AbVBUSTR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Feb 2005 13:19:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262063AbVBUSTR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Feb 2005 13:19:17 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:6611 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262062AbVBUSTP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Feb 2005 13:19:15 -0500
Date: Mon, 21 Feb 2005 18:19:09 +0000 (GMT)
From: James Simmons <jsimmons@www.infradead.org>
X-X-Sender: jsimmons@pentafluge.infradead.org
To: Vojtech Pavlik <vojtech@suse.cz>
cc: Oliver Neukum <oliver@neukum.org>, Pavel Machek <pavel@suse.cz>,
       dtor_core@ameritech.net, Richard Purdie <rpurdie@rpsys.net>,
       James Simmons <jsimmons@pentafluge.infradead.org>,
       Adrian Bunk <bunk@stusta.de>,
       Linux Input Devices <linux-input@atrey.karlin.mff.cuni.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6: drivers/input/power.c is never built
In-Reply-To: <20050218213801.GA3544@ucw.cz>
Message-ID: <Pine.LNX.4.56.0502211811420.13423@pentafluge.infradead.org>
References: <047401c515bb$437b5130$0f01a8c0@max> <20050218202443.GB1403@elf.ucw.cz>
 <20050218204018.GA2760@ucw.cz> <200502182223.19896.oliver@neukum.org>
 <20050218213801.GA3544@ucw.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > What is the benefit of splitting the flow of information so?
> 
> It's split already. You get some from input (power and sleep keys on
> keyboards, sound volume keys and display brightness on some notebooks),
> some from ACPI events (power keys on notebooks and desktop cases, sound
> volume, display brightness on other notebooks), some from /proc/acpi/*
> (battery status, fan status), some from APM, from platform specific
> devices, from hotplug, from userspace daemons (UPS status).
> 
> The question is how to unify it.

When I wrote power.c I thought there was a common power management 
interface. I found out I was wrong. I though the new driver model supplied 
a common method for power management for all platforms 
