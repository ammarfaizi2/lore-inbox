Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030179AbWCCQu3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030179AbWCCQu3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Mar 2006 11:50:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030229AbWCCQu3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Mar 2006 11:50:29 -0500
Received: from e33.co.us.ibm.com ([32.97.110.151]:16301 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S1030179AbWCCQu2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Mar 2006 11:50:28 -0500
Subject: Re: [PATCH 3/4] map multiple blocks for mpage_readpages()
From: Badari Pulavarty <pbadari@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20060301204502.63330347.akpm@osdl.org>
References: <1141075239.10542.19.camel@dyn9047017100.beaverton.ibm.com>
	 <1141075456.10542.25.camel@dyn9047017100.beaverton.ibm.com>
	 <20060301204502.63330347.akpm@osdl.org>
Content-Type: text/plain
Date: Fri, 03 Mar 2006 08:51:54 -0800
Message-Id: <1141404714.10542.62.camel@dyn9047017100.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-03-01 at 20:45 -0800, Andrew Morton wrote:
> Badari Pulavarty <pbadari@us.ibm.com> wrote:
> >
> >  do_mpage_readpage(struct bio *bio, struct page *page, unsigned nr_pages,
> >  -			sector_t *last_block_in_bio, get_block_t get_block)
> >  +			sector_t *last_block_in_bio, struct buffer_head *map_bh,
> >  +			unsigned long *first_logical_block, int *map_valid,
> >  +			get_block_t get_block)
> 
> I wonder if we really need that map_valid pointer there.  The normal way of
> communicating the validity of a bh is via buffer_uptodate().  I _think_
> that's an appropriate thing to use here.  With appropriate comments, of
> course..
> 
> If those options are not a sufficiently good fit then we can easily create
> a new buffer-head.state bit for this purpose - there are lots to spare.

Yep. Can be done. I will take a pass at it.

Thanks,
Badari

