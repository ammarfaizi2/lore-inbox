Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261639AbVBDGqD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261639AbVBDGqD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 01:46:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262698AbVBDGoO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 01:44:14 -0500
Received: from smtp101.mail.sc5.yahoo.com ([216.136.174.139]:53951 "HELO
	smtp101.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S263534AbVBDGn3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 01:43:29 -0500
Subject: Re: A scrub daemon (prezeroing)
From: Nick Piggin <nickpiggin@yahoo.com.au>
To: Christoph Lameter <clameter@sgi.com>
Cc: Paul Mackerras <paulus@samba.org>, Rik van Riel <riel@redhat.com>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       David Woodhouse <dwmw2@infradead.org>, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org, akpm@osdl.org
In-Reply-To: <Pine.LNX.4.58.0502032220430.28851@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.58.0501211228430.26068@schroedinger.engr.sgi.com>
	 <1106828124.19262.45.camel@hades.cambridge.redhat.com>
	 <20050202153256.GA19615@logos.cnet>
	 <Pine.LNX.4.58.0502021103410.12695@schroedinger.engr.sgi.com>
	 <20050202163110.GB23132@logos.cnet>
	 <Pine.LNX.4.61.0502022204140.2678@chimarrao.boston.redhat.com>
	 <16898.46622.108835.631425@cargo.ozlabs.ibm.com>
	 <Pine.LNX.4.58.0502031650590.26551@schroedinger.engr.sgi.com>
	 <16899.2175.599702.827882@cargo.ozlabs.ibm.com>
	 <Pine.LNX.4.58.0502032220430.28851@schroedinger.engr.sgi.com>
Content-Type: text/plain
Date: Fri, 04 Feb 2005 17:43:23 +1100
Message-Id: <1107499403.5461.32.camel@npiggin-nld.site>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-02-03 at 22:26 -0800, Christoph Lameter wrote:
> On Fri, 4 Feb 2005, Paul Mackerras wrote:
> 
> > As has my scepticism about pre-zeroing actually providing any benefit
> > on ppc64.  Nevertheless, the only definitive answer is to actually
> > measure the performance both ways.
> 
> Of course. The optimization depends on the type of load. If you use a
> benchmark that writes to all pages in a page then you will see no benefit
> at all. For a kernel compile you will see a slight benefit. For processing
> of a sparse matrix (page tables are one example) a significant benefit can
> be obtained.

If you have got to the stage of doing "real world" tests, I'd be
interested to see results of tests that best highlight the improvements.

I imagine many general purpose server things wouldn't be helped much,
because they'll typically have little free memory, and will be
continually working and turning things over.

A kernel compile on a newly booted system? Well that is a valid test.
It is great that performance doesn't *decrease* in that case :P

Of course HPC things may be a different story. It would be good to
see your gross improvement on typical types of workloads that can best
leverage this - and not just initial ramp up phases while memory is
being faulted in, but the the full run time.

Thanks,
Nick



