Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932804AbVJ3DGp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932804AbVJ3DGp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Oct 2005 23:06:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932805AbVJ3DGp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Oct 2005 23:06:45 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:39146 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S932804AbVJ3DGo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Oct 2005 23:06:44 -0400
Date: Sat, 29 Oct 2005 20:06:34 -0700
From: Paul Jackson <pj@sgi.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: rohit.seth@intel.com, akpm@osdl.org, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH]: Clean up of __alloc_pages
Message-Id: <20051029200634.778a57d6.pj@sgi.com>
In-Reply-To: <436430BA.4010606@yahoo.com.au>
References: <20051028183326.A28611@unix-os.sc.intel.com>
	<20051029184728.100e3058.pj@sgi.com>
	<4364296E.1080905@yahoo.com.au>
	<20051029191946.1832adaf.pj@sgi.com>
	<436430BA.4010606@yahoo.com.au>
Organization: SGI
X-Mailer: Sylpheed version 2.0.0beta5 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick, replying to pj:
> > And if it is inlined, then are you expecting to also have an out of
> > line copy, for use by the call to it from mm/swap_prefetch.c
> > prefetch_get_page()?
> > 
> 
> No, that shouldn't be there though.
> 
> > Adding the 'inline' keyword increases my kernel text size by
> > 1448 bytes, for the extra copy of this code used inline from
> > the call to it from mm/page_alloc.c:get_page_from_freelist().
> > Is that really worth it?
> > 
> 
> Hmm, where is the other callsite? 

The other callsite is mm/swap_prefetch.c:prefetch_get_page(), from Con
Kolivas's mm-implement-swap-prefetching.patch patch in *-mm, dated
about six days ago.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
