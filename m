Return-Path: <linux-kernel-owner+w=401wt.eu-S1425510AbWLHM6r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1425510AbWLHM6r (ORCPT <rfc822;w@1wt.eu>);
	Fri, 8 Dec 2006 07:58:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1425512AbWLHM6r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 07:58:47 -0500
Received: from brick.kernel.dk ([62.242.22.158]:28169 "EHLO kernel.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1425510AbWLHM6q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 07:58:46 -0500
Date: Fri, 8 Dec 2006 13:59:43 +0100
From: Jens Axboe <jens.axboe@oracle.com>
To: Dave Jones <davej@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       torvalds@osdl.org, akpm@osdl.org, Christoph Lameter <clameter@sgi.com>
Subject: Re: [PATCH] slab: remove SLAB_KERNEL
Message-ID: <20061208125942.GQ23887@kernel.dk>
References: <200612071659.kB7Gxa89031154@hera.kernel.org> <20061208120207.GA13841@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061208120207.GA13841@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 08 2006, Dave Jones wrote:
> On Thu, Dec 07, 2006 at 04:59:36PM +0000, Linux Kernel wrote:
>  > Gitweb:     http://git.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=e94b1766097d53e6f3ccfb36c8baa562ffeda3fc
>  > Commit:     e94b1766097d53e6f3ccfb36c8baa562ffeda3fc
>  > Parent:     54e6ecb23951b195d02433a741c7f7cb0b796c78
>  > Author:     Christoph Lameter <clameter@sgi.com>
>  > AuthorDate: Wed Dec 6 20:33:17 2006 -0800
>  > Committer:  Linus Torvalds <torvalds@woody.osdl.org>
>  > CommitDate: Thu Dec 7 08:39:24 2006 -0800
>  > 
>  >     [PATCH] slab: remove SLAB_KERNEL
>  >     
>  >     SLAB_KERNEL is an alias of GFP_KERNEL.
>  >     
>  >     Signed-off-by: Christoph Lameter <clameter@sgi.com>
>  >     Signed-off-by: Andrew Morton <akpm@osdl.org>
>  >     Signed-off-by: Linus Torvalds <torvalds@osdl.org>
> 
> Missed one.
> 
> Signed-off-by: Dave Jones <davej@redhat.com>
> 
> 
> --- linux-2.6.19.noarch/mm/mmap.c~	2006-12-08 06:51:55.000000000 -0500
> +++ linux-2.6.19.noarch/mm/mmap.c	2006-12-08 06:52:05.000000000 -0500
> @@ -2226,7 +2226,7 @@ int install_special_mapping(struct mm_st
>  	struct vm_area_struct *vma;
>  	int err;
>  
> -	vma = kmem_cache_alloc(vm_area_cachep, SLAB_KERNEL);
> +	vma = kmem_cache_alloc(vm_area_cachep, GFP_KERNEL);
>  	if (unlikely(vma == NULL))
>  		return -ENOMEM;
>  	memset(vma, 0, sizeof(*vma));

What kernel is that?

-- 
Jens Axboe

