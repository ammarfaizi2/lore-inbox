Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267238AbTAKOiG>; Sat, 11 Jan 2003 09:38:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267243AbTAKOiG>; Sat, 11 Jan 2003 09:38:06 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:33548 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S267238AbTAKOgv>; Sat, 11 Jan 2003 09:36:51 -0500
Date: Sat, 11 Jan 2003 09:43:13 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Erich Focht <efocht@ess.nec.de>
cc: linux-kernel <linux-kernel@vger.kernel.org>,
       lse-tech <lse-tech@lists.sourceforge.net>
Subject: Re: [Lse-tech] Minature NUMA scheduler
In-Reply-To: <200301101734.56182.efocht@ess.nec.de>
Message-ID: <Pine.LNX.3.96.1030111094032.8637A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Jan 2003, Erich Focht wrote:

> Having some sort of automatic node affinity of processes and equal
> node loads in mind (as design targets), we could:
>  - take the minimal NUMA scheduler
>  - if the normal (node-restricted) find_busiest_queue() fails and
>  certain conditions are fulfilled (tried to balance inside own node
>  for a while and didn't succeed, own CPU idle, etc... ???) rebalance
>  over node boundaries (eg. using my load balancer)
> This actually resembles the original design of the node affine
> scheduler, having the cross-node balancing separate is ok and might
> make the ideas clearer.

Agreed, but honestly just this explanation would make it easier to
understand! I'm not sure you have the "balance of nodes" trigger defined
quite right, but I'm assuming if this gets implemented as described that
some long term umbalance detector mechanism will be run occasionally.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

