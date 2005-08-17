Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750961AbVHQHxt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750961AbVHQHxt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Aug 2005 03:53:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750959AbVHQHxt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Aug 2005 03:53:49 -0400
Received: from ylpvm15-ext.prodigy.net ([207.115.57.46]:7567 "EHLO
	ylpvm15.prodigy.net") by vger.kernel.org with ESMTP
	id S1750759AbVHQHxs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Aug 2005 03:53:48 -0400
X-ORBL: [67.117.73.34]
Date: Wed, 17 Aug 2005 00:53:21 -0700
From: Tony Lindgren <tony@atomide.com>
To: Con Kolivas <kernel@kolivas.org>
Cc: vatsa@in.ibm.com, tuukka.tikkanen@elektrobit.com, akpm@osdl.org,
       johnstul@us.ibm.com, linux-kernel@vger.kernel.org, ak@muc.de,
       george@mvista.com
Subject: Re: [ck] [PATCH] dynamic-tick patch modified for SMP
Message-ID: <20050817075320.GC16992@atomide.com>
References: <20050812201946.GA5327@in.ibm.com> <200508160230.52860.kernel@kolivas.org> <20050816131942.GD8608@in.ibm.com> <200508162323.33333.kernel@kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200508162323.33333.kernel@kolivas.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Con Kolivas <kernel@kolivas.org> [050816 06:23]:
> On Tue, 16 Aug 2005 23:19, Srivatsa Vaddagiri wrote:
> > On Tue, Aug 16, 2005 at 02:30:51AM +1000, Con Kolivas wrote:
> > > Time definitely was lost the longer the machine was running.
> >
> > I think I found the reason for time drift. Basically cur_timer->mark_offset
> > doesnt expect to be called from non-timer interrupt handler. Hence it drops
> > one jiffy from the lost count. I fixed this in some "crude" fashion and
> > time has not drifted so far or is pretty much close to what it was in
> > pre-smp version.  Will find a neat way to fix this and post a patch soon.
> >
> > > You mean disable it at runtime or not compile it in at all? Disabling it
> > > at runtime caused what I described to you as PIT mode (long stalls etc).
> >
> > I think I have recreated this on a machine here. Disabling
> > CONFIG_DYN_TICK_APIC at compile-time didnt seem to make any difference.
> > Will look at this problem next.
> 
> Excellent. 
> 
> Mind you the APIC dyntick never really worked well on the pre-smp version on 
> any hardware I tried it on so if you get both the APIC and PIT version 
> working well you're doing great.

Sounds good! I only got the APIC stuff working properly on P3, but not on P4.

Tony
