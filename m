Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315285AbSFTRQw>; Thu, 20 Jun 2002 13:16:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315287AbSFTRQv>; Thu, 20 Jun 2002 13:16:51 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:59659 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S315285AbSFTRQt>; Thu, 20 Jun 2002 13:16:49 -0400
Date: Thu, 20 Jun 2002 10:15:19 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Cort Dougan <cort@fsmlabs.com>
cc: "Eric W. Biederman" <ebiederm@xmission.com>,
       Benjamin LaHaise <bcrl@redhat.com>,
       Rusty Russell <rusty@rustcorp.com.au>, Robert Love <rml@tech9.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: latest linus-2.5 BK broken
In-Reply-To: <20020620103003.C6243@host110.fsmlabs.com>
Message-ID: <Pine.LNX.4.44.0206201003500.8225-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 20 Jun 2002, Cort Dougan wrote:
>
> "Beating the SMP horse to death" does make sense for 2 processor SMP
> machines.

It makes fine sense for any tightly coupled system, where the tight
coupling is cost-efficient.

Today that means 2 CPU's, and maybe 4.

Things like SMT (Intel calls it "HT") increase that to 4/8. It's just
_cheaper_ to do that kind of built-in SMP support than it is to not use
it.

The important part of what Cort says is "commodity". Not the "small number
of CPU's". Linux is focusing on SMP, because it is the ONLY INTERESTING
HARDWARE BASE in the commodity space.

ccNuma and clusters just aren't even on the _radar_ from a commodity
standpoint. While commodity 4- and 8-way SMP is just a few years away.

So because SMP hardware is cheap and efficient, all reasonable scalability
work is done on SMP. And the fringe is just that - fringe. The
numa/cluster fringe tends to try to use SMP approaches because they know
they are a minority, and they want to try to leverage off the commodity.

And it will continue to be this way for the forseeable future. People
should just accept the fact.

The only thing that may change the current state of affairs is that some
cluster/numa issues are slowly percolating down and they may become more
commoditized. For example, I think the AMD approach to SMP on the hammer
series is "local memories" with a fast CPU interconnect. That's a lot more
NUMA than we're used to in the PC space.

On the other hand, another interesting trend seems to be that since
commoditizing NUMA ends up being done with a lot of integration, the
actual _latency_ difference is so small that those potential future
commodity NUMA boxes can be considered largely UMA/SMP.

And I guarantee Linux will scale up fine to 16 CPU's, once that is
commodity. And the rest is just not all that important.

		Linus

