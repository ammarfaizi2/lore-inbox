Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269311AbUIYL53@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269311AbUIYL53 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Sep 2004 07:57:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267543AbUIYL53
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Sep 2004 07:57:29 -0400
Received: from p5089F3FB.dip.t-dialin.net ([80.137.243.251]:1284 "EHLO
	timbaland.dnsalias.org") by vger.kernel.org with ESMTP
	id S269311AbUIYLxZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Sep 2004 07:53:25 -0400
From: Borislav Petkov <petkov@uni-muenster.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: OOM-killer killed everything
Date: Sat, 25 Sep 2004 13:26:13 +0200
User-Agent: KMail/1.7
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_VXVVBq8Ey+Tkhlh"
Message-Id: <200409251326.13915.petkov@uni-muenster.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_VXVVBq8Ey+Tkhlh
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi there,

I just started burning an audio cd with cdrecord, ran it as root because of 
the SUID changes in 2.6.8 when this big bad guy by the name of OOM-killer 
appeared and started killing everything :) I don't know whether the spurious 
interrupt issue has something to do with it but according to what I've read 
on lkml about it until now, it is supposed to be quite harmless. Sysinfo 
+ .config attached.

Regards,
Boris.



Sep 25 12:56:31 gollum kernel: spurious 8259A interrupt: IRQ7.  <----
Sep 25 13:06:46 gollum kernel: oom-killer: gfp_mask=0xd2
Sep 25 13:06:49 gollum kernel: DMA per-cpu:
Sep 25 13:06:50 gollum kernel: cpu 0 hot: low 2, high 6, batch 1
Sep 25 13:06:50 gollum kernel: cpu 0 cold: low 0, high 2, batch 1
Sep 25 13:06:50 gollum kernel: Normal per-cpu:
Sep 25 13:06:50 gollum kernel: cpu 0 hot: low 32, high 96, batch 16
Sep 25 13:06:50 gollum kernel: cpu 0 cold: low 0, high 32, batch 16
Sep 25 13:06:50 gollum kernel: HighMem per-cpu: empty
Sep 25 13:06:50 gollum kernel: 
Sep 25 13:06:50 gollum kernel: Free pages:        3168kB (0kB HighMem)
Sep 25 13:06:50 gollum kernel: Active:659 inactive:558 dirty:0 writeback:1 
unstable:0 free:792 slab:2429 mapped:1020 pagetables:390
Sep 25 13:06:50 gollum kernel: DMA free:1488kB min:20kB low:40kB high:60kB 
active:0kB inactive:4kB present:16384kB
Sep 25 13:06:50 gollum kernel: protections[]: 10 358 358
Sep 25 13:06:58 gollum kernel: Normal free:1680kB min:696kB low:1392kB 
high:2088kB active:2636kB inactive:2228kB present:507136kB
Sep 25 13:07:01 gollum kernel: protections[]: 0 348 348
Sep 25 13:07:01 gollum kernel: HighMem free:0kB min:128kB low:256kB high:384kB 
active:0kB inactive:0kB present:0kB
Sep 25 13:07:01 gollum kernel: protections[]: 0 0 0
Sep 25 13:07:01 gollum kernel: DMA: 14*4kB 3*8kB 0*16kB 0*32kB 0*64kB 1*128kB 
1*256kB 0*512kB 1*1024kB 0*2048kB 0*4096kB = 1488kB
Sep 25 13:07:01 gollum kernel: Normal: 70*4kB 11*8kB 22*16kB 4*32kB 3*64kB 
1*128kB 0*256kB 1*512kB 0*1024kB 0*2048kB 0*4096kB = 1680kB
Sep 25 13:07:01 gollum kernel: HighMem: empty
Sep 25 13:07:01 gollum kernel: Swap cache: add 49393, delete 49182, find 
1609/3363, race 0+0
Sep 25 13:07:01 gollum kernel: Out of Memory: Killed process 2731 
(mozilla-bin).
Sep 25 13:07:01 gollum kernel: iller: gfp_mask=0xd2
Sep 25 13:07:02 gollum kernel: DMA per-cpu:
Sep 25 13:07:02 gollum kernel: cpu 0 hot: low 2, high 6, batch 1
Sep 25 13:07:02 gollum kernel: cpu 0 cold: low 0, high 2, batch 1
Sep 25 13:07:02 gollum kernel: Normal per-cpu:
Sep 25 13:07:02 gollum kernel: cpu 0 hot: low 32, high 96, batch 16
Sep 25 13:07:02 gollum kernel: cpu 0 cold: low 0, high 32, batch 16
Sep 25 13:07:02 gollum kernel: HighMem per-cpu: empty
Sep 25 13:07:02 gollum kernel: 
Sep 25 13:07:02 gollum kernel: Free pages:        2140kB (0kB HighMem)
Sep 25 13:07:02 gollum kernel: Active:513 inactive:619 dirty:0 writeback:14 
unstable:0 free:535 slab:2261 mapped:1028 pagetables:300
Sep 25 13:07:02 gollum kernel: DMA free:1420kB min:20kB low:40kB high:60kB 
active:0kB inactive:0kB present:16384kB
Sep 25 13:07:02 gollum kernel: protections[]: 10 358 358
Sep 25 13:07:02 gollum kernel: Normal free:720kB min:696kB low:1392kB 
high:2088kB active:2052kB inactive:2476kB present:507136kB
Sep 25 13:07:02 gollum kernel: protections[]: 0 348 348
Sep 25 13:07:02 gollum kernel: HighMem free:0kB min:128kB low:256kB high:384kB 
active:0kB inactive:0kB present:0kB
Sep 25 13:07:02 gollum kernel: protections[]: 0 0 0
Sep 25 13:07:02 gollum kernel: DMA: 3*4kB 0*8kB 0*16kB 0*32kB 0*64kB 1*128kB 
1*256kB 0*512kB 1*1024kB 0*2048kB 0*4096kB = 1420kB
Sep 25 13:07:02 gollum kernel: Normal: 20*4kB 16*8kB 4*16kB 0*32kB 1*64kB 
1*128kB 1*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 720kB
Sep 25 13:07:02 gollum kernel: HighMem: empty
Sep 25 13:07:02 gollum kernel: Swap cache: add 91463, delete 91341, find 
2956/11878, race 3+0
Sep 25 13:07:02 gollum kernel: Out of Memory: Killed process 2740 
(gnome-terminal).
Sep 25 13:07:02 gollum kernel: oom-killer: gfp_mask=0xd2
Sep 25 13:07:02 gollum kernel: DMA per-cpu:
Sep 25 13:07:02 gollum kernel: cpu 0 hot: low 2, high 6, batch 1
Sep 25 13:07:02 gollum kernel: cpu 0 cold: low 0, high 2, batch 1
Sep 25 13:07:02 gollum kernel: Normal per-cpu:
Sep 25 13:07:02 gollum kernel: cpu 0 hot: low 32, high 96, batch 16
Sep 25 13:07:02 gollum kernel: cpu 0 cold: low 0, high 32, batch 16
Sep 25 13:07:02 gollum kernel: HighMem per-cpu: empty
Sep 25 13:07:02 gollum kernel: 
Sep 25 13:07:02 gollum kernel: Free pages:        2268kB (0kB HighMem)
Sep 25 13:07:02 gollum kernel: Active:774 inactive:330 dirty:0 writeback:14 
unstable:0 free:567 slab:2255 mapped:1033 pagetables:292
Sep 25 13:07:02 gollum kernel: DMA free:1420kB min:20kB low:40kB high:60kB 
active:0kB inactive:0kB present:16384kB
Sep 25 13:07:02 gollum kernel: protections[]: 10 358 358
Sep 25 13:07:02 gollum kernel: Normal free:848kB min:696kB low:1392kB 
high:2088kB active:3096kB inactive:1320kB present:507136kB
Sep 25 13:07:02 gollum kernel: protections[]: 0 348 348
Sep 25 13:07:02 gollum kernel: HighMem free:0kB min:128kB low:256kB high:384kB 
active:0kB inactive:0kB present:0kB
Sep 25 13:07:02 gollum kernel: protections[]: 0 0 0
Sep 25 13:07:02 gollum kernel: DMA: 3*4kB 0*8kB 0*16kB 0*32kB 0*64kB 1*128kB 
1*256kB 0*512kB 1*1024kB 0*2048kB 0*4096kB = 1420kB
Sep 25 13:07:02 gollum kernel: Normal: 38*4kB 7*8kB 2*16kB 1*32kB 1*64kB 
0*128kB 0*256kB 1*512kB 0*1024kB 0*2048kB 0*4096kB = 848kB
Sep 25 13:07:02 gollum kernel: HighMem: empty
Sep 25 13:07:02 gollum kernel: Swap cache: add 94006, delete 93865, find 
3056/12485, race 3+0
Sep 25 13:07:02 gollum kernel: Out of Memory: Killed process 2553 (kdeinit).
Sep 25 13:07:02 gollum kernel: oom-killer: gfp_mask=0xd0
Sep 25 13:07:02 gollum kernel: DMA per-cpu:
Sep 25 13:07:02 gollum kernel: cpu 0 hot: low 2, high 6, batch 1
Sep 25 13:07:02 gollum kernel: cpu 0 cold: low 0, high 2, batch 1
Sep 25 13:07:02 gollum kernel: Normal per-cpu:
Sep 25 13:07:02 gollum kernel: cpu 0 hot: low 32, high 96, batch 16
Sep 25 13:07:02 gollum kernel: cpu 0 cold: low 0, high 32, batch 16
Sep 25 13:07:02 gollum kernel: HighMem per-cpu: empty
Sep 25 13:07:02 gollum kernel: 
Sep 25 13:07:02 gollum kernel: Free pages:        2268kB (0kB HighMem)
Sep 25 13:07:02 gollum kernel: Active:640 inactive:469 dirty:0 writeback:8 
unstable:0 free:567 slab:2256 mapped:1029 pagetables:292
Sep 25 13:07:02 gollum kernel: DMA free:1420kB min:20kB low:40kB high:60kB 
active:0kB inactive:0kB present:16384kB
Sep 25 13:07:02 gollum kernel: protections[]: 10 358 358
Sep 25 13:07:02 gollum kernel: Normal free:848kB min:696kB low:1392kB 
high:2088kB active:2560kB inactive:1876kB present:507136kB
Sep 25 13:07:02 gollum kernel: protections[]: 0 348 348
Sep 25 13:07:02 gollum kernel: HighMem free:0kB min:128kB low:256kB high:384kB 
active:0kB inactive:0kB present:0kB
Sep 25 13:07:02 gollum kernel: protections[]: 0 0 0
Sep 25 13:07:02 gollum kernel: DMA: 3*4kB 0*8kB 0*16kB 0*32kB 0*64kB 1*128kB 
1*256kB 0*512kB 1*1024kB 0*2048kB 0*4096kB = 1420kB
Sep 25 13:07:02 gollum kernel: Normal: 38*4kB 15*8kB 8*16kB 2*32kB 0*64kB 
1*128kB 1*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 848kB
Sep 25 13:07:02 gollum kernel: HighMem: empty
Sep 25 13:07:02 gollum kernel: Swap cache: add 96420, delete 96289, find 
3151/13069, race 3+0
Sep 25 13:07:02 gollum kernel: Out of Memory: Killed process 2718 (xmms).
Sep 25 13:07:02 gollum kernel: oom-killer: gfp_mask=0x1d2
Sep 25 13:07:02 gollum kernel: DMA per-cpu:
Sep 25 13:07:02 gollum kernel: cpu 0 hot: low 2, high 6, batch 1
Sep 25 13:07:02 gollum kernel: cpu 0 cold: low 0, high 2, batch 1
Sep 25 13:07:02 gollum kernel: Normal per-cpu:
Sep 25 13:07:02 gollum kernel: cpu 0 hot: low 32, high 96, batch 16
Sep 25 13:07:02 gollum kernel: cpu 0 cold: low 0, high 32, batch 16
Sep 25 13:07:02 gollum kernel: HighMem per-cpu: empty
Sep 25 13:07:02 gollum kernel: 
Sep 25 13:07:02 gollum kernel: Free pages:        2268kB (0kB HighMem)
Sep 25 13:07:02 gollum kernel: Active:699 inactive:409 dirty:0 writeback:13 
unstable:0 free:567 slab:2256 mapped:1032 pagetables:292
Sep 25 13:07:02 gollum kernel: DMA free:1420kB min:20kB low:40kB high:60kB 
active:0kB inactive:0kB present:16384kB
Sep 25 13:07:02 gollum kernel: protections[]: 10 358 358
Sep 25 13:07:02 gollum kernel: Normal free:848kB min:696kB low:1392kB 
high:2088kB active:2796kB inactive:1636kB present:507136kB
Sep 25 13:07:02 gollum kernel: protections[]: 0 348 348
Sep 25 13:07:02 gollum kernel: HighMem free:0kB min:128kB low:256kB high:384kB 
active:0kB inactive:0kB present:0kB
Sep 25 13:07:02 gollum kernel: protections[]: 0 0 0
Sep 25 13:07:02 gollum kernel: DMA: 3*4kB 0*8kB 0*16kB 0*32kB 0*64kB 1*128kB 
1*256kB 0*512kB 1*1024kB 0*2048kB 0*4096kB = 1420kB
Sep 25 13:07:02 gollum kernel: Normal: 58*4kB 13*8kB 2*16kB 1*32kB 1*64kB 
1*128kB 1*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 848kB
Sep 25 13:07:02 gollum kernel: HighMem: empty
Sep 25 13:07:02 gollum kernel: Swap cache: add 99237, delete 99105, find 
3262/13700, race 4+0
Sep 25 13:07:02 gollum kernel: Out of Memory: Killed process 2719 (xmms).
Sep 25 13:07:02 gollum kernel: oom-killer: gfp_mask=0xd2
Sep 25 13:07:02 gollum kernel: DMA per-cpu:
Sep 25 13:07:02 gollum kernel: cpu 0 hot: low 2, high 6, batch 1
Sep 25 13:07:02 gollum kernel: cpu 0 cold: low 0, high 2, batch 1
Sep 25 13:07:02 gollum kernel: Normal per-cpu:
Sep 25 13:07:02 gollum kernel: cpu 0 hot: low 32, high 96, batch 16
Sep 25 13:07:02 gollum kernel: cpu 0 cold: low 0, high 32, batch 16
Sep 25 13:07:02 gollum kernel: HighMem per-cpu: empty
Sep 25 13:07:02 gollum kernel: 
Sep 25 13:07:02 gollum kernel: Free pages:        2460kB (0kB HighMem)
Sep 25 13:07:02 gollum kernel: Active:879 inactive:176 dirty:0 writeback:1 
unstable:0 free:615 slab:2255 mapped:1019 pagetables:292
Sep 25 13:07:02 gollum kernel: DMA free:1420kB min:20kB low:40kB high:60kB 
active:0kB inactive:0kB present:16384kB
Sep 25 13:07:02 gollum kernel: protections[]: 10 358 358
Sep 25 13:07:02 gollum kernel: Normal free:1040kB min:696kB low:1392kB 
high:2088kB active:3516kB inactive:704kB present:507136kB
Sep 25 13:07:02 gollum kernel: protections[]: 0 348 348
Sep 25 13:07:02 gollum kernel: HighMem free:0kB min:128kB low:256kB high:384kB 
active:0kB inactive:0kB present:0kB
Sep 25 13:07:02 gollum kernel: protections[]: 0 0 0
Sep 25 13:07:02 gollum kernel: DMA: 3*4kB 0*8kB 0*16kB 0*32kB 0*64kB 1*128kB 
1*256kB 0*512kB 1*1024kB 0*2048kB 0*4096kB = 1420kB
Sep 25 13:07:02 gollum kernel: Normal: 66*4kB 13*8kB 4*16kB 1*32kB 1*64kB 
0*128kB 0*256kB 1*512kB 0*1024kB 0*2048kB 0*4096kB = 1040kB
Sep 25 13:07:02 gollum kernel: HighMem: empty
Sep 25 13:07:02 gollum kernel: Swap cache: add 101519, delete 101408, find 
3345/14242, race 4+0
Sep 25 13:07:02 gollum kernel: Out of Memory: Killed process 2737 (xmms).
Sep 25 13:07:02 gollum kernel: oom-killer: gfp_mask=0xd2
Sep 25 13:07:02 gollum kernel: DMA per-cpu:
Sep 25 13:07:02 gollum kernel: cpu 0 hot: low 2, high 6, batch 1
Sep 25 13:07:02 gollum kernel: cpu 0 cold: low 0, high 2, batch 1
Sep 25 13:07:02 gollum kernel: Normal per-cpu:
Sep 25 13:07:02 gollum kernel: cpu 0 hot: low 32, high 96, batch 16
Sep 25 13:07:02 gollum kernel: cpu 0 cold: low 0, high 32, batch 16
Sep 25 13:07:02 gollum kernel: HighMem per-cpu: empty
Sep 25 13:07:02 gollum kernel: 
Sep 25 13:07:02 gollum kernel: Free pages:        2396kB (0kB HighMem)
Sep 25 13:07:02 gollum kernel: Active:676 inactive:429 dirty:0 writeback:10 
unstable:0 free:599 slab:2247 mapped:1029 pagetables:286
Sep 25 13:07:02 gollum kernel: DMA free:1420kB min:20kB low:40kB high:60kB 
active:0kB inactive:0kB present:16384kB
Sep 25 13:07:02 gollum kernel: protections[]: 10 358 358
Sep 25 13:07:02 gollum kernel: Normal free:976kB min:696kB low:1392kB 
high:2088kB active:2704kB inactive:1716kB present:507136kB
Sep 25 13:07:02 gollum kernel: protections[]: 0 348 348
Sep 25 13:07:02 gollum kernel: HighMem free:0kB min:128kB low:256kB high:384kB 
active:0kB inactive:0kB present:0kB
Sep 25 13:07:02 gollum kernel: protections[]: 0 0 0
Sep 25 13:07:02 gollum kernel: DMA: 3*4kB 0*8kB 0*16kB 0*32kB 0*64kB 1*128kB 
1*256kB 0*512kB 1*1024kB 0*2048kB 0*4096kB = 1420kB
Sep 25 13:07:02 gollum kernel: Normal: 46*4kB 15*8kB 4*16kB 1*32kB 1*64kB 
0*128kB 0*256kB 1*512kB 0*1024kB 0*2048kB 0*4096kB = 976kB
Sep 25 13:07:02 gollum kernel: HighMem: empty
Sep 25 13:07:02 gollum kernel: Swap cache: add 104201, delete 104073, find 
3458/14859, race 5+0
Sep 25 13:07:02 gollum kernel: Out of Memory: Killed process 2717 (kdeinit).
Sep 25 13:07:02 gollum kernel: oom-killer: gfp_mask=0x1d2
Sep 25 13:07:02 gollum kernel: DMA per-cpu:
Sep 25 13:07:02 gollum kernel: cpu 0 hot: low 2, high 6, batch 1
Sep 25 13:07:02 gollum kernel: cpu 0 cold: low 0, high 2, batch 1
Sep 25 13:07:02 gollum kernel: Normal per-cpu:
Sep 25 13:07:02 gollum kernel: cpu 0 hot: low 32, high 96, batch 16
Sep 25 13:07:02 gollum kernel: cpu 0 cold: low 0, high 32, batch 16
Sep 25 13:07:02 gollum kernel: HighMem per-cpu: empty
Sep 25 13:07:02 gollum kernel: 
Sep 25 13:07:02 gollum kernel: Free pages:        2152kB (0kB HighMem)
Sep 25 13:07:02 gollum kernel: Active:651 inactive:472 dirty:0 writeback:9 
unstable:0 free:538 slab:2238 mapped:1027 pagetables:278
Sep 25 13:07:02 gollum kernel: DMA free:1432kB min:20kB low:40kB high:60kB 
active:8kB inactive:0kB present:16384kB
Sep 25 13:07:02 gollum kernel: protections[]: 10 358 358
Sep 25 13:07:02 gollum kernel: Normal free:720kB min:696kB low:1392kB 
high:2088kB active:2596kB inactive:1888kB present:507136kB
Sep 25 13:07:02 gollum kernel: protections[]: 0 348 348
Sep 25 13:07:02 gollum kernel: HighMem free:0kB min:128kB low:256kB high:384kB 
active:0kB inactive:0kB present:0kB
Sep 25 13:07:02 gollum kernel: protections[]: 0 0 0
Sep 25 13:07:02 gollum kernel: DMA: 6*4kB 0*8kB 0*16kB 0*32kB 0*64kB 1*128kB 
1*256kB 0*512kB 1*1024kB 0*2048kB 0*4096kB = 1432kB
Sep 25 13:07:02 gollum kernel: Normal: 18*4kB 1*8kB 2*16kB 1*32kB 1*64kB 
0*128kB 0*256kB 1*512kB 0*1024kB 0*2048kB 0*4096kB = 720kB
Sep 25 13:07:02 gollum kernel: HighMem: empty
Sep 25 13:07:02 gollum kernel: Swap cache: add 107032, delete 106919, find 
3554/15477, race 5+0
Sep 25 13:07:02 gollum kernel: Out of Memory: Killed process 2995 (kdeinit).
Sep 25 13:07:02 gollum kernel: oom-killer: gfp_mask=0xd2
Sep 25 13:07:02 gollum kernel: DMA per-cpu:
Sep 25 13:07:02 gollum kernel: cpu 0 hot: low 2, high 6, batch 1
Sep 25 13:07:02 gollum kernel: cpu 0 cold: low 0, high 2, batch 1
Sep 25 13:07:02 gollum kernel: Normal per-cpu:
Sep 25 13:07:02 gollum kernel: cpu 0 hot: low 32, high 96, batch 16
Sep 25 13:07:02 gollum kernel: cpu 0 cold: low 0, high 32, batch 16
Sep 25 13:07:02 gollum kernel: HighMem per-cpu: empty
Sep 25 13:07:02 gollum kernel: 
Sep 25 13:07:02 gollum kernel: Free pages:        2452kB (0kB HighMem)
Sep 25 13:07:02 gollum kernel: Active:931 inactive:144 dirty:0 writeback:6 
unstable:0 free:613 slab:2229 mapped:1024 pagetables:270
Sep 25 13:07:02 gollum kernel: DMA free:1412kB min:20kB low:40kB high:60kB 
active:4kB inactive:0kB present:16384kB
Sep 25 13:07:02 gollum kernel: protections[]: 10 358 358
Sep 25 13:07:02 gollum kernel: Normal free:1040kB min:696kB low:1392kB 
high:2088kB active:3720kB inactive:576kB present:507136kB
Sep 25 13:07:02 gollum kernel: protections[]: 0 348 348
Sep 25 13:07:02 gollum kernel: HighMem free:0kB min:128kB low:256kB high:384kB 
active:0kB inactive:0kB present:0kB
Sep 25 13:07:02 gollum kernel: protections[]: 0 0 0
Sep 25 13:07:02 gollum kernel: DMA: 1*4kB 0*8kB 0*16kB 0*32kB 0*64kB 1*128kB 
1*256kB 0*512kB 1*1024kB 0*2048kB 0*4096kB = 1412kB
Sep 25 13:07:02 gollum kernel: Normal: 56*4kB 18*8kB 4*16kB 1*32kB 1*64kB 
0*128kB 0*256kB 1*512kB 0*1024kB 0*2048kB 0*4096kB = 1040kB
Sep 25 13:07:02 gollum kernel: HighMem: empty
Sep 25 13:07:02 gollum kernel: Swap cache: add 110062, delete 109933, find 
3642/16083, race 5+0
Sep 25 13:07:02 gollum kernel: Out of Memory: Killed process 2558 (kdeinit).
Sep 25 13:07:02 gollum kernel: oom-killer: gfp_mask=0x1d2
Sep 25 13:07:02 gollum kernel: DMA per-cpu:
Sep 25 13:07:02 gollum kernel: cpu 0 hot: low 2, high 6, batch 1
Sep 25 13:07:02 gollum kernel: cpu 0 cold: low 0, high 2, batch 1
Sep 25 13:07:02 gollum kernel: Normal per-cpu:
Sep 25 13:07:02 gollum kernel: cpu 0 hot: low 32, high 96, batch 16
Sep 25 13:07:02 gollum kernel: cpu 0 cold: low 0, high 32, batch 16
Sep 25 13:07:02 gollum kernel: HighMem per-cpu: empty
Sep 25 13:07:02 gollum kernel: 
Sep 25 13:07:02 gollum kernel: Free pages:        2320kB (0kB HighMem)
Sep 25 13:07:02 gollum kernel: Active:673 inactive:467 dirty:0 writeback:6 
unstable:0 free:580 slab:2227 mapped:1025 pagetables:262
Sep 25 13:07:02 gollum kernel: DMA free:1408kB min:20kB low:40kB high:60kB 
active:4kB inactive:0kB present:16384kB
Sep 25 13:07:02 gollum kernel: protections[]: 10 358 358
Sep 25 13:07:02 gollum kernel: Normal free:912kB min:696kB low:1392kB 
high:2088kB active:2688kB inactive:1868kB present:507136kB
Sep 25 13:07:02 gollum kernel: protections[]: 0 348 348
Sep 25 13:07:02 gollum kernel: HighMem free:0kB min:128kB low:256kB high:384kB 
active:0kB inactive:0kB present:0kB
Sep 25 13:07:02 gollum kernel: protections[]: 0 0 0
Sep 25 13:07:02 gollum kernel: DMA: 0*4kB 0*8kB 0*16kB 0*32kB 0*64kB 1*128kB 
1*256kB 0*512kB 1*1024kB 0*2048kB 0*4096kB = 1408kB
Sep 25 13:07:02 gollum kernel: Normal: 18*4kB 15*8kB 7*16kB 1*32kB 1*64kB 
0*128kB 0*256kB 1*512kB 0*1024kB 0*2048kB 0*4096kB = 912kB
Sep 25 13:07:02 gollum kernel: HighMem: empty
Sep 25 13:07:02 gollum kernel: Swap cache: add 112794, delete 112687, find 
3744/16718, race 5+0
Sep 25 13:07:02 gollum kernel: Out of Memory: Killed process 2968 (kdeinit).
Sep 25 13:07:02 gollum kernel: oom-killer: gfp_mask=0xd2
Sep 25 13:07:02 gollum kernel: DMA per-cpu:
Sep 25 13:07:02 gollum kernel: cpu 0 hot: low 2, high 6, batch 1
Sep 25 13:07:02 gollum kernel: cpu 0 cold: low 0, high 2, batch 1
Sep 25 13:07:02 gollum kernel: Normal per-cpu:
Sep 25 13:07:02 gollum kernel: cpu 0 hot: low 32, high 96, batch 16
Sep 25 13:07:02 gollum kernel: cpu 0 cold: low 0, high 32, batch 16
Sep 25 13:07:02 gollum kernel: HighMem per-cpu: empty
Sep 25 13:07:02 gollum kernel: 
Sep 25 13:07:02 gollum kernel: Free pages:        2572kB (0kB HighMem)
Sep 25 13:07:02 gollum kernel: Active:896 inactive:183 dirty:0 writeback:7 
unstable:0 free:643 slab:2227 mapped:1023 pagetables:262
Sep 25 13:07:02 gollum kernel: DMA free:1404kB min:20kB low:40kB high:60kB 
active:4kB inactive:0kB present:16384kB
Sep 25 13:07:02 gollum kernel: protections[]: 10 358 358
Sep 25 13:07:02 gollum kernel: Normal free:1168kB min:696kB low:1392kB 
high:2088kB active:3580kB inactive:732kB present:507136kB
Sep 25 13:07:02 gollum kernel: protections[]: 0 348 348
Sep 25 13:07:02 gollum kernel: HighMem free:0kB min:128kB low:256kB high:384kB 
active:0kB inactive:0kB present:0kB
Sep 25 13:07:02 gollum kernel: protections[]: 0 0 0
Sep 25 13:07:02 gollum kernel: DMA: 1*4kB 1*8kB 1*16kB 1*32kB 1*64kB 0*128kB 
1*256kB 0*512kB 1*1024kB 0*2048kB 0*4096kB = 1404kB
Sep 25 13:07:02 gollum kernel: Normal: 96*4kB 6*8kB 8*16kB 1*32kB 1*64kB 
0*128kB 0*256kB 1*512kB 0*1024kB 0*2048kB 0*4096kB = 1168kB
Sep 25 13:07:02 gollum kernel: HighMem: empty
Sep 25 13:07:02 gollum kernel: Swap cache: add 115393, delete 115260, find 
3836/17305, race 5+0
Sep 25 13:07:02 gollum kernel: Out of Memory: Killed process 2505 (kdeinit).
Sep 25 13:07:02 gollum kernel: oom-killer: gfp_mask=0xd2
Sep 25 13:07:02 gollum kernel: DMA per-cpu:
Sep 25 13:07:02 gollum kernel: cpu 0 hot: low 2, high 6, batch 1
Sep 25 13:07:02 gollum kernel: cpu 0 cold: low 0, high 2, batch 1
Sep 25 13:07:02 gollum kernel: Normal per-cpu:
Sep 25 13:07:02 gollum kernel: cpu 0 hot: low 32, high 96, batch 16
Sep 25 13:07:02 gollum kernel: cpu 0 cold: low 0, high 32, batch 16
Sep 25 13:07:02 gollum kernel: HighMem per-cpu: empty
Sep 25 13:07:02 gollum kernel: 
Sep 25 13:07:02 gollum kernel: Free pages:        2380kB (0kB HighMem)
Sep 25 13:07:02 gollum kernel: Active:650 inactive:494 dirty:0 writeback:21 
unstable:0 free:595 slab:2226 mapped:1031 pagetables:254
Sep 25 13:07:02 gollum kernel: DMA free:1404kB min:20kB low:40kB high:60kB 
active:0kB inactive:4kB present:16384kB
Sep 25 13:07:02 gollum kernel: protections[]: 10 358 358
Sep 25 13:07:02 gollum kernel: Normal free:976kB min:696kB low:1392kB 
high:2088kB active:2600kB inactive:1972kB present:507136kB
Sep 25 13:07:02 gollum kernel: protections[]: 0 348 348
Sep 25 13:07:02 gollum kernel: HighMem free:0kB min:128kB low:256kB high:384kB 
active:0kB inactive:0kB present:0kB
Sep 25 13:07:02 gollum kernel: protections[]: 0 0 0
Sep 25 13:07:02 gollum kernel: DMA: 1*4kB 1*8kB 1*16kB 1*32kB 1*64kB 0*128kB 
1*256kB 0*512kB 1*1024kB 0*2048kB 0*4096kB = 1404kB
Sep 25 13:07:02 gollum kernel: Normal: 56*4kB 18*8kB 2*16kB 0*32kB 1*64kB 
0*128kB 0*256kB 1*512kB 0*1024kB 0*2048kB 0*4096kB = 976kB
Sep 25 13:07:02 gollum kernel: HighMem: empty
Sep 25 13:07:02 gollum kernel: Swap cache: add 118164, delete 118023, find 
3931/17938, race 5+0
Sep 25 13:07:02 gollum kernel: Out of Memory: Killed process 2551 (kdeinit).
Sep 25 13:07:02 gollum kernel: oom-killer: gfp_mask=0xd2
Sep 25 13:07:02 gollum kernel: DMA per-cpu:
Sep 25 13:07:02 gollum kernel: cpu 0 hot: low 2, high 6, batch 1
Sep 25 13:07:02 gollum kernel: cpu 0 cold: low 0, high 2, batch 1
Sep 25 13:07:02 gollum kernel: Normal per-cpu:
Sep 25 13:07:02 gollum kernel: cpu 0 hot: low 32, high 96, batch 16
Sep 25 13:07:02 gollum kernel: cpu 0 cold: low 0, high 32, batch 16
Sep 25 13:07:02 gollum kernel: HighMem per-cpu: empty
Sep 25 13:07:02 gollum kernel: 
Sep 25 13:07:02 gollum kernel: Free pages:        2176kB (0kB HighMem)
Sep 25 13:07:02 gollum kernel: Active:677 inactive:522 dirty:0 writeback:9 
unstable:0 free:544 slab:2227 mapped:1039 pagetables:246
Sep 25 13:07:02 gollum kernel: DMA free:1392kB min:20kB low:40kB high:60kB 
active:0kB inactive:4kB present:16384kB
Sep 25 13:07:02 gollum kernel: protections[]: 10 358 358
Sep 25 13:07:02 gollum kernel: Normal free:784kB min:696kB low:1392kB 
high:2088kB active:2708kB inactive:2084kB present:507136kB
Sep 25 13:07:02 gollum kernel: protections[]: 0 348 348
Sep 25 13:07:02 gollum kernel: HighMem free:0kB min:128kB low:256kB high:384kB 
active:0kB inactive:0kB present:0kB
Sep 25 13:07:02 gollum kernel: protections[]: 0 0 0
Sep 25 13:07:02 gollum kernel: DMA: 0*4kB 0*8kB 1*16kB 1*32kB 1*64kB 0*128kB 
1*256kB 0*512kB 1*1024kB 0*2048kB 0*4096kB = 1392kB
Sep 25 13:07:02 gollum kernel: Normal: 0*4kB 4*8kB 9*16kB 1*32kB 1*64kB 
0*128kB 0*256kB 1*512kB 0*1024kB 0*2048kB 0*4096kB = 784kB
Sep 25 13:07:02 gollum kernel: HighMem: empty
Sep 25 13:07:02 gollum kernel: Swap cache: add 120986, delete 120852, find 
4043/18638, race 5+0
Sep 25 13:07:02 gollum kernel: Out of Memory: Killed process 2548 (kdeinit).
Sep 25 13:07:02 gollum kernel: oom-killer: gfp_mask=0x1d2
Sep 25 13:07:02 gollum kernel: DMA per-cpu:
Sep 25 13:07:02 gollum kernel: cpu 0 hot: low 2, high 6, batch 1
Sep 25 13:07:02 gollum kernel: cpu 0 cold: low 0, high 2, batch 1
Sep 25 13:07:02 gollum kernel: Normal per-cpu:
Sep 25 13:07:02 gollum kernel: cpu 0 hot: low 32, high 96, batch 16
Sep 25 13:07:02 gollum kernel: cpu 0 cold: low 0, high 32, batch 16
Sep 25 13:07:02 gollum kernel: HighMem per-cpu: empty
Sep 25 13:07:02 gollum kernel: 
Sep 25 13:07:02 gollum kernel: Free pages:        2616kB (0kB HighMem)
Sep 25 13:07:02 gollum kernel: Active:653 inactive:408 dirty:0 writeback:6 
unstable:0 free:654 slab:2229 mapped:1023 pagetables:246
Sep 25 13:07:02 gollum kernel: DMA free:1384kB min:20kB low:40kB high:60kB 
active:0kB inactive:4kB present:16384kB
Sep 25 13:07:02 gollum kernel: protections[]: 10 358 358
Sep 25 13:07:02 gollum kernel: Normal free:1232kB min:696kB low:1392kB 
high:2088kB active:2612kB inactive:1628kB present:507136kB
Sep 25 13:07:02 gollum kernel: protections[]: 0 348 348
Sep 25 13:07:02 gollum kernel: HighMem free:0kB min:128kB low:256kB high:384kB 
active:0kB inactive:0kB present:0kB
Sep 25 13:07:02 gollum kernel: protections[]: 0 0 0
Sep 25 13:07:02 gollum kernel: DMA: 0*4kB 1*8kB 0*16kB 1*32kB 1*64kB 0*128kB 
1*256kB 0*512kB 1*1024kB 0*2048kB 0*4096kB = 1384kB
Sep 25 13:07:02 gollum kernel: Normal: 86*4kB 23*8kB 6*16kB 1*32kB 1*64kB 
0*128kB 0*256kB 1*512kB 0*1024kB 0*2048kB 0*4096kB = 1232kB
Sep 25 13:07:02 gollum kernel: HighMem: empty
Sep 25 13:07:02 gollum kernel: Swap cache: add 123892, delete 123765, find 
4173/19386, race 5+0
Sep 25 13:07:02 gollum kernel: Out of Memory: Killed process 2500 (kdeinit).
Sep 25 13:07:02 gollum kernel: oom-killer: gfp_mask=0xd2
Sep 25 13:07:02 gollum kernel: DMA per-cpu:
Sep 25 13:07:02 gollum kernel: cpu 0 hot: low 2, high 6, batch 1
Sep 25 13:07:02 gollum kernel: cpu 0 cold: low 0, high 2, batch 1
Sep 25 13:07:02 gollum kernel: Normal per-cpu:
Sep 25 13:07:02 gollum kernel: cpu 0 hot: low 32, high 96, batch 16
Sep 25 13:07:02 gollum kernel: cpu 0 cold: low 0, high 32, batch 16
Sep 25 13:07:02 gollum kernel: HighMem per-cpu: empty
Sep 25 13:07:02 gollum kernel: 
Sep 25 13:07:02 gollum kernel: Free pages:        2224kB (0kB HighMem)
Sep 25 13:07:02 gollum kernel: Active:800 inactive:408 dirty:0 writeback:3 
unstable:0 free:556 slab:2230 mapped:1020 pagetables:238
Sep 25 13:07:02 gollum kernel: DMA free:1376kB min:20kB low:40kB high:60kB 
active:0kB inactive:4kB present:16384kB
Sep 25 13:07:02 gollum kernel: protections[]: 10 358 358
Sep 25 13:07:02 gollum kernel: Normal free:848kB min:696kB low:1392kB 
high:2088kB active:3200kB inactive:1628kB present:507136kB
Sep 25 13:07:02 gollum kernel: protections[]: 0 348 348
Sep 25 13:07:02 gollum kernel: HighMem free:0kB min:128kB low:256kB high:384kB 
active:0kB inactive:0kB present:0kB
Sep 25 13:07:02 gollum kernel: protections[]: 0 0 0
Sep 25 13:07:02 gollum kernel: DMA: 0*4kB 0*8kB 0*16kB 1*32kB 1*64kB 0*128kB 
1*256kB 0*512kB 1*1024kB 0*2048kB 0*4096kB = 1376kB
Sep 25 13:07:02 gollum kernel: Normal: 0*4kB 8*8kB 11*16kB 1*32kB 1*64kB 
0*128kB 0*256kB 1*512kB 0*1024kB 0*2048kB 0*4096kB = 848kB
Sep 25 13:07:02 gollum kernel: HighMem: empty
Sep 25 13:07:02 gollum kernel: Swap cache: add 126691, delete 126587, find 
4250/20058, race 6+0
Sep 25 13:07:02 gollum kernel: Out of Memory: Killed process 2503 (kdeinit).
Sep 25 13:07:14 gollum shutdown[3273]: shutting down for system reboot


