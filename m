Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268293AbUGXF0L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268293AbUGXF0L (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jul 2004 01:26:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268294AbUGXF0L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jul 2004 01:26:11 -0400
Received: from smtp015.mail.yahoo.com ([216.136.173.59]:24167 "HELO
	smtp015.mail.yahoo.com") by vger.kernel.org with SMTP
	id S268293AbUGXF0J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jul 2004 01:26:09 -0400
Message-ID: <4101F2ED.3050208@yahoo.com.au>
Date: Sat, 24 Jul 2004 15:26:05 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040707 Debian/1.7-5
X-Accept-Language: en
MIME-Version: 1.0
To: Jesse Barnes <jbarnes@engr.sgi.com>
CC: Dimitri Sivanich <sivanich@sgi.com>, linux-kernel@vger.kernel.org,
       John Hawkes <hawkes@sgi.com>
Subject: Re: [RFC] Patch for isolated scheduler domains
References: <20040722164126.GB13189@sgi.com> <200407231603.09055.jbarnes@engr.sgi.com>
In-Reply-To: <200407231603.09055.jbarnes@engr.sgi.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesse Barnes wrote:
> On Thursday, July 22, 2004 12:41 pm, Dimitri Sivanich wrote:
> 
>>I'm interested in implementing something I'll call isolated sched domains
>>for single cpus (to minimize the latencies involved when doing things like
>>load balancing on certain select cpus) on IA64.
> 
> 
> And here's what I had in mind for restricting the CPU span of a given node's 
> domain.  I haven't even compiled it though, so it probably won't work.  I'm 
> just posting it for comments.
> 
> I think the code can be reused for a hierarchical system too, by simply 
> looping in sched_domain_node_span with a few different values of SD_MAX_NODE.
> 
> Any thoughts?
> 

Yeah that is like what I had in mind.

You might have the theoretical problem of ending up with more than
one disjoint top level domain (ie. no overlap, basically partitioning
the CPUs).

No doubt you could come up with something provably correct, however
it might just be good enough to examine the end result and check that
it is good. At least while you test different configurations.
