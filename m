Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266347AbTATQt7>; Mon, 20 Jan 2003 11:49:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266353AbTATQt7>; Mon, 20 Jan 2003 11:49:59 -0500
Received: from mx1.elte.hu ([157.181.1.137]:21635 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S266347AbTATQt4>;
	Mon, 20 Jan 2003 11:49:56 -0500
Date: Mon, 20 Jan 2003 18:04:36 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Erich Focht <efocht@ess.nec.de>
Cc: Michael Hohnbaum <hohnbaum@us.ibm.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       Matthew Dobson <colpatch@us.ibm.com>,
       Christoph Hellwig <hch@infradead.org>, Robert Love <rml@tech9.net>,
       Andrew Theurer <habanero@us.ibm.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       lse-tech <lse-tech@lists.sourceforge.net>
Subject: Re: [patch] sched-2.5.59-A2
In-Reply-To: <Pine.LNX.4.44.0301201743230.11746-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0301201802300.11746-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 20 Jan 2003, Ingo Molnar wrote:

> ie. SMP is just the first level in the cache-hierarchy, NUMA is the
> second level. (lets hope we dont have to deal with a third caching level
> anytime soon - although that could as well happen once SMT CPUs start
> doing NUMA.)

or as Arjan points out, like the IBM x440 boxes ...

i think we want to handle SMT on a different level, ie. via the
shared-runqueue approach, so it's not a genuine new level of caching, it's
rather a new concept of multiple logical cores per physical core. (which
needs is own code in the scheduler.)

	Ingo