--Boundary-00=_VXVVBq8Ey+Tkhlh
Content-Type: text/x-log;
  charset="us-ascii";
  name="sysinfo.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="sysinfo.log"


			System Configuration Summary
			----------------------------

Date:  Sat Sep 25 13:23:30 CEST 2004
User:  boris: 

Hostname: gollum
	Linux gollum 2.6.8.1-vp #3 Tue Sep 21 15:04:43 CEST 2004 i686 GNU/Linu
	x

Uptime:  13:23:30 up 12 min,  2 users,  load average: 0.08, 0.21, 0.17

sysinfo.sh version: 1.7, 2002/04/05 20:10:44

========================================================================

Basic Hardware:
------------------------------------

  cpu:
  --------------------
    
	processor	: 0
	vendor_id	: GenuineIntel
	cpu family	: 6
	model		: 9
	model name	: Intel(R) Pentium(R) M processor 1500MHz
	stepping	: 5
	cpu MHz		: 1500.123
	cache size	: 1024 KB
	fdiv_bug	: no
	hlt_bug		: no
	f00f_bug	: no
	coma_bug	: no
	fpu		: yes
	fpu_exception	: yes
	cpuid level	: 2
	wp		: yes
	flags		: fpu vme de pse tsc msr mce cx8 apic sep mtrr pge mca
	 cmov pat clflush dts acpi mmx fxsr sse sse2 tm pbe tm2 est
	bogomips	: 2973.69
	

  memory:
  --------------------
    
	MemTotal:       515008 kB
	MemFree:        151828 kB
	Buffers:         45516 kB
	Cached:         163356 kB
	SwapCached:          0 kB
	Active:         253612 kB
	Inactive:        87956 kB
	HighTotal:           0 kB
	HighFree:            0 kB
	LowTotal:       515008 kB
	LowFree:        151828 kB
	SwapTotal:      979956 kB
	SwapFree:       979956 kB
	Dirty:             228 kB
	Writeback:           0 kB
	Mapped:         205560 kB
	Slab:            15820 kB
	Committed_AS:   259168 kB
	PageTables:       1588 kB
	VmallocTotal:   516020 kB
	VmallocUsed:      2672 kB
	VmallocChunk:   512928 kB

  PCI:
  --------------------
    
	0000:00:00.0 Host bridge: Intel Corp. 82855PM Processor to I/O Control
	ler (rev 21)
	0000:00:01.0 PCI bridge: Intel Corp. 82855PM Processor to AGP Controll
	er (rev 21)
	0000:00:1d.0 USB Controller: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/
	ICH4-M) USB UHCI Controller #1 (rev 03)
	0000:00:1d.1 USB Controller: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/
	ICH4-M) USB UHCI Controller #2 (rev 03)
	0000:00:1d.2 USB Controller: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/
	ICH4-M) USB UHCI Controller #3 (rev 03)
	0000:00:1d.7 USB Controller: Intel Corp. 82801DB/DBM (ICH4/ICH4-M) USB
	 2.0 EHCI Controller (rev 03)
	0000:00:1e.0 PCI bridge: Intel Corp. 82801 PCI Bridge (rev 83)
	0000:00:1f.0 ISA bridge: Intel Corp. 82801DBM LPC Interface Controller
	 (rev 03)
	0000:00:1f.1 IDE interface: Intel Corp. 82801DBM (ICH4) Ultra ATA Stor
	age Controller (rev 03)
	0000:00:1f.5 Multimedia audio controller: Intel Corp. 82801DB/DBL/DBM 
	(ICH4/ICH4-L/ICH4-M) AC'97 Audio Controller (rev 03)
	0000:00:1f.6 Modem: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) A
	C'97 Modem Controller (rev 03)
	0000:01:00.0 VGA compatible controller: ATI Technologies Inc RV350 [Mo
	bility Radeon 9600 M10]
	0000:02:00.0 Ethernet controller: Broadcom Corporation NetXtreme BCM57
	88 Gigabit Ethernet (rev 03)
	0000:02:01.0 CardBus bridge: Ricoh Co Ltd RL5c476 II (rev ac)
	0000:02:01.1 CardBus bridge: Ricoh Co Ltd RL5c476 II (rev ac)
	0000:02:01.2 FireWire (IEEE 1394): Ricoh Co Ltd R5C552 IEEE 1394 Contr
	oller (rev 04)
	0000:02:02.0 Network controller: Intel Corp. PRO/Wireless 2200BG (rev 
	05)



