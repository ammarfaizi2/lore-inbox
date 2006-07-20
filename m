Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030279AbWGTGRR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030279AbWGTGRR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jul 2006 02:17:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030275AbWGTGRR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jul 2006 02:17:17 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:63750 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1030279AbWGTGRQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jul 2006 02:17:16 -0400
Date: Thu, 20 Jul 2006 08:17:15 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Chris Wright <chrisw@sous-sol.org>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.osdl.org,
       xen-devel@lists.xensource.com, Jeremy Fitzhardinge <jeremy@goop.org>,
       Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>,
       Rusty Russell <rusty@rustcorp.com.au>, Zachary Amsden <zach@vmware.com>,
       Ian Pratt <ian.pratt@xensource.com>,
       Christian Limpach <Christian.Limpach@cl.cam.ac.uk>
Subject: Re: [RFC PATCH 01/33] Add apply_to_page_range() function
Message-ID: <20060720061715.GC25367@stusta.de>
References: <20060718091807.467468000@sous-sol.org> <20060718091945.432845000@sous-sol.org> <20060718103850.GD3748@stusta.de> <20060718192925.GC2654@sequoia.sous-sol.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060718192925.GC2654@sequoia.sous-sol.org>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 18, 2006 at 12:29:25PM -0700, Chris Wright wrote:
> * Adrian Bunk (bunk@stusta.de) wrote:
> > On Tue, Jul 18, 2006 at 12:00:01AM -0700, Chris Wright wrote:
> > >...
> > > --- a/mm/memory.c	Fri Mar 24 04:29:46 2006 +0000
> > > +++ b/mm/memory.c	Fri Mar 24 04:30:48 2006 +0000
> > > @@ -1358,6 +1358,100 @@ int remap_pfn_range(struct vm_area_struc
> > >  }
> > >  EXPORT_SYMBOL(remap_pfn_range);
> > >  
> > > +static inline int apply_to_pte_range(struct mm_struct *mm, pmd_t *pmd,
> > > +				     unsigned long addr, unsigned long end,
> > > +				     pte_fn_t fn, void *data)
> > >...
> > > +static inline int apply_to_pmd_range(struct mm_struct *mm, pud_t *pud,
> > > +				     unsigned long addr, unsigned long end,
> > > +				     pte_fn_t fn, void *data)
> > >...
> > > +static inline int apply_to_pud_range(struct mm_struct *mm, pgd_t *pgd,
> > > +				     unsigned long addr, unsigned long end,
> > > +				     pte_fn_t fn, void *data)
> > >...
> > 
> > Please avoid "inline" in C files.
> > 
> > (gcc already automatically inlines static functions with only one caller.)
> 
> Sure, that's fair.  The surrounding similar code follows the same format 
> as above, perhaps you plan to patch?

Already part of a bigger item on my TODO list for some months.

Priority: low...

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

