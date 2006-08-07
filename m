Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932147AbWHGPTv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932147AbWHGPTv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 11:19:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932144AbWHGPTu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 11:19:50 -0400
Received: from wr-out-0506.google.com ([64.233.184.226]:15997 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S932147AbWHGPTu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 11:19:50 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=dg4XpFUS5U+MrnSfmmkOk805aM0n12zZiAZGyJd228SAXzk3khTIcR+sVAugvWP1hhkO+7iJdJ4mZ8f6d2TzvHckWKInXXOfESp2Oi8BqmRCleNSDO9xnlAqQUO1SYDelEow80GHgk/vyPg5BIVLRfAyHEqEQhI3huguuqSUw1s=
Message-ID: <5bdc1c8b0608070819w653368cm82112655a7b98ec4@mail.gmail.com>
Date: Mon, 7 Aug 2006 08:19:48 -0700
From: "Mark Knecht" <markknecht@gmail.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Call Trace: 2.6.17-rt5: Call Trace: <ffffffff802500fd>{out_of_memory+55}
Cc: "Ingo Molnar" <mingo@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,
   I've never seen this on 2.6.17-rt5. Up until today it had always
been quite stable. I was running MythTV at the time. Nothing out of
the ordinary.

   Excuse my lack of experience here but after an event like this what
is the proper way to make sure the kernel is as stable as it can be?
Do I need to clean anything up? Reboot? Or is the cleanup all
automatic and everything is fine?

Thanks,
Mark



mark@lightning ~ $ uname -a
Linux lightning 2.6.17-rt5 #1 PREEMPT Sat Jul 1 17:02:05 PDT 2006
x86_64 AMD Athlon(tm) 64 Processor 3000+ GNU/Linux
mark@lightning ~ $

mark@lightning ~ $ free
             total       used       free     shared    buffers     cached
Mem:       1025928     177808     848120          0       6488      64664
-/+ buffers/cache:     106656     919272
Swap:      2008084     111352    1896732
mark@lightning ~ $


EXT3 FS on sdc1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
ieee1394: Node changed: 0-01:1023 -> 0-00:1023
ieee1394: Node changed: 0-02:1023 -> 0-01:1023
ieee1394: Reconnected to SBP-2 device
ieee1394: Node 0-00:1023: Max speed [S400] - Max payload [2048]
ieee1394: Node suspended: ID:BUS[0-00:1023]  GUID[00303c020010645c]
ieee1394: Node changed: 0-01:1023 -> 0-00:1023
ieee1394: Node suspended: ID:BUS[0-00:1023]  GUID[0050c504e0006463]
oom-killer: gfp_mask=0x201d2, order=0

Call Trace:
       <ffffffff802500fd>{out_of_memory+55}
       <ffffffff80251238>{__alloc_pages+531}
       <ffffffff8025301f>{__do_page_cache_readahead+206}
       <ffffffff802418cd>{debug_rt_mutex_unlock+288}
       <ffffffff8024ddf3>{filemap_nopage+334}
       <ffffffff80259b33>{__handle_mm_fault+953}
       <ffffffff80495bdb>{do_page_fault+1046}
       <ffffffff804922c8>{thread_return+177}
       <ffffffff8023f7f5>{sys_futex+173}
       <ffffffff8020a02d>{error_exit+0}
---------------------------
| preempt count: 00000000 ]
| 0-level deep critical section nesting:
----------------------------------------

Mem-info:
DMA per-cpu:
cpu 0 hot: high 0, batch 1 used:0
cpu 0 cold: high 0, batch 1 used:0
DMA32 per-cpu:
cpu 0 hot: high 186, batch 31 used:0
cpu 0 cold: high 62, batch 15 used:0
Normal per-cpu: empty
HighMem per-cpu: empty
Free pages:        8712kB (0kB HighMem)
Active:121456 inactive:121471 dirty:0 writeback:0 unstable:0 free:2178
slab:4887  mapped:242043 pagetables:2298
DMA free:4028kB min:36kB low:44kB high:52kB active:2820kB
inactive:2860kB presen t:9700kB pages_scanned:2265 all_unreclaimable?
no
lowmem_reserve[]: 0 994 994 994
DMA32 free:4684kB min:4012kB low:5012kB high:6016kB active:483004kB
inactive:483 024kB present:1018020kB pages_scanned:241386
all_unreclaimable? no
lowmem_reserve[]: 0 0 0 0
Normal free:0kB min:0kB low:0kB high:0kB active:0kB inactive:0kB
present:0kB pag es_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0 0
HighMem free:0kB min:128kB low:128kB high:128kB active:0kB
inactive:0kB present: 0kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0 0
DMA: 5*4kB 1*8kB 0*16kB 1*32kB 0*64kB 1*128kB 1*256kB 1*512kB 1*1024kB
1*2048kB 0*4096kB = 4028kB
DMA32: 233*4kB 41*8kB 10*16kB 4*32kB 1*64kB 0*128kB 0*256kB 0*512kB
1*1024kB 1*2 048kB 0*4096kB = 4684kB
Normal: empty
HighMem: empty
Swap cache: add 529025, delete 528759, find 4504/7351, race 0+3
Free swap  = 0kB
Total swap = 2008084kB
Free swap:            0kB
262128 pages of RAM
5646 reserved pages
7844 pages shared
266 pages swap cached
Out of Memory: Kill process 2505 (mythfrontend) score 757537 and children.
Out of memory: Killed process 2505 (mythfrontend).
oom-killer: gfp_mask=0x201d2, order=0

