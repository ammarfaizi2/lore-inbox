Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262839AbUJ1JMN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262839AbUJ1JMN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 05:12:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262842AbUJ1JMN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 05:12:13 -0400
Received: from cantor.suse.de ([195.135.220.2]:29591 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262839AbUJ1JMF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 05:12:05 -0400
Date: Thu, 28 Oct 2004 11:12:04 +0200
From: Andi Kleen <ak@suse.de>
To: manfred@colorfullife.com
Cc: linux-kernel@vger.kernel.org
Subject: slab errors
Message-ID: <20041028091204.GB1618@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I get this when booting 2.6.10rc1-bk6 on x86-64. slab doesn't seem
to like its own initialization.

-Andi


Memory: 122340k/130496k available (3062k kernel code, 0k reserved, 1226k data, 244k init)
slab error in cache_alloc_debugcheck_after(): cache `size-1024': double free, or memory outside object was overwritten

Call Trace:<ffffffff80161dde>{alloc_arraycache+94} <ffffffff801603ea>{cache_alloc_debugcheck_after+186} 
       <ffffffff80161955>{__kmalloc+181} <ffffffff80161dde>{alloc_arraycache+94} 
       <ffffffff80161f72>{do_tune_cpucache+338} <ffffffff80160448>{cache_alloc_debugcheck_after+280} 
       <ffffffff801621e9>{enable_cpucache+105} <ffffffff805cf468>{kmem_cache_init+712} 
       <ffffffff805bb956>{start_kernel+310} <ffffffff805bb268>{_sinittext+616} 
       
0000010001102450: redzone 1: 0x5a2cf071, redzone 2: 0x5a2c5a5a.
slab error in cache_alloc_debugcheck_after(): cache `size-1024': double free, or memory outside object was overwritten

Call Trace:<ffffffff80161dde>{alloc_arraycache+94} <ffffffff801603ea>{cache_alloc_debugcheck_after+186} 
       <ffffffff80161955>{__kmalloc+181} <ffffffff80161dde>{alloc_arraycache+94} 
       <ffffffff80161f72>{do_tune_cpucache+338} <ffffffff80160448>{cache_alloc_debugcheck_after+280} 
       <ffffffff801621e9>{enable_cpucache+105} <ffffffff805cf468>{kmem_cache_init+712} 
       <ffffffff805bb956>{start_kernel+310} <ffffffff805bb268>{_sinittext+616} 
       
0000010001102868: redzone 1: 0x5a2cf071, redzone 2: 0x5a2cf05a.
slab error in cache_alloc_debugcheck_after(): cache `size-1024': double free, or memory outside object was overwritten

Call Trace:<ffffffff80161dde>{alloc_arraycache+94} <ffffffff801603ea>{cache_alloc_debugcheck_after+186} 
       <ffffffff80161955>{__kmalloc+181} <ffffffff80161dde>{alloc_arraycache+94} 
       <ffffffff80161f72>{do_tune_cpucache+338} <ffffffff80160448>{cache_alloc_debugcheck_after+280} 
       <ffffffff801621e9>{enable_cpucache+105} <ffffffff805cf468>{kmem_cache_init+712} 
       <ffffffff805bb956>{start_kernel+310} <ffffffff805bb268>{_sinittext+616} 
       
0000010001103098: redzone 1: 0x5a2cf071, redzone 2: 0x5a5a5a5a5a5a5a.
slab error in cache_alloc_debugcheck_after(): cache `size-1024': double free, or memory outside object was overwritten

Call Trace:<ffffffff80161dde>{alloc_arraycache+94} <ffffffff801603ea>{cache_alloc_debugcheck_after+186} 
       <ffffffff80161955>{__kmalloc+181} <ffffffff80161dde>{alloc_arraycache+94} 
       <ffffffff80161f72>{do_tune_cpucache+338} <ffffffff80160448>{cache_alloc_debugcheck_after+280} 
       <ffffffff801621e9>{enable_cpucache+105} <ffffffff805cf468>{kmem_cache_init+712} 
       <ffffffff805bb956>{start_kernel+310} <ffffffff805bb268>{_sinittext+616} 
       
00000100011038c8: redzone 1: 0x5a2cf071, redzone 2: 0x5a5a5a5a5a5a.
slab error in cache_alloc_debugcheck_after(): cache `size-2048': double free, or memory outside object was overwritten

Call Trace:<ffffffff80161dde>{alloc_arraycache+94} <ffffffff801603ea>{cache_alloc_debugcheck_after+186} 
       <ffffffff80161955>{__kmalloc+181} <ffffffff80161dde>{alloc_arraycache+94} 
       <ffffffff80161f72>{do_tune_cpucache+338} <ffffffff80160448>{cache_alloc_debugcheck_after+280} 
       <ffffffff801621e9>{enable_cpucache+105} <ffffffff805cf468>{kmem_cache_init+712} 
       <ffffffff805bb956>{start_kernel+310} <ffffffff805bb268>{_sinittext+616} 
       
0000010003ff1060: redzone 1: 0x5a2cf071, redzone 2: 0x5a5a5a5a5a.
slab error in cache_alloc_debugcheck_after(): cache `size-2048': double free, or memory outside object was overwritten

Call Trace:<ffffffff80161dde>{alloc_arraycache+94} <ffffffff801603ea>{cache_alloc_debugcheck_after+186} 
       <ffffffff80161955>{__kmalloc+181} <ffffffff80161dde>{alloc_arraycache+94} 
       <ffffffff80161f72>{do_tune_cpucache+338} <ffffffff80160448>{cache_alloc_debugcheck_after+280} 
       <ffffffff801621e9>{enable_cpucache+105} <ffffffff805cf468>{kmem_cache_init+712} 
       <ffffffff805bb956>{start_kernel+310} <ffffffff805bb268>{_sinittext+616} 
       
0000010003ff0848: redzone 1: 0x5a2cf071, redzone 2: 0x5a5a5a5a.
slab error in cache_alloc_debugcheck_after(): cache `size-2048': double free, or memory outside object was overwritten

Call Trace:<ffffffff80161dde>{alloc_arraycache+94} <ffffffff801603ea>{cache_alloc_debugcheck_after+186} 
       <ffffffff80161955>{__kmalloc+181} <ffffffff80161dde>{alloc_arraycache+94} 
       <ffffffff80161f72>{do_tune_cpucache+338} <ffffffff80160448>{cache_alloc_debugcheck_after+280} 
       <ffffffff801621e9>{enable_cpucache+105} <ffffffff805cf468>{kmem_cache_init+712} 
       <ffffffff805bb956>{start_kernel+310} <ffffffff805bb268>{_sinittext+616} 
       
0000010003ff0030: redzone 1: 0x5a2cf071, redzone 2: 0x5a5a5a5a.
slab error in cache_alloc_debugcheck_after(): cache `size-2048': double free, or memory outside object was overwritten

Call Trace:<ffffffff80161dde>{alloc_arraycache+94} <ffffffff801603ea>{cache_alloc_debugcheck_after+186} 
       <ffffffff80161955>{__kmalloc+181} <ffffffff80161dde>{alloc_arraycache+94} 
       <ffffffff80161f72>{do_tune_cpucache+338} <ffffffff80160448>{cache_alloc_debugcheck_after+280} 
       <ffffffff801621e9>{enable_cpucache+105} <ffffffff805cf468>{kmem_cache_init+712} 
       <ffffffff805bb956>{start_kernel+310} <ffffffff805bb268>{_sinittext+616} 
       
0000010003ff30a0: redzone 1: 0x5a2cf071, redzone 2: 0x5a2c5a5a.
slab error in cache_alloc_debugcheck_after(): cache `size-2048': double free, or memory outside object was overwritten

Call Trace:<ffffffff80161dde>{alloc_arraycache+94} <ffffffff801603ea>{cache_alloc_debugcheck_after+186} 
       <ffffffff80161955>{__kmalloc+181} <ffffffff80161dde>{alloc_arraycache+94} 
       <ffffffff80161f72>{do_tune_cpucache+338} <ffffffff80160448>{cache_alloc_debugcheck_after+280} 
       <ffffffff801621e9>{enable_cpucache+105} <ffffffff805cf468>{kmem_cache_init+712} 
       <ffffffff805bb956>{start_kernel+310} <ffffffff805bb268>{_sinittext+616} 
       
0000010003ff2888: redzone 1: 0x5a2cf071, redzone 2: 0x5a2cf05a.
slab error in cache_alloc_debugcheck_after(): cache `size-2048': double free, or memory outside object was overwritten

Call Trace:<ffffffff80161dde>{alloc_arraycache+94} <ffffffff801603ea>{cache_alloc_debugcheck_after+186} 
       <ffffffff80161955>{__kmalloc+181} <ffffffff80161dde>{alloc_arraycache+94} 
       <ffffffff80161f72>{do_tune_cpucache+338} <ffffffff80160448>{cache_alloc_debugcheck_after+280} 
       <ffffffff801621e9>{enable_cpucache+105} <ffffffff805cf468>{kmem_cache_init+712} 
       <ffffffff805bb956>{start_kernel+310} <ffffffff805bb268>{_sinittext+616} 
       
00000100011050e0: redzone 1: 0x5a2cf071, redzone 2: 0x5a5a5a5a5a5a5a.
slab error in cache_alloc_debugcheck_after(): cache `size-2048': double free, or memory outside object was overwritten

Call Trace:<ffffffff80161dde>{alloc_arraycache+94} <ffffffff801603ea>{cache_alloc_debugcheck_after+186} 
       <ffffffff80161955>{__kmalloc+181} <ffffffff80161dde>{alloc_arraycache+94} 
       <ffffffff80161f72>{do_tune_cpucache+338} <ffffffff80160448>{cache_alloc_debugcheck_after+280} 
       <ffffffff801621e9>{enable_cpucache+105} <ffffffff805cf468>{kmem_cache_init+712} 
       <ffffffff805bb956>{start_kernel+310} <ffffffff805bb268>{_sinittext+616} 
       
00000100011048c8: redzone 1: 0x5a2cf071, redzone 2: 0x5a5a5a5a5a5a.
slab error in cache_alloc_debugcheck_after(): cache `size-2048': double free, or memory outside object was overwritten

Call Trace:<ffffffff80161dde>{alloc_arraycache+94} <ffffffff801603ea>{cache_alloc_debugcheck_after+186} 
       <ffffffff80161955>{__kmalloc+181} <ffffffff80161dde>{alloc_arraycache+94} 
       <ffffffff80161f72>{do_tune_cpucache+338} <ffffffff80160448>{cache_alloc_debugcheck_after+280} 
       <ffffffff801621e9>{enable_cpucache+105} <ffffffff805cf468>{kmem_cache_init+712} 
       <ffffffff805bb956>{start_kernel+310} <ffffffff805bb268>{_sinittext+616} 
       
00000100011040b0: redzone 1: 0x5a2cf071, redzone 2: 0x5a5a5a5a5a.
slab error in cache_alloc_debugcheck_after(): cache `size-2048': double free, or memory outside object was overwritten

Call Trace:<ffffffff80161dde>{alloc_arraycache+94} <ffffffff801603ea>{cache_alloc_debugcheck_after+186} 
       <ffffffff80161955>{__kmalloc+181} <ffffffff80161dde>{alloc_arraycache+94} 
       <ffffffff80161f72>{do_tune_cpucache+338} <ffffffff80160448>{cache_alloc_debugcheck_after+280} 
       <ffffffff801621e9>{enable_cpucache+105} <ffffffff805cf468>{kmem_cache_init+712} 
       <ffffffff805bb956>{start_kernel+310} <ffffffff805bb268>{_sinittext+616} 
       
0000010001109120: redzone 1: 0x5a2cf071, redzone 2: 0x5a5a5a5a.
Mount-cache hash table entries: 256 (order: 0, 4096 bytes)
slab error in cache_alloc_debugcheck_after(): cache `size-32': double free, or memory outside object was overwritten

Call Trace:<ffffffff801976c7>{alloc_vfsmnt+167} <ffffffff801603ea>{cache_alloc_debugcheck_after+186} 
       <ffffffff80161955>{__kmalloc+181} <ffffffff801976c7>{alloc_vfsmnt+167} 
       <ffffffff80181202>{do_kern_mount+82} <ffffffff805cff6f>{mnt_init+207} 
       <ffffffff805cfcd6>{vfs_caches_init+198} <ffffffff805bb9b1>{start_kernel+401} 
       <ffffffff805bb268>{_sinittext+616} 
0000010003ffd668: redzone 1: 0x5a2cf071, redzone 2: 0x6b6b6b6b.
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
CPU: Physical Processor ID: 0


-Andi
