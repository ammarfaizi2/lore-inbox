Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261432AbVEXSDs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261432AbVEXSDs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 May 2005 14:03:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261369AbVEXSDs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 May 2005 14:03:48 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:40946 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S261466AbVEXSBn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 May 2005 14:01:43 -0400
Subject: Re: RT patch acceptance
From: Daniel Walker <dwalker@mvista.com>
Reply-To: dwalker@mvista.com
To: Ingo Molnar <mingo@elte.hu>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>,
       Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
       akpm@osdl.org, sdietrich@mvista.com
In-Reply-To: <20050524081517.GA22205@elte.hu>
References: <1116890066.13086.61.camel@dhcp153.mvista.com>
	 <20050524054722.GA6160@infradead.org> <20050524064522.GA9385@elte.hu>
	 <4292DFC3.3060108@yahoo.com.au>  <20050524081517.GA22205@elte.hu>
Content-Type: text/plain
Organization: MontaVista
Date: Tue, 24 May 2005 11:01:30 -0700
Message-Id: <1116957690.31174.31.camel@dhcp153.mvista.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-05-24 at 10:15 +0200, Ingo Molnar wrote:
> * Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> 
> > Of course this is weighed off against the improvements added to the
> > kernel. I'm personally not too clear on what those improvements are; a
> > bit better soft-realtime response? (I don't know) [...]
> 
> what the -RT kernel (PREEMPT_RT) offers are guaranteed hard-realtime 
> responses. ~15 usecs worst-case latency on a 2GHz Athlon64. On arbitrary 
> (SCHED_OTHER) workloads. (I.e. i've measured such worst-case latencies 
> when running 1000 hackbench tasks or when swapping the box to death, or 
> when running 40 parallel copies of the LTP testsuite.)


I wouldn't start making guarantees yet .. For instance printk can hold
off interrupts for unknown periods (unknown to me anyway) depending on
the size of the strings that it prints.

Daniel

