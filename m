Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262906AbVAKV6K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262906AbVAKV6K (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 16:58:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262879AbVAKV5I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 16:57:08 -0500
Received: from gprs215-193.eurotel.cz ([160.218.215.193]:33155 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S262901AbVAKVzy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 16:55:54 -0500
Date: Tue, 11 Jan 2005 22:55:37 +0100
From: Pavel Machek <pavel@ucw.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.10-mm2: swsusp problem with resuming on batteries (AMD64)
Message-ID: <20050111215537.GE1802@elf.ucw.cz>
References: <200501112220.53011.rjw@sisk.pl> <20050111212729.GC1802@elf.ucw.cz> <200501112233.01113.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200501112233.01113.rjw@sisk.pl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > On 2.6.10-mm2, if swsusp suspends my box on AC power and then it's resumed 
> on 
> > > batteries, the box reboots after (or while) suspending devices (ie before 
> > > restoring the image).  This is 100% reproducible, it appears.
> > > 
> > > The box is an Athlon 64 laptop on NForce 3.
> > 
> > Forcing machine to 800MHz before suspend may do the trick, too.
> 
> How can I do this?

echo "0%44%44%powersave" > /proc/cpufreq if you have that interface
enabled. Or simply turn off CONFIG_CPUFREQ in config.

								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
