Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266208AbUHHTtn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266208AbUHHTtn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Aug 2004 15:49:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266214AbUHHTtm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Aug 2004 15:49:42 -0400
Received: from gprs214-77.eurotel.cz ([160.218.214.77]:6784 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S266208AbUHHTsV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Aug 2004 15:48:21 -0400
Date: Sun, 8 Aug 2004 21:48:05 +0200
From: Pavel Machek <pavel@ucw.cz>
To: =?iso-8859-1?Q?=C9ric?= Brunet <ebrunet@quatramaran.ens.fr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: What PM should be and do (Was Re: Solving suspend-level confusion)
Message-ID: <20040808194805.GA7765@elf.ucw.cz>
References: <20040730164413.GB4672@elf.ucw.cz> <200408031928.08475.david-b@pacbell.net> <1091588163.5225.77.camel@gaston> <200408032030.41410.david-b@pacbell.net> <1091594872.3191.71.camel@laptop.cunninghams> <20040805181925.GB30543@kroah.com> <1091744073.2597.15.camel@laptop.cunninghams> <20040807000824.C657C18122@quatramaran.ens.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040807000824.C657C18122@quatramaran.ens.fr>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >> > - support for telling what class of device a driver is handling (I'm
> >> > particularly interested in keeping the keyboard, screen and storage
> >> > devices alive while suspending).
> >> 
> >> You can see that info today from userspace by looking in
> >> /sys/class/input, /sys/class/graphics, and /sys/block
> 
> It is a minor point, but as many people are working on swsuspend right
> now, I thought I'd mentionned it. It seems (as of 2.6.8.rc1) that the
> screen is not shut down or put in a low power state when suspending to
> disk.
> 
> I guess that for 99.5 % of the population, it is not an issue as the
> monitor is usually plugged in the power supply of the computer and
> power is cut when the computer shuts down. My monitor, however, is
> directly plugged in the mains outlet and, after a suspend to disk, it
> displays indefinitely an information box stating that it has no video
> signal coming in.

Hmm, pretty stupid monitor, it should timeout and poweroff itself.

> The X server knows how to shutdown (DPMS) the screen afer some
> inactivity, so I guess the kernel could do that while
> suspending. And it

If you shutdown monitor via DPMS then hard-turn the machine off, what
happens? Does monitor stay turned off? [If not, all hopes are off.]

> would be very nice if it would. But I believe there is no device
> driver handling the monitor, so I don't know where to do it.

radeonfb (etc) could do that, but support for this is poor, I agree.

								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
