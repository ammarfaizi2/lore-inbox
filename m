Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319088AbSIDHgj>; Wed, 4 Sep 2002 03:36:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319089AbSIDHgj>; Wed, 4 Sep 2002 03:36:39 -0400
Received: from mx2.elte.hu ([157.181.151.9]:8082 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S319088AbSIDHgi>;
	Wed, 4 Sep 2002 03:36:38 -0400
Date: Wed, 4 Sep 2002 09:45:21 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Michael Hohnbaum <hohnbaum@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [patch] "fully HT-aware scheduler" support, 2.5.31-BK-curr
In-Reply-To: <3D754BAE.4020402@us.ibm.com>
Message-ID: <Pine.LNX.4.44.0209040944120.12060-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 3 Sep 2002, Michael Hohnbaum wrote:

> > (NUMA systems which have tightly coupled CPUs with a smaller cache and
> > protected by a large L3 cache might benefit from sharing the runqueue as
> > well - but the target for this concept is SMT.)
> 
> Sharing a runqueue for all processors on a node of a NUMA system has the
> drawback of not accounting for cache warmth for processes. [...]

hence the 'might'.

> [...] Ideally, for a NUMA system there should continue to be individual
> runqueues per cpu (or per set of HT processors), and then a grouping of
> runqueues at the node level.  At load balancing, priority should be to
> redispatch on the same processor, followed by on the same node.  The
> pain threshold for crossing the node boundary will vary depending on the
> NUMA-ness of the hardware, so it would be good to account for this in
> the scheduler.

agreed.

	Ingo

