Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261403AbSIWSm7>; Mon, 23 Sep 2002 14:42:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261405AbSIWSm5>; Mon, 23 Sep 2002 14:42:57 -0400
Received: from zeus.kernel.org ([204.152.189.113]:27041 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S261403AbSIWSma>;
	Mon, 23 Sep 2002 14:42:30 -0400
Date: Mon, 23 Sep 2002 08:30:04 -0700
From: Larry McVoy <lm@bitmover.com>
To: Bill Davidsen <davidsen@tmr.com>
Cc: Larry McVoy <lm@bitmover.com>, Peter Waechtler <pwaechtler@mac.com>,
       linux-kernel@vger.kernel.org, ingo Molnar <mingo@redhat.com>
Subject: Re: [ANNOUNCE] Native POSIX Thread Library 0.1
Message-ID: <20020923083004.B14944@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Bill Davidsen <davidsen@tmr.com>, Larry McVoy <lm@bitmover.com>,
	Peter Waechtler <pwaechtler@mac.com>, linux-kernel@vger.kernel.org,
	ingo Molnar <mingo@redhat.com>
References: <20020922143257.A8397@work.bitmover.com> <Pine.LNX.3.96.1020923055128.11375A-100000@gatekeeper.tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.3.96.1020923055128.11375A-100000@gatekeeper.tmr.com>; from davidsen@tmr.com on Mon, Sep 23, 2002 at 06:05:18AM -0400
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Instead of taking the traditional "we've screwed up the normal system 
> > primitives so we'll event new lightweight ones" try this:
> > 
> > We depend on the system primitives to not be broken or slow.
> > 
> > If that's a true statement, and in Linux it tends to be far more true
> > than other operating systems, then there is no reason to have M:N.
> 
> No matter how fast you do context switch in and out of kernel and a sched
> to see what runs next, it can't be done as fast as it can be avoided.

You are arguing about how many angels can dance on the head of a pin.
Sure, there are lotso benchmarks which show how fast user level threads
can context switch amongst each other and it is always faster than going
into the kernel.  So what?  What do you think causes a context switch in
a threaded program?  What?  Could it be blocking on I/O?  Like 99.999%
of the time?  And doesn't that mean you already went into the kernel to
see if the I/O was ready?  And doesn't that mean that in all the real
world applications they are already doing all the work you are arguing
to avoid?
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
