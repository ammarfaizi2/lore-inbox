Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261420AbSIWVRe>; Mon, 23 Sep 2002 17:17:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261428AbSIWVRe>; Mon, 23 Sep 2002 17:17:34 -0400
Received: from wsip68-15-8-100.sd.sd.cox.net ([68.15.8.100]:59776 "EHLO
	gnuppy.monkey.org") by vger.kernel.org with ESMTP
	id <S261420AbSIWVRd>; Mon, 23 Sep 2002 17:17:33 -0400
Date: Mon, 23 Sep 2002 14:22:40 -0700
To: Bill Davidsen <davidsen@tmr.com>
Cc: Larry McVoy <lm@bitmover.com>, Peter Waechtler <pwaechtler@mac.com>,
       linux-kernel@vger.kernel.org, ingo Molnar <mingo@redhat.com>,
       "Bill Huey (Hui)" <billh@gnuppy.monkey.org>
Subject: Re: [ANNOUNCE] Native POSIX Thread Library 0.1
Message-ID: <20020923212240.GC2075@gnuppy.monkey.org>
References: <20020922143257.A8397@work.bitmover.com> <Pine.LNX.3.96.1020923055128.11375A-100000@gatekeeper.tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.3.96.1020923055128.11375A-100000@gatekeeper.tmr.com>
User-Agent: Mutt/1.4i
From: Bill Huey (Hui) <billh@gnuppy.monkey.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 23, 2002 at 06:05:18AM -0400, Bill Davidsen wrote:
> And BSD? And Solaris?

Me and buddy of mine ran lmbench on NetBSD 1.6 (ppc) and a recent version
of Linux (same machine) and found that NetBSD was about 2x slower than
Linux for context switching. It's really not that bad considering that it
was worse at one point. It might effect things like inter-process pipe
communication performance, but it's not outside of reasonablility to use
a 1:1 system in that case.

BTW, NetBSD is moving to a scheduler activations threading system and
they have some preliminary stuff in the works and working. ;)

> > If that's a true statement, and in Linux it tends to be far more true
> > than other operating systems, then there is no reason to have M:N.
> 
> No matter how fast you do context switch in and out of kernel and a sched
> to see what runs next, it can't be done as fast as it can be avoided.
> Being N:M doesn't mean all implementations must be faster, just that doing
> it all in user mode CAN be faster.

Unless you have a broken architecture like the x86. The FPU in that case
can be problematic and folks where playing around with adding a syscall
to query the status of the FPU. They things might be more even, but...
this is also unclear as to how these variables are going to play out.

> Benchmarks are nice, I await results from a loaded production threaded
> DNS/mail/web/news/database server. Well, I guess production and 2.5 don't
> really go together, do they, but maybe some experimental site which could
> use 2.5 long enough to get numbers. If you could get a threaded database
> to run, that would be a good test of shared resources rather than a bunch
> of independent activities doing i/o. 

I think that would be interesting too.

bill

