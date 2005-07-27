Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262177AbVG0Ux4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262177AbVG0Ux4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Jul 2005 16:53:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262398AbVG0Uvv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Jul 2005 16:51:51 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:10250 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262482AbVG0Uu3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Jul 2005 16:50:29 -0400
Date: Wed, 27 Jul 2005 22:50:28 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Christoph Lameter <christoph@lameter.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] mm/slab: unexport kmem_cache_alloc_node
Message-ID: <20050727205028.GB3679@stusta.de>
References: <20050727195107.GC29092@stusta.de> <20050727130355.08a534b7.akpm@osdl.org> <Pine.LNX.4.62.0507271317400.12883@graphe.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0507271317400.12883@graphe.net>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 27, 2005 at 01:19:00PM -0700, Christoph Lameter wrote:
> On Wed, 27 Jul 2005, Andrew Morton wrote:
> 
> > >  	return objp;
> > >  }
> > > -EXPORT_SYMBOL(kmem_cache_alloc_node);
> > >  
> > >  #endif
> > 
> > Even though we don't currently have in-module users, we probably will do so
> > soon and it's a part of the slab API and the slab API is exported to
> > modules.  I don't see much point in partially-exporting the API and
> > applying a patch which we'll soon revert.
> > 
> > Christoph?
> > 
> 
> I fully agree. Drivers will have to use that call in the future in order 
> to properly place their control structures. The e1000 in your tree already 
> does so and may be compiled as a module. Thus applying this patch will 
> break mm.

I don't see e1000 in 2.6.13-rc3-mm2 using it.

And yes, I tried compilation of as much as possible (including e1000) in 
2.6.13-rc3-mm2 with my patch applied before resending it.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

