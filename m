Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751560AbWEKMQs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751560AbWEKMQs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 May 2006 08:16:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751610AbWEKMQs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 May 2006 08:16:48 -0400
Received: from [212.76.92.117] ([212.76.92.117]:58889 "EHLO raad.intranet")
	by vger.kernel.org with ESMTP id S1751560AbWEKMQr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 May 2006 08:16:47 -0400
From: Al Boldi <a1426z@gawab.com>
To: linux-kernel@vger.kernel.org
Subject: swapping and oom-killer: gfp_mask=0x201d2, order=0
Date: Thu, 11 May 2006 15:14:45 +0300
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200605111514.45503.a1426z@gawab.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The current mm behaviour in 2.6, during physical memory exhaustion, expresses 
itself as an oom-killing spree, while the kernel could have resorted to 
swapping.

Is there a reason why oom-killing is currently preferred over swapping?

Thanks!

--
Al

---
oom-killer: gfp_mask=0x201d2, order=0
 [<c0463e40>] pci_claim_resource+0x20/0xd0
 [<c013ff25>] out_of_memory+0xa5/0xc0
 [<c0141099>] __alloc_pages+0x279/0x310
 [<c0143669>] __do_page_cache_readahead+0xe9/0x120
 [<c0143b3f>] max_sane_readahead+0x2f/0x50
 [<c0463eac>] pci_claim_resource+0x8c/0xd0
 [<c013d8cb>] filemap_nopage+0x2eb/0x370
 [<c0149ea5>] do_no_page+0x65/0x220
 [<c0463f18>] pdev_sort_resources+0x28/0x100
 [<c014a1dc>] __handle_mm_fault+0xec/0x200
 [<c0113258>] do_page_fault+0x188/0x5c5
 [<c0463fbc>] pdev_sort_resources+0xcc/0x100
 [<c0463fbc>] pdev_sort_resources+0xcc/0x100
 [<c0463fbc>] pdev_sort_resources+0xcc/0x100
 [<c01130d0>] do_page_fault+0x0/0x5c5
 [<c0103a0f>] error_code+0x4f/0x54
Mem-info:
DMA per-cpu:
cpu 0 hot: high 0, batch 1 used:0
cpu 0 cold: high 0, batch 1 used:0
DMA32 per-cpu: empty
Normal per-cpu: empty
HighMem per-cpu: empty
Free pages:         476kB (0kB HighMem)
Active:96 inactive:126 dirty:0 writeback:0 unstable:0 free:119 slab:445 
mapped:186 pagetables:31
DMA free:476kB min:360kB low:448kB high:540kB active:384kB inactive:504kB 
present:8192kB pages_scanned:257 all_unreclaimable? no
lowmem_reserve[]: 0 0 0 0
DMA32 free:0kB min:0kB low:0kB high:0kB active:0kB inactive:0kB present:0kB 
pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0 0
Normal free:0kB min:0kB low:0kB high:0kB active:0kB inactive:0kB present:0kB 
pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0 0
HighMem free:0kB min:128kB low:128kB high:128kB active:0kB inactive:0kB 
present:0kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0 0
DMA: 23*4kB 4*8kB 0*16kB 1*32kB 1*64kB 0*128kB 1*256kB 0*512kB 0*1024kB 
0*2048kB 0*4096kB = 476kB
DMA32: empty
Normal: empty
HighMem: empty
Swap cache: add 11494, delete 11444, find 2453/5972, race 0+0
Free swap  = 1016696kB
Total swap = 1020088kB
Free swap:       1016696kB
2048 pages of RAM
0 pages of HIGHMEM
1031 reserved pages
209 pages shared
50 pages swap cached
0 pages dirty
0 pages writeback
186 pages mapped
445 pages slab
31 pages pagetables
Out of Memory: Kill process 65 (bash) score 88 and children.
Out of memory: Killed process 104 (mc).
oom-killer: gfp_mask=0x201d2, order=0
 [<c044fe40>] gzip_mark+0x0/0x10
 [<c013ff25>] out_of_memory+0xa5/0xc0
 [<c0141099>] __alloc_pages+0x279/0x310
 [<c0143669>] __do_page_cache_readahead+0xe9/0x120
 [<c0143b3f>] max_sane_readahead+0x2f/0x50
 [<c044feac>] flush_window+0x4c/0x70
 [<c013d8cb>] filemap_nopage+0x2eb/0x370
 [<c0149ea5>] do_no_page+0x65/0x220
 [<c044ff18>] unpack_to_rootfs+0x48/0x200
 [<c014a1dc>] __handle_mm_fault+0xec/0x200
 [<c0113258>] do_page_fault+0x188/0x5c5
 [<c044ffbc>] unpack_to_rootfs+0xec/0x200
 [<c044ffbc>] unpack_to_rootfs+0xec/0x200
 [<c044e000>] do_name+0x150/0x1b0
 [<c044e000>] do_name+0x150/0x1b0
 [<c01130d0>] do_page_fault+0x0/0x5c5
 [<c0103a0f>] error_code+0x4f/0x54
