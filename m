Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964798AbWCTNvh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964798AbWCTNvh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 08:51:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964799AbWCTNvh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 08:51:37 -0500
Received: from gw1.cosmosbay.com ([62.23.185.226]:2019 "EHLO gw1.cosmosbay.com")
	by vger.kernel.org with ESMTP id S964798AbWCTNvg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 08:51:36 -0500
Message-ID: <441EB350.50609@cosmosbay.com>
Date: Mon, 20 Mar 2006 14:51:12 +0100
From: Eric Dumazet <dada1@cosmosbay.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Pekka J Enberg <penberg@cs.Helsinki.FI>
CC: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] slab: introduce kmem_cache_zalloc allocator
References: <Pine.LNX.4.58.0603201506140.19005@sbz-30.cs.Helsinki.FI>
In-Reply-To: <Pine.LNX.4.58.0603201506140.19005@sbz-30.cs.Helsinki.FI>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.6 (gw1.cosmosbay.com [172.16.8.80]); Mon, 20 Mar 2006 14:51:18 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pekka J Enberg a écrit :
> From: Pekka Enberg <penberg@cs.helsinki.fi>
> 
> This patch introduces a memory-zeroing variant of kmem_cache_alloc. The
> allocator already exits in XFS and there are potential users for it so
> this patch makes the allocator available for the general public.
> 

Excellent.

Please change zalloc() so that a zalloc(constant_value) uses your 
kmem_cache_zalloc on the appropriate cache.

This way we can really introduce zalloc() *everywhere* without paying the cost 
of runtime lookup to find the right cache.

Eric
