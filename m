Return-Path: <linux-kernel-owner+willy=40w.ods.org-S937548AbWLENZU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937548AbWLENZU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 08:25:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937549AbWLENZU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 08:25:20 -0500
Received: from cs9347-45.austin.rr.com ([24.93.47.45]:36435 "EHLO
	ms-smtp-06.texas.rr.com" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S937548AbWLENZT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 08:25:19 -0500
Message-Id: <200612051325.kB5DP3aB015710@ms-smtp-06.texas.rr.com>
Reply-To: <Aucoin@Houston.RR.com>
From: "Aucoin" <Aucoin@Houston.RR.com>
To: "'Nick Piggin'" <nickpiggin@yahoo.com.au>
Cc: "'Linus Torvalds'" <torvalds@osdl.org>,
       "'Tim Schmielau'" <tim@physik3.uni-rostock.de>,
       "'Andrew Morton'" <akpm@osdl.org>, <linux-kernel@vger.kernel.org>,
       <clameter@sgi.com>
Subject: RE: la la la la ... swappiness
Date: Tue, 5 Dec 2006 07:25:03 -0600
Organization: home
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
In-reply-to: <45751955.8010506@yahoo.com.au>
Thread-Index: AccYO1RPZniOG9QUTT+VKMyq9vslXAANL2Ow
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2962
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Nick Piggin [mailto:nickpiggin@yahoo.com.au]
> Can you try getting the output of /proc/vmstat as well?

Ouput from vmstat, meminfo and bloatmon below.

vmstat
nr_dirty 0
nr_writeback 0
nr_unstable 0
nr_page_table_pages 361
nr_mapped 33077
nr_slab 8107
pgpgin 1433195947
pgpgout 148795046
pswpin 0
pswpout 1
pgalloc_high 19333815
pgalloc_normal 38376025
pgalloc_dma32 0
pgalloc_dma 1043219
pgfree 58768398
pgactivate 99313
pgdeactivate 61910
pgfault 248450153
pgmajfault 1009
pgrefill_high 18587
pgrefill_normal 129658
pgrefill_dma32 0
pgrefill_dma 6299
pgsteal_high 11954
pgsteal_normal 197484
pgsteal_dma32 0
pgsteal_dma 6176
pgscan_kswapd_high 13035
pgscan_kswapd_normal 205326
pgscan_kswapd_dma32 0
pgscan_kswapd_dma 6369
pgscan_direct_high 0
pgscan_direct_normal 0
pgscan_direct_dma32 0
pgscan_direct_dma 0
pginodesteal 0
slabs_scanned 24576
kswapd_steal 215614
kswapd_inodesteal 0
pageoutrun 3315
allocstall 0
pgrotated 1
nr_bounce 0

meminfo 
MemTotal:      2075152 kB
MemFree:         59052 kB
Buffers:         45088 kB
Cached:         401128 kB
SwapCached:          0 kB
Active:         246424 kB
Inactive:       313332 kB
HighTotal:     1179392 kB
HighFree:         1696 kB
LowTotal:       895760 kB
LowFree:         57356 kB
SwapTotal:      524276 kB
SwapFree:       524272 kB
Dirty:               4 kB
Writeback:           0 kB
Mapped:         132252 kB
Slab:            32432 kB
CommitLimit:    855292 kB
Committed_AS:   980948 kB
PageTables:       1432 kB
VmallocTotal:   114680 kB
VmallocUsed:      1000 kB
VmallocChunk:   113584 kB
HugePages_Total:   345
HugePages_Free:      0
Hugepagesize:     4096 kB

bloatmon
skbuff_fclone_cache:       22KB       22KB  100.0
reiser_inode_cache:        0KB        0KB  100.0
posix_timers_cache:        0KB        0KB  100.0
mqueue_inode_cache:       60KB       63KB   95.9
inotify_watch_cache:        0KB        3KB   14.85
inotify_event_cache:        0KB        0KB  100.0
hugetlbfs_inode_cache:        1KB        3KB   27.27
 skbuff_head_cache:     2082KB     2100KB   99.14
 shmem_inode_cache:        5KB       11KB   48.14
 isofs_inode_cache:        0KB        0KB  100.0
  sock_inode_cache:       21KB       26KB   82.85
  size-131072(DMA):        0KB        0KB  100.0
  request_sock_TCP:        0KB        0KB  100.0
  proc_inode_cache:       18KB       38KB   48.18
  ext3_inode_cache:      314KB      375KB   83.85
  ext2_inode_cache:       11KB       30KB   37.50
   tcp_bind_bucket:        0KB        3KB    3.94
   sysfs_dir_cache:       85KB       86KB  100.0
   size-65536(DMA):        0KB        0KB  100.0
   size-32768(DMA):        0KB        0KB  100.0
   size-16384(DMA):        0KB        0KB  100.0
   scsi_io_context:        0KB        0KB  100.0


