Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261152AbUJaP06@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261152AbUJaP06 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Oct 2004 10:26:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261169AbUJaP06
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Oct 2004 10:26:58 -0500
Received: from mail.gmx.de ([213.165.64.20]:10929 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261152AbUJaP0j convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Oct 2004 10:26:39 -0500
X-Authenticated: #12899180
Date: Sun, 31 Oct 2004 16:26:28 +0100
From: Stefan Schilling <mail.suse@gmx.de>
X-Mailer: The Bat! (v1.53d)
Reply-To: Stefan Schilling <mail.suse@gmx.de>
X-Priority: 3 (Normal)
Message-ID: <729414246.20041031162628@gmx.de>
To: linux-kernel@vger.kernel.org
Subject: vanilla-2.6.9: Problems with oom-killer again
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

Last night, several applications have been killed by the kernel,
something I´m now having for the first time.
I know, this problem has been discussed before, but I couldnt find an
answer, yet. Sorry for asking the same, again.
I can give you the following information, if you anything else,
please contact me, I´ll deliver soon.

System configuration:

MSI K7 Pro
164 MB RAM (3 sticks from different firms)
Athlon 650 Mhz CPU
2 swap partitions: /dev/hda5 with approx. 200MB
                   /dev/hde1 with approx. 250MB
vanilla-2.6.9 (configuration can be obtained from me on a request)

now real load on the system at this time, only a virusscan running.
Those problems didnt occur on a vanilla-2.6.7


The following was written into the .log:

root@linux:/var/log > less messages
Oct 31 05:51:48 linux antivir[4523]: AntiVir WARNING: /exports/mp3/mldonkey/temp/6C6AABC2AB6E08188EE42DC5CF4E7D46 not
complet
Oct 31 05:55:52 linux kernel: oom-killer: gfp_mask=0xd2
Oct 31 05:56:22 linux kernel: DMA per-cpu:
Oct 31 05:56:22 linux kernel: cpu 0 hot: low 2, high 6, batch 1
Oct 31 05:56:22 linux kernel: cpu 0 cold: low 0, high 2, batch 1
Oct 31 05:56:22 linux kernel: Normal per-cpu:
Oct 31 05:56:22 linux kernel: cpu 0 hot: low 16, high 48, batch 8
Oct 31 05:56:22 linux kernel: cpu 0 cold: low 0, high 16, batch 8
Oct 31 05:56:22 linux kernel: HighMem per-cpu: empty
Oct 31 05:56:22 linux kernel:
Oct 31 05:56:22 linux kernel: Free pages:         536kB (0kB HighMem)
Oct 31 05:56:22 linux kernel: Active:34523 inactive:801 dirty:13 writeback:1 unstable:0 free:134 slab:2467 mapped:34283
paget
Oct 31 05:56:22 linux kernel: DMA free:80kB min:40kB low:80kB high:120kB active:10648kB inactive:164kB present:16384kB
Oct 31 05:56:22 linux kernel: protections[]: 0 0 0
Oct 31 05:56:24 linux kernel: Normal free:456kB min:360kB low:720kB high:1080kB active:127444kB inactive:3040kB
present:14739
Oct 31 05:56:24 linux kernel: protections[]: 0 0 0
Oct 31 05:56:24 linux kernel: HighMem free:0kB min:128kB low:256kB high:384kB active:0kB inactive:0kB present:0kB
Oct 31 05:56:24 linux kernel: protections[]: 0 0 0
Oct 31 05:56:24 linux kernel: DMA: 8*4kB 2*8kB 0*16kB 1*32kB 0*64kB 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB =
80kB
Oct 31 05:56:24 linux kernel: Normal: 4*4kB 11*8kB 0*16kB 1*32kB 1*64kB 0*128kB 1*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB =
Oct 31 05:56:24 linux kernel: HighMem: empty
Oct 31 05:56:24 linux kernel: Swap cache: add 620095, delete 605069, find 148168/211121, race 2+8
Oct 31 05:56:24 linux kernel: Out of Memory: Killed process 4846 (mysqld).
Oct 31 05:56:24 linux kernel: Out of Memory: Killed process 4848 (mysqld).
Oct 31 05:56:24 linux kernel: Out of Memory: Killed process 4849 (mysqld).
Oct 31 05:56:24 linux kernel: Out of Memory: Killed process 4850 (mysqld).
Oct 31 05:56:24 linux kernel: Out of Memory: Killed process 4851 (mysqld).
Oct 31 05:56:24 linux kernel: Out of Memory: Killed process 4852 (mysqld).
Oct 31 05:56:24 linux kernel: Out of Memory: Killed process 4853 (mysqld).
Oct 31 05:56:24 linux kernel: Out of Memory: Killed process 4854 (mysqld).
Oct 31 05:56:24 linux kernel: Out of Memory: Killed process 4855 (mysqld).
Oct 31 05:56:24 linux kernel: Out of Memory: Killed process 4856 (mysqld).
Oct 31 05:56:24 linux kernel: oom-killer: gfp_mask=0xd2
Oct 31 05:56:24 linux kernel: DMA per-cpu:
Oct 31 05:56:24 linux kernel: cpu 0 hot: low 2, high 6, batch 1
Oct 31 05:56:24 linux kernel: cpu 0 cold: low 0, high 2, batch 1
Oct 31 05:56:24 linux kernel: Normal per-cpu:
Oct 31 05:56:25 linux kernel: cpu 0 hot: low 16, high 48, batch 8
Oct 31 05:56:25 linux kernel: cpu 0 cold: low 0, high 16, batch 8
Oct 31 05:56:25 linux kernel: HighMem per-cpu: empty
Oct 31 05:56:25 linux kernel:
Oct 31 05:56:25 linux kernel: Free pages:         760kB (0kB HighMem)
Oct 31 05:56:25 linux kernel: Active:27579 inactive:7647 dirty:0 writeback:0 unstable:0 free:190 slab:2464 mapped:34239
paget
Oct 31 05:56:25 linux kernel: DMA free:80kB min:40kB low:80kB high:120kB active:8136kB inactive:2696kB present:16384kB
Oct 31 05:56:25 linux kernel: protections[]: 0 0 0
Oct 31 05:56:25 linux kernel: Normal free:680kB min:360kB low:720kB high:1080kB active:102180kB inactive:27892kB
present:1473
Oct 31 05:56:25 linux kernel: protections[]: 0 0 0
Oct 31 05:56:25 linux kernel: HighMem free:0kB min:128kB low:256kB high:384kB active:0kB inactive:0kB present:0kB
Oct 31 05:56:25 linux kernel: protections[]: 0 0 0
Oct 31 05:56:25 linux kernel: DMA: 8*4kB 2*8kB 0*16kB 1*32kB 0*64kB 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB =
80kB
Oct 31 05:56:25 linux kernel: Normal: 58*4kB 12*8kB 0*16kB 1*32kB 1*64kB 0*128kB 1*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB
Oct 31 05:56:25 linux kernel: HighMem: empty
Oct 31 05:56:25 linux kernel: Swap cache: add 623595, delete 608251, find 148695/212212, race 2+8
Oct 31 05:56:25 linux kernel: Out of Memory: Killed process 4523 (antivir).
Oct 31 05:56:25 linux kernel: oom-killer: gfp_mask=0x1d2
Oct 31 05:56:25 linux kernel: DMA per-cpu:
Oct 31 05:56:25 linux kernel: cpu 0 hot: low 2, high 6, batch 1
Oct 31 05:56:25 linux kernel: cpu 0 cold: low 0, high 2, batch 1
Oct 31 05:56:25 linux kernel: Normal per-cpu:
Oct 31 05:56:25 linux kernel: cpu 0 hot: low 16, high 48, batch 8
Oct 31 05:56:25 linux kernel: cpu 0 cold: low 0, high 16, batch 8
Oct 31 05:56:25 linux kernel: HighMem per-cpu: empty
Oct 31 05:56:25 linux kernel:
Oct 31 05:56:25 linux kernel: Free pages:         656kB (0kB HighMem)
Oct 31 05:56:25 linux kernel: Active:35091 inactive:20 dirty:0 writeback:0 unstable:0 free:164 slab:2462 mapped:34329
pagetab
Oct 31 05:56:25 linux kernel: DMA free:40kB min:40kB low:80kB high:120kB active:10572kB inactive:68kB present:16384kB
Oct 31 05:56:25 linux kernel: protections[]: 0 0 0
Oct 31 05:56:25 linux kernel: Normal free:616kB min:360kB low:720kB high:1080kB active:129792kB inactive:12kB
present:147392k
Oct 31 05:56:25 linux kernel: protections[]: 0 0 0
Oct 31 05:56:25 linux kernel: HighMem free:0kB min:128kB low:256kB high:384kB active:0kB inactive:0kB present:0kB
Oct 31 05:56:25 linux kernel: protections[]: 0 0 0
Oct 31 05:56:25 linux kernel: DMA: 0*4kB 1*8kB 0*16kB 1*32kB 0*64kB 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB =
40kB
Oct 31 05:56:25 linux kernel: Normal: 70*4kB 8*8kB 1*16kB 2*32kB 1*64kB 1*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB =
Oct 31 05:56:25 linux kernel: HighMem: empty
Oct 31 05:56:25 linux kernel: Swap cache: add 625072, delete 609586, find 148887/212674, race 2+8
Oct 31 05:56:25 linux kernel: Out of Memory: Killed process 3044 (nscd).
Oct 31 05:56:25 linux kernel: Out of Memory: Killed process 3046 (nscd).
Oct 31 05:56:25 linux kernel: Out of Memory: Killed process 3047 (nscd).
Oct 31 05:56:25 linux kernel: Out of Memory: Killed process 3048 (nscd).
Oct 31 05:56:25 linux kernel: Out of Memory: Killed process 3049 (nscd).
Oct 31 05:56:25 linux kernel: Out of Memory: Killed process 3050 (nscd).
Oct 31 05:56:25 linux kernel: Out of Memory: Killed process 3051 (nscd).
Oct 31 05:56:25 linux kernel: oom-killer: gfp_mask=0x1d2
Oct 31 05:56:25 linux kernel: DMA per-cpu:
Oct 31 05:56:25 linux kernel: cpu 0 hot: low 2, high 6, batch 1
Oct 31 05:56:25 linux kernel: cpu 0 cold: low 0, high 2, batch 1
Oct 31 05:56:25 linux kernel: Normal per-cpu:
Oct 31 05:56:25 linux kernel: cpu 0 hot: low 16, high 48, batch 8
Oct 31 05:56:25 linux kernel: cpu 0 cold: low 0, high 16, batch 8
Oct 31 05:56:25 linux kernel: HighMem per-cpu: empty
Oct 31 05:56:25 linux kernel:
Oct 31 05:56:25 linux kernel: Free pages:         504kB (0kB HighMem)
Oct 31 05:56:25 linux kernel: Active:34635 inactive:560 dirty:8 writeback:0 unstable:0 free:126 slab:2460 mapped:34368
pageta
Oct 31 05:56:25 linux kernel: DMA free:48kB min:40kB low:80kB high:120kB active:10576kB inactive:116kB present:16384kB
Oct 31 05:56:25 linux kernel: protections[]: 0 0 0
Oct 31 05:56:25 linux kernel: Normal free:456kB min:360kB low:720kB high:1080kB active:127964kB inactive:2124kB
present:14739
Oct 31 05:56:25 linux kernel: protections[]: 0 0 0
Oct 31 05:56:25 linux kernel: HighMem free:0kB min:128kB low:256kB high:384kB active:0kB inactive:0kB present:0kB
Oct 31 05:56:25 linux kernel: protections[]: 0 0 0
Oct 31 05:56:25 linux kernel: DMA: 2*4kB 1*8kB 0*16kB 1*32kB 0*64kB 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB =
48kB
Oct 31 05:56:25 linux kernel: Normal: 26*4kB 6*8kB 1*16kB 3*32kB 1*64kB 1*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB =
Oct 31 05:56:25 linux kernel: HighMem: empty
Oct 31 05:56:25 linux kernel: Swap cache: add 626012, delete 610481, find 148921/212935, race 2+9
Oct 31 05:56:25 linux kernel: Out of Memory: Killed process 4891 (pickup).
Oct 31 05:56:25 linux kernel: oom-killer: gfp_mask=0x1d2
Oct 31 05:56:25 linux kernel: DMA per-cpu:
Oct 31 05:56:25 linux kernel: cpu 0 hot: low 2, high 6, batch 1
Oct 31 05:56:25 linux kernel: cpu 0 cold: low 0, high 2, batch 1
Oct 31 05:56:25 linux kernel: Normal per-cpu:
Oct 31 05:56:25 linux kernel: cpu 0 hot: low 16, high 48, batch 8
Oct 31 05:56:25 linux kernel: cpu 0 cold: low 0, high 16, batch 8
Oct 31 05:56:25 linux kernel: HighMem per-cpu: empty
Oct 31 05:56:25 linux kernel:
Oct 31 05:56:25 linux kernel: Free pages:         476kB (0kB HighMem)
Oct 31 05:56:25 linux kernel: Active:34493 inactive:771 dirty:0 writeback:0 unstable:0 free:119 slab:2457 mapped:34406
pageta
Oct 31 05:56:25 linux kernel: DMA free:52kB min:40kB low:80kB high:120kB active:10584kB inactive:196kB present:16384kB
Oct 31 05:56:25 linux kernel: protections[]: 0 0 0
Oct 31 05:56:25 linux kernel: Normal free:424kB min:360kB low:720kB high:1080kB active:127388kB inactive:2888kB
present:14739
Oct 31 05:56:25 linux kernel: protections[]: 0 0 0
Oct 31 05:56:25 linux kernel: HighMem free:0kB min:128kB low:256kB high:384kB active:0kB inactive:0kB present:0kB
Oct 31 05:56:25 linux kernel: protections[]: 0 0 0
Oct 31 05:56:25 linux kernel: DMA: 3*4kB 1*8kB 0*16kB 1*32kB 0*64kB 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB =
52kB
Oct 31 05:56:25 linux kernel: Normal: 30*4kB 2*8kB 0*16kB 3*32kB 1*64kB 1*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB =
Oct 31 05:56:25 linux kernel: HighMem: empty
Oct 31 05:56:25 linux kernel: Swap cache: add 626596, delete 611037, find 148947/213117, race 2+9
Oct 31 05:56:25 linux kernel: Out of Memory: Killed process 3158 (c2faxrecv).
Oct 31 05:56:25 linux kernel: Out of Memory: Killed process 3189 (c2faxrecv).
Oct 31 05:56:25 linux kernel: Out of Memory: Killed process 3190 (c2faxrecv).
Oct 31 05:56:25 linux kernel: Out of Memory: Killed process 3191 (c2faxrecv).
Oct 31 05:56:25 linux kernel: oom-killer: gfp_mask=0x1d2
Oct 31 05:56:25 linux kernel: DMA per-cpu:
Oct 31 05:56:25 linux kernel: cpu 0 hot: low 2, high 6, batch 1
Oct 31 05:56:25 linux kernel: cpu 0 cold: low 0, high 2, batch 1
Oct 31 05:56:25 linux kernel: Normal per-cpu:
Oct 31 05:56:25 linux kernel: cpu 0 hot: low 16, high 48, batch 8
Oct 31 05:56:25 linux kernel: cpu 0 cold: low 0, high 16, batch 8
Oct 31 05:56:25 linux kernel: HighMem per-cpu: empty
Oct 31 05:56:25 linux kernel:
Oct 31 05:56:25 linux kernel: Free pages:         400kB (0kB HighMem)
Oct 31 05:56:25 linux kernel: Active:34573 inactive:736 dirty:0 writeback:0 unstable:0 free:100 slab:2450 mapped:34497
pageta
Oct 31 05:56:25 linux kernel: DMA free:40kB min:40kB low:80kB high:120kB active:10664kB inactive:0kB present:16384kB
Oct 31 05:56:25 linux kernel: protections[]: 0 0 0
Oct 31 05:56:25 linux kernel: Normal free:360kB min:360kB low:720kB high:1080kB active:127628kB inactive:2944kB
present:14739
Oct 31 05:56:25 linux kernel: protections[]: 0 0 0
Oct 31 05:56:25 linux kernel: HighMem free:0kB min:128kB low:256kB high:384kB active:0kB inactive:0kB present:0kB
Oct 31 05:56:25 linux kernel: protections[]: 0 0 0
Oct 31 05:56:25 linux kernel: DMA: 0*4kB 1*8kB 0*16kB 1*32kB 0*64kB 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB =
40kB
Oct 31 05:56:25 linux kernel: Normal: 22*4kB 6*8kB 0*16kB 1*32kB 1*64kB 1*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB =
Oct 31 05:56:25 linux kernel: HighMem: empty
Oct 31 05:56:25 linux kernel: Swap cache: add 626933, delete 611280, find 149017/213284, race 2+9
Oct 31 05:56:25 linux kernel: Out of Memory: Killed process 2585 (qmgr).
Oct 31 05:56:25 linux kernel: oom-killer: gfp_mask=0x1d2
Oct 31 05:56:25 linux kernel: DMA per-cpu:
Oct 31 05:56:25 linux kernel: cpu 0 hot: low 2, high 6, batch 1
Oct 31 05:56:25 linux kernel: cpu 0 cold: low 0, high 2, batch 1
Oct 31 05:56:25 linux kernel: Normal per-cpu:
Oct 31 05:56:25 linux kernel: cpu 0 hot: low 16, high 48, batch 8
Oct 31 05:56:25 linux kernel: cpu 0 cold: low 0, high 16, batch 8
Oct 31 05:56:25 linux kernel: HighMem per-cpu: empty
Oct 31 05:56:25 linux kernel:
Oct 31 05:56:25 linux kernel: Free pages:         272kB (0kB HighMem)
Oct 31 05:56:25 linux kernel: Active:34565 inactive:779 dirty:0 writeback:0 unstable:0 free:68 slab:2443 mapped:34533
pagetab
Oct 31 05:56:25 linux kernel: DMA free:40kB min:40kB low:80kB high:120kB active:10600kB inactive:64kB present:16384kB
Oct 31 05:56:25 linux kernel: protections[]: 0 0 0
Oct 31 05:56:25 linux kernel: Normal free:232kB min:360kB low:720kB high:1080kB active:127660kB inactive:3052kB
present:14739
Oct 31 05:56:25 linux kernel: protections[]: 0 0 0
Oct 31 05:56:25 linux kernel: HighMem free:0kB min:128kB low:256kB high:384kB active:0kB inactive:0kB present:0kB
Oct 31 05:56:25 linux kernel: protections[]: 0 0 0
Oct 31 05:56:25 linux kernel: DMA: 0*4kB 1*8kB 0*16kB 1*32kB 0*64kB 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB =
40kB
Oct 31 05:56:25 linux kernel: Normal: 4*4kB 9*8kB 1*16kB 0*32kB 0*64kB 1*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB =
Oct 31 05:56:25 linux kernel: HighMem: empty
Oct 31 05:56:25 linux kernel: Swap cache: add 627044, delete 611356, find 149037/213319, race 2+9
Oct 31 05:56:25 linux kernel: Out of Memory: Killed process 3471 (smbd).
Oct 31 05:56:25 linux kernel: oom-killer: gfp_mask=0x1d2
Oct 31 05:56:25 linux kernel: DMA per-cpu:
Oct 31 05:56:25 linux kernel: cpu 0 hot: low 2, high 6, batch 1
Oct 31 05:56:25 linux kernel: cpu 0 cold: low 0, high 2, batch 1
Oct 31 05:56:25 linux kernel: Normal per-cpu:
Oct 31 05:56:25 linux kernel: cpu 0 hot: low 16, high 48, batch 8
Oct 31 05:56:25 linux kernel: cpu 0 cold: low 0, high 16, batch 8
Oct 31 05:56:25 linux kernel: HighMem per-cpu: empty
Oct 31 05:56:25 linux kernel:
Oct 31 05:56:25 linux kernel: Free pages:         192kB (0kB HighMem)
Oct 31 05:56:25 linux kernel: Active:34638 inactive:765 dirty:0 writeback:0 unstable:0 free:48 slab:2438 mapped:34558
pagetab
Oct 31 05:56:25 linux kernel: DMA free:32kB min:40kB low:80kB high:120kB active:10664kB inactive:0kB present:16384kB
Oct 31 05:56:25 linux kernel: protections[]: 0 0 0
Oct 31 05:56:25 linux kernel: Normal free:160kB min:360kB low:720kB high:1080kB active:127888kB inactive:3060kB
present:14739
Oct 31 05:56:25 linux kernel: protections[]: 0 0 0
Oct 31 05:56:25 linux kernel: HighMem free:0kB min:128kB low:256kB high:384kB active:0kB inactive:0kB present:0kB
Oct 31 05:56:25 linux kernel: protections[]: 0 0 0
Oct 31 05:56:25 linux kernel: DMA: 0*4kB 0*8kB 0*16kB 1*32kB 0*64kB 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB =
32kB
Oct 31 05:56:25 linux kernel: Normal: 8*4kB 10*8kB 1*16kB 1*32kB 0*64kB 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB =
Oct 31 05:56:25 linux kernel: HighMem: empty
Oct 31 05:56:25 linux kernel: Swap cache: add 627228, delete 611513, find 149048/213360, race 2+9
Oct 31 05:56:25 linux kernel: Out of Memory: Killed process 1502 (httpd).
Oct 31 05:56:25 linux kernel: httpd: page allocation failure. order:0, mode:0x1d2
Oct 31 05:56:25 linux kernel:  [__alloc_pages+745/784] __alloc_pages+0x2e9/0x310
Oct 31 05:56:25 linux kernel:  [do_page_cache_readahead+182/304] do_page_cache_readahead+0xb6/0x130
Oct 31 05:56:25 linux kernel:  [filemap_nopage+302/816] filemap_nopage+0x12e/0x330
Oct 31 05:56:25 linux kernel:  [do_no_page+153/720] do_no_page+0x99/0x2d0
Oct 31 05:56:25 linux kernel:  [handle_mm_fault+106/256] handle_mm_fault+0x6a/0x100
Oct 31 05:56:25 linux kernel:  [do_page_fault+423/1312] do_page_fault+0x1a7/0x520
Oct 31 05:56:25 linux kernel:  [do_page_fault+0/1312] do_page_fault+0x0/0x520
Oct 31 05:56:25 linux kernel:  [pipe_read+41/48] pipe_read+0x29/0x30
Oct 31 05:56:25 linux kernel:  [copy_from_user+48/96] copy_from_user+0x30/0x60
Oct 31 05:56:25 linux kernel:  [sys_socketcall+179/512] sys_socketcall+0xb3/0x200
Oct 31 05:56:25 linux kernel:  [do_notify_resume+45/64] do_notify_resume+0x2d/0x40
Oct 31 05:56:25 linux kernel:  [error_code+45/56] error_code+0x2d/0x38
Oct 31 05:56:25 linux kernel: httpd: page allocation failure. order:0, mode:0x1d2
Oct 31 05:56:25 linux kernel:  [__alloc_pages+745/784] __alloc_pages+0x2e9/0x310
Oct 31 05:56:25 linux kernel:  [schedule+953/992] schedule+0x3b9/0x3e0
Oct 31 05:56:25 linux kernel:  [do_page_cache_readahead+182/304] do_page_cache_readahead+0xb6/0x130
Oct 31 05:56:25 linux kernel:  [filemap_nopage+302/816] filemap_nopage+0x12e/0x330
Oct 31 05:56:25 linux kernel:  [do_no_page+153/720] do_no_page+0x99/0x2d0
Oct 31 05:56:25 linux kernel:  [handle_mm_fault+106/256] handle_mm_fault+0x6a/0x100
Oct 31 05:56:25 linux kernel:  [do_page_fault+423/1312] do_page_fault+0x1a7/0x520
Oct 31 05:56:25 linux kernel:  [do_page_fault+0/1312] do_page_fault+0x0/0x520
Oct 31 05:56:25 linux kernel:  [pipe_read+41/48] pipe_read+0x29/0x30
Oct 31 05:56:25 linux kernel:  [copy_from_user+48/96] copy_from_user+0x30/0x60
Oct 31 05:56:25 linux kernel:  [sys_socketcall+179/512] sys_socketcall+0xb3/0x200
Oct 31 05:56:25 linux kernel:  [do_notify_resume+45/64] do_notify_resume+0x2d/0x40
Oct 31 05:56:25 linux kernel:  [error_code+45/56] error_code+0x2d/0x38
Oct 31 05:56:25 linux kernel: oom-killer: gfp_mask=0xd2
Oct 31 05:56:25 linux kernel: DMA per-cpu:
Oct 31 05:56:25 linux kernel: cpu 0 hot: low 2, high 6, batch 1
Oct 31 05:56:25 linux kernel: cpu 0 cold: low 0, high 2, batch 1
Oct 31 05:56:25 linux kernel: Normal per-cpu:
Oct 31 05:56:25 linux kernel: cpu 0 hot: low 16, high 48, batch 8
Oct 31 05:56:25 linux kernel: cpu 0 cold: low 0, high 16, batch 8
Oct 31 05:56:25 linux kernel: HighMem per-cpu: empty
Oct 31 05:56:25 linux kernel:
Oct 31 05:56:25 linux kernel: Free pages:         164kB (0kB HighMem)
Oct 31 05:56:25 linux kernel: Active:34874 inactive:570 dirty:0 writeback:0 unstable:0 free:41 slab:2437 mapped:34566
pagetab
Oct 31 05:56:25 linux kernel: DMA free:36kB min:40kB low:80kB high:120kB active:10600kB inactive:188kB present:16384kB
Oct 31 05:56:25 linux kernel: protections[]: 0 0 0
Oct 31 05:56:25 linux kernel: Normal free:128kB min:360kB low:720kB high:1080kB active:128896kB inactive:2092kB
present:14739
Oct 31 05:56:25 linux kernel: protections[]: 0 0 0
Oct 31 05:56:25 linux kernel: HighMem free:0kB min:128kB low:256kB high:384kB active:0kB inactive:0kB present:0kB
Oct 31 05:56:25 linux kernel: protections[]: 0 0 0
Oct 31 05:56:25 linux kernel: DMA: 1*4kB 0*8kB 0*16kB 1*32kB 0*64kB 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB =
36kB
Oct 31 05:56:25 linux kernel: Normal: 18*4kB 7*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB =
Oct 31 05:56:25 linux kernel: HighMem: empty
Oct 31 05:56:25 linux kernel: Swap cache: add 627380, delete 611657, find 149048/213388, race 2+9
Oct 31 05:56:25 linux kernel: Out of Memory: Killed process 1503 (httpd).
Oct 31 05:56:25 linux kernel: httpd: page allocation failure. order:0, mode:0x1d2
Oct 31 05:56:25 linux kernel:  [__alloc_pages+745/784] __alloc_pages+0x2e9/0x310
Oct 31 05:56:25 linux kernel:  [do_page_cache_readahead+182/304] do_page_cache_readahead+0xb6/0x130
Oct 31 05:56:25 linux kernel:  [filemap_nopage+302/816] filemap_nopage+0x12e/0x330
Oct 31 05:56:25 linux kernel:  [do_no_page+153/720] do_no_page+0x99/0x2d0
Oct 31 05:56:25 linux kernel:  [handle_mm_fault+106/256] handle_mm_fault+0x6a/0x100
Oct 31 05:56:25 linux kernel:  [do_page_fault+423/1312] do_page_fault+0x1a7/0x520
Oct 31 05:56:25 linux kernel:  [do_page_fault+0/1312] do_page_fault+0x0/0x520
Oct 31 05:56:25 linux kernel:  [do_brk+343/528] do_brk+0x157/0x210
Oct 31 05:56:25 linux kernel:  [copy_from_user+48/96] copy_from_user+0x30/0x60
Oct 31 05:56:25 linux kernel:  [sys_socketcall+179/512] sys_socketcall+0xb3/0x200
Oct 31 05:56:25 linux kernel:  [do_notify_resume+45/64] do_notify_resume+0x2d/0x40
Oct 31 05:56:25 linux kernel:  [error_code+45/56] error_code+0x2d/0x38
Oct 31 05:56:25 linux kernel: antivir: page allocation failure. order:0, mode:0xd2
Oct 31 05:56:25 linux kernel:  [__alloc_pages+745/784] __alloc_pages+0x2e9/0x310
Oct 31 05:56:25 linux kernel:  [generic_file_buffered_write+323/1424] generic_file_buffered_write+0x143/0x590
Oct 31 05:56:25 linux kernel:  [generic_file_aio_write_nolock+932/992] generic_file_aio_write_nolock+0x3a4/0x3e0
Oct 31 05:56:25 linux kernel:  [generic_file_write_nolock+159/192] generic_file_write_nolock+0x9f/0xc0
Oct 31 05:56:25 linux kernel:  [do_mmap_pgoff+976/1696] do_mmap_pgoff+0x3d0/0x6a0
Oct 31 05:56:25 linux kernel:  [do_mmap_pgoff+1559/1696] do_mmap_pgoff+0x617/0x6a0
Oct 31 05:56:25 linux kernel:  [autoremove_wake_function+0/64] autoremove_wake_function+0x0/0x40
Oct 31 05:56:25 linux kernel:  [generic_file_write+70/192] generic_file_write+0x46/0xc0
Oct 31 05:56:25 linux kernel:  [old_mmap+205/272] old_mmap+0xcd/0x110
Oct 31 05:56:25 linux kernel:  [vfs_write+181/240] vfs_write+0xb5/0xf0
Oct 31 05:56:25 linux kernel:  [sys_write+64/112] sys_write+0x40/0x70
Oct 31 05:56:25 linux kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Oct 31 05:56:25 linux kernel: smbd: page allocation failure. order:0, mode:0x1d2
Oct 31 05:56:25 linux kernel:  [__alloc_pages+745/784] __alloc_pages+0x2e9/0x310
Oct 31 05:56:25 linux kernel:  [schedule+953/992] schedule+0x3b9/0x3e0
Oct 31 05:56:25 linux kernel:  [do_page_cache_readahead+182/304] do_page_cache_readahead+0xb6/0x130
Oct 31 05:56:25 linux kernel:  [filemap_nopage+302/816] filemap_nopage+0x12e/0x330
Oct 31 05:56:25 linux kernel:  [do_no_page+153/720] do_no_page+0x99/0x2d0
Oct 31 05:56:25 linux kernel:  [handle_mm_fault+106/256] handle_mm_fault+0x6a/0x100
Oct 31 05:56:25 linux kernel:  [do_page_fault+423/1312] do_page_fault+0x1a7/0x520
Oct 31 05:56:25 linux kernel:  [do_page_fault+0/1312] do_page_fault+0x0/0x520
Oct 31 05:56:25 linux kernel:  [pipe_write+41/48] pipe_write+0x29/0x30
Oct 31 05:56:25 linux kernel:  [vfs_write+181/240] vfs_write+0xb5/0xf0
Oct 31 05:56:25 linux kernel:  [vfs_write+216/240] vfs_write+0xd8/0xf0
Oct 31 05:56:25 linux kernel:  [sys_sigreturn+130/176] sys_sigreturn+0x82/0xb0
Oct 31 05:56:25 linux kernel:  [error_code+45/56] error_code+0x2d/0x38
Oct 31 05:56:25 linux kernel: smbd: page allocation failure. order:0, mode:0x1d2
Oct 31 05:56:25 linux kernel:  [__alloc_pages+745/784] __alloc_pages+0x2e9/0x310
Oct 31 05:56:25 linux kernel:  [page_cache_read+44/224] page_cache_read+0x2c/0xe0
Oct 31 05:56:25 linux kernel:  [filemap_nopage+409/816] filemap_nopage+0x199/0x330
Oct 31 05:56:25 linux kernel:  [do_no_page+153/720] do_no_page+0x99/0x2d0
Oct 31 05:56:25 linux kernel:  [handle_mm_fault+106/256] handle_mm_fault+0x6a/0x100
Oct 31 05:56:25 linux kernel:  [do_page_fault+423/1312] do_page_fault+0x1a7/0x520
Oct 31 05:56:25 linux kernel:  [do_page_fault+0/1312] do_page_fault+0x0/0x520
Oct 31 05:56:25 linux kernel:  [pipe_write+41/48] pipe_write+0x29/0x30
Oct 31 05:56:25 linux kernel:  [vfs_write+181/240] vfs_write+0xb5/0xf0
Oct 31 05:56:25 linux kernel:  [vfs_write+216/240] vfs_write+0xd8/0xf0
Oct 31 05:56:25 linux kernel:  [sys_sigreturn+130/176] sys_sigreturn+0x82/0xb0
Oct 31 05:56:25 linux kernel:  [error_code+45/56] error_code+0x2d/0x38
Oct 31 05:56:25 linux kernel: VM: killing process smbd

root@debian:~ > ls -1 /proc/sys/vm/
block_dump
dirty_background_ratio
dirty_expire_centisecs
dirty_ratio
dirty_writeback_centisecs
laptop_mode
legacy_va_layout
lower_zone_protection
max_map_count
min_free_kbytes
nr_pdflush_threads
overcommit_memory
overcommit_ratio
page-cluster
swappiness
vfs_cache_pressure
root@debian:~ > cat /proc/sys/vm/overcommit_memory
0
root@debian:~ >

Thanks for advice.

Stefan, Germany


