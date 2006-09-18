Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965559AbWIRIQf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965559AbWIRIQf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Sep 2006 04:16:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965560AbWIRIQf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Sep 2006 04:16:35 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:47800 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S965559AbWIRIQe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Sep 2006 04:16:34 -0400
Message-ID: <450E55BB.80208@sgi.com>
Date: Mon, 18 Sep 2006 10:15:55 +0200
From: Jes Sorensen <jes@sgi.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060527)
MIME-Version: 1.0
To: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
Cc: Ingo Molnar <mingo@elte.hu>, Roman Zippel <zippel@linux-m68k.org>,
       Andrew Morton <akpm@osdl.org>, tglx@linutronix.de, karim@opersys.com,
       Paul Mundt <lethal@linux-sh.org>, linux-kernel@vger.kernel.org,
       Christoph Hellwig <hch@infradead.org>, Ingo Molnar <mingo@redhat.com>,
       Greg Kroah-Hartman <gregkh@suse.de>, Tom Zanussi <zanussi@us.ibm.com>,
       ltt-dev@shafik.org, Michel Dagenais <michel.dagenais@polymtl.ca>
Subject: Re: [PATCH 0/11] LTTng-core (basic tracing infrastructure) 0.5.108
References: <450AB957.2050206@opersys.com> <20060915142836.GA9288@localhost.usen.ad.jp> <450ABE08.2060107@opersys.com> <1158332447.5724.423.camel@localhost.localdomain> <20060915111644.c857b2cf.akpm@osdl.org> <20060915181907.GB17581@elte.hu> <Pine.LNX.4.64.0609152111030.6761@scrub.home> <20060915200559.GB30459@elte.hu> <20060915202233.GA23318@Krystal> <450BCAF1.2030205@sgi.com> <20060916173035.GA705@Krystal>
In-Reply-To: <20060916173035.GA705@Krystal>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mathieu Desnoyers wrote:
> And about those extra cycles.. according to :
> Documentation/kprobes.txt
> "6. Probe Overhead
> 
> On a typical CPU in use in 2005, a kprobe hit takes 0.5 to 1.0
> microseconds to process.  Specifically, a benchmark that hits the same
> probepoint repeatedly, firing a simple handler each time, reports 1-2
> million hits per second, depending on the architecture.  A jprobe or
> return-probe hit typically takes 50-75% longer than a kprobe hit.
> When you have a return probe set on a function, adding a kprobe at
> the entry to that function adds essentially no overhead.
[snip]
> So, 1 microsecond seems more like 1500-2000 cycles to me, not 50.

So call it 2000 cycles, now go measure it in *real* life benchmarks
and not some artificial I call this one syscall that hits the probe
every time in a tight loop, kinda thing.

Show us some *real* numbers please.

Jes
