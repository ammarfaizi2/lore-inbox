Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261751AbUJYKsi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261751AbUJYKsi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 06:48:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261753AbUJYKsi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 06:48:38 -0400
Received: from lucidpixels.com ([66.45.37.187]:3971 "HELO lucidpixels.com")
	by vger.kernel.org with SMTP id S261751AbUJYKsf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 06:48:35 -0400
Date: Mon, 25 Oct 2004 06:48:34 -0400 (EDT)
From: Justin Piszcz <jpiszcz@lucidpixels.com>
X-X-Sender: jpiszcz@p500
To: linux-kernel@vger.kernel.org
cc: akpm@osdl.org
Subject: Kernel 2.6.9 Page Allocation Failures w/TSO+rollup.patch 
Message-ID: <Pine.LNX.4.61.0410250645540.9868@p500>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I guess people who get this should just stick with 2.6.8.1?

$ dmesg
nfsd: page allocation failure. order:0, mode:0x20
  [<c013923c>] __alloc_pages+0x21c/0x350
  [<c0139388>] __get_free_pages+0x18/0x40
  [<c013c9ef>] kmem_getpages+0x1f/0xc0
  [<c013d730>] cache_grow+0xc0/0x1a0
  [<c013d9db>] cache_alloc_refill+0x1cb/0x210
  [<c013de41>] __kmalloc+0x71/0x80
  [<c036f583>] alloc_skb+0x53/0x100
  [<c031fb18>] e1000_alloc_rx_buffers+0x48/0xf0
  [<c031f81e>] e1000_clean_rx_irq+0x18e/0x440
  [<c0106a2f>] handle_IRQ_event+0x6f/0x80
  [<c031f3fb>] e1000_clean+0x5b/0x100
  [<c0375c0a>] net_rx_action+0x6a/0xf0
  [<c011daa1>] __do_softirq+0x41/0x90
  [<c011db17>] do_softirq+0x27/0x30
  [<c0106ebc>] do_IRQ+0x10c/0x130
  [<c01049c8>] common_interrupt+0x18/0x20
  [<c013007b>] simplify_symbols+0x5b/0x110
  [<c014019a>] shrink_list+0x30a/0x4b0
  [<c01404a3>] shrink_cache+0x163/0x380
  [<c0140c42>] shrink_zone+0xa2/0xd0
  [<c0140cc3>] shrink_caches+0x53/0x70
  [<c0140d8f>] try_to_free_pages+0xaf/0x1b0
  [<c0139287>] __alloc_pages+0x267/0x350
  [<c0136763>] generic_file_buffered_write+0x123/0x660
  [<c013918b>] __alloc_pages+0x16b/0x350
  [<c013d557>] alloc_slabmgmt+0x57/0x70
  [<c027c156>] xfs_trans_unlocked_item+0x56/0x60
  [<c02929cf>] xfs_write+0x78f/0xc00
  [<c028de01>] linvfs_writev+0x101/0x140
  [<c0116c60>] autoremove_wake_function+0x0/0x60
  [<c02a5e52>] copy_from_user+0x42/0x70
  [<c01542fa>] do_readv_writev+0x28a/0x2b0
  [<c028dfe0>] linvfs_open+0x0/0x90
  [<c01049c8>] common_interrupt+0x18/0x20
  [<c0153bc0>] do_sync_write+0x0/0x110
  [<c028e03a>] linvfs_open+0x5a/0x90
  [<c0152da2>] dentry_open+0xd2/0x270
  [<c01543d8>] vfs_writev+0x58/0x60
  [<c01caf26>] nfsd_write+0xf6/0x390
  [<c01049c8>] common_interrupt+0x18/0x20
  [<c01d33bb>] nfsd3_proc_write+0xbb/0x120
  [<c01c66c3>] nfsd_dispatch+0xa3/0x250
  [<c041f4e1>] svc_process+0x6e1/0x7f0
  [<c01c6463>] nfsd+0x203/0x3c0
  [<c01c6260>] nfsd+0x0/0x3c0
  [<c010207d>] kernel_thread_helper+0x5/0x18

I am not sure what else to do except stay with 2.6.8.1 as it did not have 
these problems.


