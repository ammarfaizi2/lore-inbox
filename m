Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932391AbVJDMEA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932391AbVJDMEA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Oct 2005 08:04:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932395AbVJDMEA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Oct 2005 08:04:00 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:45291 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932391AbVJDMD7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Oct 2005 08:03:59 -0400
Date: Tue, 4 Oct 2005 14:03:34 +0200
From: Pavel Machek <pavel@suse.cz>
To: Timo Hoenig <thoenig@suse.de>
Cc: Stefan Seyfried <seife@suse.de>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: thinkpad suspend to ram and backlight
Message-ID: <20051004120334.GE17458@elf.ucw.cz>
References: <20051002175703.GA3141@elf.ucw.cz> <43410149.9070007@suse.de> <1128427214.14551.15.camel@nouse.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1128427214.14551.15.camel@nouse.suse.de>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > When I suspend to RAM on x32, backlight is not turned off. (And, IIRC,
> > > video chips is not turned off, too). Unfortunately, backlight is not
> > > turned even when lid is closed. I know some patches were floating
> > > around to solve that... but I can't find them now. Any ideas?
> > 
> > Which framebuffer driver? Vesafb works for Timo, at least he did not
> > complain lately ;-)
> 
> It's never too late to complain: I just gave it a try with vesfb.
> Backlight stays on.
> 
> When eying the display precisely it seems to be switched off for a short
> moment once the system enters S3 but then gets turned on again.

Yes, same with radeonfb here.

I use

#!/bin/bash
radeontool light off
echo 3 > /proc/acpi/sleep
radeontool light on

...and it works most of the time. Sometimes screen is corrupted after
resume, another suspend/resume cycle cures that. (Strange!)

								Pavel
-- 
if you have sharp zaurus hardware you don't need... you know my address
