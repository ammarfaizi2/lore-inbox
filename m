Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283541AbRLIPxS>; Sun, 9 Dec 2001 10:53:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283561AbRLIPxI>; Sun, 9 Dec 2001 10:53:08 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:33554 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S283541AbRLIPw5>;
	Sun, 9 Dec 2001 10:52:57 -0500
Date: Sun, 9 Dec 2001 16:47:21 +0100
From: Jens Axboe <axboe@suse.de>
To: Frank Cornelis <fcorneli@elis.rug.ac.be>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kmem_cache_alloc & kernel_lock
Message-ID: <20011209154721.GF28729@suse.de>
In-Reply-To: <Pine.LNX.4.33.0112091626110.27042-100000@trappist.elis.rug.ac.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0112091626110.27042-100000@trappist.elis.rug.ac.be>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 09 2001, Frank Cornelis wrote:
> Hi,
> 
> Can I use kmem_cache_alloc(mycache_cachep, SLAB_KERNEL) within
> a kernel_lock/kernel_unlock block? Or should it be SLAB_ATOMIC?

GFP_KERNEL is ok, you can sleep with the kernel lock held.

-- 
Jens Axboe

