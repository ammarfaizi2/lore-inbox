Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751122AbWBJFiU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751122AbWBJFiU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 00:38:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751124AbWBJFiU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 00:38:20 -0500
Received: from mail14.syd.optusnet.com.au ([211.29.132.195]:59545 "EHLO
	mail14.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1751122AbWBJFiT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 00:38:19 -0500
From: Con Kolivas <kernel@kolivas.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: [PATCH] mm: Implement Swap Prefetching v23
Date: Fri, 10 Feb 2006 16:37:57 +1100
User-Agent: KMail/1.9.1
Cc: Andrew Morton <akpm@osdl.org>, linux-mm@kvack.org, ck@vds.kolivas.org,
       pj@sgi.com, linux-kernel@vger.kernel.org
References: <200602101355.41421.kernel@kolivas.org> <200602101626.12824.kernel@kolivas.org> <43EC2572.7010100@yahoo.com.au>
In-Reply-To: <43EC2572.7010100@yahoo.com.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602101637.57821.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 10 February 2006 16:32, Nick Piggin wrote:
> Con Kolivas wrote:
> > Just so it's clear I understand, is this what you (both) had in mind?
> > Inline so it's not built for !CONFIG_SWAP_PREFETCH
>
> Close...

> > +inline void lru_cache_add_tail(struct page *page)
>
> Is this inline going to do what you intend?

I don't care if it's actually inlined, but the subtleties of compilers is way 
beyond me. All it positively achieves is silencing the unused function 
warning so I had hoped it meant that function was not built. I tend to be 
wrong though...

>      spin_lock_irq(&zone->lru_lock);
>
> > +	add_page_to_inactive_list_tail(zone, page);
>
>      spin_unlock_irq(&zone->lru_lock);

Thanks!

Cheers,
Con
