Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262789AbTKYSOh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Nov 2003 13:14:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262838AbTKYSOh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Nov 2003 13:14:37 -0500
Received: from pengo.systems.pipex.net ([62.241.160.193]:60641 "EHLO
	pengo.systems.pipex.net") by vger.kernel.org with ESMTP
	id S262789AbTKYSOc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Nov 2003 13:14:32 -0500
Message-ID: <3FC39C1E.8000005@xenon-computing.com>
Date: Tue, 25 Nov 2003 18:14:54 +0000
From: root <kernel@xenon-computing.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6a) Gecko/20031014 Thunderbird/0.4a
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: What exactly are the issues with 2.6.0-test10 preempt?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Hi,

I know it's binary only, but the NVidia driver produces the folowing
which I thought might help in determining where this problem lies.

Debug: sleeping function called from invalid context at mm/slab.c:1856
in_atomic():1, irqs_disabled():0
Call Trace:
  [<c01202ac>] __might_sleep+0xac/0xe0
  [<c0145a18>] kmem_cache_alloc+0x78/0x80
  [<c0157035>] __get_vm_area+0x25/0x150
  [<c0157193>] get_vm_area+0x33/0x40
  [<c011bd2d>] __ioremap+0xbd/0x120
  [<c011bdbc>] ioremap_nocache+0x2c/0xc0
  [<f8b66edc>] os_map_kernel_space+0x4c/0x70 [nvidia]
  [<f8a3b377>] __nvsym00568+0x1f/0x2c [nvidia]
  [<f8a3d496>] __nvsym00775+0x6e/0xe0 [nvidia]
  [<f8a3d526>] __nvsym00781+0x1e/0x190 [nvidia]
  [<f8a3efac>] rm_init_adapter+0xc/0x10 [nvidia]
  [<f8b63489>] nv_kern_open+0x119/0x270 [nvidia]
  [<c016d519>] may_open+0x59/0x1d0
  [<c01673f8>] chrdev_open+0xe8/0x250
  [<c015e198>] get_empty_filp+0x68/0xe0
  [<c015c440>] dentry_open+0x110/0x180
  [<c015c328>] filp_open+0x68/0x70
  [<c015c7eb>] sys_open+0x5b/0x90
  [<c010b16b>] syscall_call+0x7/0xb



1: NVRM: AGPGART: unable to retrieve symbol table
Debug: sleeping function called from invalid context at mm/page_alloc.c:548
in_atomic():1, irqs_disabled():0
Call Trace:
  [<c01202ac>] __might_sleep+0xac/0xe0
  [<c0141e7c>] __alloc_pages+0x35c/0x370
  [<c011afb2>] pte_alloc_one+0x22/0x70
  [<c014b3a7>] pte_alloc_map+0x47/0x120
  [<c014c965>] remap_page_range+0xf5/0x250
  [<f8b66f8a>] os_map_io_space+0x5a/0x70 [nvidia]
  [<f8a3b3fa>] __nvsym00625+0x1e/0x28 [nvidia]
  [<f8a39731>] __nvsym00602+0x91/0xc4 [nvidia]
  [<f8a398e2>] __nvsym00611+0x26/0x5c [nvidia]
  [<f8a3f123>] rm_map_agp_pages+0x1b/0x24 [nvidia]
  [<f8b639d2>] nv_kern_mmap+0x272/0x440 [nvidia]
  [<c014f6e0>] do_mmap_pgoff+0x310/0x6b0
  [<c011266e>] old_mmap+0x13e/0x190
  [<c010b16b>] syscall_call+0x7/0xb
  [<c0284627>] __scm_destroy+0x27/0x60





Regards, Mark.
