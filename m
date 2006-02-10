Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751096AbWBJE4f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751096AbWBJE4f (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Feb 2006 23:56:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751097AbWBJE4f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Feb 2006 23:56:35 -0500
Received: from smtp.osdl.org ([65.172.181.4]:49047 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751096AbWBJE4e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Feb 2006 23:56:34 -0500
Date: Thu, 9 Feb 2006 20:55:59 -0800
From: Andrew Morton <akpm@osdl.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: kernel@kolivas.org, linux-mm@kvack.org, ck@vds.kolivas.org, pj@sgi.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: Implement Swap Prefetching v23
Message-Id: <20060209205559.409c0290.akpm@osdl.org>
In-Reply-To: <43EC1A85.2000001@yahoo.com.au>
References: <200602101355.41421.kernel@kolivas.org>
	<200602101449.59486.kernel@kolivas.org>
	<43EC1164.4000605@yahoo.com.au>
	<200602101514.40140.kernel@kolivas.org>
	<20060209202507.26f66be0.akpm@osdl.org>
	<43EC1A85.2000001@yahoo.com.au>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin <nickpiggin@yahoo.com.au> wrote:
>
> Andrew Morton wrote:
> > Con Kolivas <kernel@kolivas.org> wrote:
> > 
> >> Ok I see. We don't have a way to add to the tail of that list though?
> > 
> > 
> > del_page_from_lru() + (new) add_page_to_inactive_list_tail().
> > 
> > 
> >>Is that 
> >> a worthwhile addition to this (ever growing) project? That would definitely 
> >> have an impact on the other code if not all done within swap_prefetch.c.. 
> >> which would also be quite a large open coded something.
> > 
> > 
> > Do both of the above in a new function in swap.c.
> > 
> 
> That'll require the caller to do lru locking.
> 
> I'd add an lru_cache_add_tail, use it instead of the current lru_cache_add
> that Con's got now, and just implement it in a simple manner, without
> pagevecs.

umm, that's what I said ;)
