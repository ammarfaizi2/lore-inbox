Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266540AbUFQPW4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266540AbUFQPW4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jun 2004 11:22:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266537AbUFQPW4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jun 2004 11:22:56 -0400
Received: from zork.zork.net ([64.81.246.102]:29827 "EHLO zork.zork.net")
	by vger.kernel.org with ESMTP id S266548AbUFQPWg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jun 2004 11:22:36 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.7
References: <Pine.LNX.4.58.0406152253390.6392@ppc970.osdl.org>
From: Sean Neakums <sneakums@zork.net>
Mail-Followup-To: linux-kernel@vger.kernel.org
Date: Thu, 17 Jun 2004 16:22:34 +0100
In-Reply-To: <Pine.LNX.4.58.0406152253390.6392@ppc970.osdl.org> (Linus
	Torvalds's message of "Tue, 15 Jun 2004 22:56:52 -0700 (PDT)")
Message-ID: <6uisdqryyt.fsf@zork.zork.net>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: sneakums@zork.net
X-SA-Exim-Scanned: No (on zork.zork.net); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The 2.6.7 I built seems kind of swap-happy, apparently triggered by an
overnight updatedb run.  I think this also happened with
2.6.7-rc3-mm2.  I can't seem to find anything particularly out of the
ordinary in the information below.  I started off with swappiness set
to 50 as I have for a while and dropped it twice by ten each time
after a swapoff/swapon.  It starts paging stuff out again pretty fast
after it gets the swap back.  Swap is is a dm-crypt device map.

Sorry about the vagueness.  Is anyone else seeing anything odd like
this?


Linux version 2.6.7 (sean@slagpiece) (gcc version 3.4.0 (Debian 20040516)) #242 Wed Jun 16 11:51:02 IST 2004

slabinfo - version: 2.0
# name            <active_objs> <num_objs> <objsize> <objperslab> <pagesperslab> : tunables <batchcount> <limit> <sharedfactor> : slabdata <active_slabs> <num_slabs> <sharedavail>
unix_sock            113    121    352   11    1 : tunables   54   27    0 : slabdata     11     11      0
tcp_tw_bucket          0      0     96   41    1 : tunables  120   60    0 : slabdata      0      0      0
tcp_bind_bucket       14    226     16  226    1 : tunables  120   60    0 : slabdata      1      1      0
tcp_open_request       0      0     64   61    1 : tunables  120   60    0 : slabdata      0      0      0
inet_peer_cache        0      0     64   61    1 : tunables  120   60    0 : slabdata      0      0      0
secpath_cache          0      0    128   31    1 : tunables  120   60    0 : slabdata      0      0      0
xfrm_dst_cache         0      0    256   15    1 : tunables  120   60    0 : slabdata      0      0      0
ip_fib_hash            9    226     16  226    1 : tunables  120   60    0 : slabdata      1      1      0
ip_dst_cache         315    315    256   15    1 : tunables  120   60    0 : slabdata     21     21      0
arp_cache              5     31    128   31    1 : tunables  120   60    0 : slabdata      1      1      0
raw4_sock              0      0    480    8    1 : tunables   54   27    0 : slabdata      0      0      0
udp_sock               2      8    480    8    1 : tunables   54   27    0 : slabdata      1      1      0
tcp_sock              33     40    992    4    1 : tunables   54   27    0 : slabdata     10     10      0
flow_cache             0      0     96   41    1 : tunables  120   60    0 : slabdata      0      0      0
dm-crypt_io          256    275     72   55    1 : tunables  120   60    0 : slabdata      5      5      0
dm_tio               256    452     16  226    1 : tunables  120   60    0 : slabdata      2      2      0
dm_io                256    452     16  226    1 : tunables  120   60    0 : slabdata      2      2      0
mqueue_inode_cache      1      8    480    8    1 : tunables   54   27    0 : slabdata      1      1      0
udf_inode_cache        0      0    352   11    1 : tunables   54   27    0 : slabdata      0      0      0
isofs_inode_cache      0      0    320   12    1 : tunables   54   27    0 : slabdata      0      0      0
fat_inode_cache        0      0    352   11    1 : tunables   54   27    0 : slabdata      0      0      0
ext2_inode_cache       0      0    416    9    1 : tunables   54   27    0 : slabdata      0      0      0
journal_handle         1    135     28  135    1 : tunables  120   60    0 : slabdata      1      1      0
journal_head          83    243     48   81    1 : tunables  120   60    0 : slabdata      3      3      0
revoke_table          10    290     12  290    1 : tunables  120   60    0 : slabdata      1      1      0
revoke_record          0      0     16  226    1 : tunables  120   60    0 : slabdata      0      0      0
ext3_inode_cache    2919  12258    416    9    1 : tunables   54   27    0 : slabdata   1362   1362      0
eventpoll_pwq          0      0     36  107    1 : tunables  120   60    0 : slabdata      0      0      0
eventpoll_epi          0      0     96   41    1 : tunables  120   60    0 : slabdata      0      0      0
kioctx                 0      0    160   25    1 : tunables  120   60    0 : slabdata      0      0      0
kiocb                  0      0    160   25    1 : tunables  120   60    0 : slabdata      0      0      0
dnotify_cache          0      0     20  185    1 : tunables  120   60    0 : slabdata      0      0      0
file_lock_cache       19     43     92   43    1 : tunables  120   60    0 : slabdata      1      1      0
fasync_cache           2    226     16  226    1 : tunables  120   60    0 : slabdata      1      1      0
shmem_inode_cache    114    120    384   10    1 : tunables   54   27    0 : slabdata     12     12      0
posix_timers_cache      0      0     80   49    1 : tunables  120   60    0 : slabdata      0      0      0
uid_cache              3    119     32  119    1 : tunables  120   60    0 : slabdata      1      1      0
cfq_pool              64    119     32  119    1 : tunables  120   60    0 : slabdata      1      1      0
crq_pool               0      0     40   96    1 : tunables  120   60    0 : slabdata      0      0      0
deadline_drq           0      0     52   75    1 : tunables  120   60    0 : slabdata      0      0      0
as_arq                16     61     64   61    1 : tunables  120   60    0 : slabdata      1      1      0
blkdev_ioc            69    185     20  185    1 : tunables  120   60    0 : slabdata      1      1      0
blkdev_queue          12     18    448    9    1 : tunables   54   27    0 : slabdata      2      2      0
blkdev_requests       18     25    160   25    1 : tunables  120   60    0 : slabdata      1      1      0
biovec-(256)         256    256   3072    2    2 : tunables   24   12    0 : slabdata    128    128      0
biovec-128           256    260   1536    5    2 : tunables   24   12    0 : slabdata     52     52      0
biovec-64            256    260    768    5    1 : tunables   54   27    0 : slabdata     52     52      0
biovec-16            256    260    192   20    1 : tunables  120   60    0 : slabdata     13     13      0
biovec-4             256    305     64   61    1 : tunables  120   60    0 : slabdata      5      5      0
biovec-1             272    452     16  226    1 : tunables  120   60    0 : slabdata      2      2      0
bio                  281    305     64   61    1 : tunables  120   60    0 : slabdata      5      5      0
sock_inode_cache     158    165    352   11    1 : tunables   54   27    0 : slabdata     15     15      0
skbuff_head_cache    115    175    160   25    1 : tunables  120   60    0 : slabdata      7      7      0
sock                   3     12    320   12    1 : tunables   54   27    0 : slabdata      1      1      0
proc_inode_cache     170    336    320   12    1 : tunables   54   27    0 : slabdata     28     28      0
sigqueue              16     27    144   27    1 : tunables  120   60    0 : slabdata      1      1      0
radix_tree_node     1793   3514    276   14    1 : tunables   54   27    0 : slabdata    251    251      0
bdev_cache            10     18    416    9    1 : tunables   54   27    0 : slabdata      2      2      0
mnt_cache             22     61     64   61    1 : tunables  120   60    0 : slabdata      1      1      0
inode_cache          702    714    288   14    1 : tunables   54   27    0 : slabdata     51     51      0
dentry_cache        3486  17415    148   27    1 : tunables  120   60    0 : slabdata    645    645      0
filp                1437   1450    160   25    1 : tunables  120   60    0 : slabdata     58     58      0
names_cache            1      1   4096    1    1 : tunables   24   12    0 : slabdata      1      1      0
idr_layer_cache       39     58    136   29    1 : tunables  120   60    0 : slabdata      2      2      0
buffer_head         4005  16425     52   75    1 : tunables  120   60    0 : slabdata    219    219      0
mm_struct             63     63    512    7    1 : tunables   54   27    0 : slabdata      9      9      0
vm_area_struct      3324   3337     84   47    1 : tunables  120   60    0 : slabdata     71     71      0
fs_cache              59    119     32  119    1 : tunables  120   60    0 : slabdata      1      1      0
files_cache           63     63    416    9    1 : tunables   54   27    0 : slabdata      7      7      0
signal_cache          75     82     96   41    1 : tunables  120   60    0 : slabdata      2      2      0
sighand_cache         75     75   1312    3    1 : tunables   24   12    0 : slabdata     25     25      0
task_struct           95     95   1408    5    2 : tunables   24   12    0 : slabdata     19     19      0
anon_vma            1425   1628      8  407    1 : tunables  120   60    0 : slabdata      4      4      0
pgd                   60     60   4096    1    1 : tunables   24   12    0 : slabdata     60     60      0
size-131072(DMA)       0      0 131072    1   32 : tunables    8    4    0 : slabdata      0      0      0
size-131072            0      0 131072    1   32 : tunables    8    4    0 : slabdata      0      0      0
size-65536(DMA)        0      0  65536    1   16 : tunables    8    4    0 : slabdata      0      0      0
size-65536             0      0  65536    1   16 : tunables    8    4    0 : slabdata      0      0      0
size-32768(DMA)        0      0  32768    1    8 : tunables    8    4    0 : slabdata      0      0      0
size-32768             0      0  32768    1    8 : tunables    8    4    0 : slabdata      0      0      0
size-16384(DMA)        0      0  16384    1    4 : tunables    8    4    0 : slabdata      0      0      0
size-16384             0      0  16384    1    4 : tunables    8    4    0 : slabdata      0      0      0
size-8192(DMA)         0      0   8192    1    2 : tunables    8    4    0 : slabdata      0      0      0
size-8192              1      1   8192    1    2 : tunables    8    4    0 : slabdata      1      1      0
size-4096(DMA)         0      0   4096    1    1 : tunables   24   12    0 : slabdata      0      0      0
size-4096            137    137   4096    1    1 : tunables   24   12    0 : slabdata    137    137      0
size-2048(DMA)         0      0   2048    2    1 : tunables   24   12    0 : slabdata      0      0      0
size-2048             58     58   2048    2    1 : tunables   24   12    0 : slabdata     29     29      0
size-1024(DMA)         0      0   1024    4    1 : tunables   54   27    0 : slabdata      0      0      0
size-1024             64     64   1024    4    1 : tunables   54   27    0 : slabdata     16     16      0
size-512(DMA)          0      0    512    8    1 : tunables   54   27    0 : slabdata      0      0      0
size-512             176    480    512    8    1 : tunables   54   27    0 : slabdata     60     60      0
size-256(DMA)          0      0    256   15    1 : tunables  120   60    0 : slabdata      0      0      0
size-256             161    375    256   15    1 : tunables  120   60    0 : slabdata     25     25      0
size-192(DMA)          0      0    192   20    1 : tunables  120   60    0 : slabdata      0      0      0
size-192              80     80    192   20    1 : tunables  120   60    0 : slabdata      4      4      0
size-128(DMA)          0      0    128   31    1 : tunables  120   60    0 : slabdata      0      0      0
size-128             217    310    128   31    1 : tunables  120   60    0 : slabdata     10     10      0
size-96(DMA)           0      0     96   41    1 : tunables  120   60    0 : slabdata      0      0      0
size-96              748    779     96   41    1 : tunables  120   60    0 : slabdata     19     19      0
size-64(DMA)           0      0     64   61    1 : tunables  120   60    0 : slabdata      0      0      0
size-64              417   1220     64   61    1 : tunables  120   60    0 : slabdata     20     20      0
size-32(DMA)           0      0     32  119    1 : tunables  120   60    0 : slabdata      0      0      0
size-32              833    833     32  119    1 : tunables  120   60    0 : slabdata      7      7      0
kmem_cache           124    124    128   31    1 : tunables  120   60    0 : slabdata      4      4      0

MemTotal:       385204 kB
MemFree:         11572 kB
Buffers:          8164 kB
Cached:          78260 kB
SwapCached:      54440 kB
Active:         248344 kB
Inactive:        97736 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:       385204 kB
LowFree:         11572 kB
SwapTotal:      530104 kB
SwapFree:       465816 kB
Dirty:              92 kB
Writeback:           0 kB
Mapped:         242956 kB
Slab:            14856 kB
Committed_AS:   433516 kB
PageTables:       1368 kB
VmallocTotal:   647128 kB
VmallocUsed:       920 kB
VmallocChunk:   645944 kB

Filename				Type		Size	Used	Priority
/dev/mapper/swap0                       partition	530104	64288	-3
