Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262308AbVBCUER@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262308AbVBCUER (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 15:04:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262873AbVBCUBy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 15:01:54 -0500
Received: from web51608.mail.yahoo.com ([206.190.38.213]:33925 "HELO
	web51608.mail.yahoo.com") by vger.kernel.org with SMTP
	id S263506AbVBCTug (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 14:50:36 -0500
Message-ID: <20050203195033.29314.qmail@web51608.mail.yahoo.com>
Date: Thu, 3 Feb 2005 20:50:33 +0100 (CET)
From: =?iso-8859-1?q?Terje=20F=E5berg?= <terje_fb@yahoo.no>
Subject: Re: 2.6.10: kswapd spins like crazy
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050203115446.5063.qmail@web51601.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-1871811813-1107460233=:26976"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--0-1871811813-1107460233=:26976
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Id: 
Content-Disposition: inline

Terje Fåberg <terje_fb@yahoo.no> skrev: 

> The kernel is compiling right now, but I cannot 
> reboot this machine until six or seven o'clock
> tonight (CET). I will report then.

Well, well, I rebooted the same kernel, now with
MAGIC-SYSRQ enabled.  At first the kswapd-effect
wouldn't show up, but now the image is much clearer
than before. kswapd eats constantly 95% cpu time while
the system is "idle".

The System is quite sluggish. Switching between
applications needs ages. After Eclipse has been active
for a few minutes, I it lasts 45 seconds until enough
of Mozilla is swapped back in, and Mozilla has redrawn
its window. 

Complete info including SysRq-Meminfo is attached.

Regards,
Terje

--0-1871811813-1107460233=:26976
Content-Type: text/plain; name=stat2
Content-Description: stat2
Content-Disposition: inline; filename=stat2


galileo:~# vmstat 1
procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
 1  0 286576   4984   8712 352232    0    0     0    88 1015  4288  5 95  0  0
 1  0 286576   4984   8712 352232    0    0     0     0 1002  4278  5 95  0  0
 1  0 286576   4984   8712 352232   32    0    32     0 1003  4365  7 93  0  0
 1  0 286576   4984   8736 352256    0    0    40     0 1010  4296  6 94  0  0
 2  1 286696   4856   8756 352328    0  120   920   120 1081  4406  4 96  0  0
 1  0 287068   4936   8832 352496  104  448   588   568 1072  4422  7 93  0  0
 1  0 287068   4936   8832 352496    0    0     0     0 1002  4275  5 95  0  0
 1  0 287068   4936   8832 352496    0    0     0     0 1002  4289  6 94  0  0
 1  0 287068   4936   8832 352496    0    0     0     0 1002  4324  6 94  0  0
 1  0 287068   4936   8832 352496    0    0     0     0 1002  4285  5 95  0  0
 1  0 287068   4936   8832 352496    0    0     0     0 1002  4271  5 95  0  0
 1  0 287068   4936   8832 352496    0    0     0     0 1002  4335  6 94  0  0
 1  0 287068   4936   8832 352496    0    0     0     0 1002  4297  5 95  0  0

galileo:~# cat /proc/vmstat > pre ; sleep 10 ; cat /proc/vmstat > post

galileo:~# cat pre
nr_dirty 201
nr_writeback 0
nr_unstable 0
nr_page_table_pages 1667
nr_mapped 113889
nr_slab 4289
pgpgin 1653048
pgpgout 532204
pswpin 67956
pswpout 84224
pgalloc_high 0
pgalloc_normal 6255968
pgalloc_dma 91765
pgfree 6350163
pgactivate 381383
pgdeactivate 364613
pgfault 2110239
pgmajfault 36305
pgrefill_high 0
pgrefill_normal 4903463
pgrefill_dma 116195
pgsteal_high 0
pgsteal_normal 366259
pgsteal_dma 17568
pgscan_kswapd_high 0
pgscan_kswapd_normal 2504667
pgscan_kswapd_dma 615532032
pgscan_direct_high 0
pgscan_direct_normal 60489
pgscan_direct_dma 11979
pginodesteal 0
slabs_scanned 510336
kswapd_steal 364044
kswapd_inodesteal 99903
pageoutrun 105762
allocstall 435
pgrotated 77400

galileo:~# cat post
nr_dirty 31
nr_writeback 0
nr_unstable 0
nr_page_table_pages 1667
nr_mapped 113890
nr_slab 4285
pgpgin 1653308
pgpgout 532340
pswpin 67956
pswpout 84224
pgalloc_high 0
pgalloc_normal 6290302
pgalloc_dma 91765
pgfree 6384390
pgactivate 381413
pgdeactivate 364613
pgfault 2110638
pgmajfault 36308
pgrefill_high 0
pgrefill_normal 4903463
pgrefill_dma 116195
pgsteal_high 0
pgsteal_normal 366259
pgsteal_dma 17568
pgscan_kswapd_high 0
pgscan_kswapd_normal 2504667
pgscan_kswapd_dma 649881006
pgscan_direct_high 0
pgscan_direct_normal 60489
pgscan_direct_dma 11979
pginodesteal 0
slabs_scanned 514944
kswapd_steal 364044
kswapd_inodesteal 99903
pageoutrun 111269
allocstall 435
pgrotated 77400

galileo:~# cat /proc/meminfo
MemTotal:       645976 kB
MemFree:          8776 kB
Buffers:          9228 kB
Cached:         350380 kB
SwapCached:      74776 kB
Active:         443452 kB
Inactive:        97500 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:       645976 kB
LowFree:          8776 kB
SwapTotal:     2101056 kB
SwapFree:      1812348 kB
Dirty:              56 kB
Writeback:           0 kB
Mapped:         455596 kB
Slab:            17124 kB
CommitLimit:   2424044 kB
Committed_AS:  1216312 kB
PageTables:       6668 kB
VmallocTotal:   384980 kB
VmallocUsed:     16420 kB
VmallocChunk:   367568 kB

galileo:~# uname -a
Linux galileo 2.6.10-4 #7 Thu Feb 3 16:34:30 CET 2005 i686 GNU/Linux

galileo:~# uptime
 20:39:55 up 50 min,  2 users,  load average: 4.54, 3.05, 2.25

galileo:~# ps aux | grep kswapd
root       105 34.5  0.0     0    0 ?        R    19:49  17:27 [kswapd0]
root      8111  0.0  0.0  1548  444 pts/4    S+   20:39   0:00 grep kswapd

galileo:~# dmesg 
[...]
SysRq : Show Memory
Mem-info:
DMA per-cpu:
cpu 0 hot: low 2, high 6, batch 1
cpu 0 cold: low 0, high 2, batch 1
Normal per-cpu:
cpu 0 hot: low 32, high 96, batch 16
cpu 0 cold: low 0, high 32, batch 16
HighMem per-cpu: empty

Free pages:        7872kB (0kB HighMem)
Active:48698 inactive:86241 dirty:0 writeback:0 unstable:0 free:1968 slab:4509 mapped:50560 pagetables:1717
DMA free:80kB min:80kB low:100kB high:120kB active:0kB inactive:11716kB present:16384kB pages_scanned:123 all_unreclaimable? no
protections[]: 0 0 0
Normal free:7792kB min:3152kB low:3940kB high:4728kB active:194792kB inactive:333248kB present:638976kB pages_scanned:0all_unreclaimable? no
protections[]: 0 0 0
HighMem free:0kB min:128kB low:160kB high:192kB active:0kB inactive:0kB present:0kB pages_scanned:0 all_unreclaimable? no
protections[]: 0 0 0
DMA: 0*4kB 0*8kB 1*16kB 0*32kB 1*64kB 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 80kB
Normal: 590*4kB 153*8kB 59*16kB 4*32kB 1*64kB 0*128kB 0*256kB 0*512kB 1*1024kB 1*2048kB 0*4096kB = 7792kB
HighMem: empty
Swap cache: add 173594, delete 157410, find 30045/43843, race 0+0
Free swap:       1763412kB
163840 pages of RAM
0 pages of HIGHMEM
9692 reserved pages
156561 pages shared
16184 pages swap cached


--0-1871811813-1107460233=:26976--
