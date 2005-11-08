Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965066AbVKHBVv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965066AbVKHBVv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 20:21:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965069AbVKHBVu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 20:21:50 -0500
Received: from ozlabs.org ([203.10.76.45]:14984 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S965066AbVKHBVu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 20:21:50 -0500
Date: Tue, 8 Nov 2005 12:21:38 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Adam Litke <agl@us.ibm.com>, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org, hugh@veritas.com, rohit.seth@intel.com,
       "Chen, Kenneth W" <kenneth.w.chen@intel.com>, akpm@osdl.org
Subject: Re: [RFC 1/2] Hugetlb fault fixes and reorg
Message-ID: <20051108012138.GA10769@localhost.localdomain>
Mail-Followup-To: David Gibson <david@gibson.dropbear.id.au>,
	William Lee Irwin III <wli@holomorphy.com>,
	Adam Litke <agl@us.ibm.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, hugh@veritas.com,
	rohit.seth@intel.com, "Chen, Kenneth W" <kenneth.w.chen@intel.com>,
	akpm@osdl.org
References: <1131397841.25133.90.camel@localhost.localdomain> <1131399496.25133.103.camel@localhost.localdomain> <20051107233053.GG29402@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051107233053.GG29402@holomorphy.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 07, 2005 at 03:30:53PM -0800, William Lee Irwin wrote:
> On Mon, Nov 07, 2005 at 03:38:16PM -0600, Adam Litke wrote:
> > (Patch originally from David Gibson <david@gibson.dropbear.id.au>)
> > Initial Post: Tue. 25 Oct 2005
> > -static struct page *find_lock_huge_page(struct address_space *mapping,
> > -			unsigned long idx)
> > +static struct page *find_or_alloc_huge_page(struct address_space *mapping,
> > +					    unsigned long idx)
> >  {
> >  	struct page *page;
> >  	int err;
> > -	struct inode *inode = mapping->host;
> > -	unsigned long size;
> 
> This patch is a combination of function renaming, variable
> initialization/assignment and return path/etc. oddities, plus some
> functional changes (did I catch them all?) which apparently took a bit
> of effort to get to after sifting through the rest of that.

Functional changes?   There shouldn't be...

> Dump the parallel cleanups or split them into pure cleanup and pure
> functional patches. I don't mind the cleanups, I mind the mixing.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
