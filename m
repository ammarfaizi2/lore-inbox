Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030341AbVKHTKr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030341AbVKHTKr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 14:10:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030342AbVKHTKr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 14:10:47 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.144]:47025 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1030341AbVKHTKq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 14:10:46 -0500
Message-ID: <4370F833.30906@us.ibm.com>
Date: Tue, 08 Nov 2005 11:10:43 -0800
From: Matthew Dobson <colpatch@us.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051011)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pekka J Enberg <penberg@cs.Helsinki.FI>
CC: Matthew Wilcox <matthew@wil.cx>, kernel-janitors@lists.osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [KJ] [PATCH 4/8] Cleanup kmem_cache_create()
References: <436FF51D.8080509@us.ibm.com> <436FF70D.6040604@us.ibm.com> <20051108150008.GL23749@parisc-linux.org> <Pine.LNX.4.58.0511081710280.26730@sbz-30.cs.Helsinki.FI>
In-Reply-To: <Pine.LNX.4.58.0511081710280.26730@sbz-30.cs.Helsinki.FI>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pekka J Enberg wrote:
> On Tue, 8 Nov 2005, Matthew Wilcox wrote:
> 
>>+/*
>>+ * Calculate size (in pages) of slabs, and the num of objs per slab.  This
>>+ * could be made much more intelligent.  For now, try to avoid using high
>>+ * page-orders for slabs.  When the gfp() funcs are more friendly towards
>>+ * high-order requests, this should be changed.
>>+ */
>>+static size_t find_best_slab_order(kmem_cache_t *cachep, size_t size,
>>+					 size_t align, unsigned long flags)
>>+{
> 
> 
> Looks ok to me. I would prefer this to be called calculate_slab_order() 
> instead though.
> 
> 			Pekka

Agreed.  Will include this in the next version, due out this afternoon.

Thank you both for the review and comments.

-Matt
