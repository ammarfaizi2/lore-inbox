Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932307AbWCGVXY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932307AbWCGVXY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 16:23:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932313AbWCGVXY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 16:23:24 -0500
Received: from smtp.osdl.org ([65.172.181.4]:54966 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932307AbWCGVXX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 16:23:23 -0500
Date: Tue, 7 Mar 2006 13:21:32 -0800
From: Andrew Morton <akpm@osdl.org>
To: Christoph Lameter <clameter@engr.sgi.com>
Cc: mbligh@mbligh.org, linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: 2.6.16-rc5-mm3
Message-Id: <20060307132132.105d9d38.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0603071300100.32539@schroedinger.engr.sgi.com>
References: <20060307021929.754329c9.akpm@osdl.org>
	<440DEF0A.3030701@mbligh.org>
	<440DEF75.9060802@mbligh.org>
	<20060307125122.5f7d3462.akpm@osdl.org>
	<Pine.LNX.4.64.0603071300100.32539@schroedinger.engr.sgi.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter <clameter@engr.sgi.com> wrote:
>
> On Tue, 7 Mar 2006, Andrew Morton wrote:
> 
> > --- devel/mm/mempolicy.c~numa_maps-update-fix	2006-03-07 12:48:38.000000000 -0800
> > +++ devel-akpm/mm/mempolicy.c	2006-03-07 12:49:22.000000000 -0800
> > @@ -1789,6 +1789,7 @@ static void gather_stats(struct page *pa
> >  	cond_resched();
> >  }
> >  
> > +#ifdef CONFIG_HUGETLB_PAGE
> >  static void check_huge_range(struct vm_area_struct *vma,
> >  		unsigned long start, unsigned long end,
> >  		struct numa_maps *md)
> > @@ -1814,6 +1815,7 @@ static void check_huge_range(struct vm_a
> >  		gather_stats(page, md, pte_dirty(*ptep));
> >  	}
> >  }
> #else
> ....
> 
> {
> }
> 
> ?

Yeah, that won't be needed for a link, but it's needed to avoid a compile
warning.

