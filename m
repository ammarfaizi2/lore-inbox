Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751064AbWHPJji@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751064AbWHPJji (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 05:39:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751065AbWHPJji
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 05:39:38 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:61641 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751058AbWHPJjh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 05:39:37 -0400
Date: Wed, 16 Aug 2006 19:38:25 +1000
From: David Chinner <dgc@sgi.com>
To: Matt Mackall <mpm@selenic.com>
Cc: Andi Kleen <ak@muc.de>, Christoph Lameter <clameter@sgi.com>,
       Marcelo Tosatti <marcelo@kvack.org>, linux-kernel@vger.kernel.org,
       Nick Piggin <nickpiggin@yahoo.com.au>, Andi Kleen <ak@suse.de>,
       Manfred Spraul <manfred@colorfullife.com>, Dave Chinner <dgc@sgi.com>
Subject: Re: [MODSLAB 0/7] A modular slab allocator V1
Message-ID: <20060816093825.GN51703024@melbourne.sgi.com>
References: <20060816022238.13379.24081.sendpatchset@schroedinger.engr.sgi.com> <20060816095254.14ac872c.ak@muc.de> <20060816084119.GW6908@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060816084119.GW6908@waste.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 16, 2006 at 03:41:19AM -0500, Matt Mackall wrote:
> On Wed, Aug 16, 2006 at 09:52:54AM +0200, Andi Kleen wrote:
> > > 1. shrink_slab takes a function to move object. Using that
> > >    function slabs can be defragmented to ease slab reclaim.
> > 
> > Does that help with the inefficient dcache/icache pruning? 
> 
> There was a fair amount of debate on this at the VM summit.
> 
> The approach we thought was most promising started with splitting the
> dcache into directory and leaf entries.

That's been tried before with no noticable effect on fragmentation.
Patch:

http://marc.theaimsgroup.com/?l=linux-mm&m=112858024817277&w=2

And informative thread:

http://marc.theaimsgroup.com/?l=linux-mm&m=112660138015732&w=2

Cheers,

Dave.
-- 
Dave Chinner
Principal Engineer
SGI Australian Software Group
