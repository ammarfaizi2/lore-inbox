Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269881AbUIDLKG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269881AbUIDLKG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Sep 2004 07:10:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269883AbUIDLKG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Sep 2004 07:10:06 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:9928 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S269881AbUIDLJw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Sep 2004 07:09:52 -0400
Date: Sat, 4 Sep 2004 13:09:50 +0200
From: Pavel Machek <pavel@ucw.cz>
To: John Lenz <lenz@cs.wisc.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.8.1 0/2] leds: new class for led devices
Message-ID: <20040904110950.GA28074@atrey.karlin.mff.cuni.cz>
References: <1094157190l.4235l.2l@hydra> <20040903135103.GA982@elf.ucw.cz> <1094236686l.7429l.0l@hydra>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1094236686l.7429l.0l@hydra>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >> function : a read/write attribute that sets the current function of
> >> this led.  The available options are
> >>
> >>  timer : the led blinks on and off on a timer
> >>  idle : the led turns off when the system is idle and on when not idle
> >>  power : the led represents the current power state
> >>  user : the led is controlled by user space
> >
> >I'm afraid this is really good idea. It seems quite overengineered to
> >me (and I'd be afraid that idle part slows machine). Perhaps having
> >only "user" mode is better idea?
> 
> I was only mimicing the support currently in the arm led code.
> After thinking about it from a broader perspective of including GPIOs,
> we should probably get rid of this function thing entirely.  Just let user  
> space do everything... userspace can monitor sysfs and hotplug and have the 
> led represent power or idle or whatever.

Well, it might be okay than.

Another possibility would be to use hard-coded behaviour while system
is booting/stopping and /sys-controlled behaviour while userspace is
alive.

								Pavel