Call Trace:
       <ffffffff802500fd>{out_of_memory+55}
       <ffffffff80251238>{__alloc_pages+531}
       <ffffffff8025301f>{__do_page_cache_readahead+206}
       <ffffffff802418cd>{debug_rt_mutex_unlock+288}
       <ffffffff8024ddf3>{filemap_nopage+334}
       <ffffffff80259b33>{__handle_mm_fault+953}
       <ffffffff80495bdb>{do_page_fault+1046}
       <ffffffff80414a05>{sock_ioctl+445}
       <ffffffff8027c135>{do_ioctl+41}
       <ffffffff8027c3f0>{vfs_ioctl+626}
       <ffffffff8020a02d>{error_exit+0}
---------------------------
| preempt count: 00000000 ]
| 0-level deep critical section nesting:
----------------------------------------

Mem-info:
DMA per-cpu:
cpu 0 hot: high 0, batch 1 used:0
cpu 0 cold: high 0, batch 1 used:0
DMA32 per-cpu:
cpu 0 hot: high 186, batch 31 used:0
cpu 0 cold: high 62, batch 15 used:0
Normal per-cpu: empty
HighMem per-cpu: empty
Free pages:        8024kB (0kB HighMem)
Active:3577 inactive:239595 dirty:0 writeback:0 unstable:0 free:2006
slab:4889 m apped:242076 pagetables:2298
DMA free:4012kB min:36kB low:44kB high:52kB active:2920kB
inactive:2812kB presen t:9700kB pages_scanned:6214 all_unreclaimable?
yes
lowmem_reserve[]: 0 994 994 994
DMA32 free:4012kB min:4012kB low:5012kB high:6016kB active:11388kB
inactive:9555 68kB present:1018020kB pages_scanned:351254
all_unreclaimable? no
lowmem_reserve[]: 0 0 0 0
Normal free:0kB min:0kB low:0kB high:0kB active:0kB inactive:0kB
present:0kB pag es_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0 0
HighMem free:0kB min:128kB low:128kB high:128kB active:0kB
inactive:0kB present: 0kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0 0
DMA: 1*4kB 1*8kB 0*16kB 1*32kB 0*64kB 1*128kB 1*256kB 1*512kB 1*1024kB
1*2048kB 0*4096kB = 4012kB
DMA32: 63*4kB 40*8kB 11*16kB 4*32kB 1*64kB 0*128kB 0*256kB 0*512kB
1*1024kB 1*20 48kB 0*4096kB = 4012kB
Normal: empty
HighMem: empty
Swap cache: add 529099, delete 528833, find 4506/7361, race 0+3
Free swap  = 0kB
Total swap = 2008084kB
Free swap:            0kB
262128 pages of RAM
5646 reserved pages
7845 pages shared
266 pages swap cached
oom-killer: gfp_mask=0x201d2, order=0

Call Trace:
       <ffffffff802500fd>{out_of_memory+55}
       <ffffffff80251238>{__alloc_pages+531}
       <ffffffff8025301f>{__do_page_cache_readahead+206}
       <ffffffff802418cd>{debug_rt_mutex_unlock+288}
       <ffffffff8024ddf3>{filemap_nopage+334}
       <ffffffff80259b33>{__handle_mm_fault+953}
       <ffffffff80495bdb>{do_page_fault+1046}
       <ffffffff80273943>{sys_newstat+40}
       <ffffffff8020a02d>{error_exit+0}
---------------------------
| preempt count: 00000000 ]
| 0-level deep critical section nesting:
----------------------------------------

Mem-info:
DMA per-cpu:
cpu 0 hot: high 0, batch 1 used:0
cpu 0 cold: high 0, batch 1 used:0
DMA32 per-cpu:
cpu 0 hot: high 186, batch 31 used:0
cpu 0 cold: high 62, batch 15 used:0
Normal per-cpu: empty
HighMem per-cpu: empty
Free pages:        8024kB (0kB HighMem)
Active:16105 inactive:227096 dirty:0 writeback:0 unstable:0 free:2006
slab:4889 mapped:242076 pagetables:2298
DMA free:4012kB min:36kB low:44kB high:52kB active:2920kB
inactive:2812kB presen t:9700kB pages_scanned:6214 all_unreclaimable?
yes
lowmem_reserve[]: 0 994 994 994
DMA32 free:4012kB min:4012kB low:5012kB high:6016kB active:61500kB
inactive:9055 72kB present:1018020kB pages_scanned:25160
all_unreclaimable? no
lowmem_reserve[]: 0 0 0 0
Normal free:0kB min:0kB low:0kB high:0kB active:0kB inactive:0kB
present:0kB pag es_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0 0
HighMem free:0kB min:128kB low:128kB high:128kB active:0kB
inactive:0kB present: 0kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0 0
DMA: 1*4kB 1*8kB 0*16kB 1*32kB 0*64kB 1*128kB 1*256kB 1*512kB 1*1024kB
1*2048kB 0*4096kB = 4012kB
DMA32: 53*4kB 45*8kB 11*16kB 4*32kB 1*64kB 0*128kB 0*256kB 0*512kB
1*1024kB 1*20 48kB 0*4096kB = 4012kB
Normal: empty
HighMem: empty
Swap cache: add 529099, delete 528833, find 4506/7361, race 0+3
Free swap  = 0kB
Total swap = 2008084kB
Free swap:            0kB
262128 pages of RAM
5646 reserved pages
7821 pages shared
266 pages swap cached
mark@lightning ~ $
