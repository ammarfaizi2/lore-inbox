Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261729AbVDDD56@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261729AbVDDD56 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Apr 2005 23:57:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261732AbVDDD56
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Apr 2005 23:57:58 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:37526 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S261729AbVDDD5z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Apr 2005 23:57:55 -0400
Date: Sun, 3 Apr 2005 20:55:58 -0700
From: Paul Jackson <pj@engr.sgi.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: mingo@elte.hu, kenneth.w.chen@intel.com, torvalds@osdl.org, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] sched: auto-tune migration costs [was: Re: Industry db
 benchmark result on recent 2.6 kernels]
Message-Id: <20050403205558.753f2b55.pj@engr.sgi.com>
In-Reply-To: <4250A195.5030306@yahoo.com.au>
References: <200504020100.j3210fg04870@unix-os.sc.intel.com>
	<20050402145351.GA11601@elte.hu>
	<20050402215332.79ff56cc.pj@engr.sgi.com>
	<20050403070415.GA18893@elte.hu>
	<20050403043420.212290a8.pj@engr.sgi.com>
	<20050403071227.666ac33d.pj@engr.sgi.com>
	<20050403152413.GA26631@elte.hu>
	<20050403160807.35381385.pj@engr.sgi.com>
	<4250A195.5030306@yahoo.com.au>
Organization: SGI
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul wrote:
> I should push in the direction of improving the
> SN2 sched domain hierarchy.

Nick wrote:
> I'd just be a bit careful about this.

Good point - thanks.

I will - be careful.  I have no delusions that I know what would be an
"improvement" to the scheduler - if anything.

Ingo, if I understood correctly, suggested pushing any necessary detail
of the CPU hierarchy into the scheduler domains, so that his latest work
tuning migration costs could pick it up from there.

It makes good sense for the migration cost estimation to be based on
whatever CPU hierarchy is visible in the sched domains.

But if we knew the CPU hierarchy in more detail, and if we had some
other use for that detail (we don't that I know), then I take it from
your comment that we should be reluctant to push those details into the
sched domains.  Put them someplace else if we need them.


One question - how serious do you view difference in migration cost
between say 21.7 and 25.3, two of the cacheflush times I reported on a
small SN2?

I'm guessing that this is probably below the noise threshold, at least
as far as scheduler domains, schedulers and migration care, unless and
until some persuasive measurements show a situation in which it matters.

As you say - not an exact science.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@engr.sgi.com> 1.650.933.1373, 1.925.600.0401
