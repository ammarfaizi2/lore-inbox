Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263317AbVBCL4M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263317AbVBCL4M (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 06:56:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263169AbVBCL4L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 06:56:11 -0500
Received: from web51601.mail.yahoo.com ([206.190.38.206]:59571 "HELO
	web51601.mail.yahoo.com") by vger.kernel.org with SMTP
	id S263028AbVBCLyv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 06:54:51 -0500
Message-ID: <20050203115446.5063.qmail@web51601.mail.yahoo.com>
Date: Thu, 3 Feb 2005 12:54:46 +0100 (CET)
From: =?iso-8859-1?q?Terje=20F=E5berg?= <terje_fb@yahoo.no>
Subject: Re: 2.6.10: kswapd spins like crazy
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1107427629.5611.13.camel@npiggin-nld.site>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-1132094803-1107431686=:97119"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--0-1132094803-1107431686=:97119
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Id: 
Content-Disposition: inline

Nick Piggin <nickpiggin@yahoo.com.au> skrev: 

> Can you post about 10 seconds of `vmstat 1` output
> while this is happening?
> 
> Also:
> `cat /proc/vmstat > pre ; sleep 10 ; cat
> /proc/vmstat > post`
> while this is happening, and send the pre and post
> files.
> 
> cat /proc/meminfo also might be helpful.

You will find those attached.

> And compile a kernel with "magic sysrq" support, 
> and get a couple of Alt+SysRq+M dumps (the output
> will be in dmesg).

The kernel is compiling right now, but I cannot 
reboot this machine until six or seven o'clock
tonight (CET). I will report then.

Regards,
Terje
--0-1132094803-1107431686=:97119
Content-Type: text/plain; name=stat
Content-Description: stat
Content-Disposition: inline; filename=stat


galileo:~# vmstat 1
procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
 2  5 428692   4964 118492 320196   84   72  6560   696 1561  8993 40 60  0  0
 5  3 428884   3392 118516 318960  140  368  6832  1172 1517  8563 40 60  0  0
 5  3 429908   4888 120548 318092  108 1844  5812  2020 1498  7842 53 47  0  0
 4  4 430076   3296 121876 318472  340  184  6900   604 1396  8502 43 57  0  0
 5  3 430120   4776 121748 316820   80  440  6780   440 1391  8360 34 66  0  0
 4  4 430112   4916 123016 317304  376   68  7056   440 1293  8852 23 77  0  0
 4  7 430096   4916 123576 316468  348   60  7324   204 1233  8290 21 79  0  0
 5  3 430032  14084 129040 316960  192    0  6664   464 1380  8403 24 76  0  0
 4  4 430032   7044 135060 317516  244    0  6424     0 1166  8217 17 83  0  0
 5  3 430064   4548 138072 317388  172  216  6364   216 1176  8312 17 83  0  0
 2  3 430132   4856 139000 316860  252  156  6656   872 1311  8125 19 81  0  0
^C

galileo:~# cat /proc/meminfo
MemTotal:       646052 kB
MemFree:          3296 kB
Buffers:        156912 kB
Cached:         314876 kB
SwapCached:      47524 kB
Active:          92792 kB
Inactive:       447588 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:       646052 kB
LowFree:          3296 kB
SwapTotal:     2101056 kB
SwapFree:      1661600 kB
Dirty:           12088 kB
Writeback:           0 kB
Mapped:         103476 kB
Slab:            30032 kB
CommitLimit:   2424080 kB
Committed_AS:  3125208 kB
PageTables:       8440 kB
VmallocTotal:   384980 kB
VmallocUsed:      7392 kB
VmallocChunk:   377500 kB

galileo:~# cat /proc/vmstat > pre ; sleep 10 ; cat /proc/vmstat > post

galileo:~# cat pre
nr_dirty 61
nr_writeback 138
nr_unstable 0
nr_page_table_pages 2118
nr_mapped 24903
nr_slab 7494
pgpgin 40072965
pgpgout 32683347
pswpin 707678
pswpout 491400
pgalloc_high 0
pgalloc_normal 289749372
pgalloc_dma 5185962
pgfree 294936222
pgactivate 7678427
pgdeactivate 7086934
pgfault 76930918
pgmajfault 422426
pgrefill_high 0
pgrefill_normal 63766162
pgrefill_dma 3133019
pgsteal_high 0
pgsteal_normal 11946755
pgsteal_dma 855413
pgscan_kswapd_high 0
pgscan_kswapd_normal 31430190
pgscan_kswapd_dma 2037500863
pgscan_direct_high 0
pgscan_direct_normal 1083423
pgscan_direct_dma 89251
pginodesteal 0
slabs_scanned 15591040
kswapd_steal 12527148
kswapd_inodesteal 2803439
pageoutrun 3511541
allocstall 6111
pgrotated 719114

galileo:~# cat post
nr_dirty 504
nr_writeback 38
nr_unstable 0
nr_page_table_pages 2093
nr_mapped 25652
nr_slab 7488
pgpgin 40106505
pgpgout 32695255
pswpin 710721
pswpout 491907
pgalloc_high 0
pgalloc_normal 289790611
pgalloc_dma 5185979
pgfree 294977468
pgactivate 7680721
pgdeactivate 7089056
pgfault 76933748
pgmajfault 423145
pgrefill_high 0
pgrefill_normal 63776342
pgrefill_dma 3133311
pgsteal_high 0
pgsteal_normal 11957164
pgsteal_dma 855422
pgscan_kswapd_high 0
pgscan_kswapd_normal 31443126
pgscan_kswapd_dma 2038597486
pgscan_direct_high 0
pgscan_direct_normal 1100385
pgscan_direct_dma 90604
pginodesteal 0
slabs_scanned 15596032
kswapd_steal 12531233
kswapd_inodesteal 2803526
pageoutrun 3511829
allocstall 6272
pgrotated 719582

--0-1132094803-1107431686=:97119--
