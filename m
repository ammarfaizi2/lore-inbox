Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261566AbTGAJON (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jul 2003 05:14:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261688AbTGAJON
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jul 2003 05:14:13 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:31927
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S261566AbTGAJOB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jul 2003 05:14:01 -0400
Date: Tue, 1 Jul 2003 11:27:58 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: William Lee Irwin III <wli@holomorphy.com>, Joel.Becker@oracle.com,
       Mel Gorman <mel@csn.ul.ie>,
       Linux Memory Management List <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: What to expect with the 2.6 VM
Message-ID: <20030701092758.GC3040@dualathlon.random>
References: <Pine.LNX.4.53.0307010238210.22576@skynet> <20030701022516.GL3040@dualathlon.random> <20030701032531.GC20413@holomorphy.com> <20030701043902.GP3040@dualathlon.random> <20030701063317.GF20413@holomorphy.com> <20030701074915.GQ3040@dualathlon.random> <20030701085939.GG20413@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030701085939.GG20413@holomorphy.com>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 01, 2003 at 01:59:39AM -0700, William Lee Irwin III wrote:
> After observing that, the benchmark is flawed because
> (a) it doesn't run long enough to produce stable numbers
> (b) the results are apparently measured with gettimeofday(), which is
> 	wildly inaccurate for such short-lived phenomena
> (c) large differences in performance appear to come about as a result
> 	of differing versions of common programs (i.e. gcc)

not enough time right now to answer the whole email which is growing and
growing in size ;), but I wanted to add a quick comment on this. many
shell loads happens to do something similar, and the speed of
compilation will be a very important factor until you rewrite make and
gcc not to exit and to compile multiple files from a single invocation.

The fact is that this is not a flawed benchmark, this is a real life
workload that you can't avoid to deal with, and I want my kernel to run
the fastest on the most common apps I run. I don't mind if swapping is
slightly slower, I simply don't swap all the time for the whole system
time, while I tend to keep the cpu 100% busy always. Still I want the
best possible swapping that is zerocost for me on the other side. Giving
me a CONFIG_SLOWSWAP_FAST_GCC would be more than enough to make me
happy. I don't think I'll resist to the rmap slowdown while migrating to
2.6 if it keeps showing up in the profiling. Especially Martin's number
were not good.

Andrea
