Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262946AbVG3VmV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262946AbVG3VmV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Jul 2005 17:42:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262928AbVG3VmU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Jul 2005 17:42:20 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:37040 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262946AbVG3Vl5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Jul 2005 17:41:57 -0400
Date: Sat, 30 Jul 2005 23:41:52 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Richard Purdie <rpurdie@rpsys.net>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Heads up for distro folks: PCMCIA hotplug differences (Re: -rc4: arm broken?)
Message-ID: <20050730214152.GE9418@elf.ucw.cz>
References: <20050730130406.GA4285@elf.ucw.cz> <1122741937.7650.27.camel@localhost.localdomain> <20050730201508.B26592@flint.arm.linux.org.uk> <20050730223628.M26592@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050730223628.M26592@flint.arm.linux.org.uk>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > > I merged -rc4 into my zaurus tree, and now zaurus will not boot. I see
> > > > oops-like display, and it seems to be __call_usermodehelper /
> > > > do_execve / load_script related. Anyone seen it before?
> > > 
> > > For the record -rc4 works fine on my Zaurus c760 (which is pxa255 based
> > > rather than sa1100).
> > 
> > It appears to work fine on Intel Assabet.
> 
> Let me qualify that, because it's not 100% fine due to the changes in
> PCMCIA land.
> 
> Since PCMCIA cards are detected and drivers bound at boot time, we no
> longer get hotplug events to setup networking for PCMCIA network cards
> already inserted.  Consequently, if you are relying on /sbin/hotplug to
> setup your PCMCIA network card at boot time, triggered by the cardmgr
> startup binding the driver, it won't happen.

Does that mean that if CF is inserted during bootup, it will simply
appear as /dev/hda after bootup, without need to run cardmgr?

								Pavel
-- 
if you have sharp zaurus hardware you don't need... you know my address
