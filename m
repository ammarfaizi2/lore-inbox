Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946050AbWBORhO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946050AbWBORhO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 12:37:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946054AbWBORhO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 12:37:14 -0500
Received: from e33.co.us.ibm.com ([32.97.110.151]:15772 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S1946050AbWBORhM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 12:37:12 -0500
Subject: Re: [PATCH] add asm-generic/mman.h
From: Badari Pulavarty <pbadari@us.ibm.com>
To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Cc: linux-arch@vger.kernel.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Nick Piggin <nickpiggin@yahoo.com.au>, Andrew Morton <akpm@osdl.org>,
       Roland Dreier <rdreier@cisco.com>, Hugh Dickins <hugh@veritas.com>,
       Linus Torvalds <torvalds@osdl.org>, Gleb Natapov <gleb@minantech.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       openib-general@openib.org, Petr Vandrovec <vandrove@vc.cvut.cz>,
       Matthew Wilcox <matthew@wil.cx>
In-Reply-To: <20060215165016.GD12974@mellanox.co.il>
References: <20060215151649.GA12090@mellanox.co.il>
	 <1140019088.21448.3.camel@dyn9047017100.beaverton.ibm.com>
	 <20060215165016.GD12974@mellanox.co.il>
Content-Type: text/plain
Date: Wed, 15 Feb 2006 08:52:57 -0800
Message-Id: <1140022377.21448.6.camel@dyn9047017100.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-02-15 at 18:50 +0200, Michael S. Tsirkin wrote:
> Quoting r. Badari Pulavarty <pbadari@us.ibm.com>:
> > Subject: Re: [PATCH] add asm-generic/mman.h
> > 
> > On Wed, 2006-02-15 at 17:16 +0200, Michael S. Tsirkin wrote:
> > > How does the following look (against gc3-git)?
> > 
> > I tried to do the same earlier (while doing MADV_REMOVE) and got
> > ugly (I was trying to completely get rid of asm-specific ones), 
> > so I gave up.
> > 
> > Anyway,
> > 
> > 
> > > Index: linux-2.6.16-rc3/include/asm-generic/mman.h
> > > ===================================================================
> > > --- /dev/null	1970-01-01 00:00:00.000000000 +0000
> > > +++ linux-2.6.16-rc3/include/asm-generic/mman.h	2006-02-15 19:59:41.000000000 +0200
> > ..
> > > +#define MS_ASYNC	1		/* sync memory asynchronously */
> > > +#define MS_SYNC		2		/* synchronous memory sync */
> > > +#define MS_INVALIDATE	4		/* invalidate the caches */
> > 
> > Shouldn't this be ?
> > 
> > +#define MS_ASYNC	1		/* sync memory asynchronously */
> > +#define MS_INVALIDATE	2		/* invalidate the caches */
> > +#define MS_SYNC	4		/* synchronous memory sync */
> > 
> > Thanks,
> > Badari
> > 
> 
> Note that this only looks misaligned in the patch. When you apply, +
> disappears and numbers get aligned.
> Other stuff in asm-xx/mman.h is aligned by tabs and not by spaces,
> so why should these options be aligned by spaces?


I am not talking about alignment or spaces. 
What I meant was ..

MS_SYNC should be 4
MS_INVALIDATE should be 2

You got it other way in your patch.

Thanks,
Badari

