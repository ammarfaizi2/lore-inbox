Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751579AbWIRIeK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751579AbWIRIeK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Sep 2006 04:34:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751592AbWIRIeJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Sep 2006 04:34:09 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:62696 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1751579AbWIRIeI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Sep 2006 04:34:08 -0400
Message-ID: <450E59D3.8070003@sgi.com>
Date: Mon, 18 Sep 2006 10:33:23 +0200
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
References: <450AB957.2050206@opersys.com> <20060915142836.GA9288@localhost.usen.ad.jp> <450ABE08.2060107@opersys.com> <1158332447.5724.423.camel@localhost.localdomain> <20060915111644.c857b2cf.akpm@osdl.org> <20060915181907.GB17581@elte.hu> <Pine.LNX.4.64.0609152111030.6761@scrub.home> <20060915200559.GB30459@elte.hu> <20060915202233.GA23318@Krystal> <450BCAF1.2030205@sgi.com> <20060916172419.GA15427@Krystal>
In-Reply-To: <20060916172419.GA15427@Krystal>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mathieu Desnoyers wrote:
> The bottom line is :
> 
> LTTng impact on the studied phenomenon : 35% slower
> 
> LTTng+kprobes impact on the studied phenomenon : 73% slower
> 
> Therefore, I conclude that on this type of high event rate workload, kprobes
> doubles the tracer impact on the system.

For this specific benchmark, for which we have not seen the code, nor
do we know what system configuration it was run on. Sorry, but even M$'s
sham benchmarks generally tell you which system they used for their
tests.

In addition, some profiling would be interesting so we can see exactly
where things go wrong and fix it. Ingo seems to be doing a good job at
that even without you providing this basic info....

Anyway, despite what Karim likes to claim, this *is* the Linux way!
Things don't get fixed if they are not reported broken and when they
are, whoever is interested in the item will try and fix it. We are not
going to cease Linux kernel development just to please Karim.

The point of this discussion is that the concept of dynamic tracing is
the way to go. If the code isn't 100% there today, then it should be
fixed, thats *not* an excuse to add a lot of cruft based on the wrong
design when we know which path to take. I know it's hard for someone
to accept when he's thrown so much personal time into a project, but as
Ingo keeps saying, there is a lot of value in LTT, the actual markup
isn't the big issue.

Jes
