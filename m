Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964991AbVKHPMP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964991AbVKHPMP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 10:12:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965094AbVKHPMP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 10:12:15 -0500
Received: from courier.cs.helsinki.fi ([128.214.9.1]:7124 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP id S964991AbVKHPMO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 10:12:14 -0500
Date: Tue, 8 Nov 2005 17:11:40 +0200 (EET)
From: Pekka J Enberg <penberg@cs.Helsinki.FI>
To: Matthew Wilcox <matthew@wil.cx>
cc: Matthew Dobson <colpatch@us.ibm.com>, kernel-janitors@lists.osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [KJ] [PATCH 4/8] Cleanup kmem_cache_create()
In-Reply-To: <20051108150008.GL23749@parisc-linux.org>
Message-ID: <Pine.LNX.4.58.0511081710280.26730@sbz-30.cs.Helsinki.FI>
References: <436FF51D.8080509@us.ibm.com> <436FF70D.6040604@us.ibm.com>
 <20051108150008.GL23749@parisc-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Nov 2005, Matthew Wilcox wrote:
> +/*
> + * Calculate size (in pages) of slabs, and the num of objs per slab.  This
> + * could be made much more intelligent.  For now, try to avoid using high
> + * page-orders for slabs.  When the gfp() funcs are more friendly towards
> + * high-order requests, this should be changed.
> + */
> +static size_t find_best_slab_order(kmem_cache_t *cachep, size_t size,
> +					 size_t align, unsigned long flags)
> +{

Looks ok to me. I would prefer this to be called calculate_slab_order() 
instead though.

			Pekka
