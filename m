Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262239AbTE0BSb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 May 2003 21:18:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262528AbTE0BQD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 May 2003 21:16:03 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:23250
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S262430AbTE0BPE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 May 2003 21:15:04 -0400
Date: Tue, 27 May 2003 03:28:18 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Dave Jones <davej@codemonkey.org.uk>, "David S. Miller" <davem@redhat.com>,
       akpm@digeo.com, davidsen@tmr.com, haveblue@us.ibm.com,
       habanero@us.ibm.com, mbligh@aracnet.com, linux-kernel@vger.kernel.org
Subject: Re: userspace irq balancer
Message-ID: <20030527012818.GI3767@dualathlon.random>
References: <20030527000639.GA3767@dualathlon.random> <20030526.171527.35691510.davem@redhat.com> <20030527004115.GD3767@dualathlon.random> <20030526.174841.116378513.davem@redhat.com> <20030527010903.GF3767@dualathlon.random> <20030527011620.GB7135@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030527011620.GB7135@suse.de>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43
X-PGP-Key: 1024R/CB4660B9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 27, 2003 at 02:16:20AM +0100, Dave Jones wrote:
> On Tue, May 27, 2003 at 03:09:03AM +0200, Andrea Arcangeli wrote:
> 
>  > > So I'm asking you, again, how are you going to measure softirq load in
>  > > making hardware IRQ load balancing decisions?  Watching the scheduling
>  > 
>  > rdtsc could do it very well, irqs and softirqs can't be rescheduled so
>  > you can tick measure how long you take in each cpu
> 
> On CPUs that vary frequency, this will break, unless TSC scales
> with frequency. You cannot assume that this will be the case.

those stats would per-second or similar anyways. so unless you change
frequency every second it won't matter. it's an heuristic. And
especially if you change frequency on all cpus at nearly the same time
as I expect it will matter even less since it would decrease the window
even more.

Andrea
