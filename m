Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311406AbSCMWYz>; Wed, 13 Mar 2002 17:24:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311411AbSCMWYq>; Wed, 13 Mar 2002 17:24:46 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:62473 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S311407AbSCMWYf>; Wed, 13 Mar 2002 17:24:35 -0500
Date: Wed, 13 Mar 2002 17:22:50 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Ingo Molnar <mingo@elte.hu>
cc: Linux Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Severe IRQ problems on Foster (P4 Xeon) system
In-Reply-To: <Pine.LNX.4.33.0203132006310.28859-100000@localhost.localdomain>
Message-ID: <Pine.LNX.3.96.1020313171800.5467C-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Mar 2002, Ingo Molnar wrote:

> 
> On Wed, 13 Mar 2002, Martin Wilck wrote:
> 
> > First of all, we see that virtually 100% of all IRQs are handled by
> > CPU 0. I have seen this reported a number of times before. I guess it
> > can become a severe performance problem in IRQ-intensive situations.
> 
> i've written a patch for this, it's enclosed in this email. It implements
> a brownean motion of IRQs, based on load patterns. The concept works
> really well on Foster CPUs - eg. it will redirect IRQs to idle CPUs - but
> if all CPUs are idle then the IRQs are randomly and evenly distributed
> between CPUs.

If several processors are idle, say CPU0 busy and CPU[123] idle, does it
preferentially use a "CPU" on another chip? And does that make any
difference? It's not clear to me if the HT CPUs share cache or not, they
obviously share bandwidth from L2 to RAM.

I'm looking at P4 chips and boards, my 2Q02 budget has some $$ for a
system. I also will be getting some laptops 3Q02, does the new P4-M mobile
chip by any chance have HT? If so a good reason to go Intel, assuming that
either the BIOS or Linux can get it to use the feature ;-)

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

