Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266755AbTBYEnx>; Mon, 24 Feb 2003 23:43:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266796AbTBYEnx>; Mon, 24 Feb 2003 23:43:53 -0500
Received: from bitmover.com ([192.132.92.2]:53897 "EHLO mail.bitmover.com")
	by vger.kernel.org with ESMTP id <S266755AbTBYEnw>;
	Mon, 24 Feb 2003 23:43:52 -0500
Date: Mon, 24 Feb 2003 20:54:04 -0800
From: Larry McVoy <lm@bitmover.com>
To: William Lee Irwin III <wli@holomorphy.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>, Larry McVoy <lm@bitmover.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Minutes from Feb 21 LSE Call
Message-ID: <20030225045404.GA26831@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	William Lee Irwin III <wli@holomorphy.com>,
	"Martin J. Bligh" <mbligh@aracnet.com>,
	Larry McVoy <lm@bitmover.com>, linux-kernel@vger.kernel.org
References: <20030222231552.GA31268@work.bitmover.com> <3610000.1045957443@[10.10.2.4]> <20030224045616.GB4215@work.bitmover.com> <48940000.1046063797@[10.10.2.4]> <20030224065826.GA5665@work.bitmover.com> <20030224075142.GA10396@holomorphy.com> <20030224154725.GB5665@work.bitmover.com> <20030224233638.GS10411@holomorphy.com> <20030225002309.GA12146@work.bitmover.com> <20030225044236.GB10396@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030225044236.GB10396@holomorphy.com>
User-Agent: Mutt/1.4i
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Userspace owns the cache; using
> cache for the kernel is "cache pollution", which should be minimized.
> Going too far out on the space end of time/space tradeoff curves is
> every bit as bad for SMP as UP, and really horrible for NUMA.

Cool, I agree 100% with this.

> > So "measuring" doesn't mean "it's not slower on XYZ microbenchmark".
> > It means "under the following work loads the cache misses went down or
> > stayed the same for before and after tests".
> 
> This kind of measurement is actually relatively unusual. I'm definitely
> interested in it, as there appear to be some deficits wrt. locality of
> reference that show up as big profile spikes on NUMA boxen. With care
> exercised good solutions should also trim down cache misses on UP also.
> Cache and TLB miss profile driven development sounds very attractive.

Again, I'm with you all the way on this.  If the scale up guys can adopt
this as a mantra, I'm a lot less concerned that anything bad will happen.

Tim at OSDL and I have been talking about trying to work out some benchmarks
to test for this.  I came up with the idea of adding a "-s XXX" which means
"touch XXX bytes between each iteration" to each LMbench test.  One problem
is the lack of page coloring will make the numbers bounce around too much.
We talked that over with Linus and he suggested using the big TLB hack to
get around that.  Assuming we can deal with the page coloring, do you think
that there is any merit in taking microbenchmarks, adding an artificial
working set, and running those?

> Let me put it this way: IBM sells tiny boxen too, from 4x, to UP, to
> whatever. And people are simultaneously actively trying to scale
> downward to embedded bacteria or whatever. 

That's really great, I know it's a lot less sexy but it's important.
I'd love to see as much attention on making Linux work on tiny embedded
platforms as there is on making it work on big iron.  Small is cool too.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
