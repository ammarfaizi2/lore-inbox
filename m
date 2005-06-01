Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261521AbVFAXu6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261521AbVFAXu6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 19:50:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261512AbVFAXse
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 19:48:34 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:44180 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261520AbVFAXrj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 19:47:39 -0400
Date: Wed, 1 Jun 2005 16:47:30 -0700
From: Mike Kravetz <kravetz@us.ibm.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: jschopp@austin.ibm.com, Mel Gorman <mel@csn.ul.ie>, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: Avoiding external fragmentation with a placement policy Version 12
Message-ID: <20050601234730.GF3998@w-mikek2.ibm.com>
References: <20050531112048.D2511E57A@skynet.csn.ul.ie> <429E20B6.2000907@austin.ibm.com> <429E4023.2010308@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <429E4023.2010308@yahoo.com.au>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 02, 2005 at 09:09:23AM +1000, Nick Piggin wrote:
> 
> It adds a lot of complexity to the page allocator and while
> it might be very good, the only improvement we've been shown
> yet is allocating lots of MAX_ORDER allocations I think? (ie.
> not very useful)
> 

Allocating lots of MAX_ORDER blocks can be very useful for things
like hot-pluggable memory.  I know that this may not be of interest
to most.  However, I've been combining Mel's defragmenting patch
with the memory hotplug patch set.  As a result, I've been able to
go from 5GB down to 544MB of memory on my ppc64 system via offline
operations.  Note that ppc64 only employs a single (DMA) zone.  So,
page 'grouping' based on use is coming mainly from Mel's patch.

-- 
Mike
