Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261927AbSJEBWK>; Fri, 4 Oct 2002 21:22:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261932AbSJEBWK>; Fri, 4 Oct 2002 21:22:10 -0400
Received: from dp.samba.org ([66.70.73.150]:44419 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S261926AbSJEBWG>;
	Fri, 4 Oct 2002 21:22:06 -0400
Date: Sat, 5 Oct 2002 10:14:34 +1000
From: Anton Blanchard <anton@samba.org>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: "Randy.Dunlap" <rddunlap@osdl.org>, Andrew Morton <akpm@digeo.com>,
       linux-kernel@vger.kernel.org, mbligh@aracnet.com
Subject: Re: [PATCH] patch-slab-split-03-tail
Message-ID: <20021005001434.GA15031@krispykreme>
References: <Pine.LNX.4.33L2.0210041321370.20655-100000@dragon.pdx.osdl.net> <3D9E0760.8040507@colorfullife.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D9E0760.8040507@colorfullife.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> <<<<<<<
> An object cache's CPU layer contains per-CPU state that must be 
> protected either by per-CPU locking or by disabling interrupts. We 
> selected per-CPU locking for several reasons:
> [...]
>  x    Performance. On most modern processors, grabbing an uncontended 
> lock is cheaper than modifying the processor interrupt level.
> <<<<<<<<
> 
> Which cpus have slow local_irq_disable() implementations? At least for 
> my Duron, this doesn't seem to be the case [~ 4 cpu cycles for cli]

Rusty did some tests and found on the intel chips he tested
local_irq_disable was slower. He posted the results to lkml a few weeks
ago.

On ppc64 it varies between chips.

Anton
