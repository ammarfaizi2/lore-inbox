Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932373AbWGRTbD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932373AbWGRTbD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jul 2006 15:31:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932370AbWGRTbB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jul 2006 15:31:01 -0400
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:21888 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S932368AbWGRTbA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jul 2006 15:31:00 -0400
Date: Tue, 18 Jul 2006 12:29:25 -0700
From: Chris Wright <chrisw@sous-sol.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: Chris Wright <chrisw@sous-sol.org>, linux-kernel@vger.kernel.org,
       virtualization@lists.osdl.org, xen-devel@lists.xensource.com,
       Jeremy Fitzhardinge <jeremy@goop.org>, Andi Kleen <ak@suse.de>,
       Andrew Morton <akpm@osdl.org>, Rusty Russell <rusty@rustcorp.com.au>,
       Zachary Amsden <zach@vmware.com>, Ian Pratt <ian.pratt@xensource.com>,
       Christian Limpach <Christian.Limpach@cl.cam.ac.uk>
Subject: Re: [RFC PATCH 01/33] Add apply_to_page_range() function
Message-ID: <20060718192925.GC2654@sequoia.sous-sol.org>
References: <20060718091807.467468000@sous-sol.org> <20060718091945.432845000@sous-sol.org> <20060718103850.GD3748@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060718103850.GD3748@stusta.de>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Adrian Bunk (bunk@stusta.de) wrote:
> On Tue, Jul 18, 2006 at 12:00:01AM -0700, Chris Wright wrote:
> >...
> > --- a/mm/memory.c	Fri Mar 24 04:29:46 2006 +0000
> > +++ b/mm/memory.c	Fri Mar 24 04:30:48 2006 +0000
> > @@ -1358,6 +1358,100 @@ int remap_pfn_range(struct vm_area_struc
> >  }
> >  EXPORT_SYMBOL(remap_pfn_range);
> >  
> > +static inline int apply_to_pte_range(struct mm_struct *mm, pmd_t *pmd,
> > +				     unsigned long addr, unsigned long end,
> > +				     pte_fn_t fn, void *data)
> >...
> > +static inline int apply_to_pmd_range(struct mm_struct *mm, pud_t *pud,
> > +				     unsigned long addr, unsigned long end,
> > +				     pte_fn_t fn, void *data)
> >...
> > +static inline int apply_to_pud_range(struct mm_struct *mm, pgd_t *pgd,
> > +				     unsigned long addr, unsigned long end,
> > +				     pte_fn_t fn, void *data)
> >...
> 
> Please avoid "inline" in C files.
> 
> (gcc already automatically inlines static functions with only one caller.)

Sure, that's fair.  The surrounding similar code follows the same format 
as above, perhaps you plan to patch?
