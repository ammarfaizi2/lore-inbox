Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932240AbVHNUPA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932240AbVHNUPA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Aug 2005 16:15:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932241AbVHNUO7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Aug 2005 16:14:59 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:46804 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S932240AbVHNUO7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Aug 2005 16:14:59 -0400
Date: Sun, 14 Aug 2005 21:47:56 +0200
From: Pavel Machek <pavel@suse.cz>
To: Con Kolivas <kernel@kolivas.org>
Cc: Jim MacBaine <jmacbaine@gmail.com>, linux-kernel@vger.kernel.org,
       ck@vds.kolivas.org, tony@atomide.com, tuukka.tikkanen@elektrobit.com
Subject: Re: [PATCH] i386 No-Idle-Hz aka Dynamic-Ticks 3
Message-ID: <20050814194756.GC1686@openzaurus.ucw.cz>
References: <200508031559.24704.kernel@kolivas.org> <200508040716.24346.kernel@kolivas.org> <3afbacad050803152226016790@mail.gmail.com> <200508040852.10224.kernel@kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200508040852.10224.kernel@kolivas.org>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > What happens when you disable it at runtime before suspending?
> > >
> > > echo 0 > /sys/devices/system/dyn_tick/dyn_tick0/enable
> >
> > This has no effect. The system stalls at exactly the same point. The
> > last lines on my screen are:
> 
> Ok perhaps on the resume side instead. When trying to resume can you try 
> booting with 'dyntick=disable'. Note this isn't meant to be a long term fix 
> but once we figure out where the problem is we should be able to code around 
> it.

Can you reproduce it using plain swsusp?

We probably need more carefull suspend/resume support on timer with dyntick
enabled.

With vanilla, timer just ticks on constant rate; no state to save.
With dyntick, however...
				Pavel
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

