Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261821AbSIXVaX>; Tue, 24 Sep 2002 17:30:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261822AbSIXVaX>; Tue, 24 Sep 2002 17:30:23 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:59144 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S261821AbSIXVaR>; Tue, 24 Sep 2002 17:30:17 -0400
Date: Tue, 24 Sep 2002 17:27:55 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Ingo Molnar <mingo@elte.hu>
cc: Con Kolivas <conman@kolivas.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       gcc@gcc.gnu.org
Subject: Re: [BENCHMARK] Corrected gcc3.2 v gcc2.95.3 contest results
In-Reply-To: <Pine.LNX.4.44.0209230945260.2917-100000@localhost.localdomain>
Message-ID: <Pine.LNX.3.96.1020924172145.19732F-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Sep 2002, Ingo Molnar wrote:

> 
> On Mon, 23 Sep 2002, Con Kolivas wrote:
> 
> > IO Full Load:
> > 2.5.38                  170.21          42%
> > 2.5.38-gcc32            230.77          30%
> 
> > This time only the IO loads showed a statistically significant
> > difference.
> 
> how many times are you running each test? You should run them at least
> twice (ideally 3 times at least), to establish some sort of statistical
> noise measure. Especially IO benchmarks tend to fluctuate very heavily
> depending on various things - they are also very dependent on the initial
> state - ie. how the pagecache happens to lay out, etc. Ie. a meaningful
> measurement result would be something like:

Do note that the instructions for the benchmark suggest you boot single
user, which cuts down one problem, and since Con adopted my suggestion to
allow the user to set the location of the test file, I put the big file in
a filesystem which is formatted just before the test (I knew I'd find a
use for all that disk ;-) so that stays pretty constant.

The problem of memory size on the halfmem io is more serious, on a large
system the writes are all in memory, on a small system they cause
thrashing. I run in 256m for all tests just for this reason.

Not disagreeing with what you said, but the test is not inherently subject
to much jitter given care in running it.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