Mem-info:
DMA per-cpu:
cpu 0 hot: high 0, batch 1 used:0
cpu 0 cold: high 0, batch 1 used:0
DMA32 per-cpu: empty
Normal per-cpu: empty
HighMem per-cpu: empty
Free pages:         528kB (0kB HighMem)
Active:177 inactive:73 dirty:0 writeback:0 unstable:0 free:132 slab:440 
mapped:213 pagetables:27
DMA free:528kB min:360kB low:448kB high:540kB active:708kB inactive:292kB 
present:8192kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0 0
DMA32 free:0kB min:0kB low:0kB high:0kB active:0kB inactive:0kB present:0kB 
pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0 0
Normal free:0kB min:0kB low:0kB high:0kB active:0kB inactive:0kB present:0kB 
pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0 0
HighMem free:0kB min:128kB low:128kB high:128kB active:0kB inactive:0kB 
present:0kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0 0
DMA: 40*4kB 2*8kB 0*16kB 1*32kB 1*64kB 0*128kB 1*256kB 0*512kB 0*1024kB 
0*2048kB 0*4096kB = 528kB
DMA32: empty
Normal: empty
HighMem: empty
Swap cache: add 13712, delete 13643, find 2842/7215, race 0+0
Free swap  = 1016948kB
Total swap = 1020088kB
Free swap:       1016948kB
2048 pages of RAM
0 pages of HIGHMEM
1031 reserved pages
213 pages shared
69 pages swap cached
0 pages dirty
0 pages writeback
213 pages mapped
440 pages slab
27 pages pagetables
Out of Memory: Kill process 22 (bash) score 64 and children.
Out of memory: Killed process 103 (top).
oom-killer: gfp_mask=0x201d2, order=0
 [<c013ff25>] out_of_memory+0xa5/0xc0
 [<c0141099>] __alloc_pages+0x279/0x310
 [<c0143669>] __do_page_cache_readahead+0xe9/0x120
 [<c0143b3f>] max_sane_readahead+0x2f/0x50
 [<c013d8cb>] filemap_nopage+0x2eb/0x370
 [<c0149ea5>] do_no_page+0x65/0x220
 [<c014a1dc>] __handle_mm_fault+0xec/0x200
 [<c0113258>] do_page_fault+0x188/0x5c5
 [<c01130d0>] do_page_fault+0x0/0x5c5
 [<c0103a0f>] error_code+0x4f/0x54
Mem-info:
DMA per-cpu:
cpu 0 hot: high 0, batch 1 used:0
cpu 0 cold: high 0, batch 1 used:0
DMA32 per-cpu: empty
Normal per-cpu: empty
HighMem per-cpu: empty
Free pages:         368kB (0kB HighMem)
Active:18 inactive:261 dirty:0 writeback:0 unstable:0 free:92 slab:443 
mapped:246 pagetables:27
DMA free:368kB min:360kB low:448kB high:540kB active:72kB inactive:1044kB 
present:8192kB pages_scanned:466 all_unreclaimable? no
lowmem_reserve[]: 0 0 0 0
DMA32 free:0kB min:0kB low:0kB high:0kB active:0kB inactive:0kB present:0kB 
pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0 0
Normal free:0kB min:0kB low:0kB high:0kB active:0kB inactive:0kB present:0kB 
pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0 0
HighMem free:0kB min:128kB low:128kB high:128kB active:0kB inactive:0kB 
present:0kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0 0
DMA: 0*4kB 2*8kB 0*16kB 1*32kB 1*64kB 0*128kB 1*256kB 0*512kB 0*1024kB 
0*2048kB 0*4096kB = 368kB
DMA32: empty
Normal: empty
HighMem: empty
Swap cache: add 16443, delete 16334, find 3542/8819, race 0+0
Free swap  = 1016548kB
Total swap = 1020088kB
Free swap:       1016548kB
2048 pages of RAM
0 pages of HIGHMEM
1031 reserved pages
253 pages shared
109 pages swap cached
0 pages dirty
0 pages writeback
246 pages mapped
443 pages slab
27 pages pagetables
Out of Memory: Kill process 108 (bash) score 74 and children.
Out of memory: Killed process 144 (bash).
---
