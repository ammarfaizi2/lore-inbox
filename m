Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751503AbWEUIKm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751503AbWEUIKm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 May 2006 04:10:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751504AbWEUIKm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 May 2006 04:10:42 -0400
Received: from ns.dynamicweb.hu ([195.228.155.139]:42731 "EHLO dynamicweb.hu")
	by vger.kernel.org with ESMTP id S1751503AbWEUIKl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 May 2006 04:10:41 -0400
Message-ID: <00e901c67cad$fe9a9d90$1800a8c0@dcccs>
From: =?iso-8859-2?Q?Haar_J=E1nos?= <djani22@netcenter.hu>
To: <linux-kernel@vger.kernel.org>
Subject: swapper: page allocation failure.
Date: Sun, 21 May 2006 10:10:13 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1437
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1441
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, list,

I seriously gets this, and dont know why.
This server have 2GB ram, and ~1.1G always free!
Anybody have an idea?

Thanks,
Janos

May 21 09:05:35 st-0003 kernel: swapper: page allocation failure. order:0,
mode:0x20
May 21 09:05:35 st-0003 kernel:  <c013c6ac> __alloc_pages+0x274/0x286
<c014af1d> cache_alloc_refill+0x2a6/0x45c
May 21 09:05:35 st-0003 kernel:  <c014b12b> __kmalloc+0x58/0x61   <c03d5bfc>
__alloc_skb+0x49/0xf5
May 21 09:05:35 st-0003 kernel:  <f88336b1>
e1000_alloc_rx_buffers+0x5c/0x2e5 [e1000]   <f88315de>
e1000_clean_rx_irq+0x4fd/0x50a [e1000]
May 21 09:05:35 st-0003 kernel:  <f88342d2> e1000_intr+0x96/0xf4 [e1000]
<c0136927> handle_IRQ_event+0x20/0x4c
May 21 09:05:35 st-0003 kernel:  <c01369cf> __do_IRQ+0x7c/0xcd   <c0104a65>
do_IRQ+0x44/0x53
May 21 09:05:35 st-0003 kernel:  <c01030ba> common_interrupt+0x1a/0x20
<c01016f5> mwait_idle+0x20/0x34
May 21 09:05:35 st-0003 kernel:  <c01016c0> cpu_idle+0x5a/0x6f   <c05966c9>
start_kernel+0x317/0x31d
May 21 09:05:35 st-0003 kernel: Mem-info:
May 21 09:05:35 st-0003 kernel: DMA per-cpu:
May 21 09:05:35 st-0003 kernel: cpu 0 hot: high 0, batch 1 used:0
May 21 09:05:35 st-0003 kernel: cpu 0 cold: high 0, batch 1 used:0
May 21 09:05:35 st-0003 kernel: cpu 1 hot: high 0, batch 1 used:0
May 21 09:05:35 st-0003 kernel: cpu 1 cold: high 0, batch 1 used:0
May 21 09:05:35 st-0003 kernel: DMA32 per-cpu: empty
May 21 09:05:35 st-0003 kernel: Normal per-cpu:
May 21 09:05:35 st-0003 kernel: cpu 0 hot: high 186, batch 31 used:30
May 21 09:05:35 st-0003 kernel: cpu 0 cold: high 62, batch 15 used:47
May 21 09:05:35 st-0003 kernel: cpu 1 hot: high 186, batch 31 used:51
May 21 09:05:35 st-0003 kernel: cpu 1 cold: high 62, batch 15 used:55
May 21 09:05:35 st-0003 kernel: HighMem per-cpu:
May 21 09:05:35 st-0003 kernel: cpu 0 hot: high 186, batch 31 used:98
May 21 09:05:35 st-0003 kernel: cpu 0 cold: high 62, batch 15 used:10
May 21 09:05:35 st-0003 kernel: cpu 1 hot: high 186, batch 31 used:183
May 21 09:05:35 st-0003 kernel: cpu 1 cold: high 62, batch 15 used:6
May 21 09:05:35 st-0003 kernel: Free pages:     1165384kB (1160424kB
HighMem)
May 21 09:05:35 st-0003 kernel: Active:3002 inactive:212594 dirty:35905
writeback:1 unstable:0 free:291346 slab:6782 mapped:929 pagetables:57
May 21 09:05:35 st-0003 kernel: DMA free:3548kB min:68kB low:84kB high:100kB
active:0kB inactive:5808kB present:16384kB pages_scanned:0
all_unreclaimable? no
May 21 09:05:35 st-0003 kernel: lowmem_reserve[]: 0 0 880 2031
May 21 09:05:35 st-0003 kernel: DMA32 free:0kB min:0kB low:0kB high:0kB
active:0kB inactive:0kB present:0kB pages_scanned:0 all_unreclaimable? no
May 21 09:05:35 st-0003 kernel: lowmem_reserve[]: 0 0 880 2031
May 21 09:05:35 st-0003 kernel: Normal free:1412kB min:3756kB low:4692kB
high:5632kB active:8kB inactive:838708kB present:901120kB pages_scanned:0
all_unrecla
imable? no
May 21 09:05:35 st-0003 kernel: lowmem_reserve[]: 0 0 0 9215
May 21 09:05:35 st-0003 kernel: HighMem free:1160424kB min:512kB low:1740kB
high:2972kB active:12000kB inactive:5860kB present:1179584kB pages_scanned:0
all_u
nreclaimable? no
May 21 09:05:35 st-0003 kernel: lowmem_reserve[]: 0 0 0 0
May 21 09:05:35 st-0003 kernel: DMA: 1*4kB 1*8kB 1*16kB 0*32kB 1*64kB
1*128kB 1*256kB 0*512kB 1*1024kB 1*2048kB 0*4096kB = 3548kB
May 21 09:05:35 st-0003 kernel: DMA32: empty
May 21 09:05:35 st-0003 kernel: Normal: 1*4kB 0*8kB 0*16kB 0*32kB 0*64kB
1*128kB 1*256kB 0*512kB 1*1024kB 0*2048kB 0*4096kB = 1412kB
May 21 09:05:35 st-0003 kernel: HighMem: 142*4kB 34*8kB 18*16kB 8*32kB
6*64kB 2*128kB 1*256kB 0*512kB 1*1024kB 1*2048kB 282*4096kB = 1160424kB
May 21 09:05:35 st-0003 kernel: Free swap:            0kB
May 21 09:05:35 st-0003 kernel: 524272 pages of RAM
May 21 09:05:35 st-0003 kernel: 294896 pages of HIGHMEM
May 21 09:05:35 st-0003 kernel: 6010 reserved pages
May 21 09:05:35 st-0003 kernel: 213818 pages shared
May 21 09:05:35 st-0003 kernel: 0 pages swap cached
May 21 09:05:35 st-0003 kernel: 35905 pages dirty
May 21 09:05:35 st-0003 kernel: 1 pages writeback
May 21 09:05:35 st-0003 kernel: 929 pages mapped
May 21 09:05:35 st-0003 kernel: 6782 pages slab
May 21 09:05:35 st-0003 kernel: 57 pages pagetables
May 21 09:05:35 st-0003 kernel: swapper: page allocation failure. order:0,
mode:0x20
May 21 09:05:35 st-0003 kernel:  <c013c6ac> __alloc_pages+0x274/0x286
<c014af1d> cache_alloc_refill+0x2a6/0x45c
May 21 09:05:35 st-0003 kernel:  <c014b12b> __kmalloc+0x58/0x61   <c03d5bfc>
__alloc_skb+0x49/0xf5
May 21 09:05:35 st-0003 kernel:  <f88336b1>
e1000_alloc_rx_buffers+0x5c/0x2e5 [e1000]   <f8831570>
e1000_clean_rx_irq+0x48f/0x50a [e1000]
May 21 09:05:35 st-0003 kernel:  <f88342d2> e1000_intr+0x96/0xf4 [e1000]
<c0136927> handle_IRQ_event+0x20/0x4c
May 21 09:05:35 st-0003 kernel:  <c01369cf> __do_IRQ+0x7c/0xcd   <c0104a65>
do_IRQ+0x44/0x53
May 21 09:05:35 st-0003 kernel:  <c01030ba> common_interrupt+0x1a/0x20
<c01016f5> mwait_idle+0x20/0x34
May 21 09:05:35 st-0003 kernel:  <c01016c0> cpu_idle+0x5a/0x6f   <c05966c9>
start_kernel+0x317/0x31d
May 21 09:05:35 st-0003 kernel: Mem-info:
May 21 09:05:35 st-0003 kernel: DMA per-cpu:
May 21 09:05:35 st-0003 kernel: cpu 0 hot: high 0, batch 1 used:0
May 21 09:05:35 st-0003 kernel: cpu 0 cold: high 0, batch 1 used:0
May 21 09:05:35 st-0003 kernel: cpu 1 hot: high 0, batch 1 used:0
May 21 09:05:35 st-0003 kernel: cpu 1 cold: high 0, batch 1 used:0
May 21 09:05:35 st-0003 kernel: DMA32 per-cpu: empty
May 21 09:05:35 st-0003 kernel: Normal per-cpu:
May 21 09:05:35 st-0003 kernel: cpu 0 hot: high 186, batch 31 used:30
May 21 09:05:35 st-0003 kernel: cpu 0 cold: high 62, batch 15 used:47
May 21 09:05:35 st-0003 kernel: cpu 1 hot: high 186, batch 31 used:51
May 21 09:05:35 st-0003 kernel: cpu 1 cold: high 62, batch 15 used:55
May 21 09:05:35 st-0003 kernel: HighMem per-cpu:
May 21 09:05:35 st-0003 kernel: cpu 0 hot: high 186, batch 31 used:98
May 21 09:05:35 st-0003 kernel: cpu 0 cold: high 62, batch 15 used:10
May 21 09:05:35 st-0003 kernel: cpu 1 hot: high 186, batch 31 used:183
May 21 09:05:35 st-0003 kernel: cpu 1 cold: high 62, batch 15 used:6
May 21 09:05:35 st-0003 kernel: Free pages:     1165384kB (1160424kB
HighMem)
May 21 09:05:35 st-0003 kernel: Active:3002 inactive:212594 dirty:35905
writeback:1 unstable:0 free:291346 slab:6782 mapped:929 pagetables:57
May 21 09:05:35 st-0003 kernel: DMA free:3548kB min:68kB low:84kB high:100kB
active:0kB inactive:5808kB present:16384kB pages_scanned:0
all_unreclaimable? no
May 21 09:05:35 st-0003 kernel: lowmem_reserve[]: 0 0 880 2031
May 21 09:05:35 st-0003 kernel: DMA32 free:0kB min:0kB low:0kB high:0kB
active:0kB inactive:0kB present:0kB pages_scanned:0 all_unreclaimable? no
May 21 09:05:35 st-0003 kernel: lowmem_reserve[]: 0 0 880 2031
May 21 09:05:35 st-0003 kernel: Normal free:1412kB min:3756kB low:4692kB
high:5632kB active:8kB inactive:838708kB present:901120kB pages_scanned:0
all_unrecla
imable? no
May 21 09:05:35 st-0003 kernel: lowmem_reserve[]: 0 0 0 9215
May 21 09:05:35 st-0003 kernel: HighMem free:1160424kB min:512kB low:1740kB
high:2972kB active:12000kB inactive:5860kB present:1179584kB pages_scanned:0
all_u
nreclaimable? no
May 21 09:05:35 st-0003 kernel: lowmem_reserve[]: 0 0 0 0
May 21 09:05:35 st-0003 kernel: DMA: 1*4kB 1*8kB 1*16kB 0*32kB 1*64kB
1*128kB 1*256kB 0*512kB 1*1024kB 1*2048kB 0*4096kB = 3548kB
May 21 09:05:35 st-0003 kernel: DMA32: empty
May 21 09:05:35 st-0003 kernel: Normal: 1*4kB 0*8kB 0*16kB 0*32kB 0*64kB
1*128kB 1*256kB 0*512kB 1*1024kB 0*2048kB 0*4096kB = 1412kB
May 21 09:05:35 st-0003 kernel: HighMem: 142*4kB 34*8kB 18*16kB 8*32kB
6*64kB 2*128kB 1*256kB 0*512kB 1*1024kB 1*2048kB 282*4096kB = 1160424kB
May 21 09:05:35 st-0003 kernel: Free swap:            0kB
May 21 09:05:35 st-0003 kernel: 524272 pages of RAM
May 21 09:05:35 st-0003 kernel: 294896 pages of HIGHMEM
May 21 09:05:35 st-0003 kernel: 6010 reserved pages
May 21 09:05:35 st-0003 kernel: 213818 pages shared
May 21 09:05:35 st-0003 kernel: 0 pages swap cached
May 21 09:05:35 st-0003 kernel: 35905 pages dirty
May 21 09:05:35 st-0003 kernel: 1 pages writeback
May 21 09:05:35 st-0003 kernel: 929 pages mapped
May 21 09:05:35 st-0003 kernel: 6782 pages slab
May 21 09:05:35 st-0003 kernel: 57 pages pagetables
May 21 09:05:35 st-0003 kernel: swapper: page allocation failure. order:0,
mode:0x20
May 21 09:05:35 st-0003 kernel:  <c013c6ac> __alloc_pages+0x274/0x286
<c014af1d> cache_alloc_refill+0x2a6/0x45c
May 21 09:05:35 st-0003 kernel:  <c014b12b> __kmalloc+0x58/0x61   <c03d5bfc>
__alloc_skb+0x49/0xf5
May 21 09:05:35 st-0003 kernel:  <f88336b1>
e1000_alloc_rx_buffers+0x5c/0x2e5 [e1000]   <f8831570>
e1000_clean_rx_irq+0x48f/0x50a [e1000]
May 21 09:05:35 st-0003 kernel:  <f88342d2> e1000_intr+0x96/0xf4 [e1000]
<c0136927> handle_IRQ_event+0x20/0x4c
May 21 09:05:35 st-0003 kernel:  <c01369cf> __do_IRQ+0x7c/0xcd   <c0104a65>
do_IRQ+0x44/0x53
May 21 09:05:35 st-0003 kernel:  <c01030ba> common_interrupt+0x1a/0x20
<c01016f5> mwait_idle+0x20/0x34
May 21 09:05:35 st-0003 kernel:  <c01016c0> cpu_idle+0x5a/0x6f   <c05966c9>
start_kernel+0x317/0x31d
May 21 09:05:35 st-0003 kernel: Mem-info:
May 21 09:05:35 st-0003 kernel: DMA per-cpu:
May 21 09:05:35 st-0003 kernel: cpu 0 hot: high 0, batch 1 used:0
May 21 09:05:35 st-0003 kernel: cpu 0 cold: high 0, batch 1 used:0
May 21 09:05:35 st-0003 kernel: cpu 1 hot: high 0, batch 1 used:0
May 21 09:05:35 st-0003 kernel: cpu 1 cold: high 0, batch 1 used:0
May 21 09:05:35 st-0003 kernel: DMA32 per-cpu: empty
May 21 09:05:35 st-0003 kernel: Normal per-cpu:
May 21 09:05:35 st-0003 kernel: cpu 0 hot: high 186, batch 31 used:30
May 21 09:05:35 st-0003 kernel: cpu 0 cold: high 62, batch 15 used:47
May 21 09:05:35 st-0003 kernel: cpu 1 hot: high 186, batch 31 used:51
May 21 09:05:35 st-0003 kernel: cpu 1 cold: high 62, batch 15 used:55
May 21 09:05:35 st-0003 kernel: HighMem per-cpu:
May 21 09:05:35 st-0003 kernel: cpu 0 hot: high 186, batch 31 used:98
May 21 09:05:35 st-0003 kernel: cpu 0 cold: high 62, batch 15 used:10
May 21 09:05:35 st-0003 kernel: cpu 1 hot: high 186, batch 31 used:183
May 21 09:05:35 st-0003 kernel: cpu 1 cold: high 62, batch 15 used:6
May 21 09:05:35 st-0003 kernel: Free pages:     1165384kB (1160424kB
HighMem)
May 21 09:05:35 st-0003 kernel: Active:3002 inactive:212594 dirty:35905
writeback:1 unstable:0 free:291346 slab:6782 mapped:929 pagetables:57
May 21 09:05:35 st-0003 kernel: DMA free:3548kB min:68kB low:84kB high:100kB
active:0kB inactive:5808kB present:16384kB pages_scanned:0
all_unreclaimable? no
May 21 09:05:35 st-0003 kernel: lowmem_reserve[]: 0 0 880 2031
May 21 09:05:35 st-0003 kernel: DMA32 free:0kB min:0kB low:0kB high:0kB
active:0kB inactive:0kB present:0kB pages_scanned:0 all_unreclaimable? no
May 21 09:05:35 st-0003 kernel: lowmem_reserve[]: 0 0 880 2031
May 21 09:05:35 st-0003 kernel: Normal free:1412kB min:3756kB low:4692kB
high:5632kB active:8kB inactive:838708kB present:901120kB pages_scanned:0
all_unrecla
imable? no
May 21 09:05:35 st-0003 kernel: lowmem_reserve[]: 0 0 0 9215
May 21 09:05:35 st-0003 kernel: HighMem free:1160424kB min:512kB low:1740kB
high:2972kB active:12000kB inactive:5860kB present:1179584kB pages_scanned:0
all_u
nreclaimable? no
May 21 09:05:35 st-0003 kernel: lowmem_reserve[]: 0 0 0 0
May 21 09:05:35 st-0003 kernel: DMA: 1*4kB 1*8kB 1*16kB 0*32kB 1*64kB
1*128kB 1*256kB 0*512kB 1*1024kB 1*2048kB 0*4096kB = 3548kB
May 21 09:05:35 st-0003 kernel: DMA32: empty
May 21 09:05:35 st-0003 kernel: Normal: 1*4kB 0*8kB 0*16kB 0*32kB 0*64kB
1*128kB 1*256kB 0*512kB 1*1024kB 0*2048kB 0*4096kB = 1412kB
May 21 09:05:35 st-0003 kernel: HighMem: 142*4kB 34*8kB 18*16kB 8*32kB
6*64kB 2*128kB 1*256kB 0*512kB 1*1024kB 1*2048kB 282*4096kB = 1160424kB
May 21 09:05:35 st-0003 kernel: Free swap:            0kB
May 21 09:05:35 st-0003 kernel: 524272 pages of RAM
May 21 09:05:35 st-0003 kernel: 294896 pages of HIGHMEM
May 21 09:05:35 st-0003 kernel: 6010 reserved pages
May 21 09:05:35 st-0003 kernel: 213818 pages shared
May 21 09:05:35 st-0003 kernel: 0 pages swap cached
May 21 09:05:35 st-0003 kernel: 35905 pages dirty
May 21 09:05:35 st-0003 kernel: 1 pages writeback
May 21 09:05:35 st-0003 kernel: 929 pages mapped
May 21 09:05:35 st-0003 kernel: 6782 pages slab
May 21 09:05:35 st-0003 kernel: 57 pages pagetables
May 21 09:05:35 st-0003 kernel: swapper: page allocation failure. order:0,
mode:0x20
May 21 09:05:35 st-0003 kernel:  <c013c6ac> __alloc_pages+0x274/0x286
<c014af1d> cache_alloc_refill+0x2a6/0x45c
May 21 09:05:35 st-0003 kernel:  <c014b12b> __kmalloc+0x58/0x61   <c03d5bfc>
__alloc_skb+0x49/0xf5
May 21 09:05:35 st-0003 kernel:  <f88336b1>
e1000_alloc_rx_buffers+0x5c/0x2e5 [e1000]   <f8831570>
e1000_clean_rx_irq+0x48f/0x50a [e1000]
May 21 09:05:35 st-0003 kernel:  <f88342d2> e1000_intr+0x96/0xf4 [e1000]
<c0136927> handle_IRQ_event+0x20/0x4c
May 21 09:05:35 st-0003 kernel:  <c01369cf> __do_IRQ+0x7c/0xcd   <c0104a65>
do_IRQ+0x44/0x53
May 21 09:05:35 st-0003 kernel:  <c01030ba> common_interrupt+0x1a/0x20
<c01016f5> mwait_idle+0x20/0x34
May 21 09:05:35 st-0003 kernel:  <c01016c0> cpu_idle+0x5a/0x6f   <c05966c9>
start_kernel+0x317/0x31d
May 21 09:05:35 st-0003 kernel: Mem-info:
May 21 09:05:35 st-0003 kernel: DMA per-cpu:
May 21 09:05:35 st-0003 kernel: cpu 0 hot: high 0, batch 1 used:0
May 21 09:05:35 st-0003 kernel: cpu 0 cold: high 0, batch 1 used:0
May 21 09:05:35 st-0003 kernel: cpu 1 hot: high 0, batch 1 used:0
May 21 09:05:35 st-0003 kernel: cpu 1 cold: high 0, batch 1 used:0
May 21 09:05:35 st-0003 kernel: DMA32 per-cpu: empty
May 21 09:05:35 st-0003 kernel: Normal per-cpu:
May 21 09:05:35 st-0003 kernel: cpu 0 hot: high 186, batch 31 used:30
May 21 09:05:35 st-0003 kernel: cpu 0 cold: high 62, batch 15 used:47
May 21 09:05:35 st-0003 kernel: cpu 1 hot: high 186, batch 31 used:51
May 21 09:05:35 st-0003 kernel: cpu 1 cold: high 62, batch 15 used:55
May 21 09:05:35 st-0003 kernel: HighMem per-cpu:
May 21 09:05:35 st-0003 kernel: cpu 0 hot: high 186, batch 31 used:98
May 21 09:05:35 st-0003 kernel: cpu 0 cold: high 62, batch 15 used:10
May 21 09:05:35 st-0003 kernel: cpu 1 hot: high 186, batch 31 used:183
May 21 09:05:35 st-0003 kernel: cpu 1 cold: high 62, batch 15 used:6
May 21 09:05:35 st-0003 kernel: Free pages:     1165384kB (1160424kB
HighMem)
May 21 09:05:35 st-0003 kernel: Active:3002 inactive:212594 dirty:35905
writeback:1 unstable:0 free:291346 slab:6782 mapped:929 pagetables:57
May 21 09:05:35 st-0003 kernel: DMA free:3548kB min:68kB low:84kB high:100kB
active:0kB inactive:5808kB present:16384kB pages_scanned:0
all_unreclaimable? no
May 21 09:05:35 st-0003 kernel: lowmem_reserve[]: 0 0 880 2031
May 21 09:05:35 st-0003 kernel: DMA32 free:0kB min:0kB low:0kB high:0kB
active:0kB inactive:0kB present:0kB pages_scanned:0 all_unreclaimable? no
May 21 09:05:35 st-0003 kernel: lowmem_reserve[]: 0 0 880 2031
May 21 09:05:35 st-0003 kernel: Normal free:1412kB min:3756kB low:4692kB
high:5632kB active:8kB inactive:838708kB present:901120kB pages_scanned:0
all_unrecla
imable? no
May 21 09:05:35 st-0003 kernel: lowmem_reserve[]: 0 0 0 9215
May 21 09:05:35 st-0003 kernel: HighMem free:1160424kB min:512kB low:1740kB
high:2972kB active:12000kB inactive:5860kB present:1179584kB pages_scanned:0
all_u
nreclaimable? no
May 21 09:05:35 st-0003 kernel: lowmem_reserve[]: 0 0 0 0
May 21 09:05:35 st-0003 kernel: DMA: 1*4kB 1*8kB 1*16kB 0*32kB 1*64kB
1*128kB 1*256kB 0*512kB 1*1024kB 1*2048kB 0*4096kB = 3548kB
May 21 09:05:35 st-0003 kernel: DMA32: empty
May 21 09:05:35 st-0003 kernel: Normal: 1*4kB 0*8kB 0*16kB 0*32kB 0*64kB
1*128kB 1*256kB 0*512kB 1*1024kB 0*2048kB 0*4096kB = 1412kB
May 21 09:05:35 st-0003 kernel: HighMem: 142*4kB 34*8kB 18*16kB 8*32kB
6*64kB 2*128kB 1*256kB 0*512kB 1*1024kB 1*2048kB 282*4096kB = 1160424kB
May 21 09:05:35 st-0003 kernel: Free swap:            0kB
May 21 09:05:35 st-0003 kernel: 524272 pages of RAM
May 21 09:05:35 st-0003 kernel: 294896 pages of HIGHMEM
May 21 09:05:35 st-0003 kernel: 6010 reserved pages
May 21 09:05:35 st-0003 kernel: 213818 pages shared
May 21 09:05:35 st-0003 kernel: 0 pages swap cached
May 21 09:05:35 st-0003 kernel: 35905 pages dirty
May 21 09:05:35 st-0003 kernel: 1 pages writeback
May 21 09:05:35 st-0003 kernel: 929 pages mapped
May 21 09:05:35 st-0003 kernel: 6782 pages slab
May 21 09:05:35 st-0003 kernel: 57 pages pagetables
May 21 09:05:35 st-0003 kernel: swapper: page allocation failure. order:0,
mode:0x20
May 21 09:05:35 st-0003 kernel:  <c013c6ac> __alloc_pages+0x274/0x286
<c014af1d> cache_alloc_refill+0x2a6/0x45c
May 21 09:05:35 st-0003 kernel:  <c014b12b> __kmalloc+0x58/0x61   <c03d5bfc>
__alloc_skb+0x49/0xf5
May 21 09:05:35 st-0003 kernel:  <f88336b1>
e1000_alloc_rx_buffers+0x5c/0x2e5 [e1000]   <f8831570>
e1000_clean_rx_irq+0x48f/0x50a [e1000]
May 21 09:05:35 st-0003 kernel:  <f88342d2> e1000_intr+0x96/0xf4 [e1000]
<c0136927> handle_IRQ_event+0x20/0x4c
May 21 09:05:35 st-0003 kernel:  <c01369cf> __do_IRQ+0x7c/0xcd   <c0104a65>
do_IRQ+0x44/0x53
May 21 09:05:35 st-0003 kernel:  <c01030ba> common_interrupt+0x1a/0x20
<c01016f5> mwait_idle+0x20/0x34
May 21 09:05:35 st-0003 kernel:  <c01016c0> cpu_idle+0x5a/0x6f   <c05966c9>
start_kernel+0x317/0x31d
May 21 09:05:35 st-0003 kernel: Mem-info:
May 21 09:05:35 st-0003 kernel: DMA per-cpu:
May 21 09:05:35 st-0003 kernel: cpu 0 hot: high 0, batch 1 used:0
May 21 09:05:35 st-0003 kernel: cpu 0 cold: high 0, batch 1 used:0
May 21 09:05:35 st-0003 kernel: cpu 1 hot: high 0, batch 1 used:0
May 21 09:05:35 st-0003 kernel: cpu 1 cold: high 0, batch 1 used:0
May 21 09:05:35 st-0003 kernel: DMA32 per-cpu: empty
May 21 09:05:35 st-0003 kernel: Normal per-cpu:
May 21 09:05:35 st-0003 kernel: cpu 0 hot: high 186, batch 31 used:30
May 21 09:05:35 st-0003 kernel: cpu 0 cold: high 62, batch 15 used:47
May 21 09:05:35 st-0003 kernel: cpu 1 hot: high 186, batch 31 used:51
May 21 09:05:35 st-0003 kernel: cpu 1 cold: high 62, batch 15 used:55
May 21 09:05:35 st-0003 kernel: HighMem per-cpu:
May 21 09:05:35 st-0003 kernel: cpu 0 hot: high 186, batch 31 used:98
May 21 09:05:35 st-0003 kernel: cpu 0 cold: high 62, batch 15 used:10
May 21 09:05:35 st-0003 kernel: cpu 1 hot: high 186, batch 31 used:183
May 21 09:05:35 st-0003 kernel: cpu 1 cold: high 62, batch 15 used:6
May 21 09:05:35 st-0003 kernel: Free pages:     1165384kB (1160424kB
HighMem)
May 21 09:05:35 st-0003 kernel: Active:3002 inactive:212594 dirty:35905
writeback:1 unstable:0 free:291346 slab:6782 mapped:929 pagetables:57
May 21 09:05:35 st-0003 kernel: DMA free:3548kB min:68kB low:84kB high:100kB
active:0kB inactive:5808kB present:16384kB pages_scanned:0
all_unreclaimable? no
May 21 09:05:35 st-0003 kernel: lowmem_reserve[]: 0 0 880 2031
May 21 09:05:35 st-0003 kernel: DMA32 free:0kB min:0kB low:0kB high:0kB
active:0kB inactive:0kB present:0kB pages_scanned:0 all_unreclaimable? no
May 21 09:05:35 st-0003 kernel: lowmem_reserve[]: 0 0 880 2031
May 21 09:05:35 st-0003 kernel: Normal free:1412kB min:3756kB low:4692kB
high:5632kB active:8kB inactive:838708kB present:901120kB pages_scanned:0
all_unrecla
imable? no
May 21 09:05:35 st-0003 kernel: lowmem_reserve[]: 0 0 0 9215
May 21 09:05:35 st-0003 kernel: HighMem free:1160424kB min:512kB low:1740kB
high:2972kB active:12000kB inactive:5860kB present:1179584kB pages_scanned:0
all_u
nreclaimable? no
May 21 09:05:35 st-0003 kernel: lowmem_reserve[]: 0 0 0 0
May 21 09:05:35 st-0003 kernel: DMA: 1*4kB 1*8kB 1*16kB 0*32kB 1*64kB
1*128kB 1*256kB 0*512kB 1*1024kB 1*2048kB 0*4096kB = 3548kB
May 21 09:05:35 st-0003 kernel: DMA32: empty
May 21 09:05:35 st-0003 kernel: Normal: 1*4kB 0*8kB 0*16kB 0*32kB 0*64kB
1*128kB 1*256kB 0*512kB 1*1024kB 0*2048kB 0*4096kB = 1412kB
May 21 09:05:35 st-0003 kernel: HighMem: 142*4kB 34*8kB 18*16kB 8*32kB
6*64kB 2*128kB 1*256kB 0*512kB 1*1024kB 1*2048kB 282*4096kB = 1160424kB
May 21 09:05:35 st-0003 kernel: Free swap:            0kB
May 21 09:05:35 st-0003 kernel: 524272 pages of RAM
May 21 09:05:35 st-0003 kernel: 294896 pages of HIGHMEM
May 21 09:05:35 st-0003 kernel: 6010 reserved pages
May 21 09:05:35 st-0003 kernel: 213818 pages shared
May 21 09:05:35 st-0003 kernel: 0 pages swap cached
May 21 09:05:35 st-0003 kernel: 35905 pages dirty
May 21 09:05:35 st-0003 kernel: 1 pages writeback
May 21 09:05:35 st-0003 kernel: 929 pages mapped
May 21 09:05:35 st-0003 kernel: 6782 pages slab
May 21 09:05:35 st-0003 kernel: 57 pages pagetables
May 21 09:05:35 st-0003 kernel: swapper: page allocation failure. order:0,
mode:0x20
May 21 09:05:35 st-0003 kernel:  <c013c6ac> __alloc_pages+0x274/0x286
<c014af1d> cache_alloc_refill+0x2a6/0x45c
May 21 09:05:35 st-0003 kernel:  <c014b12b> __kmalloc+0x58/0x61   <c03d5bfc>
__alloc_skb+0x49/0xf5
May 21 09:05:35 st-0003 kernel:  <f88336b1>
e1000_alloc_rx_buffers+0x5c/0x2e5 [e1000]   <f8831570>
e1000_clean_rx_irq+0x48f/0x50a [e1000]
May 21 09:05:35 st-0003 kernel:  <f88342d2> e1000_intr+0x96/0xf4 [e1000]
<c0136927> handle_IRQ_event+0x20/0x4c
May 21 09:05:35 st-0003 kernel:  <c01369cf> __do_IRQ+0x7c/0xcd   <c0104a65>
do_IRQ+0x44/0x53
May 21 09:05:35 st-0003 kernel:  <c01030ba> common_interrupt+0x1a/0x20
<c01016f5> mwait_idle+0x20/0x34
May 21 09:05:35 st-0003 kernel:  <c01016c0> cpu_idle+0x5a/0x6f   <c05966c9>
start_kernel+0x317/0x31d
May 21 09:05:35 st-0003 kernel: Mem-info:
May 21 09:05:35 st-0003 kernel: DMA per-cpu:
May 21 09:05:35 st-0003 kernel: cpu 0 hot: high 0, batch 1 used:0
May 21 09:05:35 st-0003 kernel: cpu 0 cold: high 0, batch 1 used:0
May 21 09:05:35 st-0003 kernel: cpu 1 hot: high 0, batch 1 used:0
May 21 09:05:35 st-0003 kernel: cpu 1 cold: high 0, batch 1 used:0
May 21 09:05:35 st-0003 kernel: DMA32 per-cpu: empty
May 21 09:05:35 st-0003 kernel: Normal per-cpu:
May 21 09:05:35 st-0003 kernel: cpu 0 hot: high 186, batch 31 used:30
May 21 09:05:35 st-0003 kernel: cpu 0 cold: high 62, batch 15 used:47
May 21 09:05:35 st-0003 kernel: cpu 1 hot: high 186, batch 31 used:51
May 21 09:05:35 st-0003 kernel: cpu 1 cold: high 62, batch 15 used:55
May 21 09:05:35 st-0003 kernel: HighMem per-cpu:
May 21 09:05:35 st-0003 kernel: cpu 0 hot: high 186, batch 31 used:98
May 21 09:05:35 st-0003 kernel: cpu 0 cold: high 62, batch 15 used:10
May 21 09:05:35 st-0003 kernel: cpu 1 hot: high 186, batch 31 used:183
May 21 09:05:35 st-0003 kernel: cpu 1 cold: high 62, batch 15 used:6
May 21 09:05:35 st-0003 kernel: Free pages:     1165384kB (1160424kB
HighMem)
May 21 09:05:35 st-0003 kernel: Active:3002 inactive:212594 dirty:35905
writeback:1 unstable:0 free:291346 slab:6782 mapped:929 pagetables:57
May 21 09:05:35 st-0003 kernel: DMA free:3548kB min:68kB low:84kB high:100kB
active:0kB inactive:5808kB present:16384kB pages_scanned:0
all_unreclaimable? no
May 21 09:05:35 st-0003 kernel: lowmem_reserve[]: 0 0 880 2031
May 21 09:05:35 st-0003 kernel: DMA32 free:0kB min:0kB low:0kB high:0kB
active:0kB inactive:0kB present:0kB pages_scanned:0 all_unreclaimable? no
May 21 09:05:35 st-0003 kernel: lowmem_reserve[]: 0 0 880 2031
May 21 09:05:35 st-0003 kernel: Normal free:1412kB min:3756kB low:4692kB
high:5632kB active:8kB inactive:838708kB present:901120kB pages_scanned:0
all_unrecla
imable? no
May 21 09:05:35 st-0003 kernel: lowmem_reserve[]: 0 0 0 9215
May 21 09:05:35 st-0003 kernel: HighMem free:1160424kB min:512kB low:1740kB
high:2972kB active:12000kB inactive:5860kB present:1179584kB pages_scanned:0
all_u
nreclaimable? no
May 21 09:05:35 st-0003 kernel: lowmem_reserve[]: 0 0 0 0
May 21 09:05:35 st-0003 kernel: DMA: 1*4kB 1*8kB 1*16kB 0*32kB 1*64kB
1*128kB 1*256kB 0*512kB 1*1024kB 1*2048kB 0*4096kB = 3548kB
May 21 09:05:35 st-0003 kernel: DMA32: empty
May 21 09:05:35 st-0003 kernel: Normal: 1*4kB 0*8kB 0*16kB 0*32kB 0*64kB
1*128kB 1*256kB 0*512kB 1*1024kB 0*2048kB 0*4096kB = 1412kB
May 21 09:05:35 st-0003 kernel: HighMem: 142*4kB 34*8kB 18*16kB 8*32kB
6*64kB 2*128kB 1*256kB 0*512kB 1*1024kB 1*2048kB 282*4096kB = 1160424kB
May 21 09:05:35 st-0003 kernel: Free swap:            0kB
May 21 09:05:35 st-0003 kernel: 524272 pages of RAM
May 21 09:05:35 st-0003 kernel: 294896 pages of HIGHMEM
May 21 09:05:35 st-0003 kernel: 6010 reserved pages
May 21 09:05:35 st-0003 kernel: 213818 pages shared
May 21 09:05:35 st-0003 kernel: 0 pages swap cached
May 21 09:05:35 st-0003 kernel: 35905 pages dirty
May 21 09:05:35 st-0003 kernel: 1 pages writeback
May 21 09:05:35 st-0003 kernel: 929 pages mapped
May 21 09:05:35 st-0003 kernel: 6782 pages slab
May 21 09:05:35 st-0003 kernel: 57 pages pagetables

