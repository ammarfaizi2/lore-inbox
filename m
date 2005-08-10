Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965042AbVHJIDY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965042AbVHJIDY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Aug 2005 04:03:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965035AbVHJIDY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Aug 2005 04:03:24 -0400
Received: from ylpvm15-ext.prodigy.net ([207.115.57.46]:16802 "EHLO
	ylpvm15.prodigy.net") by vger.kernel.org with ESMTP id S965043AbVHJIDX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Aug 2005 04:03:23 -0400
X-ORBL: [67.117.73.34]
Date: Wed, 10 Aug 2005 01:02:47 -0700
From: Tony Lindgren <tony@atomide.com>
To: George Anzinger <george@mvista.com>
Cc: Srivatsa Vaddagiri <vatsa@in.ibm.com>, Con Kolivas <kernel@kolivas.org>,
       linux-kernel@vger.kernel.org, ck@vds.kolivas.org,
       tuukka.tikkanen@elektrobit.com, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] i386 No-Idle-Hz aka Dynamic-Ticks 3
Message-ID: <20050810080246.GB4140@atomide.com>
References: <200508031559.24704.kernel@kolivas.org> <20050805123754.GA1262@in.ibm.com> <20050808072600.GE28070@atomide.com> <42F90C78.60500@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42F90C78.60500@mvista.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* George Anzinger <george@mvista.com> [050809 13:07]:
>
> >>I can take a shot at addressing these concerns in dynamic_tick patch, but 
> >>it seems to me that VST has already addressed all these to a big extent. 
> >>Had you considered VST before? The biggest bottleneck I see in VST going 
> >>mainline is its dependency on HRT patch but IMO it should be possible to 
> >>write a small patch
> >>to support VST w/o HRT. 
> >>
> >>George, what do you think?
> >
> >
> >HRT + VST depend on APIC only, and does not use next_timer_interrupt().
> 
> I convinced my self that the next_timer... code in timer.c misses timers 
> (i.e. gives the wrong answer).  I did this (after wondering due to 
> performance) by scanning the whole timer list after I had the 
> next_timer... answer and finding a better answer, not always, but some 
> times.  That code does not address the cascade list correctly.

Do you have a patch around for improving next_timer_interrupt()?

Tony
