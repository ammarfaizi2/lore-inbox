Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751213AbWHPPGF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751213AbWHPPGF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 11:06:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751217AbWHPPGF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 11:06:05 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:58276 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1751213AbWHPPGE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 11:06:04 -0400
Date: Wed, 16 Aug 2006 08:05:35 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Andi Kleen <ak@muc.de>
cc: mpm@selenic.com, Marcelo Tosatti <marcelo@kvack.org>,
       linux-kernel@vger.kernel.org, Nick Piggin <nickpiggin@yahoo.com.au>,
       Andi Kleen <ak@suse.de>, Manfred Spraul <manfred@colorfullife.com>,
       Dave Chinner <dgc@sgi.com>
Subject: Re: [MODSLAB 0/7] A modular slab allocator V1
In-Reply-To: <20060816095254.14ac872c.ak@muc.de>
Message-ID: <Pine.LNX.4.64.0608160803210.16619@schroedinger.engr.sgi.com>
References: <20060816022238.13379.24081.sendpatchset@schroedinger.engr.sgi.com>
 <20060816095254.14ac872c.ak@muc.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Aug 2006, Andi Kleen wrote:

> What other ones do we have?

vmalloc and the page allocators you derive from others using the 
framework.

> > 1. shrink_slab takes a function to move object. Using that
> >    function slabs can be defragmented to ease slab reclaim.
> 
> Does that help with the inefficient dcache/icache pruning? 

It will fix that if the dcache/icache would provide a move object
function.

> 
> > - No support for pagese
> 
> What does that mean?

That was just clutter. Sorry.

> 
> > Performance tests with AIM7 on an 8p Itanium machine (4 NUMA nodes)
> > (Memory spreading active which means that we do not take advantage of NUMA locality
> > in favor of load balancing)
> 
> Hmm, i'm not sure how allocator intensive AIM7 is. I guess networking
> would be a good test because it is very sensitive to allocator performance.
> Perhaps also check with the routing people on netdev -- they seem to be able
> to stress the allocator very much.

Yeah, well I think the implementations could be much more sophisticated 
and one should do better tests but I am not sure how much time I can spend 
on them.

