Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266411AbTATQ4I>; Mon, 20 Jan 2003 11:56:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266425AbTATQ4I>; Mon, 20 Jan 2003 11:56:08 -0500
Received: from franka.aracnet.com ([216.99.193.44]:60340 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S266411AbTATQ4H>; Mon, 20 Jan 2003 11:56:07 -0500
Date: Mon, 20 Jan 2003 09:04:57 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Ingo Molnar <mingo@elte.hu>, Erich Focht <efocht@ess.nec.de>
cc: Michael Hohnbaum <hohnbaum@us.ibm.com>,
       Matthew Dobson <colpatch@us.ibm.com>,
       Christoph Hellwig <hch@infradead.org>, Robert Love <rml@tech9.net>,
       Andrew Theurer <habanero@us.ibm.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       lse-tech <lse-tech@lists.sourceforge.net>
Subject: Re: [patch] sched-2.5.59-A2
Message-ID: <1380580000.1043082296@titus>
In-Reply-To: <Pine.LNX.4.44.0301201743230.11746-100000@localhost.localdomain>
References: <Pine.LNX.4.44.0301201743230.11746-100000@localhost.localdomain>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> yes, but eg. in the idle-rebalance case we are more agressive at moving
> tasks across SMP CPUs. We could perhaps do a similar ->nr_balanced logic
> to do this 'agressive' balancing even if not triggered from the
> CPU-will-be-idle path. Ie. _perhaps_ the SMP balancer could become a bit
> more agressive.

Do you think it's worth looking at the initial load-balance code for 
standard SMP?

> ie. SMP is just the first level in the cache-hierarchy, NUMA is the second
> level. (lets hope we dont have to deal with a third caching level anytime
> soon - although that could as well happen once SMT CPUs start doing NUMA.)  

We have those already (IBM x440) ;-) That's one of the reasons why I prefer
the pools concept I posted at the weekend over just "nodes". Also, there
are NUMA machines where nodes are not all equidistant ... that can be
thought of as multi-level too.

> There's no real reason to do balancing in a different way on each level -
> the weight might be different, but the core logic should be synced up.
> (one thing that is indeed different for the NUMA step is locality of
> uncached memory.)

Right, the current model should work fine, it just needs generalising out
a bit.
 
M

