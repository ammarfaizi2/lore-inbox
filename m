Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932705AbVISVcV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932705AbVISVcV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Sep 2005 17:32:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932707AbVISVcV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Sep 2005 17:32:21 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:46044 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S932705AbVISVcU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Sep 2005 17:32:20 -0400
Date: Mon, 19 Sep 2005 14:32:04 -0700 (PDT)
From: Christoph Lameter <clameter@engr.sgi.com>
To: Andi Kleen <ak@suse.de>
cc: Andrew Morton <akpm@osdl.org>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: NUMA mempolicy /proc code in mainline shouldn't have been merged
In-Reply-To: <20050919194038.GB12810@verdi.suse.de>
Message-ID: <Pine.LNX.4.62.0509191426250.26388@schroedinger.engr.sgi.com>
References: <200509101120.19236.ak@suse.de> <Pine.LNX.4.62.0509101904070.20145@schroedinger.engr.sgi.com>
 <20050910235139.4a8865c2.akpm@osdl.org> <200509110911.22212.ak@suse.de>
 <Pine.LNX.4.62.0509190958470.25549@schroedinger.engr.sgi.com>
 <20050919194038.GB12810@verdi.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Sep 2005, Andi Kleen wrote:

> On Mon, Sep 19, 2005 at 10:11:20AM -0700, Christoph Lameter wrote:
> > However, one still does not know which memory section (vma) is allocated 
> > on which nodes. And this may be important since critical data may need to 
> 
> Maybe. Well sure of things could be maybe important. Or maybe not.
> Doesn't seem like a particularly strong case to add a lot of ugly
> code though.

We gradually need to fix the deficiencies of the policy layer. Calling 
fixes "ugly code" and refusing to discuss solutions does not help anyone.

> > External memory policy management is a necessary feature for system 
> > administration, batch process scheduling as well as for testing and 
> > debugging a system.
> 
> I'm not convinced of this at all. Most of these things proposed so far
> can be done much simpler with 90% of the functionality (e.g. just swapoff
> per process for migration) , and I haven't seen a clear rationale except
> for lots of maybes that the missing 10% are worth all the complexity
> you seem to plan to add.

Have you ever had the challenge to work with large HPC applications on a 
large NUMA system? Which things? Many HPC apps do not use swap space 
at all and we likely wont be using swap for page migration (see Marcelo's 
work on a migration cache). All I have heard is you imagining complex 
solutions ("performance counters" etc) to things that would be simple if 
the policy layer would be up to the task.
