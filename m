Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286521AbSCOI7w>; Fri, 15 Mar 2002 03:59:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286959AbSCOI7m>; Fri, 15 Mar 2002 03:59:42 -0500
Received: from mx2.elte.hu ([157.181.151.9]:16571 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S286521AbSCOI70>;
	Fri, 15 Mar 2002 03:59:26 -0500
Date: Fri, 15 Mar 2002 08:55:19 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: mingo@elte.hu
To: Bill Davidsen <davidsen@tmr.com>
Cc: Linux Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Severe IRQ problems on Foster (P4 Xeon) system
In-Reply-To: <Pine.LNX.3.96.1020313171800.5467C-100000@gatekeeper.tmr.com>
Message-ID: <Pine.LNX.4.44.0203150852470.11415-100000@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 13 Mar 2002, Bill Davidsen wrote:

> > i've written a patch for this, it's enclosed in this email. It implements
> > a brownean motion of IRQs, based on load patterns. The concept works
> > really well on Foster CPUs - eg. it will redirect IRQs to idle CPUs - but
> > if all CPUs are idle then the IRQs are randomly and evenly distributed
> > between CPUs.
> 
> If several processors are idle, say CPU0 busy and CPU[123] idle, does it
> preferentially use a "CPU" on another chip? And does that make any
> difference? It's not clear to me if the HT CPUs share cache or not, they
> obviously share bandwidth from L2 to RAM.

it has no HT affinity knowledge yet, but adding it should be
straightforward. The IRQ 'move' function is in the slow path and can be
made HT-aware without any performance-worries.

	Ingo

