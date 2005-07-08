Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262821AbVGHUkH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262821AbVGHUkH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 16:40:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261421AbVGHUiv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 16:38:51 -0400
Received: from ns2.suse.de ([195.135.220.15]:50408 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S262821AbVGHUfX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 16:35:23 -0400
Date: Fri, 8 Jul 2005 22:35:14 +0200
From: Olaf Hering <olh@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH]  implicit declaration of function `page_cache_release'
Message-ID: <20050708203514.GA31975@suse.de>
References: <20050708150313.GA30373@suse.de> <20050708133127.302cbafe.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20050708133127.302cbafe.akpm@osdl.org>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 On Fri, Jul 08, Andrew Morton wrote:

> > +++ linux-2.6.13-rc2-olh/include/linux/pagemap.h
> > @@ -48,7 +48,7 @@ static inline void mapping_set_gfp_mask(
> >  
> >  #define page_cache_get(page)		get_page(page)
> >  #define page_cache_release(page)	put_page(page)
> > -void release_pages(struct page **pages, int nr, int cold);
> > +extern void release_pages(struct page **pages, int nr, int cold);
> 
> Why this change?  I think that was just me saving disk space.

Its only used in mm/swap.c and in linux/swap.h.
However, swap.h is used in many places. If no extern works as well, just
drop that part.
