Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932236AbVHHWRV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932236AbVHHWRV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 18:17:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932284AbVHHWRV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 18:17:21 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:4744 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932236AbVHHWRU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 18:17:20 -0400
Date: Mon, 8 Aug 2005 23:54:44 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Con Kolivas <kernel@kolivas.org>
Cc: "Theodore Ts'o" <tytso@mit.edu>, linux-kernel@vger.kernel.org,
       tony@atomide.com, tuukka.tikkanen@elektrobit.com, ck@vds.kolivas.org
Subject: Re: [patch] i386 dynamic ticks 2.6.13-rc4 (code reordered)
Message-ID: <20050808215444.GA2589@elf.ucw.cz>
References: <200508021443.55429.kernel@kolivas.org> <20050806145418.GA16523@thunk.org> <200508070100.55319.kernel@kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200508070100.55319.kernel@kolivas.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > I monitored 
> > power utilization using pmstats-0.2, and used
> > /proc/acpi/processor/CPU/power to monitor bus mastering activity and the
> > CPU C-states.
> >
> > As soon as I disabled dynamic tick using:
> >
> > 	echo 0 > /sys/devices/system/timer/timer0/dyn_tick_state
> >
> > The number of ticks went up to 1024, bus mastering activity dropped to
> > zero, and the processor entered C4 state, and power utilization
> > dropped by 20%.
> >
> > When I enabled dynamic tick using:
> >
> > 	echo 1 > /sys/devices/system/timer/timer0/dyn_tick_state
> >
> > The number of ticks dropped down to 60-70 HZ, bus mastering activity
> > jumpped up to being almost always active,
> 
> Anyone know why this would happen?

Bus mastering monitor was broken last time I checked... it depended on
HZ in ugly way or something like that. It was on ACPI mailing lists.

								Pavel
-- 
if you have sharp zaurus hardware you don't need... you know my address
