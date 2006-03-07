Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751479AbWCGVBU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751479AbWCGVBU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 16:01:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751526AbWCGVBU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 16:01:20 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:47061 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751479AbWCGVBU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 16:01:20 -0500
Date: Tue, 7 Mar 2006 13:01:08 -0800 (PST)
From: Christoph Lameter <clameter@engr.sgi.com>
To: Andrew Morton <akpm@osdl.org>
cc: Martin Bligh <mbligh@mbligh.org>, linux-kernel@vger.kernel.org,
       torvalds@osdl.org
Subject: Re: 2.6.16-rc5-mm3
In-Reply-To: <20060307125122.5f7d3462.akpm@osdl.org>
Message-ID: <Pine.LNX.4.64.0603071300100.32539@schroedinger.engr.sgi.com>
References: <20060307021929.754329c9.akpm@osdl.org> <440DEF0A.3030701@mbligh.org>
 <440DEF75.9060802@mbligh.org> <20060307125122.5f7d3462.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Mar 2006, Andrew Morton wrote:

> --- devel/mm/mempolicy.c~numa_maps-update-fix	2006-03-07 12:48:38.000000000 -0800
> +++ devel-akpm/mm/mempolicy.c	2006-03-07 12:49:22.000000000 -0800
> @@ -1789,6 +1789,7 @@ static void gather_stats(struct page *pa
>  	cond_resched();
>  }
>  
> +#ifdef CONFIG_HUGETLB_PAGE
>  static void check_huge_range(struct vm_area_struct *vma,
>  		unsigned long start, unsigned long end,
>  		struct numa_maps *md)
> @@ -1814,6 +1815,7 @@ static void check_huge_range(struct vm_a
>  		gather_stats(page, md, pte_dirty(*ptep));
>  	}
>  }
#else
....

{
}

?

> +#endif
>  
>  int show_numa_map(struct seq_file *m, void *v)
>  {
> _
> 
> 
