Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261893AbVDES4q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261893AbVDES4q (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 14:56:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261905AbVDESzC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 14:55:02 -0400
Received: from fmr22.intel.com ([143.183.121.14]:12192 "EHLO
	scsfmr002.sc.intel.com") by vger.kernel.org with ESMTP
	id S261893AbVDESvV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 14:51:21 -0400
Date: Tue, 5 Apr 2005 11:51:13 -0700
From: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.12-rc2-mm1
Message-ID: <20050405115113.A17809@unix-os.sc.intel.com>
References: <20050405000524.592fc125.akpm@osdl.org> <42523F5D.7020201@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <42523F5D.7020201@yahoo.com.au>; from nickpiggin@yahoo.com.au on Tue, Apr 05, 2005 at 05:33:49PM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 05, 2005 at 05:33:49PM +1000, Nick Piggin wrote:
> Andrew Morton wrote:
> 
> > +sched-remove-unnecessary-sched-domains.patch
> > +sched-improve-pinned-task-handling-again.patch
> [snip]
> > 
> >  CPU scheduler updates
> > 
> 
> It is no problem that you picked these up for testing. But
> don't merge them yet, please.
> 
> Suresh's underlying problem with the unnecessary sched domains
> is a failing of sched-balance-exec and sched-balance-fork, which

That wasn't the only motivation. For example, on non-HT cpu's we shouldn't
be setting up SMT sched-domain, same with NUMA domains on non-NUMA systems.

> I am working on now.
> 
> Removing unnecessary domains is a nice optimisation, but just
> needs to account for a few more flags before declaring that a

Can you elaborate when we require a domain with special flags but has
no or only one group in it.

> domain is unnecessary (not to mention this probably breaks if
> isolcpus= is used). I have made some modifications to the patch

I have tested my patch with "ioslcpus=" and it works just fine.

> to fix these problems.
> 
> Lastly, I'd like to be a bit less intrusive with pinned task
> handling improvements. I think we can do this while still being
> effective in preventing livelocks.

We want to see this fixed. Please post your patch and I can let you know
the test results.

> 
> I will keep you posted with regards to the various scheduler
> patches.

Nick, Can you post the patches you sent me earlier to this list?

thanks,
suresh
