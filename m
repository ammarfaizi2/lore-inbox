Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317576AbSHHJiT>; Thu, 8 Aug 2002 05:38:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317578AbSHHJiT>; Thu, 8 Aug 2002 05:38:19 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:53693 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S317576AbSHHJiB>;
	Thu, 8 Aug 2002 05:38:01 -0400
Date: Thu, 8 Aug 2002 15:09:57 +0530
From: Ravikiran G Thirumalai <kiran@in.ibm.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Andrew Morton <akpm@zip.com.au>, Rik van Riel <riel@conectiva.com.br>,
       lse <lse-tech@lists.sourceforge.net>, linux-kernel@vger.kernel.org
Subject: Re: [Lse-tech] [patch] Scalable statistics counters with /proc reporting
Message-ID: <20020808150957.A21873@in.ibm.com>
References: <20020807142227.B12301@in.ibm.com> <20020807100216.A27321@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020807100216.A27321@infradead.org>; from hch@infradead.org on Wed, Aug 07, 2002 at 10:02:16AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 07, 2002 at 10:02:16AM +0100, Christoph Hellwig wrote:
>...
> What about a general s/_proc//g for the API?

Sure ...I was initially thinking of something like statctr_pentry,
but then thought statctr_proc_entry would be explicit although lengthy.

> 
> For statctr_init the flags argument would much better be named gfp_mask,

I'll do that. I was just following the same conventions as kmalloc and
kmem_cache_alloc; but gfp_mask is much better; thanx.

> the val argument should be removed and the counter initialized to zero
> by default - that's 90% of the uses..

Yup, I'll do this too.

> 
> Also the /proc-based implementation is really ugly.  It should be moved
> over to the seq_file interface at least, a simple ramfs-style own
> filesystem ("stats" filesystem type) would be the cleanest solution.

If I want to create difft proc files for difft groups of statctrs like 
say /proc/statistics/vmstats, /proc/statistics/netstats etc., dynamically,
using seq_file implementation might be not very neat...I have to 
confess I don't know much about seq_file interfaces....so pls correct
me if I am missing something......I just looked at them after your pointer. 

We wanted to keep things simple right now ... IMHO a custom file system 
right now might be complicating the patch.....maybe later when there are many 
users of statctrs 8-) ...

Thanks,
Kiran