Networking:
------------------------------------

  ifconfig:
  --------------------
    
    eth0      Link encap:Ethernet  HWaddr 00:11:2F:00:71:33  
              inet addr:192.168.45.67  Bcast:192.168.45.255  Mask:255.255.
    255.0
              inet6 addr: fe80::211:2fff:fe00:7133/64 Scope:Link
              UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
              RX packets:398 errors:0 dropped:0 overruns:0 frame:0
              TX packets:411 errors:0 dropped:0 overruns:0 carrier:0
              collisions:0 txqueuelen:1000 
              RX bytes:180795 (176.5 KiB)  TX bytes:50604 (49.4 KiB)
              Interrupt:11 Memory:ff9f0000-ffa00000 
    
    lo        Link encap:Local Loopback  
              inet addr:127.0.0.1  Mask:255.0.0.0
              inet6 addr: ::1/128 Scope:Host
              UP LOOPBACK RUNNING  MTU:16436  Metric:1
              RX packets:88 errors:0 dropped:0 overruns:0 frame:0
              TX packets:88 errors:0 dropped:0 overruns:0 carrier:0
              collisions:0 txqueuelen:0 
              RX bytes:6664 (6.5 KiB)  TX bytes:6664 (6.5 KiB)
    

  route:
  --------------------
    
    Kernel IP routing table
    Destination     Gateway         Genmask         Flags Metric Ref    Us
    e Iface
    192.168.45.0    0.0.0.0         255.255.255.0   U     0      0        
    0 eth0
    0.0.0.0         192.168.45.1    0.0.0.0         UG    0      0        
    0 eth0

Disk:
------------------------------------

  Partitioning:
  --------------------
    

  Mount table:
  --------------------
    
    # /etc/fstab: static file system information.
    #
    # <file system>	<mount point>	<type>	<options>		<dump>
    	<pass>
    /dev/hda1	/		ext3	defaults,errors=remount-ro
    	0	1
    /dev/hda2	none		swap	sw			0
    	0
    /dev/hda3	/home		ext3	defaults		0
    	0
    proc		/proc		proc	defaults		0
    	0
    #/dev/fd0	/floppy		auto	user,noauto		0
    	0
    /dev/hdc	/media/cdrom0	iso9660	ro,user,noauto,uid=65534,gid=6
    5534,mode=0644		0	0
    192.168.45.26:/opt/exports/	/mnt/storage2	nfs	user,rsize=327
    68,wsize=32768,timeo=28,intr
    192.168.45.3:/mnt/storage	/mnt/storage	nfs	user,rsize=327
    68,wsize=32768,timeo=28,intr
    

  Mounted partitions:
  --------------------
    
	rootfs / rootfs rw 0 0
	/dev/root / ext3 rw 0 0
	proc /proc proc rw,nodiratime 0 0
	sysfs /sys sysfs rw 0 0
	devpts /dev/pts devpts rw 0 0
	/dev/hda3 /home ext3 rw 0 0
	usbfs /proc/bus/usb usbfs rw 0 0
	192.168.45.26:/opt/exports/ /mnt/storage2 nfs rw,nosuid,nodev,noexec,v
	3,rsize=32768,wsize=32768,hard,intr,udp,lock,addr=192.168.45.26 0 0
	192.168.45.3:/mnt/storage /mnt/storage nfs rw,nosuid,nodev,noexec,v3,r
	size=8192,wsize=8192,hard,intr,udp,lock,addr=192.168.45.3 0 0


