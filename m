Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265343AbSIWKHn>; Mon, 23 Sep 2002 06:07:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265346AbSIWKHn>; Mon, 23 Sep 2002 06:07:43 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:49415 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S265343AbSIWKHm>; Mon, 23 Sep 2002 06:07:42 -0400
Date: Mon, 23 Sep 2002 06:05:18 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Larry McVoy <lm@bitmover.com>
cc: Peter Waechtler <pwaechtler@mac.com>, linux-kernel@vger.kernel.org,
       ingo Molnar <mingo@redhat.com>
Subject: Re: [ANNOUNCE] Native POSIX Thread Library 0.1
In-Reply-To: <20020922143257.A8397@work.bitmover.com>
Message-ID: <Pine.LNX.3.96.1020923055128.11375A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 22 Sep 2002, Larry McVoy wrote:

> On Sun, Sep 22, 2002 at 08:55:39PM +0200, Peter Waechtler wrote:
> > AIX and Irix deploy M:N - I guess for a good reason: it's more
> > flexible and combine both approaches with easy runtime tuning if
> > the app happens to run on SMP (the uncommon case).
> 
> No, AIX and IRIX do it that way because their processes are so bloated
> that it would be unthinkable to do a 1:1 model.

And BSD? And Solaris?
 
> Instead of taking the traditional "we've screwed up the normal system 
> primitives so we'll event new lightweight ones" try this:
> 
> We depend on the system primitives to not be broken or slow.
> 
> If that's a true statement, and in Linux it tends to be far more true
> than other operating systems, then there is no reason to have M:N.

No matter how fast you do context switch in and out of kernel and a sched
to see what runs next, it can't be done as fast as it can be avoided.
Being N:M doesn't mean all implementations must be faster, just that doing
it all in user mode CAN be faster.

Benchmarks are nice, I await results from a loaded production threaded
DNS/mail/web/news/database server. Well, I guess production and 2.5 don't
really go together, do they, but maybe some experimental site which could
use 2.5 long enough to get numbers. If you could get a threaded database
to run, that would be a good test of shared resources rather than a bunch
of independent activities doing i/o. 

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

