Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262339AbUCVTza (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Mar 2004 14:55:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262361AbUCVTza
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Mar 2004 14:55:30 -0500
Received: from FW-30-241.go.retevision.es ([62.174.241.30]:16215 "EHLO
	nebula.ghetto") by vger.kernel.org with ESMTP id S262339AbUCVTzP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Mar 2004 14:55:15 -0500
Date: Mon, 22 Mar 2004 20:54:51 +0100
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org
Subject: Re: 2.6.5-rc1-mm1
Message-ID: <20040322195450.GB2306@larroy.com>
Reply-To: piotr@larroy.com
Mail-Followup-To: linux-kernel@vger.kernel.org, akpm@osdl.org
References: <20040316015338.39e2c48e.akpm@osdl.org> <20040322125305.GA2306@larroy.com> <20040322073327.754a5b42.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040322073327.754a5b42.akpm@osdl.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
From: piotr@larroy.com (Pedro Larroy)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 22, 2004 at 07:33:27AM -0800, Andrew Morton wrote:
> piotr@larroy.com (Pedro Larroy) wrote:
> >
> > Where would kernel leaked ram be accounted?
> 
> /proc/meminfo, /proc/vmstat and /proc/slabinfo.  Also sysrq-M.


MemTotal:      1036272 kB
MemFree:          4620 kB
Buffers:           488 kB
Cached:          88928 kB
SwapCached:      12516 kB
Active:         968528 kB
Inactive:        20212 kB
HighTotal:      130496 kB
HighFree:          252 kB
LowTotal:       905776 kB
LowFree:          4368 kB
SwapTotal:     1183688 kB
SwapFree:      1105024 kB
Dirty:               4 kB
Writeback:           0 kB
Mapped:          18684 kB
Slab:            26404 kB
Committed_AS:   218460 kB
PageTables:       1828 kB
VmallocTotal:   106488 kB
VmallocUsed:      5204 kB
VmallocChunk:    98700 kB

nr_dirty 0
nr_writeback 0
nr_unstable 0
nr_page_table_pages 457
nr_mapped 4478
nr_slab 6596
pgpgin 32523744
pgpgout 6572816
pswpin 5248766
pswpout 1054427
pgalloc_high 2402153
pgalloc_normal 9585196
pgalloc_dma 300517
pgfree 12289164
pgactivate 1111683519
pgdeactivate 1116666910
pgfault 6316448
pgmajfault 2422843
pgrefill_high 252302954
pgrefill_normal 836131902
pgrefill_dma 51354936
pgsteal_high 2188874
pgsteal_normal 5980853
pgsteal_dma 284731
pgscan_kswapd_high 139237079
pgscan_kswapd_normal 506340559
pgscan_kswapd_dma 30703860
pgscan_direct_high 117999982
pgscan_direct_normal 344279733
pgscan_direct_dma 22212364
pginodesteal 461
slabs_scanned 4827493
kswapd_steal 5468280
kswapd_inodesteal 606
pageoutrun 49007
allocstall 52579
pgrotated 1043328


slabinfo - version: 2.0
# name            <active_objs> <num_objs> <objsize> <objperslab> <pagesperslab> : tunables <batchcount> <limit> <sharedfactor> : slabdata <active_slabs> <num_slabs> <sharedavail>
fib6_nodes             5    113     32  113    1 : tunables  120   60    8 : slabdata      1      1      0
ip6_dst_cache          5     15    256   15    1 : tunables  120   60    8 : slabdata      1      1      0
ndisc_cache            1     20    192   20    1 : tunables  120   60    8 : slabdata      1      1      0
raw6_sock              0      0    704   11    2 : tunables   54   27    8 : slabdata      0      0      0
udp6_sock              1      6    640    6    1 : tunables   54   27    8 : slabdata      1      1      0
tcp6_sock             11     21   1152    7    2 : tunables   24   12    8 : slabdata      3      3      0
nfs_write_data        36     36    448    9    1 : tunables   54   27    8 : slabdata      4      4      0
nfs_read_data         32     36    448    9    1 : tunables   54   27    8 : slabdata      4      4      0
nfs_inode_cache        1      6    640    6    1 : tunables   54   27    8 : slabdata      1      1      0
nfs_page               0      0    128   30    1 : tunables  120   60    8 : slabdata      0      0      0
rpc_buffers            8      8   2048    2    1 : tunables   24   12    8 : slabdata      4      4      0
rpc_tasks              8     20    192   20    1 : tunables  120   60    8 : slabdata      1      1      0
rpc_inode_cache        8      9    448    9    1 : tunables   54   27    8 : slabdata      1      1      0
ip_fib_hash            9    203     16  203    1 : tunables  120   60    8 : slabdata      1      1      0
unix_sock            161    180    448    9    1 : tunables   54   27    8 : slabdata     20     20      0
tcp_tw_bucket          0      0    128   30    1 : tunables  120   60    8 : slabdata      0      0      0
tcp_bind_bucket       25    406     16  203    1 : tunables  120   60    8 : slabdata      2      2      0
tcp_open_request       0      0    128   30    1 : tunables  120   60    8 : slabdata      0      0      0
inet_peer_cache        8     59     64   59    1 : tunables  120   60    8 : slabdata      1      1      0
secpath_cache          0      0    128   30    1 : tunables  120   60    8 : slabdata      0      0      0
xfrm_dst_cache         0      0    320   12    1 : tunables   54   27    8 : slabdata      0      0      0
ip_dst_cache          91     96    320   12    1 : tunables   54   27    8 : slabdata      8      8      0
arp_cache              4     20    192   20    1 : tunables  120   60    8 : slabdata      1      1      0
raw4_sock              0      0    512    7    1 : tunables   54   27    8 : slabdata      0      0      0
udp_sock               8     14    512    7    1 : tunables   54   27    8 : slabdata      2      2      0
tcp_sock              29     44   1024    4    1 : tunables   54   27    8 : slabdata     11     11      0
flow_cache             0      0    128   30    1 : tunables  120   60    8 : slabdata      0      0      0
scsi_cmd_cache        48     48    320   12    1 : tunables   54   27    8 : slabdata      4      4      0
mqueue_inode_cache      1      7    512    7    1 : tunables   54   27    8 : slabdata      1      1      0
ext2_inode_cache       0      0    512    7    1 : tunables   54   27    8 : slabdata      0      0      0
journal_handle        16    113     32  113    1 : tunables  120   60    8 : slabdata      1      1      0
journal_head          78    118     64   59    1 : tunables  120   60    8 : slabdata      2      2      0
revoke_table           4    203     16  203    1 : tunables  120   60    8 : slabdata      1      1      0
revoke_record          0      0     16  203    1 : tunables  120   60    8 : slabdata      0      0      0
ext3_inode_cache    1071   2296    512    7    1 : tunables   54   27    8 : slabdata    328    328      0
ext3_xattr             0      0     64   59    1 : tunables  120   60    8 : slabdata      0      0      0
dquot                  0      0    112   35    1 : tunables  120   60    8 : slabdata      0      0      0
eventpoll_pwq          0      0     64   59    1 : tunables  120   60    8 : slabdata      0      0      0
eventpoll_epi          0      0    128   30    1 : tunables  120   60    8 : slabdata      0      0      0
kioctx                 0      0    192   20    1 : tunables  120   60    8 : slabdata      0      0      0
kiocb                  0      0    192   20    1 : tunables  120   60    8 : slabdata      0      0      0
dnotify_cache        171    226     32  113    1 : tunables  120   60    8 : slabdata      2      2      0
file_lock_cache       11     60    128   30    1 : tunables  120   60    8 : slabdata      2      2      0
fasync_cache           3    203     16  203    1 : tunables  120   60    8 : slabdata      1      1      0
shmem_inode_cache      4      9    448    9    1 : tunables   54   27    8 : slabdata      1      1      0
posix_timers_cache      0      0    128   30    1 : tunables  120   60    8 : slabdata      0      0      0
uid_cache              7    113     32  113    1 : tunables  120   60    8 : slabdata      1      1      0
sgpool-128            32     32   2048    2    1 : tunables   24   12    8 : slabdata     16     16      0
sgpool-64             32     32   1024    4    1 : tunables   54   27    8 : slabdata      8      8      0
sgpool-32             32     32    512    8    1 : tunables   54   27    8 : slabdata      4      4      0
sgpool-16             62     75    256   15    1 : tunables  120   60    8 : slabdata      5      5      0
sgpool-8             126    150    128   30    1 : tunables  120   60    8 : slabdata      5      5      0
cfq_pool              64    113     32  113    1 : tunables  120   60    8 : slabdata      1      1      0
crq_pool               0      0     64   59    1 : tunables  120   60    8 : slabdata      0      0      0
deadline_drq           0      0     64   59    1 : tunables  120   60    8 : slabdata      0      0      0
as_arq               177    236     64   59    1 : tunables  120   60    8 : slabdata      4      4     60
blkdev_requests      179    200    192   20    1 : tunables  120   60    8 : slabdata     10     10     60
biovec-BIO_MAX_PAGES    256    256   3072    2    2 : tunables   24   12    8 : slabdata    128    128      0
biovec-128           256    260   1536    5    2 : tunables   24   12    8 : slabdata     52     52      0
biovec-64            256    260    768    5    1 : tunables   54   27    8 : slabdata     52     52      0
biovec-16            280    280    192   20    1 : tunables  120   60    8 : slabdata     14     14      0
biovec-4             295    295     64   59    1 : tunables  120   60    8 : slabdata      5      5      0
biovec-1             443    812     16  203    1 : tunables  120   60    8 : slabdata      4      4     60
bio                  442    649     64   59    1 : tunables  120   60    8 : slabdata     11     11     60
sock_inode_cache     221    280    384   10    1 : tunables   54   27    8 : slabdata     28     28      0
skbuff_head_cache    129    200    192   20    1 : tunables  120   60    8 : slabdata     10     10      0
sock                   2     10    384   10    1 : tunables   54   27    8 : slabdata      1      1      0
proc_inode_cache      26     40    384   10    1 : tunables   54   27    8 : slabdata      4      4      0
sigqueue              27     27    144   27    1 : tunables  120   60    8 : slabdata      1      1      0
radix_tree_node     1604   3720    320   12    1 : tunables   54   27    8 : slabdata    310    310     54
bdev_cache             8     18    448    9    1 : tunables   54   27    8 : slabdata      2      2      0
mnt_cache             22     59     64   59    1 : tunables  120   60    8 : slabdata      1      1      0
inode_cache         1009   1060    384   10    1 : tunables   54   27    8 : slabdata    106    106      0
dentry_cache        1995   4680    192   20    1 : tunables  120   60    8 : slabdata    234    234      0
filp                1495   1640    192   20    1 : tunables  120   60    8 : slabdata     82     82      0
names_cache            4      4   4096    1    1 : tunables   24   12    8 : slabdata      4      4      0
idr_layer_cache       11     20    192   20    1 : tunables  120   60    8 : slabdata      1      1      0
buffer_head       241843 241959     64   59    1 : tunables  120   60    8 : slabdata   4101   4101      0
mm_struct             96     96    640    6    1 : tunables   54   27    8 : slabdata     16     16      0
vm_area_struct      4848   4897     64   59    1 : tunables  120   60    8 : slabdata     83     83     12
fs_cache             107    118     64   59    1 : tunables  120   60    8 : slabdata      2      2      0
files_cache           99     99    448    9    1 : tunables   54   27    8 : slabdata     11     11      0
signal_cache         133    177     64   59    1 : tunables  120   60    8 : slabdata      3      3      0
sighand_cache        114    114   1344    3    1 : tunables   24   12    8 : slabdata     38     38      0
task_struct          130    130   1440    5    2 : tunables   24   12    8 : slabdata     26     26      0
pte_chain           1063   3717     64   59    1 : tunables  120   60    8 : slabdata     63     63      0
pgd                   93     93   4096    1    1 : tunables   24   12    8 : slabdata     93     93      0
size-131072(DMA)       0      0 131072    1   32 : tunables    8    4    0 : slabdata      0      0      0
size-131072            0      0 131072    1   32 : tunables    8    4    0 : slabdata      0      0      0
size-65536(DMA)        0      0  65536    1   16 : tunables    8    4    0 : slabdata      0      0      0
size-65536             0      0  65536    1   16 : tunables    8    4    0 : slabdata      0      0      0
size-32768(DMA)        0      0  32768    1    8 : tunables    8    4    0 : slabdata      0      0      0
size-32768             0      0  32768    1    8 : tunables    8    4    0 : slabdata      0      0      0
size-16384(DMA)        0      0  16384    1    4 : tunables    8    4    0 : slabdata      0      0      0
size-16384             5      5  16384    1    4 : tunables    8    4    0 : slabdata      5      5      0
size-8192(DMA)         0      0   8192    1    2 : tunables    8    4    0 : slabdata      0      0      0
size-8192              0      0   8192    1    2 : tunables    8    4    0 : slabdata      0      0      0
size-4096(DMA)         0      0   4096    1    1 : tunables   24   12    8 : slabdata      0      0      0
size-4096            221    221   4096    1    1 : tunables   24   12    8 : slabdata    221    221      0
size-2048(DMA)         0      0   2048    2    1 : tunables   24   12    8 : slabdata      0      0      0
size-2048            132    132   2048    2    1 : tunables   24   12    8 : slabdata     66     66      0
size-1024(DMA)         0      0   1024    4    1 : tunables   54   27    8 : slabdata      0      0      0
size-1024            116    116   1024    4    1 : tunables   54   27    8 : slabdata     29     29      0
size-512(DMA)          0      0    512    8    1 : tunables   54   27    8 : slabdata      0      0      0
size-512             264    288    512    8    1 : tunables   54   27    8 : slabdata     36     36      0
size-256(DMA)          0      0    256   15    1 : tunables  120   60    8 : slabdata      0      0      0
size-256             180    180    256   15    1 : tunables  120   60    8 : slabdata     12     12      0
size-192(DMA)          0      0    192   20    1 : tunables  120   60    8 : slabdata      0      0      0
size-192             132    140    192   20    1 : tunables  120   60    8 : slabdata      7      7      0
size-128(DMA)          0      0    128   30    1 : tunables  120   60    8 : slabdata      0      0      0
size-128             979   1050    128   30    1 : tunables  120   60    8 : slabdata     35     35      0
size-64(DMA)           0      0     64   59    1 : tunables  120   60    8 : slabdata      0      0      0
size-64              602    767     64   59    1 : tunables  120   60    8 : slabdata     13     13      0
size-32(DMA)           0      0     32  113    1 : tunables  120   60    8 : slabdata      0      0      0
size-32             1276   1582     32  113    1 : tunables  120   60    8 : slabdata     14     14      0
kmem_cache           120    120    128   30    1 : tunables  120   60    8 : slabdata      4      4      0

SysRq : Show Memory
Mem-info:
DMA per-cpu:
cpu 0 hot: low 2, high 6, batch 1
cpu 0 cold: low 0, high 2, batch 1
cpu 1 hot: low 2, high 6, batch 1
cpu 1 cold: low 0, high 2, batch 1
Normal per-cpu:
cpu 0 hot: low 32, high 96, batch 16
cpu 0 cold: low 0, high 32, batch 16
cpu 1 hot: low 32, high 96, batch 16
cpu 1 cold: low 0, high 32, batch 16
HighMem per-cpu:
cpu 0 hot: low 14, high 42, batch 7
cpu 0 cold: low 0, high 14, batch 7
cpu 1 hot: low 14, high 42, batch 7
cpu 1 cold: low 0, high 14, batch 7

Free pages:        4964kB (252kB HighMem)
Active:239993 inactive:7139 dirty:1 writeback:0 unstable:0 free:1241
DMA free:2160kB min:16kB low:32kB high:48kB active:16kB inactive:10844kB present:16384kB
protections[]: 8 476 540
Normal free:2552kB min:936kB low:1872kB high:2808kB active:836088kB inactive:12972kB present:901120kB
protections[]: 0 468 532
HighMem free:252kB min:128kB low:256kB high:384kB active:123868kB inactive:4740kB present:130560kB
protections[]: 0 0 64
DMA: 0*4kB 0*8kB 5*16kB 1*32kB 0*64kB 0*128kB 0*256kB 0*512kB 0*1024kB 1*2048kB 0*4096kB = 2160kB
Normal: 90*4kB 16*8kB 7*16kB 3*32kB 1*64kB 0*128kB 1*256kB 1*512kB 1*1024kB 0*2048kB 0*4096kB = 2552kB
HighMem: 1*4kB 1*8kB 1*16kB 1*32kB 1*64kB 1*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 252kB
Swap cache: add 5333279, delete 5330378, find 1552320/3550697, race 3+146
Free swap:       1104732kB
262016 pages of RAM
32624 pages of HIGHMEM
2965 reserved pages
30126 pages shared
2901 pages swap cached


Regards.

-- 
Pedro Larroy Tovar | Linux & Network consultant |  piotr%member.fsf.org 

Software patents are a threat to innovation in Europe please check: 
	http://www.eurolinux.org/     