System resources:
------------------------------------

  IO:
  --------------------
    
	0000-001f : dma1
	0020-0021 : pic1
	0040-005f : timer
	0060-006f : keyboard
	0070-0077 : rtc
	0080-008f : dma page reg
	00a0-00a1 : pic2
	00c0-00df : dma2
	00f0-00ff : fpu
	0170-0177 : ide1
	01f0-01f7 : ide0
	02f8-02ff : serial
	0376-0376 : ide1
	03c0-03df : vga+
	03f6-03f6 : ide0
	0400-047f : 0000:00:1f.0
	0500-053f : 0000:00:1f.0
	0cf8-0cff : PCI conf1
	4000-40ff : PCI CardBus #03
	4400-44ff : PCI CardBus #03
	4800-48ff : PCI CardBus #07
	4c00-4cff : PCI CardBus #07
	d000-dfff : PCI Bus #01
	  d800-d8ff : 0000:01:00.0
	e000-e03f : 0000:00:1f.5
	e080-e0ff : 0000:00:1f.6
	e400-e4ff : 0000:00:1f.6
	e800-e81f : 0000:00:1d.0
	  e800-e81f : uhci_hcd
	e880-e89f : 0000:00:1d.1
	  e880-e89f : uhci_hcd
	ec00-ec1f : 0000:00:1d.2
	  ec00-ec1f : uhci_hcd
	ee00-eeff : 0000:00:1f.5
	ffa0-ffaf : 0000:00:1f.1
	  ffa0-ffa7 : ide0
	  ffa8-ffaf : ide1

  IRQs:
  --------------------
    
	           CPU0       
	  0:     724489          XT-PIC  timer
	  1:       3385          XT-PIC  i8042
	  2:          0          XT-PIC  cascade
	  4:          2          XT-PIC  ohci1394, uhci_hcd
	  5:      39879          XT-PIC  uhci_hcd
	  8:          4          XT-PIC  rtc
	  9:         50          XT-PIC  acpi
	 10:          2          XT-PIC  ehci_hcd
	 11:      24948          XT-PIC  yenta, yenta, uhci_hcd, Intel 82801DB
	-ICH4, eth0
	 12:       1196          XT-PIC  i8042
	 14:      10893          XT-PIC  ide0
	 15:         87          XT-PIC  ide1
	NMI:          0 
	LOC:     724461 
	ERR:          0
	MIS:          0

  Devices:
  --------------------
    
	Character devices:
	  1 mem
	  4 /dev/vc/0
	  4 tty
	  4 ttyS
	  5 /dev/tty
	  5 /dev/console
	  5 /dev/ptmx
	  7 vcs
	 10 misc
	 13 input
	 14 sound
	116 alsa
	128 ptm
	136 pts
	171 ieee1394
	180 usb
	254 pcmcia
	
	Block devices:
	  3 ide0
	 22 ide1

  filesystems:
  --------------------
    
	nodev	sysfs
	nodev	rootfs
	nodev	bdev
	nodev	proc
	nodev	sockfs
	nodev	futexfs
	nodev	tmpfs
	nodev	pipefs
	nodev	eventpollfs
	nodev	devpts
		ext3
	nodev	ramfs
	nodev	nfs
	nodev	nfs4
	nodev	nfsd
	nodev	mqueue
	nodev	rpc_pipefs
	nodev	usbfs
	nodev	usbdevfs

  USB devices:
  --------------------
    
	
	T:  Bus=04 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=12  MxCh= 2
	B:  Alloc=  0/900 us ( 0%), #Int=  0, #Iso=  0
	D:  Ver= 1.10 Cls=09(hub  ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
	P:  Vendor=0000 ProdID=0000 Rev= 2.06
	S:  Manufacturer=Linux 2.6.8.1-vp uhci_hcd
	S:  Product=Intel Corp. 82801DB (ICH4) USB UHCI #3
	S:  SerialNumber=0000:00:1d.2
	C:* #Ifs= 1 Cfg#= 1 Atr=c0 MxPwr=  0mA
	I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
	E:  Ad=81(I) Atr=03(Int.) MxPS=   2 Ivl=255ms
	
	T:  Bus=03 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=12  MxCh= 2
	B:  Alloc= 93/900 us (10%), #Int=  1, #Iso=  0
	D:  Ver= 1.10 Cls=09(hub  ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
	P:  Vendor=0000 ProdID=0000 Rev= 2.06
	S:  Manufacturer=Linux 2.6.8.1-vp uhci_hcd
	S:  Product=Intel Corp. 82801DB (ICH4) USB UHCI #2
	S:  SerialNumber=0000:00:1d.1
	C:* #Ifs= 1 Cfg#= 1 Atr=c0 MxPwr=  0mA
	I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
	E:  Ad=81(I) Atr=03(Int.) MxPS=   2 Ivl=255ms
	
	T:  Bus=03 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#=  2 Spd=1.5 MxCh= 0
	D:  Ver= 2.00 Cls=00(>ifc ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
	P:  Vendor=046d ProdID=c016 Rev= 3.40
	S:  Manufacturer=Logitech
	S:  Product=Optical USB Mouse
	C:* #Ifs= 1 Cfg#= 1 Atr=a0 MxPwr=100mA
	I:  If#= 0 Alt= 0 #EPs= 1 Cls=03(HID  ) Sub=01 Prot=02 Driver=usbhid
	E:  Ad=81(I) Atr=03(Int.) MxPS=   4 Ivl=10ms
	
	T:  Bus=02 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=12  MxCh= 2
	B:  Alloc=  0/900 us ( 0%), #Int=  0, #Iso=  0
	D:  Ver= 1.10 Cls=09(hub  ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
	P:  Vendor=0000 ProdID=0000 Rev= 2.06
	S:  Manufacturer=Linux 2.6.8.1-vp uhci_hcd
	S:  Product=Intel Corp. 82801DB (ICH4) USB UHCI #1
	S:  SerialNumber=0000:00:1d.0
	C:* #Ifs= 1 Cfg#= 1 Atr=c0 MxPwr=  0mA
	I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
	E:  Ad=81(I) Atr=03(Int.) MxPS=   2 Ivl=255ms
	
	T:  Bus=01 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=480 MxCh= 6
	B:  Alloc=  0/800 us ( 0%), #Int=  0, #Iso=  0
	D:  Ver= 2.00 Cls=09(hub  ) Sub=00 Prot=01 MxPS= 8 #Cfgs=  1
	P:  Vendor=0000 ProdID=0000 Rev= 2.06
	S:  Manufacturer=Linux 2.6.8.1-vp ehci_hcd
	S:  Product=Intel Corp. 82801DB (ICH4) USB2 EHCI Controller
	S:  SerialNumber=0000:00:1d.7
	C:* #Ifs= 1 Cfg#= 1 Atr=e0 MxPwr=  0mA
	I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
	E:  Ad=81(I) Atr=03(Int.) MxPS=   2 Ivl=256ms


Kernel resources:
------------------------------------

  Version: Linux version 2.6.8.1-vp (boris@gollum) (gcc version 3.3.4 (Debian 1:3.3.4-12)) #3 Tue Sep 21 15:04:43 CEST 2004

  Modules:
  --------------------
    
	snd_pcm_oss 54184 0 - Live 0xe0a75000
	snd_mixer_oss 20608 2 snd_pcm_oss, Live 0xe0a5d000
	ipv6 259716 10 - Live 0xe0ac4000
	ieee80211 18180 0 - Live 0xe09f0000
	ieee80211_crypt 5892 1 ieee80211, Live 0xe09d3000
	8250_pci 17920 0 - Live 0xe0a49000
	8250 21664 1 8250_pci, Live 0xe0a17000
	serial_core 24064 1 8250, Live 0xe0a01000
	snd_intel8x0 34952 1 - Live 0xe0a0d000
	snd_ac97_codec 68612 1 snd_intel8x0, Live 0xe0a37000
	snd_pcm 96648 2 snd_pcm_oss,snd_intel8x0, Live 0xe0a1e000
	snd_timer 25988 1 snd_pcm, Live 0xe09f9000
	snd_page_alloc 12040 2 snd_intel8x0,snd_pcm, Live 0xe09b9000
	snd_mpu401_uart 8064 1 snd_intel8x0, Live 0xe09ce000
	snd_rawmidi 25508 1 snd_mpu401_uart, Live 0xe09d7000
	snd_seq_device 8840 1 snd_rawmidi, Live 0xe09be000
	snd 56932 9 snd_pcm_oss,snd_mixer_oss,snd_intel8x0,snd_ac97_codec,snd_
	pcm,snd_timer,snd_mpu401_uart,snd_rawmidi,snd_seq_device, Live 0xe09e1
	000
	usbhid 24576 0 - Live 0xe0999000
	uhci_hcd 32908 0 - Live 0xe09c4000
	eth1394 21768 0 - Live 0xe09a1000
	ehci_hcd 44548 0 - Live 0xe0952000
	usbcore 128356 5 usbhid,uhci_hcd,ehci_hcd, Live 0xe0978000
	tg3 83460 0 - Live 0xe093c000
	ohci1394 35204 0 - Live 0xe0918000
	ieee1394 109368 2 eth1394,ohci1394, Live 0xe08fc000
	yenta_socket 21376 0 - Live 0xe08ad000
	psmouse 20104 0 - Live 0xe0885000
	evdev 9856 1 - Live 0xe08a1000
	bcm5700 137260 0 - Live 0xe08b9000
	rtc 13112 0 - Live 0xe088b000


  Boot Parameters (/proc/cmdline)
  --------------------
   
	root=/dev/hda1 vga=0


  Boot Kernel Messages (dmesg):
  --------------------
   
	ol family 16
	PCI: PCI BIOS revision 2.10 entry at 0xf0031, last bus=2
	PCI: Using configuration type 1
	mtrr: v2.0 (20020519)
	ACPI: Subsystem revision 20040326
	ACPI: IRQ9 SCI: Edge set to Level Trigger.
	requesting new irq thread for IRQ9...
	    ACPI-1136: *** Error: Method execution failed [\_SB_.PCI0.SBRG.EC0
	_.ACS_] (Node dfe8ffe0), AE_NOT_EXIST
	    ACPI-1136: *** Error: Method execution failed [\_SB_.AC__._INI] (N
	ode dfe8fb00), AE_NOT_EXIST
	    ACPI-1136: *** Error: Method execution failed [\_SB_.PCI0.SBRG.EC0
	_.BATS] (Node dfe8ffc0), AE_NOT_EXIST
	    ACPI-1136: *** Error: Method execution failed [\_SB_.BAT0._STA] (N
	ode dfe91cc0), AE_NOT_EXIST
	    ACPI-0154: *** Error: Method execution failed [\_SB_.BAT0._STA] (N
	ode dfe91cc0), AE_NOT_EXIST
	ACPI: Interpreter enabled
	ACPI: Using PIC for interrupt routing
	ACPI: PCI Root Bridge [PCI0] (00:00)
	PCI: Probing PCI hardware (bus 00)
	PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
	PCI: Transparent bridge - 0000:00:1e.0
	ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
	ACPI: Embedded Controller [EC0] (gpe 28)
	ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P2._PRT]
	ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P1._PRT]
	IRQ#9 thread started up.
	ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 10 *11 12)
	ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 *11 12)
	ACPI: PCI Interrupt Link [LNKC] (IRQs *4 10 12)
	ACPI: PCI Interrupt Link [LNKD] (IRQs *5 6 10)
	ACPI: PCI Interrupt Link [LNKE] (IRQs 6 11) *0, disabled.
	ACPI: PCI Interrupt Link [LNKF] (IRQs 3 7) *0, disabled.
	ACPI: PCI Interrupt Link [LNKG] (IRQs 4 7) *0, disabled.
	ACPI: PCI Interrupt Link [LNKH] (IRQs 4 6 *10 12)
	Linux Plug and Play Support v0.97 (c) Adam Belay
	toshiba: not a supported Toshiba laptop
	Linux Kernel Card Services
	  options:  [pci] [cardbus] [pm]
	PCI: Using ACPI for IRQ routing
	ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 11
	ACPI: PCI interrupt 0000:00:1d.0[A] -> GSI 11 (level, low) -> IRQ 11
	ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 5
	ACPI: PCI interrupt 0000:00:1d.1[B] -> GSI 5 (level, low) -> IRQ 5
	ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 4
	ACPI: PCI interrupt 0000:00:1d.2[C] -> GSI 4 (level, low) -> IRQ 4
	ACPI: PCI Interrupt Link [LNKH] enabled at IRQ 10
	ACPI: PCI interrupt 0000:00:1d.7[D] -> GSI 10 (level, low) -> IRQ 10
	ACPI: PCI interrupt 0000:00:1f.1[A] -> GSI 4 (level, low) -> IRQ 4
	ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 11
	ACPI: PCI interrupt 0000:00:1f.5[B] -> GSI 11 (level, low) -> IRQ 11
	ACPI: PCI interrupt 0000:00:1f.6[B] -> GSI 11 (level, low) -> IRQ 11
	ACPI: PCI interrupt 0000:01:00.0[A] -> GSI 11 (level, low) -> IRQ 11
	ACPI: PCI interrupt 0000:02:00.0[A] -> GSI 11 (level, low) -> IRQ 11
	ACPI: PCI interrupt 0000:02:01.0[A] -> GSI 11 (level, low) -> IRQ 11
	ACPI: PCI interrupt 0000:02:01.1[B] -> GSI 11 (level, low) -> IRQ 11
	ACPI: PCI interrupt 0000:02:01.2[C] -> GSI 4 (level, low) -> IRQ 4
	ACPI: PCI interrupt 0000:02:02.0[A] -> GSI 11 (level, low) -> IRQ 11
	Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
	Initializing Cryptographic API
	ACPI: AC Adapter [AC] (on-line)
	ACPI: Battery Slot [BAT0] (battery absent)
	ACPI: Battery Slot [BAT1] (battery absent)
	ACPI: Processor [CPU1] (supports C1 C2)
	ACPI: Thermal Zone [THRM] (60 C)
	isapnp: Scanning for PnP cards...
	isapnp: No Plug & Play device found
	Linux agpgart interface v0.100 (c) Dave Jones
	Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
	ide: Assuming 33MHz system bus speed for PIO modes; override with ideb
	us=xx
	ICH4: IDE controller at PCI slot 0000:00:1f.1
	PCI: Enabling device 0000:00:1f.1 (0005 -> 0007)
	ACPI: PCI interrupt 0000:00:1f.1[A] -> GSI 4 (level, low) -> IRQ 4
	ICH4: chipset revision 3
	ICH4: not 100% native mode: will probe irqs later
	    ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:DMA, hdb:pio
	    ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:DMA, hdd:pio
	hda: IC25N060ATMR04-0, ATA DISK drive
	requesting new irq thread for IRQ14...
	Using anticipatory io scheduler
	ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
	hdc: TOSHIBA ODD-DVD SD-R6372, ATAPI CD/DVD-ROM drive
	requesting new irq thread for IRQ15...
	IRQ#15 thread started up.
	ide1 at 0x170-0x177,0x376 on irq 15
	hda: max request size: 1024KiB
	IRQ#14 thread started up.
	hda: 117210240 sectors (60011 MB) w/7884KiB Cache, CHS=16383/255/63, U
	DMA(100)
	 hda: hda1 hda2 hda3
	hdc: ATAPI 24X DVD-ROM DVD-R CD-R/RW drive, 2048kB Cache, UDMA(33)
	Uniform CD-ROM driver Revision: 3.20
	mice: PS/2 mouse device common for all mice
	requesting new irq thread for IRQ12...
	i8042.c: Detected active multiplexing controller, rev 1.1.
	serio: i8042 AUX0 port at 0x60,0x64 irq 12
	IRQ#12 thread started up.
	serio: i8042 AUX1 port at 0x60,0x64 irq 12
	serio: i8042 AUX2 port at 0x60,0x64 irq 12
	serio: i8042 AUX3 port at 0x60,0x64 irq 12
	serio: i8042 KBD port at 0x60,0x64 irq 1
	requesting new irq thread for IRQ1...
	IRQ#1 thread started up.
	input: AT Translated Set 2 keyboard on isa0060/serio0
	NET: Registered protocol family 2
	IP: routing cache hash table of 4096 buckets, 32Kbytes
	TCP: Hash tables configured (established 32768 bind 65536)
	NET: Registered protocol family 1
	NET: Registered protocol family 17
	EXT3-fs: INFO: recovery required on readonly filesystem.
	EXT3-fs: write access will be enabled during recovery.
	(fs/jbd/recovery.c, 255): journal_recover: JBD: recovery, exit status 
	0, recovered transactions 72238 to 72567
	(fs/jbd/recovery.c, 257): journal_recover: JBD: Replayed 4426 and revo
	ked 8/42 blocks
	kjournald starting.  Commit interval 5 seconds
	EXT3-fs: hda1: orphan cleanup on readonly fs
	ext3_orphan_cleanup: deleting unreferenced inode 1075023
	ext3_orphan_cleanup: deleting unreferenced inode 1075026
	ext3_orphan_cleanup: deleting unreferenced inode 358827
	ext3_orphan_cleanup: deleting unreferenced inode 358801
	EXT3-fs: hda1: 4 orphan inodes deleted
	EXT3-fs: recovery complete.
	EXT3-fs: mounted filesystem with ordered data mode.
	VFS: Mounted root (ext3 filesystem) readonly.
	Freeing unused kernel memory: 140k freed
	Adding 979956k swap on /dev/hda2.  Priority:-1 extents:1
	EXT3 FS on hda1, internal journal
	requesting new irq thread for IRQ8...
	Real Time Clock Driver v1.12
	IRQ#8 thread started up.
	Broadcom Gigabit Ethernet Driver bcm5700 with Broadcom NIC Extension (
	NICE) ver. 7.3.5 (06/23/04)
	ACPI: PCI interrupt 0000:02:00.0[A] -> GSI 11 (level, low) -> IRQ 11
	eth0: Broadcom BCM5788 NetLink 1000Base-T found at mem ff9f0000, IRQ 1
	1, node addr 00112f007133
	eth0: Broadcom BCM5705 Integrated Copper transceiver found
	eth0: Scatter-gather ON, 64-bit DMA OFF, Tx Checksum ON, Rx Checksum O
	N, 802.1Q VLAN ON, TSO ON
	Synaptics Touchpad, model: 1
	 Firmware: 4.6
	 180 degree mounted touchpad
	 Sensor: 18
	 new absolute packet format
	 Touchpad has extended capability bits
	 -> four buttons
	 -> multifinger detection
	 -> palm detection
	input: SynPS/2 Synaptics TouchPad on isa0060/serio4
	(fs/jbd/recovery.c, 255): journal_recover: JBD: recovery, exit status 
	0, recovered transactions 39894 to 40160
	(fs/jbd/recovery.c, 257): journal_recover: JBD: Replayed 2698 and revo
	ked 27/71 blocks
	kjournald starting.  Commit interval 5 seconds
	EXT3 FS on hda3, internal journal
	EXT3-fs: recovery complete.
	EXT3-fs: mounted filesystem with ordered data mode.
	PCI: Enabling device 0000:02:01.0 (0000 -> 0002)
	ACPI: PCI interrupt 0000:02:01.0[A] -> GSI 11 (level, low) -> IRQ 11
	Yenta: CardBus bridge found at 0000:02:01.0 [1043:1864]
	requesting new irq thread for IRQ11...
	Yenta: ISA IRQ mask 0x0088, PCI irq 11
	Socket status: 30000006
	ACPI: PCI interrupt 0000:02:01.1[B] -> GSI 11 (level, low) -> IRQ 11
	Yenta: CardBus bridge found at 0000:02:01.1 [1043:1864]
	Yenta: ISA IRQ mask 0x0088, PCI irq 11
	Socket status: 30000006
	ieee1394: Initialized config rom entry `ip1394'
	ohci1394: $Rev: 1223 $ Ben Collins <bcollins@debian.org>
	ACPI: PCI interrupt 0000:02:01.2[C] -> GSI 4 (level, low) -> IRQ 4
	requesting new irq thread for IRQ4...
	ohci1394: fw-host0: OHCI-1394 1.0 (PCI): IRQ=[4]  MMIO=[ff9ef800-ff9ef
	fff]  Max Packet=[2048]
	usbcore: registered new driver usbfs
	usbcore: registered new driver hub
	ehci_hcd: block sizes: qh 128 qtd 96 itd 192 sitd 96
	ACPI: PCI interrupt 0000:00:1d.7[D] -> GSI 10 (level, low) -> IRQ 10
	ehci_hcd 0000:00:1d.7: Intel Corp. 82801DB (ICH4) USB2 EHCI Controller
	ehci_hcd 0000:00:1d.7: reset hcs_params 0x103206 dbg=1 cc=3 pcc=2 orde
	red !ppc ports=6
	ehci_hcd 0000:00:1d.7: reset hcc_params 6871 thresh 7 uframes 1024 64 
	bit addr
	ehci_hcd 0000:00:1d.7: capability 0001 at 68
	PCI: Setting latency timer of device 0000:00:1d.7 to 64
	requesting new irq thread for IRQ10...
	ehci_hcd 0000:00:1d.7: irq 10, pci mem e0924c00
	ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 1
	ehci_hcd 0000:00:1d.7: reset command 080002 (park)=0 ithresh=8 period=
	1024 Reset HALT
	PCI: cache line size of 32 is not supported by device 0000:00:1d.7
	ehci_hcd 0000:00:1d.7: init command 010001 (park)=0 ithresh=1 period=1
	024 RUN
	ehci_hcd 0000:00:1d.7: USB 2.0 enabled, EHCI 1.00, driver 2004-May-10
	ehci_hcd 0000:00:1d.7: supports USB remote wakeup
	usb usb1: new device strings: Mfr=3, Product=2, SerialNumber=1
	usb usb1: default language 0x0409
	usb usb1: Product: Intel Corp. 82801DB (ICH4) USB2 EHCI Controller
	usb usb1: Manufacturer: Linux 2.6.8.1-vp ehci_hcd
	usb usb1: SerialNumber: 0000:00:1d.7
	usb usb1: hotplug
	usb usb1: adding 1-0:1.0 (config #1, interface 0)
	usb 1-0:1.0: hotplug
	hub 1-0:1.0: usb_probe_interface
	hub 1-0:1.0: usb_probe_interface - got id
	hub 1-0:1.0: USB hub found
	hub 1-0:1.0: 6 ports detected
	hub 1-0:1.0: standalone hub
	hub 1-0:1.0: ganged power switching
	hub 1-0:1.0: individual port over-current protection
	hub 1-0:1.0: Single TT
	hub 1-0:1.0: TT requires at most 8 FS bit times
	hub 1-0:1.0: power on to power good time: 20ms
	hub 1-0:1.0: local power source is good
	hub 1-0:1.0: enabling power on all ports
	IRQ#10 thread started up.
	ehci_hcd 0000:00:1d.7: GetStatus port 3 status 001403 POWER sig=k  CSC
	 CONNECT
	hub 1-0:1.0: port 3, status 0501, change 0001, 480 Mb/s
	hub 1-0:1.0: debounce: port 3: total 100ms stable 100ms status 0x501
	ehci_hcd 0000:00:1d.7: port 3 low speed --> companion
	ehci_hcd 0000:00:1d.7: GetStatus port 3 status 003002 POWER OWNER sig=
	se0  CSC
	IRQ#4 thread started up.
	ieee1394: Host added: ID:BUS[0-00:1023]  GUID[00e01800031ae8a1]
	ip1394: $Rev: 1224 $ Ben Collins <bcollins@debian.org>
	ip1394: eth1: IEEE-1394 IPv4 over 1394 Ethernet (fw-host0)
	USB Universal Host Controller Interface driver v2.2
	ACPI: PCI interrupt 0000:00:1d.0[A] -> GSI 11 (level, low) -> IRQ 11
	uhci_hcd 0000:00:1d.0: Intel Corp. 82801DB (ICH4) USB UHCI #1
	PCI: Setting latency timer of device 0000:00:1d.0 to 64
	uhci_hcd 0000:00:1d.0: irq 11, io base 0000e800
	uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 2
	uhci_hcd 0000:00:1d.0: detected 2 ports
	usb usb2: new device strings: Mfr=3, Product=2, SerialNumber=1
	usb usb2: default language 0x0409
	usb usb2: Product: Intel Corp. 82801DB (ICH4) USB UHCI #1
	usb usb2: Manufacturer: Linux 2.6.8.1-vp uhci_hcd
	usb usb2: SerialNumber: 0000:00:1d.0
	usb usb2: hotplug
	usb usb2: adding 2-0:1.0 (config #1, interface 0)
	usb 2-0:1.0: hotplug
	hub 2-0:1.0: usb_probe_interface
	hub 2-0:1.0: usb_probe_interface - got id
	hub 2-0:1.0: USB hub found
	hub 2-0:1.0: 2 ports detected
	hub 2-0:1.0: standalone hub
	hub 2-0:1.0: no power switching (usb 1.0)
	hub 2-0:1.0: individual port over-current protection
	hub 2-0:1.0: power on to power good time: 2ms
	hub 2-0:1.0: local power source is good
	ACPI: PCI interrupt 0000:00:1d.1[B] -> GSI 5 (level, low) -> IRQ 5
	uhci_hcd 0000:00:1d.1: Intel Corp. 82801DB (ICH4) USB UHCI #2
	PCI: Setting latency timer of device 0000:00:1d.1 to 64
	requesting new irq thread for IRQ5...
	uhci_hcd 0000:00:1d.1: irq 5, io base 0000e880
	uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 3
	uhci_hcd 0000:00:1d.1: detected 2 ports
	usb usb3: new device strings: Mfr=3, Product=2, SerialNumber=1
	usb usb3: default language 0x0409
	usb usb3: Product: Intel Corp. 82801DB (ICH4) USB UHCI #2
	usb usb3: Manufacturer: Linux 2.6.8.1-vp uhci_hcd
	usb usb3: SerialNumber: 0000:00:1d.1
	usb usb3: hotplug
	usb usb3: adding 3-0:1.0 (config #1, interface 0)
	usb 3-0:1.0: hotplug
	hub 3-0:1.0: usb_probe_interface
	hub 3-0:1.0: usb_probe_interface - got id
	hub 3-0:1.0: USB hub found
	hub 3-0:1.0: 2 ports detected
	hub 3-0:1.0: standalone hub
	hub 3-0:1.0: no power switching (usb 1.0)
	hub 3-0:1.0: individual port over-current protection
	hub 3-0:1.0: power on to power good time: 2ms
	hub 3-0:1.0: local power source is good
	ACPI: PCI interrupt 0000:00:1d.2[C] -> GSI 4 (level, low) -> IRQ 4
	uhci_hcd 0000:00:1d.2: Intel Corp. 82801DB (ICH4) USB UHCI #3
	uhci_hcd 0000:00:1d.1: port 1 portsc 01a3
	hub 3-0:1.0: port 1, status 0301, change 0001, 1.5 Mb/s
	PCI: Setting latency timer of device 0000:00:1d.2 to 64
	uhci_hcd 0000:00:1d.2: irq 4, io base 0000ec00
	uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 4
	uhci_hcd 0000:00:1d.2: detected 2 ports
	usb usb4: new device strings: Mfr=3, Product=2, SerialNumber=1
	usb usb4: default language 0x0409
	usb usb4: Product: Intel Corp. 82801DB (ICH4) USB UHCI #3
	usb usb4: Manufacturer: Linux 2.6.8.1-vp uhci_hcd
	usb usb4: SerialNumber: 0000:00:1d.2
	usb usb4: hotplug
	usb usb4: adding 4-0:1.0 (config #1, interface 0)
	usb 4-0:1.0: hotplug
	hub 4-0:1.0: usb_probe_interface
	hub 4-0:1.0: usb_probe_interface - got id
	hub 4-0:1.0: USB hub found
	hub 4-0:1.0: 2 ports detected
	hub 4-0:1.0: standalone hub
	hub 4-0:1.0: no power switching (usb 1.0)
	hub 4-0:1.0: individual port over-current protection
	hub 4-0:1.0: power on to power good time: 2ms
	hub 4-0:1.0: local power source is good
	hub 3-0:1.0: debounce: port 1: total 100ms stable 100ms status 0x301
	usb 3-1: new low speed USB device using address 2
	IRQ#5 thread started up.
	usb 3-1: skipped 1 descriptor after interface
	usb 3-1: new device strings: Mfr=1, Product=2, SerialNumber=0
	usb 3-1: default language 0x0409
	usb 3-1: Product: Optical USB Mouse
	usb 3-1: Manufacturer: Logitech
	usb 3-1: hotplug
	usb 3-1: adding 3-1:1.0 (config #1, interface 0)
	usb 3-1:1.0: hotplug
	usbhid 3-1:1.0: usb_probe_interface
	usbhid 3-1:1.0: usb_probe_interface - got id
	input: USB HID v1.10 Mouse [Logitech Optical USB Mouse] on usb-0000:00
	:1d.1-1
	usbcore: registered new driver usbhid
	drivers/usb/input/hid-core.c: v2.0:USB HID core driver
	hw_random: RNG not detected
	uhci_hcd 0000:00:1d.0: suspend_hc
	ACPI: PCI interrupt 0000:00:1f.5[B] -> GSI 11 (level, low) -> IRQ 11
	PCI: Setting latency timer of device 0000:00:1f.5 to 64
	uhci_hcd 0000:00:1d.2: suspend_hc
	intel8x0_measure_ac97_clock: measured 49571 usecs
	intel8x0: clocking to 48000
	Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disab
	led
	ttyS1 at I/O 0x2f8 (irq = 3) is a NS16550A
	ACPI: PCI interrupt 0000:00:1f.6[B] -> GSI 11 (level, low) -> IRQ 11
	ieee80211_crypt: registered algorithm 'NULL'
	ipw2200: Intel(R) PRO/Wireless 2200 Network Driver, 0.8
	ipw2200: Copyright(c) 2003-2004 Intel Corporation
	ACPI: PCI interrupt 0000:02:02.0[A] -> GSI 11 (level, low) -> IRQ 11
	IRQ#11 thread started up.
	eth2: Setting MAC to 00:0e:35:0d:a6:9c
	ipw2200: Calibration
	bcm5700: eth0 NIC Link is UP, 100 Mbps full duplex, receive & transmit
	 flow control ON
	nfs warning: mount version older than kernel
	nfs warning: mount version older than kernel
	requesting new irq thread for IRQ3...
	IRQ#3 thread started up.
	NET: Registered protocol family 10
	Disabled Privacy Extensions on device c03992a0(lo)
	IPv6 over IPv4 tunneling driver


  Configuration:
  --------------------
    
	#
	# Automatically generated make config: don't edit
	#
	CONFIG_X86=y
	CONFIG_MMU=y
	CONFIG_UID16=y
	CONFIG_GENERIC_ISA_DMA=y
	
	#
	# Code maturity level options
	#
	CONFIG_EXPERIMENTAL=y
	CONFIG_CLEAN_COMPILE=y
	CONFIG_BROKEN_ON_SMP=y
	
	#
	# General setup
	#
	CONFIG_SWAP=y
	CONFIG_SYSVIPC=y
	CONFIG_POSIX_MQUEUE=y
	# CONFIG_BSD_PROCESS_ACCT is not set
	CONFIG_SYSCTL=y
	# CONFIG_AUDIT is not set
	CONFIG_LOG_BUF_SHIFT=14
	CONFIG_HOTPLUG=y
	CONFIG_IKCONFIG=y
	CONFIG_IKCONFIG_PROC=y
	# CONFIG_EMBEDDED is not set
	CONFIG_KALLSYMS=y
	# CONFIG_KALLSYMS_EXTRA_PASS is not set
	CONFIG_FUTEX=y
	CONFIG_EPOLL=y
	# CONFIG_PREEMPT_TIMING is not set
	CONFIG_IOSCHED_NOOP=y
	CONFIG_IOSCHED_AS=y
	CONFIG_IOSCHED_DEADLINE=y
	CONFIG_IOSCHED_CFQ=y
	# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
	
	#
	# Loadable module support
	#
	CONFIG_MODULES=y
	CONFIG_MODULE_UNLOAD=y
	CONFIG_MODULE_FORCE_UNLOAD=y
	CONFIG_OBSOLETE_MODPARM=y
	CONFIG_MODVERSIONS=y
	CONFIG_KMOD=y
	
	#
	# Processor type and features
	#
	CONFIG_X86_PC=y
	# CONFIG_X86_ELAN is not set
	# CONFIG_X86_VOYAGER is not set
	# CONFIG_X86_NUMAQ is not set
	# CONFIG_X86_SUMMIT is not set
	# CONFIG_X86_BIGSMP is not set
	# CONFIG_X86_VISWS is not set
	# CONFIG_X86_GENERICARCH is not set
	# CONFIG_X86_ES7000 is not set
	# CONFIG_M386 is not set
	# CONFIG_M486 is not set
	# CONFIG_M586 is not set
	# CONFIG_M586TSC is not set
	# CONFIG_M586MMX is not set
	# CONFIG_M686 is not set
	# CONFIG_MPENTIUMII is not set
	# CONFIG_MPENTIUMIII is not set
	# CONFIG_MPENTIUMM is not set
	CONFIG_MPENTIUM4=y
	# CONFIG_MK6 is not set
	# CONFIG_MK7 is not set
	# CONFIG_MK8 is not set
	# CONFIG_MCRUSOE is not set
	# CONFIG_MWINCHIPC6 is not set
	# CONFIG_MWINCHIP2 is not set
	# CONFIG_MWINCHIP3D is not set
	# CONFIG_MCYRIXIII is not set
	# CONFIG_MVIAC3_2 is not set
	# CONFIG_X86_GENERIC is not set
	CONFIG_X86_CMPXCHG=y
	CONFIG_X86_XADD=y
	CONFIG_X86_L1_CACHE_SHIFT=7
	CONFIG_RWSEM_XCHGADD_ALGORITHM=y
	CONFIG_X86_WP_WORKS_OK=y
	CONFIG_X86_INVLPG=y
	CONFIG_X86_BSWAP=y
	CONFIG_X86_POPAD_OK=y
	CONFIG_X86_GOOD_APIC=y
	CONFIG_X86_INTEL_USERCOPY=y
	CONFIG_X86_USE_PPRO_CHECKSUM=y
	CONFIG_HPET_TIMER=y
	# CONFIG_SMP is not set
	CONFIG_PREEMPT=y
	CONFIG_PREEMPT_VOLUNTARY=y
	CONFIG_X86_UP_APIC=y
	CONFIG_X86_UP_IOAPIC=y
	CONFIG_X86_LOCAL_APIC=y
	CONFIG_X86_IO_APIC=y
	CONFIG_X86_TSC=y
	# CONFIG_X86_MCE is not set
	CONFIG_TOSHIBA=y
	# CONFIG_I8K is not set
	# CONFIG_MICROCODE is not set
	# CONFIG_X86_MSR is not set
	# CONFIG_X86_CPUID is not set
	
	#
	# Firmware Drivers
	#
	# CONFIG_EDD is not set
	CONFIG_NOHIGHMEM=y
	# CONFIG_HIGHMEM4G is not set
	# CONFIG_HIGHMEM64G is not set
	# CONFIG_MATH_EMULATION is not set
	CONFIG_MTRR=y
	# CONFIG_EFI is not set
	CONFIG_HAVE_DEC_LOCK=y
	# CONFIG_REGPARM is not set
	
	#
	# Power management options (ACPI, APM)
	#
	CONFIG_PM=y
	CONFIG_SOFTWARE_SUSPEND=y
	# CONFIG_PM_DISK is not set
	
	#
	# ACPI (Advanced Configuration and Power Interface) Support
	#
	CONFIG_ACPI=y
	CONFIG_ACPI_BOOT=y
	CONFIG_ACPI_INTERPRETER=y
	# CONFIG_ACPI_SLEEP is not set
	CONFIG_ACPI_AC=y
	CONFIG_ACPI_BATTERY=y
	CONFIG_ACPI_BUTTON=m
	CONFIG_ACPI_FAN=y
	CONFIG_ACPI_PROCESSOR=y
	CONFIG_ACPI_THERMAL=y
	CONFIG_ACPI_ASUS=m
	# CONFIG_ACPI_TOSHIBA is not set
	# CONFIG_ACPI_DEBUG is not set
	CONFIG_ACPI_BUS=y
	CONFIG_ACPI_EC=y
	CONFIG_ACPI_POWER=y
	CONFIG_ACPI_PCI=y
	CONFIG_ACPI_SYSTEM=y
	CONFIG_X86_PM_TIMER=y
	
	#
	# APM (Advanced Power Management) BIOS Support
	#
	# CONFIG_APM is not set
	
	#
	# CPU Frequency scaling
	#
	CONFIG_CPU_FREQ=y
	# CONFIG_CPU_FREQ_PROC_INTF is not set
	# CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE is not set
	CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE=y
	CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
	CONFIG_CPU_FREQ_GOV_POWERSAVE=y
	CONFIG_CPU_FREQ_GOV_USERSPACE=y
	# CONFIG_CPU_FREQ_24_API is not set
	CONFIG_CPU_FREQ_TABLE=y
	
	#
	# CPUFreq processor drivers
	#
	# CONFIG_X86_ACPI_CPUFREQ is not set
	# CONFIG_X86_POWERNOW_K6 is not set
	# CONFIG_X86_POWERNOW_K7 is not set
	# CONFIG_X86_POWERNOW_K8 is not set
	# CONFIG_X86_GX_SUSPMOD is not set
	CONFIG_X86_SPEEDSTEP_CENTRINO=y
	CONFIG_X86_SPEEDSTEP_CENTRINO_TABLE=y
	CONFIG_X86_SPEEDSTEP_CENTRINO_ACPI=y
	CONFIG_X86_SPEEDSTEP_ICH=m
	# CONFIG_X86_SPEEDSTEP_SMI is not set
	# CONFIG_X86_P4_CLOCKMOD is not set
	CONFIG_X86_SPEEDSTEP_LIB=m
	# CONFIG_X86_SPEEDSTEP_RELAXED_CAP_CHECK is not set
	# CONFIG_X86_LONGRUN is not set
	# CONFIG_X86_LONGHAUL is not set
	
	#
	# Bus options (PCI, PCMCIA, EISA, MCA, ISA)
	#
	CONFIG_PCI=y
	# CONFIG_PCI_GOBIOS is not set
	# CONFIG_PCI_GOMMCONFIG is not set
	# CONFIG_PCI_GODIRECT is not set
	CONFIG_PCI_GOANY=y
	CONFIG_PCI_BIOS=y
	CONFIG_PCI_DIRECT=y
	CONFIG_PCI_MMCONFIG=y
	# CONFIG_PCI_MSI is not set
	# CONFIG_PCI_LEGACY_PROC is not set
	CONFIG_PCI_NAMES=y
	CONFIG_ISA=y
	# CONFIG_EISA is not set
	# CONFIG_MCA is not set
	# CONFIG_SCx200 is not set
	
	#
	# PCMCIA/CardBus support
	#
	CONFIG_PCMCIA=y
	# CONFIG_PCMCIA_DEBUG is not set
	CONFIG_YENTA=m
	CONFIG_CARDBUS=y
	# CONFIG_PD6729 is not set
	# CONFIG_I82092 is not set
	# CONFIG_I82365 is not set
	# CONFIG_TCIC is not set
	CONFIG_PCMCIA_PROBE=y
	
	#
	# PCI Hotplug Support
	#
	# CONFIG_HOTPLUG_PCI is not set
	
	#
	# Executable file formats
	#
	CONFIG_BINFMT_ELF=y
	CONFIG_BINFMT_AOUT=m
	CONFIG_BINFMT_MISC=m
	
	#
	# Device Drivers
	#
	
	#
	# Generic Driver Options
	#
	CONFIG_STANDALONE=y
	CONFIG_PREVENT_FIRMWARE_BUILD=y
	CONFIG_FW_LOADER=y
	
	#
	# Memory Technology Devices (MTD)
	#
	# CONFIG_MTD is not set
	
	#
	# Parallel port support
	#
	CONFIG_PARPORT=m
	CONFIG_PARPORT_PC=m
	CONFIG_PARPORT_PC_CML1=m
	CONFIG_PARPORT_SERIAL=m
	CONFIG_PARPORT_PC_FIFO=y
	# CONFIG_PARPORT_PC_SUPERIO is not set
	# CONFIG_PARPORT_PC_PCMCIA is not set
	# CONFIG_PARPORT_OTHER is not set
	# CONFIG_PARPORT_1284 is not set
	
	#
	# Plug and Play support
	#
	CONFIG_PNP=y
	# CONFIG_PNP_DEBUG is not set
	
	#
	# Protocols
	#
	CONFIG_ISAPNP=y
	# CONFIG_PNPBIOS is not set
	
	#
	# Block devices
	#
	# CONFIG_BLK_DEV_FD is not set
	# CONFIG_BLK_DEV_XD is not set
	# CONFIG_PARIDE is not set
	# CONFIG_BLK_CPQ_DA is not set
	# CONFIG_BLK_CPQ_CISS_DA is not set
	# CONFIG_BLK_DEV_DAC960 is not set
	# CONFIG_BLK_DEV_UMEM is not set
	CONFIG_BLK_DEV_LOOP=m
	CONFIG_BLK_DEV_CRYPTOLOOP=m
	# CONFIG_BLK_DEV_NBD is not set
	# CONFIG_BLK_DEV_SX8 is not set
	# CONFIG_BLK_DEV_RAM is not set
	# CONFIG_LBD is not set
	
	#
	# ATA/ATAPI/MFM/RLL support
	#
	CONFIG_IDE=y
	CONFIG_BLK_DEV_IDE=y
	
	#
	# Please see Documentation/ide.txt for help/info on IDE drives
	#
	# CONFIG_BLK_DEV_IDE_SATA is not set
	# CONFIG_BLK_DEV_HD_IDE is not set
	CONFIG_BLK_DEV_IDEDISK=y
	# CONFIG_IDEDISK_MULTI_MODE is not set
	CONFIG_BLK_DEV_IDECS=m
	CONFIG_BLK_DEV_IDECD=y
	# CONFIG_BLK_DEV_IDETAPE is not set
	# CONFIG_BLK_DEV_IDEFLOPPY is not set
	# CONFIG_BLK_DEV_IDESCSI is not set
	# CONFIG_IDE_TASK_IOCTL is not set
	# CONFIG_IDE_TASKFILE_IO is not set
	
	#
	# IDE chipset support/bugfixes
	#
	CONFIG_IDE_GENERIC=y
	# CONFIG_BLK_DEV_CMD640 is not set
	# CONFIG_BLK_DEV_IDEPNP is not set
	CONFIG_BLK_DEV_IDEPCI=y
	CONFIG_IDEPCI_SHARE_IRQ=y
	# CONFIG_BLK_DEV_OFFBOARD is not set
	CONFIG_BLK_DEV_GENERIC=y
	# CONFIG_BLK_DEV_OPTI621 is not set
	# CONFIG_BLK_DEV_RZ1000 is not set
	CONFIG_BLK_DEV_IDEDMA_PCI=y
	# CONFIG_BLK_DEV_IDEDMA_FORCED is not set
	CONFIG_IDEDMA_PCI_AUTO=y
	# CONFIG_IDEDMA_ONLYDISK is not set
	CONFIG_BLK_DEV_ADMA=y
	# CONFIG_BLK_DEV_AEC62XX is not set
	# CONFIG_BLK_DEV_ALI15X3 is not set
	# CONFIG_BLK_DEV_AMD74XX is not set
	# CONFIG_BLK_DEV_ATIIXP is not set
	# CONFIG_BLK_DEV_CMD64X is not set
	# CONFIG_BLK_DEV_TRIFLEX is not set
	# CONFIG_BLK_DEV_CY82C693 is not set
	# CONFIG_BLK_DEV_CS5520 is not set
	# CONFIG_BLK_DEV_CS5530 is not set
	# CONFIG_BLK_DEV_HPT34X is not set
	# CONFIG_BLK_DEV_HPT366 is not set
	# CONFIG_BLK_DEV_SC1200 is not set
	CONFIG_BLK_DEV_PIIX=y
	# CONFIG_BLK_DEV_NS87415 is not set
	# CONFIG_BLK_DEV_PDC202XX_OLD is not set
	# CONFIG_BLK_DEV_PDC202XX_NEW is not set
	# CONFIG_BLK_DEV_SVWKS is not set
	# CONFIG_BLK_DEV_SIIMAGE is not set
	# CONFIG_BLK_DEV_SIS5513 is not set
	# CONFIG_BLK_DEV_SLC90E66 is not set
	# CONFIG_BLK_DEV_TRM290 is not set
	# CONFIG_BLK_DEV_VIA82CXXX is not set
	# CONFIG_IDE_ARM is not set
	# CONFIG_IDE_CHIPSETS is not set
	CONFIG_BLK_DEV_IDEDMA=y
	# CONFIG_IDEDMA_IVB is not set
	CONFIG_IDEDMA_AUTO=y
	# CONFIG_BLK_DEV_HD is not set
	
	#
	# SCSI device support
	#
	CONFIG_SCSI=m
	CONFIG_SCSI_PROC_FS=y
	
	#
	# SCSI support type (disk, tape, CD-ROM)
	#
	CONFIG_BLK_DEV_SD=m
	CONFIG_CHR_DEV_ST=m
	CONFIG_CHR_DEV_OSST=m
	CONFIG_BLK_DEV_SR=m
	# CONFIG_BLK_DEV_SR_VENDOR is not set
	CONFIG_CHR_DEV_SG=m
	
	#
	# Some SCSI devices (e.g. CD jukebox) support multiple LUNs
	#
	CONFIG_SCSI_MULTI_LUN=y
	# CONFIG_SCSI_CONSTANTS is not set
	# CONFIG_SCSI_LOGGING is not set
	
	#
	# SCSI Transport Attributes
	#
	CONFIG_SCSI_SPI_ATTRS=m
	# CONFIG_SCSI_FC_ATTRS is not set
	
	#
	# SCSI low-level drivers
	#
	CONFIG_BLK_DEV_3W_XXXX_RAID=m
	# CONFIG_SCSI_3W_9XXX is not set
	CONFIG_SCSI_7000FASST=m
	CONFIG_SCSI_ACARD=m
	CONFIG_SCSI_AHA152X=m
	CONFIG_SCSI_AHA1542=m
	CONFIG_SCSI_AACRAID=m
	CONFIG_SCSI_AIC7XXX=m
	CONFIG_AIC7XXX_CMDS_PER_DEVICE=8
	CONFIG_AIC7XXX_RESET_DELAY_MS=15000
	# CONFIG_AIC7XXX_BUILD_FIRMWARE is not set
	CONFIG_AIC7XXX_DEBUG_ENABLE=y
	CONFIG_AIC7XXX_DEBUG_MASK=0
	CONFIG_AIC7XXX_REG_PRETTY_PRINT=y
	CONFIG_SCSI_AIC7XXX_OLD=m
	CONFIG_SCSI_AIC79XX=m
	CONFIG_AIC79XX_CMDS_PER_DEVICE=32
	CONFIG_AIC79XX_RESET_DELAY_MS=15000
	# CONFIG_AIC79XX_BUILD_FIRMWARE is not set
	CONFIG_AIC79XX_ENABLE_RD_STRM=y
	CONFIG_AIC79XX_DEBUG_ENABLE=y
	CONFIG_AIC79XX_DEBUG_MASK=0
	CONFIG_AIC79XX_REG_PRETTY_PRINT=y
	CONFIG_SCSI_DPT_I2O=m
	CONFIG_SCSI_IN2000=m
	CONFIG_SCSI_MEGARAID=m
	CONFIG_SCSI_SATA=y
	CONFIG_SCSI_SATA_SVW=m
	CONFIG_SCSI_ATA_PIIX=m
	# CONFIG_SCSI_SATA_NV is not set
	CONFIG_SCSI_SATA_PROMISE=m
	CONFIG_SCSI_SATA_SX4=m
	CONFIG_SCSI_SATA_SIL=m
	CONFIG_SCSI_SATA_SIS=m
	CONFIG_SCSI_SATA_VIA=m
	CONFIG_SCSI_SATA_VITESSE=m
	CONFIG_SCSI_BUSLOGIC=m
	# CONFIG_SCSI_OMIT_FLASHPOINT is not set
	CONFIG_SCSI_DMX3191D=m
	CONFIG_SCSI_DTC3280=m
	CONFIG_SCSI_EATA=m
	CONFIG_SCSI_EATA_TAGGED_QUEUE=y
	CONFIG_SCSI_EATA_LINKED_COMMANDS=y
	CONFIG_SCSI_EATA_MAX_TAGS=16
	CONFIG_SCSI_EATA_PIO=m
	CONFIG_SCSI_FUTURE_DOMAIN=m
	CONFIG_SCSI_GDTH=m
	CONFIG_SCSI_GENERIC_NCR5380=m
	CONFIG_SCSI_GENERIC_NCR5380_MMIO=m
	CONFIG_SCSI_GENERIC_NCR53C400=y
	CONFIG_SCSI_IPS=m
	# CONFIG_SCSI_INIA100 is not set
	CONFIG_SCSI_PPA=m
	CONFIG_SCSI_IMM=m
	# CONFIG_SCSI_IZIP_EPP16 is not set
	# CONFIG_SCSI_IZIP_SLOW_CTR is not set
	CONFIG_SCSI_NCR53C406A=m
	CONFIG_SCSI_SYM53C8XX_2=m
	CONFIG_SCSI_SYM53C8XX_DMA_ADDRESSING_MODE=1
	CONFIG_SCSI_SYM53C8XX_DEFAULT_TAGS=16
	CONFIG_SCSI_SYM53C8XX_MAX_TAGS=64
	# CONFIG_SCSI_SYM53C8XX_IOMAPPED is not set
	CONFIG_SCSI_IPR=m
	# CONFIG_SCSI_IPR_TRACE is not set
	# CONFIG_SCSI_IPR_DUMP is not set
	CONFIG_SCSI_PAS16=m
	CONFIG_SCSI_PSI240I=m
	CONFIG_SCSI_QLOGIC_FAS=m
	CONFIG_SCSI_QLOGIC_ISP=m
	CONFIG_SCSI_QLOGIC_FC=m
	CONFIG_SCSI_QLOGIC_FC_FIRMWARE=y
	CONFIG_SCSI_QLOGIC_1280=m
	CONFIG_SCSI_QLA2XXX=m
	# CONFIG_SCSI_QLA21XX is not set
	# CONFIG_SCSI_QLA22XX is not set
	# CONFIG_SCSI_QLA2300 is not set
	# CONFIG_SCSI_QLA2322 is not set
	# CONFIG_SCSI_QLA6312 is not set
	# CONFIG_SCSI_QLA6322 is not set
	CONFIG_SCSI_SYM53C416=m
	CONFIG_SCSI_DC395x=m
	CONFIG_SCSI_DC390T=m
	CONFIG_SCSI_T128=m
	CONFIG_SCSI_U14_34F=m
	CONFIG_SCSI_U14_34F_TAGGED_QUEUE=y
	CONFIG_SCSI_U14_34F_LINKED_COMMANDS=y
	CONFIG_SCSI_U14_34F_MAX_TAGS=8
	CONFIG_SCSI_ULTRASTOR=m
	CONFIG_SCSI_NSP32=m
	CONFIG_SCSI_DEBUG=m
	
	#
	# PCMCIA SCSI adapter support
	#
	CONFIG_PCMCIA_AHA152X=m
	CONFIG_PCMCIA_FDOMAIN=m
	CONFIG_PCMCIA_NINJA_SCSI=m
	CONFIG_PCMCIA_QLOGIC=m
	CONFIG_PCMCIA_SYM53C500=m
	
	#
	# Old CD-ROM drivers (not SCSI, not IDE)
	#
	# CONFIG_CD_NO_IDESCSI is not set
	
	#
	# Multi-device support (RAID and LVM)
	#
	# CONFIG_MD is not set
	
	#
	# Fusion MPT device support
	#
	# CONFIG_FUSION is not set
	
	#
	# IEEE 1394 (FireWire) support
	#
	CONFIG_IEEE1394=m
	
	#
	# Subsystem Options
	#
	# CONFIG_IEEE1394_VERBOSEDEBUG is not set
	# CONFIG_IEEE1394_OUI_DB is not set
	CONFIG_IEEE1394_EXTRA_CONFIG_ROMS=y
	CONFIG_IEEE1394_CONFIG_ROM_IP1394=y
	
	#
	# Device Drivers
	#
	CONFIG_IEEE1394_PCILYNX=m
	CONFIG_IEEE1394_OHCI1394=m
	
	#
	# Protocol Drivers
	#
	CONFIG_IEEE1394_VIDEO1394=m
	CONFIG_IEEE1394_SBP2=m
	# CONFIG_IEEE1394_SBP2_PHYS_DMA is not set
	CONFIG_IEEE1394_ETH1394=m
	CONFIG_IEEE1394_DV1394=m
	CONFIG_IEEE1394_RAWIO=m
	CONFIG_IEEE1394_CMP=m
	CONFIG_IEEE1394_AMDTP=m
	
	#
	# I2O device support
	#
	# CONFIG_I2O is not set
	
	#
	# Networking support
	#
	CONFIG_NET=y
	
	#
	# Networking options
	#
	CONFIG_PACKET=y
	CONFIG_PACKET_MMAP=y
	# CONFIG_NETLINK_DEV is not set
	CONFIG_UNIX=y
	# CONFIG_NET_KEY is not set
	CONFIG_INET=y
	# CONFIG_IP_MULTICAST is not set
	# CONFIG_IP_ADVANCED_ROUTER is not set
	# CONFIG_IP_PNP is not set
	# CONFIG_NET_IPIP is not set
	# CONFIG_NET_IPGRE is not set
	# CONFIG_ARPD is not set
	CONFIG_SYN_COOKIES=y
	# CONFIG_INET_AH is not set
	# CONFIG_INET_ESP is not set
	# CONFIG_INET_IPCOMP is not set
	
	#
	# IP: Virtual Server Configuration
	#
	CONFIG_IP_VS=m
	# CONFIG_IP_VS_DEBUG is not set
	CONFIG_IP_VS_TAB_BITS=12
	
	#
	# IPVS transport protocol load balancing support
	#
	CONFIG_IP_VS_PROTO_TCP=y
	CONFIG_IP_VS_PROTO_UDP=y
	CONFIG_IP_VS_PROTO_ESP=y
	CONFIG_IP_VS_PROTO_AH=y
	
	#
	# IPVS scheduler
	#
	CONFIG_IP_VS_RR=m
	CONFIG_IP_VS_WRR=m
	CONFIG_IP_VS_LC=m
	CONFIG_IP_VS_WLC=m
	CONFIG_IP_VS_LBLC=m
	CONFIG_IP_VS_LBLCR=m
	CONFIG_IP_VS_DH=m
	CONFIG_IP_VS_SH=m
	CONFIG_IP_VS_SED=m
	CONFIG_IP_VS_NQ=m
	
	#
	# IPVS application helper
	#
	CONFIG_IP_VS_FTP=m
	CONFIG_IPV6=m
	CONFIG_IPV6_PRIVACY=y
	CONFIG_INET6_AH=m
	CONFIG_INET6_ESP=m
	CONFIG_INET6_IPCOMP=m
	CONFIG_IPV6_TUNNEL=m
	CONFIG_NETFILTER=y
	# CONFIG_NETFILTER_DEBUG is not set
	
	#
	# IP: Netfilter Configuration
	#
	CONFIG_IP_NF_CONNTRACK=m
	CONFIG_IP_NF_FTP=m
	CONFIG_IP_NF_IRC=m
	CONFIG_IP_NF_TFTP=m
	CONFIG_IP_NF_AMANDA=m
	CONFIG_IP_NF_QUEUE=m
	CONFIG_IP_NF_IPTABLES=m
	CONFIG_IP_NF_MATCH_LIMIT=m
	CONFIG_IP_NF_MATCH_IPRANGE=m
	CONFIG_IP_NF_MATCH_MAC=m
	CONFIG_IP_NF_MATCH_PKTTYPE=m
	CONFIG_IP_NF_MATCH_MARK=m
	CONFIG_IP_NF_MATCH_MULTIPORT=m
	CONFIG_IP_NF_MATCH_TOS=m
	CONFIG_IP_NF_MATCH_RECENT=m
	CONFIG_IP_NF_MATCH_ECN=m
	CONFIG_IP_NF_MATCH_DSCP=m
	CONFIG_IP_NF_MATCH_AH_ESP=m
	CONFIG_IP_NF_MATCH_LENGTH=m
	CONFIG_IP_NF_MATCH_TTL=m
	CONFIG_IP_NF_MATCH_TCPMSS=m
	CONFIG_IP_NF_MATCH_HELPER=m
	CONFIG_IP_NF_MATCH_STATE=m
	CONFIG_IP_NF_MATCH_CONNTRACK=m
	CONFIG_IP_NF_MATCH_OWNER=m
	CONFIG_IP_NF_FILTER=m
	CONFIG_IP_NF_TARGET_REJECT=m
	CONFIG_IP_NF_NAT=m
	CONFIG_IP_NF_NAT_NEEDED=y
	CONFIG_IP_NF_TARGET_MASQUERADE=m
	CONFIG_IP_NF_TARGET_REDIRECT=m
	CONFIG_IP_NF_TARGET_NETMAP=m
	CONFIG_IP_NF_TARGET_SAME=m
	CONFIG_IP_NF_NAT_LOCAL=y
	CONFIG_IP_NF_NAT_SNMP_BASIC=m
	CONFIG_IP_NF_NAT_IRC=m
	CONFIG_IP_NF_NAT_FTP=m
	CONFIG_IP_NF_NAT_TFTP=m
	CONFIG_IP_NF_NAT_AMANDA=m
	CONFIG_IP_NF_MANGLE=m
	CONFIG_IP_NF_TARGET_TOS=m
	CONFIG_IP_NF_TARGET_ECN=m
	CONFIG_IP_NF_TARGET_DSCP=m
	CONFIG_IP_NF_TARGET_MARK=m
	CONFIG_IP_NF_TARGET_CLASSIFY=m
	CONFIG_IP_NF_TARGET_LOG=m
	CONFIG_IP_NF_TARGET_ULOG=m
	CONFIG_IP_NF_TARGET_TCPMSS=m
	CONFIG_IP_NF_ARPTABLES=m
	CONFIG_IP_NF_ARPFILTER=m
	CONFIG_IP_NF_ARP_MANGLE=m
	CONFIG_IP_NF_COMPAT_IPCHAINS=m
	CONFIG_IP_NF_COMPAT_IPFWADM=m
	CONFIG_IP_NF_TARGET_NOTRACK=m
	CONFIG_IP_NF_RAW=m
	CONFIG_IP_NF_MATCH_ADDRTYPE=m
	CONFIG_IP_NF_MATCH_REALM=m
	
	#
	# IPv6: Netfilter Configuration
	#
	CONFIG_IP6_NF_QUEUE=m
	CONFIG_IP6_NF_IPTABLES=m
	CONFIG_IP6_NF_MATCH_LIMIT=m
	CONFIG_IP6_NF_MATCH_MAC=m
	CONFIG_IP6_NF_MATCH_RT=m
	CONFIG_IP6_NF_MATCH_OPTS=m
	CONFIG_IP6_NF_MATCH_FRAG=m
	CONFIG_IP6_NF_MATCH_HL=m
	CONFIG_IP6_NF_MATCH_MULTIPORT=m
	CONFIG_IP6_NF_MATCH_OWNER=m
	CONFIG_IP6_NF_MATCH_MARK=m
	CONFIG_IP6_NF_MATCH_IPV6HEADER=m
	CONFIG_IP6_NF_MATCH_AHESP=m
	CONFIG_IP6_NF_MATCH_LENGTH=m
	CONFIG_IP6_NF_MATCH_EUI64=m
	CONFIG_IP6_NF_FILTER=m
	CONFIG_IP6_NF_TARGET_LOG=m
	CONFIG_IP6_NF_MANGLE=m
	CONFIG_IP6_NF_TARGET_MARK=m
	CONFIG_IP6_NF_RAW=m
	CONFIG_XFRM=y
	# CONFIG_XFRM_USER is not set
	
	#
	# SCTP Configuration (EXPERIMENTAL)
	#
	# CONFIG_IP_SCTP is not set
	# CONFIG_ATM is not set
	# CONFIG_BRIDGE is not set
	# CONFIG_VLAN_8021Q is not set
	# CONFIG_DECNET is not set
	# CONFIG_LLC2 is not set
	# CONFIG_IPX is not set
	# CONFIG_ATALK is not set
	# CONFIG_X25 is not set
	# CONFIG_LAPB is not set
	# CONFIG_NET_DIVERT is not set
	# CONFIG_ECONET is not set
	# CONFIG_WAN_ROUTER is not set
	# CONFIG_NET_HW_FLOWCONTROL is not set
	
	#
	# QoS and/or fair queueing
	#
	CONFIG_NET_SCHED=y
	CONFIG_NET_SCH_CLK_JIFFIES=y
	# CONFIG_NET_SCH_CLK_GETTIMEOFDAY is not set
	# CONFIG_NET_SCH_CLK_CPU is not set
	CONFIG_NET_SCH_CBQ=m
	CONFIG_NET_SCH_HTB=m
	CONFIG_NET_SCH_HFSC=m
	CONFIG_NET_SCH_PRIO=m
	CONFIG_NET_SCH_RED=m
	CONFIG_NET_SCH_SFQ=m
	CONFIG_NET_SCH_TEQL=m
	CONFIG_NET_SCH_TBF=m
	CONFIG_NET_SCH_GRED=m
	CONFIG_NET_SCH_DSMARK=m
	# CONFIG_NET_SCH_NETEM is not set
	CONFIG_NET_SCH_INGRESS=m
	CONFIG_NET_QOS=y
	CONFIG_NET_ESTIMATOR=y
	CONFIG_NET_CLS=y
	CONFIG_NET_CLS_TCINDEX=m
	CONFIG_NET_CLS_ROUTE4=m
	CONFIG_NET_CLS_ROUTE=y
	CONFIG_NET_CLS_FW=m
	CONFIG_NET_CLS_U32=m
	# CONFIG_CLS_U32_PERF is not set
	# CONFIG_NET_CLS_IND is not set
	CONFIG_NET_CLS_RSVP=m
	CONFIG_NET_CLS_RSVP6=m
	# CONFIG_NET_CLS_ACT is not set
	CONFIG_NET_CLS_POLICE=y
	
	#
	# Network testing
	#
	# CONFIG_NET_PKTGEN is not set
	# CONFIG_NETPOLL is not set
	# CONFIG_NET_POLL_CONTROLLER is not set
	# CONFIG_HAMRADIO is not set
	# CONFIG_IRDA is not set
	# CONFIG_BT is not set
	CONFIG_NETDEVICES=y
	# CONFIG_DUMMY is not set
	# CONFIG_BONDING is not set
	# CONFIG_EQUALIZER is not set
	# CONFIG_TUN is not set
	# CONFIG_NET_SB1000 is not set
	
	#
	# ARCnet devices
	#
	# CONFIG_ARCNET is not set
	
	#
	# Ethernet (10 or 100Mbit)
	#
	# CONFIG_NET_ETHERNET is not set
	CONFIG_MII=m
	
	#
	# Ethernet (1000 Mbit)
	#
	# CONFIG_ACENIC is not set
	# CONFIG_DL2K is not set
	# CONFIG_E1000 is not set
	# CONFIG_NS83820 is not set
	# CONFIG_HAMACHI is not set
	# CONFIG_YELLOWFIN is not set
	# CONFIG_R8169 is not set
	# CONFIG_SK98LIN is not set
	CONFIG_TIGON3=m
	
	#
	# Ethernet (10000 Mbit)
	#
	# CONFIG_IXGB is not set
	# CONFIG_S2IO is not set
	
	#
	# Token Ring devices
	#
	# CONFIG_TR is not set
	
	#
	# Wireless LAN (non-hamradio)
	#
	CONFIG_NET_RADIO=y
	
	#
	# Obsolete Wireless cards support (pre-802.11)
	#
	# CONFIG_STRIP is not set
	# CONFIG_ARLAN is not set
	# CONFIG_WAVELAN is not set
	# CONFIG_PCMCIA_WAVELAN is not set
	# CONFIG_PCMCIA_NETWAVE is not set
	
	#
	# Wireless 802.11 Frequency Hopping cards support
	#
	# CONFIG_PCMCIA_RAYCS is not set
	
	#
	# Wireless 802.11b ISA/PCI cards support
	#
	# CONFIG_AIRO is not set
	# CONFIG_HERMES is not set
	# CONFIG_ATMEL is not set
	
	#
	# Wireless 802.11b Pcmcia/Cardbus cards support
	#
	# CONFIG_AIRO_CS is not set
	# CONFIG_PCMCIA_WL3501 is not set
	
	#
	# Prism GT/Duette 802.11(a/b/g) PCI/Cardbus support
	#
	# CONFIG_PRISM54 is not set
	CONFIG_NET_WIRELESS=y
	
	#
	# PCMCIA network device support
	#
	CONFIG_NET_PCMCIA=y
	CONFIG_PCMCIA_3C589=m
	CONFIG_PCMCIA_3C574=m
	CONFIG_PCMCIA_FMVJ18X=m
	CONFIG_PCMCIA_PCNET=m
	CONFIG_PCMCIA_NMCLAN=m
	CONFIG_PCMCIA_SMC91C92=m
	CONFIG_PCMCIA_XIRC2PS=m
	CONFIG_PCMCIA_AXNET=m
	
	#
	# Wan interfaces
	#
	# CONFIG_WAN is not set
	# CONFIG_FDDI is not set
	# CONFIG_HIPPI is not set
	# CONFIG_PLIP is not set
	CONFIG_PPP=m
	CONFIG_PPP_MULTILINK=y
	CONFIG_PPP_FILTER=y
	CONFIG_PPP_ASYNC=m
	CONFIG_PPP_SYNC_TTY=m
	CONFIG_PPP_DEFLATE=m
	CONFIG_PPP_BSDCOMP=m
	CONFIG_PPPOE=m
	# CONFIG_SLIP is not set
	# CONFIG_NET_FC is not set
	# CONFIG_SHAPER is not set
	# CONFIG_NETCONSOLE is not set
	
	#
	# ISDN subsystem
	#
	# CONFIG_ISDN is not set
	
	#
	# Telephony Support
	#
	CONFIG_PHONE=m
	CONFIG_PHONE_IXJ=m
	CONFIG_PHONE_IXJ_PCMCIA=m
	
	#
	# Input device support
	#
	CONFIG_INPUT=y
	
	#
	# Userland interfaces
	#
	CONFIG_INPUT_MOUSEDEV=y
	CONFIG_INPUT_MOUSEDEV_PSAUX=y
	CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
	CONFIG_INPUT_MOUSEDEV_SCREEN_Y=800
	# CONFIG_INPUT_JOYDEV is not set
	# CONFIG_INPUT_TSDEV is not set
	CONFIG_INPUT_EVDEV=m
	CONFIG_INPUT_EVBUG=m
	
	#
	# Input I/O drivers
	#
	# CONFIG_GAMEPORT is not set
	CONFIG_SOUND_GAMEPORT=y
	CONFIG_SERIO=y
	CONFIG_SERIO_I8042=y
	# CONFIG_SERIO_SERPORT is not set
	# CONFIG_SERIO_CT82C710 is not set
	CONFIG_SERIO_PARKBD=m
	# CONFIG_SERIO_PCIPS2 is not set
	
	#
	# Input Device Drivers
	#
	CONFIG_INPUT_KEYBOARD=y
	CONFIG_KEYBOARD_ATKBD=y
	# CONFIG_KEYBOARD_SUNKBD is not set
	# CONFIG_KEYBOARD_LKKBD is not set
	# CONFIG_KEYBOARD_XTKBD is not set
	# CONFIG_KEYBOARD_NEWTON is not set
	CONFIG_INPUT_MOUSE=y
	CONFIG_MOUSE_PS2=m
	# CONFIG_MOUSE_SERIAL is not set
	# CONFIG_MOUSE_INPORT is not set
	# CONFIG_MOUSE_LOGIBM is not set
	# CONFIG_MOUSE_PC110PAD is not set
	# CONFIG_MOUSE_VSXXXAA is not set
	# CONFIG_INPUT_JOYSTICK is not set
	# CONFIG_INPUT_TOUCHSCREEN is not set
	# CONFIG_INPUT_MISC is not set
	
	#
	# Character devices
	#
	CONFIG_VT=y
	CONFIG_VT_CONSOLE=y
	CONFIG_HW_CONSOLE=y
	# CONFIG_SERIAL_NONSTANDARD is not set
	
	#
	# Serial drivers
	#
	CONFIG_SERIAL_8250=m
	CONFIG_SERIAL_8250_CS=m
	# CONFIG_SERIAL_8250_ACPI is not set
	CONFIG_SERIAL_8250_NR_UARTS=4
	# CONFIG_SERIAL_8250_EXTENDED is not set
	
	#
	# Non-8250 serial port support
	#
	CONFIG_SERIAL_CORE=m
	CONFIG_UNIX98_PTYS=y
	# CONFIG_LEGACY_PTYS is not set
	CONFIG_PRINTER=m
	# CONFIG_LP_CONSOLE is not set
	# CONFIG_PPDEV is not set
	# CONFIG_TIPAR is not set
	# CONFIG_QIC02_TAPE is not set
	
	#
	# IPMI
	#
	# CONFIG_IPMI_HANDLER is not set
	
	#
	# Watchdog Cards
	#
	CONFIG_WATCHDOG=y
	# CONFIG_WATCHDOG_NOWAYOUT is not set
	
	#
	# Watchdog Device Drivers
	#
	CONFIG_SOFT_WATCHDOG=m
	CONFIG_ACQUIRE_WDT=m
	CONFIG_ADVANTECH_WDT=m
	CONFIG_ALIM1535_WDT=m
	CONFIG_ALIM7101_WDT=m
	CONFIG_SC520_WDT=m
	CONFIG_EUROTECH_WDT=m
	CONFIG_IB700_WDT=m
	CONFIG_WAFER_WDT=m
	CONFIG_I8XX_TCO=m
	CONFIG_SC1200_WDT=m
	CONFIG_SCx200_WDT=m
	CONFIG_60XX_WDT=m
	CONFIG_CPU5_WDT=m
	CONFIG_W83627HF_WDT=m
	CONFIG_W83877F_WDT=m
	CONFIG_MACHZ_WDT=m
	
	#
	# ISA-based Watchdog Cards
	#
	CONFIG_PCWATCHDOG=m
	CONFIG_MIXCOMWD=m
	CONFIG_WDT=m
	CONFIG_WDT_501=y
	
	#
	# PCI-based Watchdog Cards
	#
	CONFIG_PCIPCWATCHDOG=m
	CONFIG_WDTPCI=m
	CONFIG_WDT_501_PCI=y
	
	#
	# USB-based Watchdog Cards
	#
	CONFIG_USBPCWATCHDOG=m
	CONFIG_HW_RANDOM=m
	CONFIG_NVRAM=m
	CONFIG_RTC=m
	CONFIG_GEN_RTC=m
	CONFIG_GEN_RTC_X=y
	# CONFIG_DTLK is not set
	# CONFIG_R3964 is not set
	# CONFIG_APPLICOM is not set
	# CONFIG_SONYPI is not set
	
	#
	# Ftape, the floppy tape device driver
	#
	# CONFIG_FTAPE is not set
	CONFIG_AGP=y
	# CONFIG_AGP_ALI is not set
	# CONFIG_AGP_ATI is not set
	# CONFIG_AGP_AMD is not set
	# CONFIG_AGP_AMD64 is not set
	# CONFIG_AGP_INTEL is not set
	# CONFIG_AGP_INTEL_MCH is not set
	# CONFIG_AGP_NVIDIA is not set
	# CONFIG_AGP_SIS is not set
	# CONFIG_AGP_SWORKS is not set
	# CONFIG_AGP_VIA is not set
	# CONFIG_AGP_EFFICEON is not set
	CONFIG_DRM=y
	# CONFIG_DRM_TDFX is not set
	# CONFIG_DRM_GAMMA is not set
	# CONFIG_DRM_R128 is not set
	CONFIG_DRM_RADEON=y
	# CONFIG_DRM_MGA is not set
	# CONFIG_DRM_SIS is not set
	
	#
	# PCMCIA character devices
	#
	# CONFIG_SYNCLINK_CS is not set
	# CONFIG_MWAVE is not set
	# CONFIG_RAW_DRIVER is not set
	# CONFIG_HPET is not set
	# CONFIG_HANGCHECK_TIMER is not set
	
	#
	# I2C support
	#
	CONFIG_I2C=m
	CONFIG_I2C_CHARDEV=m
	
	#
	# I2C Algorithms
	#
	CONFIG_I2C_ALGOBIT=m
	CONFIG_I2C_ALGOPCF=m
	
	#
	# I2C Hardware Bus support
	#
	CONFIG_I2C_ALI1535=m
	CONFIG_I2C_ALI1563=m
	CONFIG_I2C_ALI15X3=m
	CONFIG_I2C_AMD756=m
	CONFIG_I2C_AMD8111=m
	CONFIG_I2C_ELEKTOR=m
	CONFIG_I2C_I801=m
	CONFIG_I2C_I810=m
	CONFIG_I2C_ISA=m
	CONFIG_I2C_NFORCE2=m
	CONFIG_I2C_PARPORT=m
	CONFIG_I2C_PARPORT_LIGHT=m
	CONFIG_I2C_PIIX4=m
	CONFIG_I2C_PROSAVAGE=m
	CONFIG_I2C_SAVAGE4=m
	CONFIG_SCx200_ACB=m
	CONFIG_I2C_SIS5595=m
	CONFIG_I2C_SIS630=m
	CONFIG_I2C_SIS96X=m
	CONFIG_I2C_VIA=m
	CONFIG_I2C_VIAPRO=m
	CONFIG_I2C_VOODOO3=m
	
	#
	# Hardware Sensors Chip support
	#
	CONFIG_I2C_SENSOR=m
	CONFIG_SENSORS_ADM1021=m
	# CONFIG_SENSORS_ADM1025 is not set
	# CONFIG_SENSORS_ADM1031 is not set
	CONFIG_SENSORS_ASB100=m
	CONFIG_SENSORS_DS1621=m
	CONFIG_SENSORS_FSCHER=m
	CONFIG_SENSORS_GL518SM=m
	CONFIG_SENSORS_IT87=m
	CONFIG_SENSORS_LM75=m
	# CONFIG_SENSORS_LM77 is not set
	CONFIG_SENSORS_LM78=m
	CONFIG_SENSORS_LM80=m
	CONFIG_SENSORS_LM83=m
	CONFIG_SENSORS_LM85=m
	CONFIG_SENSORS_LM90=m
	CONFIG_SENSORS_MAX1619=m
	CONFIG_SENSORS_VIA686A=m
	CONFIG_SENSORS_W83781D=m
	CONFIG_SENSORS_W83L785TS=m
	CONFIG_SENSORS_W83627HF=m
	
	#
	# Other I2C Chip support
	#
	CONFIG_SENSORS_EEPROM=m
	CONFIG_SENSORS_PCF8574=m
	CONFIG_SENSORS_PCF8591=m
	CONFIG_SENSORS_RTC8564=m
	# CONFIG_I2C_DEBUG_CORE is not set
	# CONFIG_I2C_DEBUG_ALGO is not set
	# CONFIG_I2C_DEBUG_BUS is not set
	# CONFIG_I2C_DEBUG_CHIP is not set
	
	#
	# Dallas's 1-wire bus
	#
	# CONFIG_W1 is not set
	
	#
	# Misc devices
	#
	# CONFIG_IBM_ASM is not set
	
	#
	# Multimedia devices
	#
	CONFIG_VIDEO_DEV=m
	
	#
	# Video For Linux
	#
	
	#
	# Video Adapters
	#
	# CONFIG_VIDEO_BT848 is not set
	# CONFIG_VIDEO_PMS is not set
	# CONFIG_VIDEO_BWQCAM is not set
	# CONFIG_VIDEO_CQCAM is not set
	# CONFIG_VIDEO_CPIA is not set
	# CONFIG_VIDEO_SAA5246A is not set
	# CONFIG_VIDEO_SAA5249 is not set
	# CONFIG_TUNER_3036 is not set
	# CONFIG_VIDEO_STRADIS is not set
	# CONFIG_VIDEO_ZORAN is not set
	# CONFIG_VIDEO_SAA7134 is not set
	# CONFIG_VIDEO_MXB is not set
	# CONFIG_VIDEO_DPC is not set
	# CONFIG_VIDEO_HEXIUM_ORION is not set
	# CONFIG_VIDEO_HEXIUM_GEMINI is not set
	# CONFIG_VIDEO_CX88 is not set
	# CONFIG_VIDEO_OVCAMCHIP is not set
	
	#
	# Radio Adapters
	#
	# CONFIG_RADIO_CADET is not set
	# CONFIG_RADIO_RTRACK is not set
	# CONFIG_RADIO_RTRACK2 is not set
	# CONFIG_RADIO_AZTECH is not set
	# CONFIG_RADIO_GEMTEK is not set
	# CONFIG_RADIO_GEMTEK_PCI is not set
	# CONFIG_RADIO_MAXIRADIO is not set
	# CONFIG_RADIO_MAESTRO is not set
	# CONFIG_RADIO_SF16FMI is not set
	# CONFIG_RADIO_SF16FMR2 is not set
	# CONFIG_RADIO_TERRATEC is not set
	# CONFIG_RADIO_TRUST is not set
	# CONFIG_RADIO_TYPHOON is not set
	# CONFIG_RADIO_ZOLTRIX is not set
	
	#
	# Digital Video Broadcasting Devices
	#
	# CONFIG_DVB is not set
	
	#
	# Graphics support
	#
	# CONFIG_FB is not set
	CONFIG_VIDEO_SELECT=y
	
	#
	# Console display driver support
	#
	CONFIG_VGA_CONSOLE=y
	# CONFIG_MDA_CONSOLE is not set
	CONFIG_DUMMY_CONSOLE=y
	
	#
	# Sound
	#
	CONFIG_SOUND=y
	
	#
	# Advanced Linux Sound Architecture
	#
	CONFIG_SND=m
	CONFIG_SND_TIMER=m
	CONFIG_SND_PCM=m
	CONFIG_SND_RAWMIDI=m
	CONFIG_SND_SEQUENCER=m
	CONFIG_SND_SEQ_DUMMY=m
	CONFIG_SND_OSSEMUL=y
	CONFIG_SND_MIXER_OSS=m
	CONFIG_SND_PCM_OSS=m
	CONFIG_SND_SEQUENCER_OSS=y
	CONFIG_SND_RTCTIMER=m
	# CONFIG_SND_VERBOSE_PRINTK is not set
	# CONFIG_SND_DEBUG is not set
	
	#
	# Generic devices
	#
	CONFIG_SND_MPU401_UART=m
	CONFIG_SND_DUMMY=m
	CONFIG_SND_VIRMIDI=m
	CONFIG_SND_MTPAV=m
	CONFIG_SND_SERIAL_U16550=m
	CONFIG_SND_MPU401=m
	
	#
	# ISA devices
	#
	# CONFIG_SND_AD1816A is not set
	# CONFIG_SND_AD1848 is not set
	# CONFIG_SND_CS4231 is not set
	# CONFIG_SND_CS4232 is not set
	# CONFIG_SND_CS4236 is not set
	# CONFIG_SND_ES968 is not set
	# CONFIG_SND_ES1688 is not set
	# CONFIG_SND_ES18XX is not set
	# CONFIG_SND_GUSCLASSIC is not set
	# CONFIG_SND_GUSEXTREME is not set
	# CONFIG_SND_GUSMAX is not set
	# CONFIG_SND_INTERWAVE is not set
	# CONFIG_SND_INTERWAVE_STB is not set
	# CONFIG_SND_OPTI92X_AD1848 is not set
	# CONFIG_SND_OPTI92X_CS4231 is not set
	# CONFIG_SND_OPTI93X is not set
	# CONFIG_SND_SB8 is not set
	# CONFIG_SND_SB16 is not set
	# CONFIG_SND_SBAWE is not set
	# CONFIG_SND_WAVEFRONT is not set
	# CONFIG_SND_ALS100 is not set
	# CONFIG_SND_AZT2320 is not set
	# CONFIG_SND_CMI8330 is not set
	# CONFIG_SND_DT019X is not set
	# CONFIG_SND_OPL3SA2 is not set
	# CONFIG_SND_SGALAXY is not set
	# CONFIG_SND_SSCAPE is not set
	
	#
	# PCI devices
	#
	CONFIG_SND_AC97_CODEC=m
	# CONFIG_SND_ALI5451 is not set
	# CONFIG_SND_ATIIXP is not set
	# CONFIG_SND_AU8810 is not set
	# CONFIG_SND_AU8820 is not set
	# CONFIG_SND_AU8830 is not set
	# CONFIG_SND_AZT3328 is not set
	# CONFIG_SND_BT87X is not set
	# CONFIG_SND_CS46XX is not set
	# CONFIG_SND_CS4281 is not set
	# CONFIG_SND_EMU10K1 is not set
	# CONFIG_SND_KORG1212 is not set
	# CONFIG_SND_MIXART is not set
	# CONFIG_SND_NM256 is not set
	# CONFIG_SND_RME32 is not set
	# CONFIG_SND_RME96 is not set
	# CONFIG_SND_RME9652 is not set
	# CONFIG_SND_HDSP is not set
	# CONFIG_SND_TRIDENT is not set
	# CONFIG_SND_YMFPCI is not set
	# CONFIG_SND_ALS4000 is not set
	# CONFIG_SND_CMIPCI is not set
	# CONFIG_SND_ENS1370 is not set
	# CONFIG_SND_ENS1371 is not set
	# CONFIG_SND_ES1938 is not set
	# CONFIG_SND_ES1968 is not set
	# CONFIG_SND_MAESTRO3 is not set
	# CONFIG_SND_FM801 is not set
	# CONFIG_SND_ICE1712 is not set
	# CONFIG_SND_ICE1724 is not set
	CONFIG_SND_INTEL8X0=m
	# CONFIG_SND_INTEL8X0M is not set
	# CONFIG_SND_SONICVIBES is not set
	# CONFIG_SND_VIA82XX is not set
	# CONFIG_SND_VX222 is not set
	
	#
	# ALSA USB devices
	#
	# CONFIG_SND_USB_AUDIO is not set
	
	#
	# PCMCIA devices
	#
	# CONFIG_SND_VXPOCKET is not set
	# CONFIG_SND_VXP440 is not set
	# CONFIG_SND_PDAUDIOCF is not set
	
	#
	# Open Sound System
	#
	# CONFIG_SOUND_PRIME is not set
	
	#
	# USB support
	#
	CONFIG_USB=m
	CONFIG_USB_DEBUG=y
	
	#
	# Miscellaneous USB options
	#
	CONFIG_USB_DEVICEFS=y
	CONFIG_USB_BANDWIDTH=y
	# CONFIG_USB_DYNAMIC_MINORS is not set
	
	#
	# USB Host Controller Drivers
	#
	CONFIG_USB_EHCI_HCD=m
	CONFIG_USB_EHCI_SPLIT_ISO=y
	CONFIG_USB_EHCI_ROOT_HUB_TT=y
	CONFIG_USB_OHCI_HCD=m
	CONFIG_USB_UHCI_HCD=m
	
	#
	# USB Device Class drivers
	#
	CONFIG_USB_AUDIO=m
	# CONFIG_USB_BLUETOOTH_TTY is not set
	# CONFIG_USB_MIDI is not set
	CONFIG_USB_ACM=m
	CONFIG_USB_PRINTER=m
	CONFIG_USB_STORAGE=m
	CONFIG_USB_STORAGE_DEBUG=y
	CONFIG_USB_STORAGE_RW_DETECT=y
	# CONFIG_USB_STORAGE_DATAFAB is not set
	# CONFIG_USB_STORAGE_FREECOM is not set
	# CONFIG_USB_STORAGE_ISD200 is not set
	# CONFIG_USB_STORAGE_DPCM is not set
	# CONFIG_USB_STORAGE_HP8200e is not set
	# CONFIG_USB_STORAGE_SDDR09 is not set
	# CONFIG_USB_STORAGE_SDDR55 is not set
	# CONFIG_USB_STORAGE_JUMPSHOT is not set
	
	#
	# USB Human Interface Devices (HID)
	#
	CONFIG_USB_HID=m
	CONFIG_USB_HIDINPUT=y
	# CONFIG_HID_FF is not set
	# CONFIG_USB_HIDDEV is not set
	
	#
	# USB HID Boot Protocol drivers
	#
	# CONFIG_USB_KBD is not set
	# CONFIG_USB_MOUSE is not set
	# CONFIG_USB_AIPTEK is not set
	# CONFIG_USB_WACOM is not set
	# CONFIG_USB_KBTAB is not set
	# CONFIG_USB_POWERMATE is not set
	# CONFIG_USB_MTOUCH is not set
	# CONFIG_USB_EGALAX is not set
	# CONFIG_USB_XPAD is not set
	# CONFIG_USB_ATI_REMOTE is not set
	
	#
	# USB Imaging devices
	#
	# CONFIG_USB_MDC800 is not set
	# CONFIG_USB_MICROTEK is not set
	# CONFIG_USB_HPUSBSCSI is not set
	
	#
	# USB Multimedia devices
	#
	# CONFIG_USB_DABUSB is not set
	# CONFIG_USB_VICAM is not set
	# CONFIG_USB_DSBR is not set
	# CONFIG_USB_IBMCAM is not set
	# CONFIG_USB_KONICAWC is not set
	# CONFIG_USB_OV511 is not set
	# CONFIG_USB_PWC is not set
	# CONFIG_USB_SE401 is not set
	# CONFIG_USB_SN9C102 is not set
	# CONFIG_USB_STV680 is not set
	
	#
	# USB Network adaptors
	#
	# CONFIG_USB_CATC is not set
	# CONFIG_USB_KAWETH is not set
	# CONFIG_USB_PEGASUS is not set
	# CONFIG_USB_RTL8150 is not set
	# CONFIG_USB_USBNET is not set
	
	#
	# USB port drivers
	#
	# CONFIG_USB_USS720 is not set
	
	#
	# USB Serial Converter support
	#
	# CONFIG_USB_SERIAL is not set
	
	#
	# USB Miscellaneous drivers
	#
	# CONFIG_USB_EMI62 is not set
	# CONFIG_USB_EMI26 is not set
	# CONFIG_USB_TIGL is not set
	# CONFIG_USB_AUERSWALD is not set
	# CONFIG_USB_RIO500 is not set
	# CONFIG_USB_LEGOTOWER is not set
	# CONFIG_USB_LCD is not set
	# CONFIG_USB_LED is not set
	# CONFIG_USB_CYTHERM is not set
	# CONFIG_USB_PHIDGETSERVO is not set
	# CONFIG_USB_TEST is not set
	
	#
	# USB Gadget Support
	#
	# CONFIG_USB_GADGET is not set
	
	#
	# File systems
	#
	CONFIG_EXT2_FS=m
	CONFIG_EXT2_FS_XATTR=y
	CONFIG_EXT2_FS_POSIX_ACL=y
	CONFIG_EXT2_FS_SECURITY=y
	CONFIG_EXT3_FS=y
	CONFIG_EXT3_FS_XATTR=y
	CONFIG_EXT3_FS_POSIX_ACL=y
	CONFIG_EXT3_FS_SECURITY=y
	CONFIG_JBD=y
	CONFIG_JBD_DEBUG=y
	CONFIG_FS_MBCACHE=y
	# CONFIG_REISERFS_FS is not set
	# CONFIG_JFS_FS is not set
	CONFIG_FS_POSIX_ACL=y
	# CONFIG_XFS_FS is not set
	# CONFIG_MINIX_FS is not set
	# CONFIG_ROMFS_FS is not set
	# CONFIG_QUOTA is not set
	# CONFIG_AUTOFS_FS is not set
	# CONFIG_AUTOFS4_FS is not set
	
	#
	# CD-ROM/DVD Filesystems
	#
	CONFIG_ISO9660_FS=m
	CONFIG_JOLIET=y
	CONFIG_ZISOFS=y
	CONFIG_ZISOFS_FS=m
	CONFIG_UDF_FS=m
	CONFIG_UDF_NLS=y
	
	#
	# DOS/FAT/NT Filesystems
	#
	CONFIG_FAT_FS=m
	CONFIG_MSDOS_FS=m
	CONFIG_VFAT_FS=m
	CONFIG_FAT_DEFAULT_CODEPAGE=437
	CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
	CONFIG_NTFS_FS=m
	CONFIG_NTFS_DEBUG=y
	CONFIG_NTFS_RW=y
	
	#
	# Pseudo filesystems
	#
	CONFIG_PROC_FS=y
	CONFIG_PROC_KCORE=y
	CONFIG_SYSFS=y
	# CONFIG_DEVFS_FS is not set
	CONFIG_DEVPTS_FS_XATTR=y
	CONFIG_DEVPTS_FS_SECURITY=y
	# CONFIG_TMPFS is not set
	# CONFIG_HUGETLBFS is not set
	# CONFIG_HUGETLB_PAGE is not set
	CONFIG_RAMFS=y
	
	#
	# Miscellaneous filesystems
	#
	# CONFIG_ADFS_FS is not set
	# CONFIG_AFFS_FS is not set
	# CONFIG_HFS_FS is not set
	# CONFIG_HFSPLUS_FS is not set
	# CONFIG_BEFS_FS is not set
	# CONFIG_BFS_FS is not set
	# CONFIG_EFS_FS is not set
	# CONFIG_CRAMFS is not set
	# CONFIG_VXFS_FS is not set
	# CONFIG_HPFS_FS is not set
	# CONFIG_QNX4FS_FS is not set
	# CONFIG_SYSV_FS is not set
	# CONFIG_UFS_FS is not set
	
	#
	# Network File Systems
	#
	CONFIG_NFS_FS=y
	CONFIG_NFS_V3=y
	CONFIG_NFS_V4=y
	CONFIG_NFS_DIRECTIO=y
	CONFIG_NFSD=y
	CONFIG_NFSD_V3=y
	CONFIG_NFSD_V4=y
	CONFIG_NFSD_TCP=y
	CONFIG_LOCKD=y
	CONFIG_LOCKD_V4=y
	CONFIG_EXPORTFS=y
	CONFIG_SUNRPC=y
	CONFIG_SUNRPC_GSS=y
	CONFIG_RPCSEC_GSS_KRB5=y
	CONFIG_SMB_FS=m
	# CONFIG_SMB_NLS_DEFAULT is not set
	CONFIG_CIFS=m
	# CONFIG_CIFS_STATS is not set
	# CONFIG_CIFS_XATTR is not set
	# CONFIG_CIFS_POSIX is not set
	# CONFIG_NCP_FS is not set
	# CONFIG_CODA_FS is not set
	# CONFIG_AFS_FS is not set
	
	#
	# Partition Types
	#
	# CONFIG_PARTITION_ADVANCED is not set
	CONFIG_MSDOS_PARTITION=y
	
	#
	# Native Language Support
	#
	CONFIG_NLS=y
	CONFIG_NLS_DEFAULT="cp437"
	CONFIG_NLS_CODEPAGE_437=m
	CONFIG_NLS_CODEPAGE_737=m
	CONFIG_NLS_CODEPAGE_775=m
	CONFIG_NLS_CODEPAGE_850=m
	CONFIG_NLS_CODEPAGE_852=m
	CONFIG_NLS_CODEPAGE_855=m
	CONFIG_NLS_CODEPAGE_857=m
	CONFIG_NLS_CODEPAGE_860=m
	CONFIG_NLS_CODEPAGE_861=m
	CONFIG_NLS_CODEPAGE_862=m
	CONFIG_NLS_CODEPAGE_863=m
	CONFIG_NLS_CODEPAGE_864=m
	CONFIG_NLS_CODEPAGE_865=m
	CONFIG_NLS_CODEPAGE_866=m
	CONFIG_NLS_CODEPAGE_869=m
	CONFIG_NLS_CODEPAGE_936=m
	CONFIG_NLS_CODEPAGE_950=m
	CONFIG_NLS_CODEPAGE_932=m
	CONFIG_NLS_CODEPAGE_949=m
	CONFIG_NLS_CODEPAGE_874=m
	CONFIG_NLS_ISO8859_8=m
	CONFIG_NLS_CODEPAGE_1250=m
	CONFIG_NLS_CODEPAGE_1251=m
	# CONFIG_NLS_ASCII is not set
	CONFIG_NLS_ISO8859_1=m
	CONFIG_NLS_ISO8859_2=m
	CONFIG_NLS_ISO8859_3=m
	CONFIG_NLS_ISO8859_4=m
	CONFIG_NLS_ISO8859_5=m
	CONFIG_NLS_ISO8859_6=m
	CONFIG_NLS_ISO8859_7=m
	CONFIG_NLS_ISO8859_9=m
	CONFIG_NLS_ISO8859_13=m
	CONFIG_NLS_ISO8859_14=m
	CONFIG_NLS_ISO8859_15=m
	CONFIG_NLS_KOI8_R=m
	CONFIG_NLS_KOI8_U=m
	CONFIG_NLS_UTF8=m
	
	#
	# Profiling support
	#
	# CONFIG_PROFILING is not set
	
	#
	# Kernel hacking
	#
	# CONFIG_DEBUG_KERNEL is not set
	CONFIG_EARLY_PRINTK=y
	CONFIG_DEBUG_SPINLOCK_SLEEP=y
	# CONFIG_FRAME_POINTER is not set
	CONFIG_4KSTACKS=y
	CONFIG_X86_FIND_SMP_CONFIG=y
	CONFIG_X86_MPPARSE=y
	
	#
	# Security options
	#
	CONFIG_SECURITY=y
	# CONFIG_SECURITY_NETWORK is not set
	CONFIG_SECURITY_CAPABILITIES=m
	CONFIG_SECURITY_ROOTPLUG=m
	# CONFIG_SECURITY_SELINUX is not set
	
	#
	# Cryptographic options
	#
	CONFIG_CRYPTO=y
	CONFIG_CRYPTO_HMAC=y
	CONFIG_CRYPTO_NULL=m
	CONFIG_CRYPTO_MD4=m
	CONFIG_CRYPTO_MD5=y
	CONFIG_CRYPTO_SHA1=m
	CONFIG_CRYPTO_SHA256=m
	CONFIG_CRYPTO_SHA512=m
	CONFIG_CRYPTO_DES=y
	CONFIG_CRYPTO_BLOWFISH=m
	CONFIG_CRYPTO_TWOFISH=m
	CONFIG_CRYPTO_SERPENT=m
	# CONFIG_CRYPTO_AES_586 is not set
	CONFIG_CRYPTO_CAST5=m
	CONFIG_CRYPTO_CAST6=m
	CONFIG_CRYPTO_TEA=m
	CONFIG_CRYPTO_ARC4=m
	CONFIG_CRYPTO_KHAZAD=m
	CONFIG_CRYPTO_DEFLATE=m
	CONFIG_CRYPTO_MICHAEL_MIC=m
	CONFIG_CRYPTO_CRC32C=m
	CONFIG_CRYPTO_TEST=m
	
	#
	# Library routines
	#
	CONFIG_CRC_CCITT=m
	CONFIG_CRC32=m
	CONFIG_LIBCRC32C=m
	CONFIG_ZLIB_INFLATE=m
	CONFIG_ZLIB_DEFLATE=m
	CONFIG_X86_BIOS_REBOOT=y
	CONFIG_PC=y


------------------------------------------------------------------------
This is an automatically created summary.
The command is "sysinfo.sh".
Written by Karsten M. Self <kmself@ix.netcom.com>, (c) 2002.

This program may be freely distributed and modified, with attribution
and the following disclaimer.
This program comes with NO WARRANTY and NO LIABILITY FOR DAMAGES.

Revision information:
    Author: karsten
    Version: 1.7
    Last revised: 2002/04/05 20:10:44

--Boundary-00=_VXVVBq8Ey+Tkhlh--
