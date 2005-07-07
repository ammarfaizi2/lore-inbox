Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261313AbVGGLvT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261313AbVGGLvT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Jul 2005 07:51:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261295AbVGGLqp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Jul 2005 07:46:45 -0400
Received: from ozlabs.org ([203.10.76.45]:39362 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261320AbVGGLpp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Jul 2005 07:45:45 -0400
Date: Thu, 7 Jul 2005 19:24:25 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Avi Kivity <avi@argo.co.il>
Cc: linux-kernel@vger.kernel.org, linuxppc64-dev@ozlabs.org
Subject: Re: RFC: Hugepage COW
Message-ID: <20050707092425.GA10044@localhost.localdomain>
Mail-Followup-To: Avi Kivity <avi@argo.co.il>, linux-kernel@vger.kernel.org,
	linuxppc64-dev@ozlabs.org
References: <20050707055554.GC11246@localhost.localdomain> <1120718967.2989.7.camel@blast.q>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1120718967.2989.7.camel@blast.q>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, Jul 07, 2005 at 09:49:27AM +0300, Avi Kivity wrote:
> On Thu, 2005-07-07 at 15:55 +1000, David Gibson wrote:
> 
> > MAP_PRIVATE|MAP_WRITE mappings of hugetlbfs.  Because the pool of
> > hugepages is limited, a write to a MAP_PRIVATE hugepage region may
> > result in a SIGBUS, if a new hugepage cannot be allocated.  This patch
> 
> in that case you might allocate regular pages for the new copy.

That's not necessarily possible.  On some archs - ppc64 for one -
the mmu has to be set up for hugepages on a granularity greater than
the hugepage size.  So you can just arbitrarily substitute normal
pages for hugepages.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/people/dgibson
