Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265134AbUGJP6t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265134AbUGJP6t (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jul 2004 11:58:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265154AbUGJP6t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jul 2004 11:58:49 -0400
Received: from mail-relay-4.tiscali.it ([212.123.84.94]:40112 "EHLO
	sparkfist.tiscali.it") by vger.kernel.org with ESMTP
	id S265134AbUGJP6s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jul 2004 11:58:48 -0400
Date: Sat, 10 Jul 2004 17:58:34 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Ingo Molnar <mingo@elte.hu>
Cc: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
       Arjan van de Ven <arjanv@redhat.com>
Subject: Re: [announce] [patch] Voluntary Kernel Preemption Patch
Message-ID: <20040710155834.GJ20947@dualathlon.random>
References: <20040709182638.GA11310@elte.hu> <20040709195105.GA4807@infradead.org> <20040710124814.GA27345@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040710124814.GA27345@elte.hu>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 10, 2004 at 02:48:14PM +0200, Ingo Molnar wrote:
> if you dont care about latencies and want to maximize throughput (for
> e.g. servers) then you dont want to enable CONFIG_PREEMPT_VOLUNTARY. 
> That way you get artificial batching of parallel workloads.

you just agreed a second time to make all the pollution go away, so why
are you talking about servers now? I mean, I don't see why production
environments should run the benchmarking testcode. And I totally
disagree CONFIG_PREEMPT_VOLUNTARY disabled could provide any benefit on
a server (even with the benchmarking on). Servers have to start the next
I/O too to avoid leaving some disk idle during a copy-user etc..

let's assume you convert the benchmark sysctl knob into a
CONFIG_LOW_RESCHEDULE_OVERHEAD as I suggested in the 30 lines rant, only
then it could make sense to classify some of the scheduling points as
"high-overhead", but I don't see the need of
CONFIG_LOW_RESCHEDULE_OVERHEAD happening any time soon.  Though such a
config option would make sense theoretically.
