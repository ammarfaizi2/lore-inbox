Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945997AbWBOP5G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945997AbWBOP5G (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 10:57:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945998AbWBOP5G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 10:57:06 -0500
Received: from e32.co.us.ibm.com ([32.97.110.150]:13536 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1945997AbWBOP5D
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 10:57:03 -0500
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
In-Reply-To: <20060215151649.GA12090@mellanox.co.il>
References: <20060215151649.GA12090@mellanox.co.il>
Content-Type: text/plain
Date: Wed, 15 Feb 2006 07:58:08 -0800
Message-Id: <1140019088.21448.3.camel@dyn9047017100.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-02-15 at 17:16 +0200, Michael S. Tsirkin wrote:
> How does the following look (against gc3-git)?

I tried to do the same earlier (while doing MADV_REMOVE) and got
ugly (I was trying to completely get rid of asm-specific ones), 
so I gave up.

Anyway,


> Index: linux-2.6.16-rc3/include/asm-generic/mman.h
> ===================================================================
> --- /dev/null	1970-01-01 00:00:00.000000000 +0000
> +++ linux-2.6.16-rc3/include/asm-generic/mman.h	2006-02-15 19:59:41.000000000 +0200
..
> +#define MS_ASYNC	1		/* sync memory asynchronously */
> +#define MS_SYNC		2		/* synchronous memory sync */
> +#define MS_INVALIDATE	4		/* invalidate the caches */

Shouldn't this be ?

+#define MS_ASYNC	1		/* sync memory asynchronously */
+#define MS_INVALIDATE	2		/* invalidate the caches */
+#define MS_SYNC	4		/* synchronous memory sync */

Thanks,
Badari


