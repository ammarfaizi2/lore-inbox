Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265247AbUGZMrK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265247AbUGZMrK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jul 2004 08:47:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265264AbUGZMrK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jul 2004 08:47:10 -0400
Received: from eik.ii.uib.no ([129.177.16.3]:63168 "EHLO eik.ii.uib.no")
	by vger.kernel.org with ESMTP id S265247AbUGZMqb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jul 2004 08:46:31 -0400
Date: Mon, 26 Jul 2004 14:46:28 +0200
From: Jan-Frode Myklebust <janfrode@parallab.uib.no>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: OOM-killer going crazy.
Message-ID: <20040726124628.GA2488@ii.uib.no>
Mail-Followup-To: Nick Piggin <nickpiggin@yahoo.com.au>,
	linux-kernel@vger.kernel.org
References: <20040725094605.GA18324@zombie.inka.de> <41045EBE.8080708@comcast.net> <20040726091004.GA32403@ii.uib.no> <4104E307.1070004@yahoo.com.au> <20040726111032.GA2067@ii.uib.no> <4104EE5C.406@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4104EE5C.406@yahoo.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 26, 2004 at 09:43:24PM +1000, Nick Piggin wrote:
> 
> Can you try echo 10000 > /proc/sys/vm/vfs_cache_pressure, and see how that 
> goes?


Yes! Now it works. So is vfs_cache_pressure=10000 a sensible value to use? 



# cat /proc/sys/fs/dentry-state /proc/slabinfo /proc/vmstat  ; dsmc incremental ; cat /proc/sys/fs/dentry-state /proc/slabinfo /proc/vmstat
354005  299163  45      0       0       0
slabinfo - version: 2.0
# name            <active_objs> <num_objs> <objsize> <objperslab> <pagesperslab> : tunables <batchcount> <limit> <sharedfactor> : slabdata <active_slabs> <num_slabs> <sharedavail>
xfrm6_tunnel_spi       0      0     64   61    1 : tunables  120   60    8 : slabdata      0      0      0
fib6_nodes             7    119     32  119    1 : tunables  120   60    8 : slabdata      1      1      0
ip6_dst_cache          9     18    224   18    1 : tunables  120   60    8 : slabdata      1      1      0
ndisc_cache            1     25    160   25    1 : tunables  120   60    8 : slabdata      1      1      0
raw6_sock              0      0    672    6    1 : tunables   54   27    8 : slabdata      0      0      0
udp6_sock              0      0    640    6    1 : tunables   54   27    8 : slabdata      0      0      0
tcp6_sock             14     18   1184    6    2 : tunables   24   12    8 : slabdata      3      3      0
ip_fib_hash           18    226     16  226    1 : tunables  120   60    8 : slabdata      1      1      0
ip_conntrack         480    516    320   12    1 : tunables   54   27    8 : slabdata     43     43      0
xfs_dqtrx              0      0    192   20    1 : tunables  120   60    8 : slabdata      0      0      0
xfs_dquots            34     36    336   12    1 : tunables   54   27    8 : slabdata      3      3      0
dm_tio                 0      0     16  226    1 : tunables  120   60    8 : slabdata      0      0      0
dm_io                  0      0     16  226    1 : tunables  120   60    8 : slabdata      0      0      0
rpc_buffers            8      8   2048    2    1 : tunables   24   12    8 : slabdata      4      4      0
rpc_tasks              8     25    160   25    1 : tunables  120   60    8 : slabdata      1      1      0
rpc_inode_cache        6      9    448    9    1 : tunables   54   27    8 : slabdata      1      1      0
unix_sock             36     36    416    9    1 : tunables   54   27    8 : slabdata      4      4      0
ip_mrt_cache           0      0     96   41    1 : tunables  120   60    8 : slabdata      0      0      0
tcp_tw_bucket          3     31    128   31    1 : tunables  120   60    8 : slabdata      1      1      0
tcp_bind_bucket       19    226     16  226    1 : tunables  120   60    8 : slabdata      1      1      0
tcp_open_request       0      0     96   41    1 : tunables  120   60    8 : slabdata      0      0      0
inet_peer_cache        5     61     64   61    1 : tunables  120   60    8 : slabdata      1      1      0
secpath_cache          0      0    128   31    1 : tunables  120   60    8 : slabdata      0      0      0
xfrm_dst_cache         0      0    256   15    1 : tunables  120   60    8 : slabdata      0      0      0
ip_dst_cache         127    150    256   15    1 : tunables  120   60    8 : slabdata     10     10      0
arp_cache             68    100    160   25    1 : tunables  120   60    8 : slabdata      4      4      0
raw4_sock              0      0    512    7    1 : tunables   54   27    8 : slabdata      0      0      0
udp_sock              21     21    544    7    1 : tunables   54   27    8 : slabdata      3      3      0
tcp_sock              31     42   1056    7    2 : tunables   24   12    8 : slabdata      6      6      0
flow_cache             0      0     96   41    1 : tunables  120   60    8 : slabdata      0      0      0
qla2xxx_srbs         128    155    128   31    1 : tunables  120   60    8 : slabdata      5      5      0
scsi_cmd_cache        11     22    352   11    1 : tunables   54   27    8 : slabdata      2      2      0
mqueue_inode_cache      1      7    512    7    1 : tunables   54   27    8 : slabdata      1      1      0
xfs_acl                0      0    304   13    1 : tunables   54   27    8 : slabdata      0      0      0
xfs_chashlist      31401  45695     20  185    1 : tunables  120   60    8 : slabdata    247    247      0
xfs_ili              237    476    140   28    1 : tunables  120   60    8 : slabdata     17     17      0
xfs_ifork              0      0     56   70    1 : tunables  120   60    8 : slabdata      0      0      0
xfs_efi_item           0      0    260   15    1 : tunables   54   27    8 : slabdata      0      0      0
xfs_efd_item           0      0    260   15    1 : tunables   54   27    8 : slabdata      0      0      0
xfs_buf_item           0      0    148   27    1 : tunables  120   60    8 : slabdata      0      0      0
xfs_dabuf              0      0     16  226    1 : tunables  120   60    8 : slabdata      0      0      0
xfs_da_state           0      0    336   12    1 : tunables   54   27    8 : slabdata      0      0      0
xfs_trans              0      0    596   13    2 : tunables   54   27    8 : slabdata      0      0      0
xfs_inode         614056 974083    368   11    1 : tunables   54   27    8 : slabdata  88553  88553     10
xfs_btree_cur          0      0    140   28    1 : tunables  120   60    8 : slabdata      0      0      0
xfs_bmap_free_item      0      0     16  226    1 : tunables  120   60    8 : slabdata      0      0      0
xfs_buf_t             40     60    256   15    1 : tunables  120   60    8 : slabdata      4      4      0
linvfs_icache     614056 971420    384   10    1 : tunables   54   27    8 : slabdata  97142  97142     10
nfs_write_data        36     36    448    9    1 : tunables   54   27    8 : slabdata      4      4      0
nfs_read_data         32     36    416    9    1 : tunables   54   27    8 : slabdata      4      4      0
nfs_inode_cache        0      0    608    6    1 : tunables   54   27    8 : slabdata      0      0      0
nfs_page               0      0     96   41    1 : tunables  120   60    8 : slabdata      0      0      0
isofs_inode_cache      0      0    352   11    1 : tunables   54   27    8 : slabdata      0      0      0
hugetlbfs_inode_cache      1     12    324   12    1 : tunables   54   27    8 : slabdata      1      1      0
ext2_inode_cache       0      0    480    8    1 : tunables   54   27    8 : slabdata      0      0      0
ext2_xattr             0      0     48   81    1 : tunables  120   60    8 : slabdata      0      0      0
journal_handle        20    135     28  135    1 : tunables  120   60    8 : slabdata      1      1      0
journal_head         313    648     48   81    1 : tunables  120   60    8 : slabdata      8      8      0
revoke_table           4    290     12  290    1 : tunables  120   60    8 : slabdata      1      1      0
revoke_record          0      0     16  226    1 : tunables  120   60    8 : slabdata      0      0      0
ext3_inode_cache    3689   3696    480    8    1 : tunables   54   27    8 : slabdata    462    462      0
ext3_xattr             0      0     48   81    1 : tunables  120   60    8 : slabdata      0      0      0
dquot                  0      0    128   31    1 : tunables  120   60    8 : slabdata      0      0      0
eventpoll_pwq          0      0     36  107    1 : tunables  120   60    8 : slabdata      0      0      0
eventpoll_epi          0      0     96   41    1 : tunables  120   60    8 : slabdata      0      0      0
kioctx                 0      0    192   20    1 : tunables  120   60    8 : slabdata      0      0      0
kiocb                  0      0     96   41    1 : tunables  120   60    8 : slabdata      0      0      0
dnotify_cache          0      0     20  185    1 : tunables  120   60    8 : slabdata      0      0      0
file_lock_cache       27     82     96   41    1 : tunables  120   60    8 : slabdata      2      2      0
fasync_cache           0      0     16  226    1 : tunables  120   60    8 : slabdata      0      0      0
shmem_inode_cache     20     36    448    9    1 : tunables   54   27    8 : slabdata      4      4      0
posix_timers_cache      0      0    104   38    1 : tunables  120   60    8 : slabdata      0      0      0
uid_cache              3    119     32  119    1 : tunables  120   60    8 : slabdata      1      1      0
sgpool-128            32     32   2048    2    1 : tunables   24   12    8 : slabdata     16     16      0
sgpool-64             32     32   1024    4    1 : tunables   54   27    8 : slabdata      8      8      0
sgpool-32             32     32    512    8    1 : tunables   54   27    8 : slabdata      4      4      0
sgpool-16             32     45    256   15    1 : tunables  120   60    8 : slabdata      3      3      0
sgpool-8              69     93    128   31    1 : tunables  120   60    8 : slabdata      3      3      0
cfq_pool              64    119     32  119    1 : tunables  120   60    8 : slabdata      1      1      0
crq_pool               0      0     40   96    1 : tunables  120   60    8 : slabdata      0      0      0
deadline_drq           0      0     52   75    1 : tunables  120   60    8 : slabdata      0      0      0
as_arq                71    122     64   61    1 : tunables  120   60    8 : slabdata      2      2      0
blkdev_ioc            87    185     20  185    1 : tunables  120   60    8 : slabdata      1      1      0
blkdev_queue          32     32    464    8    1 : tunables   54   27    8 : slabdata      4      4      0
blkdev_requests       71    125    160   25    1 : tunables  120   60    8 : slabdata      5      5      0
biovec-(256)         256    256   3072    2    2 : tunables   24   12    8 : slabdata    128    128      0
biovec-128           256    260   1536    5    2 : tunables   24   12    8 : slabdata     52     52      0
biovec-64            256    260    768    5    1 : tunables   54   27    8 : slabdata     52     52      0
biovec-16            256    260    192   20    1 : tunables  120   60    8 : slabdata     13     13      0
biovec-4             256    305     64   61    1 : tunables  120   60    8 : slabdata      5      5      0
biovec-1             367    678     16  226    1 : tunables  120   60    8 : slabdata      2      3     60
bio                  342    369     96   41    1 : tunables  120   60    8 : slabdata      9      9      0
sock_inode_cache      70    100    384   10    1 : tunables   54   27    8 : slabdata     10     10      0
skbuff_head_cache    483    660    192   20    1 : tunables  120   60    8 : slabdata     33     33     60
sock                   3     11    352   11    1 : tunables   54   27    8 : slabdata      1      1      0
proc_inode_cache     564    616    352   11    1 : tunables   54   27    8 : slabdata     56     56      0
sigqueue               8     27    148   27    1 : tunables  120   60    8 : slabdata      1      1      0
radix_tree_node     7385   7392    276   14    1 : tunables   54   27    8 : slabdata    528    528      0
bdev_cache            14     27    448    9    1 : tunables   54   27    8 : slabdata      3      3      0
mnt_cache             30     41     96   41    1 : tunables  120   60    8 : slabdata      1      1      0
inode_cache         1480   1485    352   11    1 : tunables   54   27    8 : slabdata    135    135      0
dentry_cache      354127 697977    144   27    1 : tunables  120   60    8 : slabdata  25851  25851     24
filp                 825    850    160   25    1 : tunables  120   60    8 : slabdata     34     34      0
names_cache            6      6   4096    1    1 : tunables   24   12    8 : slabdata      6      6      0
idr_layer_cache       69     87    136   29    1 : tunables  120   60    8 : slabdata      3      3      0
buffer_head         6529   9900     52   75    1 : tunables  120   60    8 : slabdata    132    132      0
mm_struct             71     77    544    7    1 : tunables   54   27    8 : slabdata     11     11      0
vm_area_struct      1861   1974     84   47    1 : tunables  120   60    8 : slabdata     42     42      0
fs_cache              87    183     64   61    1 : tunables  120   60    8 : slabdata      3      3      0
files_cache           72     81    416    9    1 : tunables   54   27    8 : slabdata      9      9      0
signal_cache         122    164     96   41    1 : tunables  120   60    8 : slabdata      4      4      0
sighand_cache        108    108   1312    3    1 : tunables   24   12    8 : slabdata     36     36      0
task_struct          123    130   1440    5    2 : tunables   24   12    8 : slabdata     26     26      0
anon_vma             750   1160     12  290    1 : tunables  120   60    8 : slabdata      4      4      0
pgd                   57     57   4096    1    1 : tunables   24   12    8 : slabdata     57     57      0
size-131072(DMA)       0      0 131072    1   32 : tunables    8    4    0 : slabdata      0      0      0
size-131072            0      0 131072    1   32 : tunables    8    4    0 : slabdata      0      0      0
size-65536(DMA)        0      0  65536    1   16 : tunables    8    4    0 : slabdata      0      0      0
size-65536             0      0  65536    1   16 : tunables    8    4    0 : slabdata      0      0      0
size-32768(DMA)        0      0  32768    1    8 : tunables    8    4    0 : slabdata      0      0      0
size-32768             0      0  32768    1    8 : tunables    8    4    0 : slabdata      0      0      0
size-16384(DMA)        0      0  16384    1    4 : tunables    8    4    0 : slabdata      0      0      0
size-16384             2      2  16384    1    4 : tunables    8    4    0 : slabdata      2      2      0
size-8192(DMA)         0      0   8192    1    2 : tunables    8    4    0 : slabdata      0      0      0
size-8192              7      7   8192    1    2 : tunables    8    4    0 : slabdata      7      7      0
size-4096(DMA)         0      0   4096    1    1 : tunables   24   12    8 : slabdata      0      0      0
size-4096            457    457   4096    1    1 : tunables   24   12    8 : slabdata    457    457     12
size-2048(DMA)         0      0   2048    2    1 : tunables   24   12    8 : slabdata      0      0      0
size-2048            212    212   2048    2    1 : tunables   24   12    8 : slabdata    106    106      0
size-1024(DMA)         0      0   1024    4    1 : tunables   54   27    8 : slabdata      0      0      0
size-1024            186    200   1024    4    1 : tunables   54   27    8 : slabdata     50     50      0
size-512(DMA)          0      0    512    8    1 : tunables   54   27    8 : slabdata      0      0      0
size-512             406   1336    512    8    1 : tunables   54   27    8 : slabdata    167    167     27
size-256(DMA)          0      0    256   15    1 : tunables  120   60    8 : slabdata      0      0      0
size-256             388   1230    256   15    1 : tunables  120   60    8 : slabdata     82     82      0
size-192(DMA)          0      0    192   20    1 : tunables  120   60    8 : slabdata      0      0      0
size-192            8415  14060    192   20    1 : tunables  120   60    8 : slabdata    703    703      0
size-128(DMA)          0      0    128   31    1 : tunables  120   60    8 : slabdata      0      0      0
size-128            8732  12276    128   31    1 : tunables  120   60    8 : slabdata    396    396      0
size-96(DMA)           0      0     96   41    1 : tunables  120   60    8 : slabdata      0      0      0
size-96            14336  20910     96   41    1 : tunables  120   60    8 : slabdata    510    510     40
size-64(DMA)           0      0     64   61    1 : tunables  120   60    8 : slabdata      0      0      0
size-64            46020  95770     64   61    1 : tunables  120   60    8 : slabdata   1570   1570      0
size-32(DMA)           0      0     32  119    1 : tunables  120   60    8 : slabdata      0      0      0
size-32             3562   4403     32  119    1 : tunables  120   60    8 : slabdata     37     37      0
kmem_cache           175    175    160   25    1 : tunables  120   60    8 : slabdata      7      7      0
nr_dirty 228
nr_writeback 0
nr_unstable 0
nr_page_table_pages 184
nr_mapped 6682
nr_slab 218165
pgpgin 10514058
pgpgout 4921463
pswpin 0
pswpout 0
pgalloc_high 3382039
pgalloc_normal 123996797
pgalloc_dma 2598824
pgfree 130194109
pgactivate 1779298
pgdeactivate 1535398
pgfault 3914892
pgmajfault 841
pgrefill_high 0
pgrefill_normal 1522984
pgrefill_dma 12414
pgsteal_high 0
pgsteal_normal 2214669
pgsteal_dma 29742
pgscan_kswapd_high 0
pgscan_kswapd_normal 2088411
pgscan_kswapd_dma 31054
pgscan_direct_high 0
pgscan_direct_normal 673264
pgscan_direct_dma 10866
pginodesteal 36536
slabs_scanned 57079454
kswapd_steal 1787022
kswapd_inodesteal 318737
pageoutrun 12219
allocstall 13132
pgrotated 15048
Tivoli Storage Manager
Command Line Backup/Archive Client Interface - Version 5, Release 1, Level 6.0
(C) Copyright IBM Corporation 1990, 2003 All Rights Reserved.
 
Node Name: BCCSFS
Session established with server TSM: Solaris 7/8
  Server Version 5, Release 1, Level 6.5
  Server date/time: 07/26/2004 13:56:02  Last access: 07/26/2004 13:55:37
 
 
Incremental backup of volume '/etc/'
 
Incremental backup of volume '/export/homebccs/'
 
Incremental backup of volume '/export/homebccs1/'
 
Incremental backup of volume '/export/netbccs/'
 
Incremental backup of volume '/export/local/'
ANS1898I ***** Processed       500 files *****
ANS1898I ***** Processed     3,000 files *****

<snip>

Total number of objects inspected: 4,719,746
Total number of objects backed up:      538
Total number of objects updated:          0
Total number of objects rebound:          0
Total number of objects deleted:          0
Total number of objects expired:         22
Total number of objects failed:           1
Total number of bytes transferred:    154.57 MB
Data transfer time:                    8.20 sec
Network data transfer rate:        19,295.48 KB/sec
Aggregate data transfer rate:         60.29 KB/sec
Objects compressed by:                    0%
Elapsed processing time:           00:43:44


54530   49612   45      0       0       0
slabinfo - version: 2.0
# name            <active_objs> <num_objs> <objsize> <objperslab> <pagesperslab> : tunables <batchcount> <limit> <sharedfactor> : slabdata <active_slabs> <num_slabs> <sharedavail>
xfrm6_tunnel_spi       0      0     64   61    1 : tunables  120   60    8 : slabdata      0      0      0
fib6_nodes             7    119     32  119    1 : tunables  120   60    8 : slabdata      1      1      0
ip6_dst_cache          9     18    224   18    1 : tunables  120   60    8 : slabdata      1      1      0
ndisc_cache            1     25    160   25    1 : tunables  120   60    8 : slabdata      1      1      0
raw6_sock              0      0    672    6    1 : tunables   54   27    8 : slabdata      0      0      0
udp6_sock              0      0    640    6    1 : tunables   54   27    8 : slabdata      0      0      0
tcp6_sock             14     18   1184    6    2 : tunables   24   12    8 : slabdata      3      3      0
ip_fib_hash           18    226     16  226    1 : tunables  120   60    8 : slabdata      1      1      0
ip_conntrack         465    480    320   12    1 : tunables   54   27    8 : slabdata     40     40      0
xfs_dqtrx              0      0    192   20    1 : tunables  120   60    8 : slabdata      0      0      0
xfs_dquots            10     36    336   12    1 : tunables   54   27    8 : slabdata      3      3      0
dm_tio                 0      0     16  226    1 : tunables  120   60    8 : slabdata      0      0      0
dm_io                  0      0     16  226    1 : tunables  120   60    8 : slabdata      0      0      0
rpc_buffers            8      8   2048    2    1 : tunables   24   12    8 : slabdata      4      4      0
rpc_tasks              8     25    160   25    1 : tunables  120   60    8 : slabdata      1      1      0
rpc_inode_cache        6      9    448    9    1 : tunables   54   27    8 : slabdata      1      1      0
unix_sock             11     36    416    9    1 : tunables   54   27    8 : slabdata      4      4      0
ip_mrt_cache           0      0     96   41    1 : tunables  120   60    8 : slabdata      0      0      0
tcp_tw_bucket         16     31    128   31    1 : tunables  120   60    8 : slabdata      1      1      0
tcp_bind_bucket       20    226     16  226    1 : tunables  120   60    8 : slabdata      1      1      0
tcp_open_request       0      0     96   41    1 : tunables  120   60    8 : slabdata      0      0      0
inet_peer_cache       24     61     64   61    1 : tunables  120   60    8 : slabdata      1      1      0
secpath_cache          0      0    128   31    1 : tunables  120   60    8 : slabdata      0      0      0
xfrm_dst_cache         0      0    256   15    1 : tunables  120   60    8 : slabdata      0      0      0
ip_dst_cache         149    195    256   15    1 : tunables  120   60    8 : slabdata     13     13      0
arp_cache             31     75    160   25    1 : tunables  120   60    8 : slabdata      3      3      0
raw4_sock              0      0    512    7    1 : tunables   54   27    8 : slabdata      0      0      0
udp_sock              10     21    544    7    1 : tunables   54   27    8 : slabdata      3      3      0
tcp_sock              33     49   1056    7    2 : tunables   24   12    8 : slabdata      7      7      0
flow_cache             0      0     96   41    1 : tunables  120   60    8 : slabdata      0      0      0
qla2xxx_srbs         279    279    128   31    1 : tunables  120   60    8 : slabdata      9      9      0
scsi_cmd_cache        52     66    352   11    1 : tunables   54   27    8 : slabdata      6      6      0
mqueue_inode_cache      1      7    512    7    1 : tunables   54   27    8 : slabdata      1      1      0
xfs_acl                0      0    304   13    1 : tunables   54   27    8 : slabdata      0      0      0
xfs_chashlist       3780  45510     20  185    1 : tunables  120   60    8 : slabdata    246    246    180
xfs_ili               38    392    140   28    1 : tunables  120   60    8 : slabdata     14     14      0
xfs_ifork              0      0     56   70    1 : tunables  120   60    8 : slabdata      0      0      0
xfs_efi_item           0      0    260   15    1 : tunables   54   27    8 : slabdata      0      0      0
xfs_efd_item           0      0    260   15    1 : tunables   54   27    8 : slabdata      0      0      0
xfs_buf_item           0      0    148   27    1 : tunables  120   60    8 : slabdata      0      0      0
xfs_dabuf             75    226     16  226    1 : tunables  120   60    8 : slabdata      1      1      0
xfs_da_state           0      0    336   12    1 : tunables   54   27    8 : slabdata      0      0      0
xfs_trans             13     13    596   13    2 : tunables   54   27    8 : slabdata      1      1      0
xfs_inode          78837  86878    368   11    1 : tunables   54   27    8 : slabdata   7898   7898      0
xfs_btree_cur          0      0    140   28    1 : tunables  120   60    8 : slabdata      0      0      0
xfs_bmap_free_item      0      0     16  226    1 : tunables  120   60    8 : slabdata      0      0      0
xfs_buf_t            117    165    256   15    1 : tunables  120   60    8 : slabdata     10     11      0
linvfs_icache      78836  86880    384   10    1 : tunables   54   27    8 : slabdata   8688   8688      0
nfs_write_data        36     36    448    9    1 : tunables   54   27    8 : slabdata      4      4      0
nfs_read_data         32     36    416    9    1 : tunables   54   27    8 : slabdata      4      4      0
nfs_inode_cache        0      0    608    6    1 : tunables   54   27    8 : slabdata      0      0      0
nfs_page               0      0     96   41    1 : tunables  120   60    8 : slabdata      0      0      0
isofs_inode_cache      0      0    352   11    1 : tunables   54   27    8 : slabdata      0      0      0
hugetlbfs_inode_cache      1     12    324   12    1 : tunables   54   27    8 : slabdata      1      1      0
ext2_inode_cache       0      0    480    8    1 : tunables   54   27    8 : slabdata      0      0      0
ext2_xattr             0      0     48   81    1 : tunables  120   60    8 : slabdata      0      0      0
journal_handle        17    135     28  135    1 : tunables  120   60    8 : slabdata      1      1      0
journal_head          93    162     48   81    1 : tunables  120   60    8 : slabdata      2      2      0
revoke_table           4    290     12  290    1 : tunables  120   60    8 : slabdata      1      1      0
revoke_record          0      0     16  226    1 : tunables  120   60    8 : slabdata      0      0      0
ext3_inode_cache     257    648    480    8    1 : tunables   54   27    8 : slabdata     81     81      0
ext3_xattr             0      0     48   81    1 : tunables  120   60    8 : slabdata      0      0      0
dquot                  0      0    128   31    1 : tunables  120   60    8 : slabdata      0      0      0
eventpoll_pwq          0      0     36  107    1 : tunables  120   60    8 : slabdata      0      0      0
eventpoll_epi          0      0     96   41    1 : tunables  120   60    8 : slabdata      0      0      0
kioctx                 0      0    192   20    1 : tunables  120   60    8 : slabdata      0      0      0
kiocb                  0      0     96   41    1 : tunables  120   60    8 : slabdata      0      0      0
dnotify_cache          0      0     20  185    1 : tunables  120   60    8 : slabdata      0      0      0
file_lock_cache       18     82     96   41    1 : tunables  120   60    8 : slabdata      2      2      0
fasync_cache           0      0     16  226    1 : tunables  120   60    8 : slabdata      0      0      0
shmem_inode_cache     20     36    448    9    1 : tunables   54   27    8 : slabdata      4      4      0
posix_timers_cache      0      0    104   38    1 : tunables  120   60    8 : slabdata      0      0      0
uid_cache              3    119     32  119    1 : tunables  120   60    8 : slabdata      1      1      0
sgpool-128            32     32   2048    2    1 : tunables   24   12    8 : slabdata     16     16      0
sgpool-64             32     32   1024    4    1 : tunables   54   27    8 : slabdata      8      8      0
sgpool-32             40     40    512    8    1 : tunables   54   27    8 : slabdata      5      5      0
sgpool-16             38     45    256   15    1 : tunables  120   60    8 : slabdata      3      3      0
sgpool-8             107    155    128   31    1 : tunables  120   60    8 : slabdata      5      5      0
cfq_pool              64    119     32  119    1 : tunables  120   60    8 : slabdata      1      1      0
crq_pool               0      0     40   96    1 : tunables  120   60    8 : slabdata      0      0      0
deadline_drq           0      0     52   75    1 : tunables  120   60    8 : slabdata      0      0      0
as_arq               145    183     64   61    1 : tunables  120   60    8 : slabdata      3      3      0
blkdev_ioc            73    185     20  185    1 : tunables  120   60    8 : slabdata      1      1      0
blkdev_queue          32     32    464    8    1 : tunables   54   27    8 : slabdata      4      4      0
blkdev_requests      151    175    160   25    1 : tunables  120   60    8 : slabdata      7      7      0
biovec-(256)         256    256   3072    2    2 : tunables   24   12    8 : slabdata    128    128      0
biovec-128           256    260   1536    5    2 : tunables   24   12    8 : slabdata     52     52      0
biovec-64            260    260    768    5    1 : tunables   54   27    8 : slabdata     52     52      0
biovec-16            258    260    192   20    1 : tunables  120   60    8 : slabdata     13     13      0
biovec-4             302    427     64   61    1 : tunables  120   60    8 : slabdata      6      7      0
biovec-1             354    452     16  226    1 : tunables  120   60    8 : slabdata      2      2      0
bio                  356    410     96   41    1 : tunables  120   60    8 : slabdata     10     10      0
sock_inode_cache      79     90    384   10    1 : tunables   54   27    8 : slabdata      9      9      0
skbuff_head_cache    542    640    192   20    1 : tunables  120   60    8 : slabdata     32     32     60
sock                   3     11    352   11    1 : tunables   54   27    8 : slabdata      1      1      0
proc_inode_cache     411    572    352   11    1 : tunables   54   27    8 : slabdata     52     52    172
sigqueue              18     27    148   27    1 : tunables  120   60    8 : slabdata      1      1      0
radix_tree_node    48011  48104    276   14    1 : tunables   54   27    8 : slabdata   3436   3436    156
bdev_cache            14     27    448    9    1 : tunables   54   27    8 : slabdata      3      3      0
mnt_cache             30     41     96   41    1 : tunables  120   60    8 : slabdata      1      1      0
inode_cache         1480   1485    352   11    1 : tunables   54   27    8 : slabdata    135    135      0
dentry_cache       54561  65205    144   27    1 : tunables  120   60    8 : slabdata   2415   2415      0
filp                 851    875    160   25    1 : tunables  120   60    8 : slabdata     35     35      0
names_cache           15     20   4096    1    1 : tunables   24   12    8 : slabdata     15     20      0
idr_layer_cache       69     87    136   29    1 : tunables  120   60    8 : slabdata      3      3      0
buffer_head         1582   9525     52   75    1 : tunables  120   60    8 : slabdata    127    127      0
mm_struct             77     77    544    7    1 : tunables   54   27    8 : slabdata     11     11      0
vm_area_struct      1906   1974     84   47    1 : tunables  120   60    8 : slabdata     42     42      0
fs_cache              73    183     64   61    1 : tunables  120   60    8 : slabdata      3      3      0
files_cache           58     81    416    9    1 : tunables   54   27    8 : slabdata      9      9      0
signal_cache         108    164     96   41    1 : tunables  120   60    8 : slabdata      4      4      0
sighand_cache        104    108   1312    3    1 : tunables   24   12    8 : slabdata     36     36      0
task_struct          116    130   1440    5    2 : tunables   24   12    8 : slabdata     26     26      0
anon_vma             856   1160     12  290    1 : tunables  120   60    8 : slabdata      4      4      0
pgd                   58     58   4096    1    1 : tunables   24   12    8 : slabdata     58     58      0
size-131072(DMA)       0      0 131072    1   32 : tunables    8    4    0 : slabdata      0      0      0
size-131072            0      0 131072    1   32 : tunables    8    4    0 : slabdata      0      0      0
size-65536(DMA)        0      0  65536    1   16 : tunables    8    4    0 : slabdata      0      0      0
size-65536             0      0  65536    1   16 : tunables    8    4    0 : slabdata      0      0      0
size-32768(DMA)        0      0  32768    1    8 : tunables    8    4    0 : slabdata      0      0      0
size-32768             0      0  32768    1    8 : tunables    8    4    0 : slabdata      0      0      0
size-16384(DMA)        0      0  16384    1    4 : tunables    8    4    0 : slabdata      0      0      0
size-16384             2      2  16384    1    4 : tunables    8    4    0 : slabdata      2      2      0
size-8192(DMA)         0      0   8192    1    2 : tunables    8    4    0 : slabdata      0      0      0
size-8192              6      6   8192    1    2 : tunables    8    4    0 : slabdata      6      6      0
size-4096(DMA)         0      0   4096    1    1 : tunables   24   12    8 : slabdata      0      0      0
size-4096            459    464   4096    1    1 : tunables   24   12    8 : slabdata    459    464      0
size-2048(DMA)         0      0   2048    2    1 : tunables   24   12    8 : slabdata      0      0      0
size-2048            258    258   2048    2    1 : tunables   24   12    8 : slabdata    129    129     60
size-1024(DMA)         0      0   1024    4    1 : tunables   54   27    8 : slabdata      0      0      0
size-1024            174    192   1024    4    1 : tunables   54   27    8 : slabdata     48     48      0
size-512(DMA)          0      0    512    8    1 : tunables   54   27    8 : slabdata      0      0      0
size-512             412   1336    512    8    1 : tunables   54   27    8 : slabdata    167    167     27
size-256(DMA)          0      0    256   15    1 : tunables  120   60    8 : slabdata      0      0      0
size-256             554   1230    256   15    1 : tunables  120   60    8 : slabdata     82     82     60
size-192(DMA)          0      0    192   20    1 : tunables  120   60    8 : slabdata      0      0      0
size-192            1327   6240    192   20    1 : tunables  120   60    8 : slabdata    312    312      0
size-128(DMA)          0      0    128   31    1 : tunables  120   60    8 : slabdata      0      0      0
size-128            1691   9641    128   31    1 : tunables  120   60    8 : slabdata    311    311      0
size-96(DMA)           0      0     96   41    1 : tunables  120   60    8 : slabdata      0      0      0
size-96             2387   4838     96   41    1 : tunables  120   60    8 : slabdata    118    118      0
size-64(DMA)           0      0     64   61    1 : tunables  120   60    8 : slabdata      0      0      0
size-64             6278  13237     64   61    1 : tunables  120   60    8 : slabdata    217    217    120
size-32(DMA)           0      0     32  119    1 : tunables  120   60    8 : slabdata      0      0      0
size-32             3710   4403     32  119    1 : tunables  120   60    8 : slabdata     37     37      0
kmem_cache           175    175    160   25    1 : tunables  120   60    8 : slabdata      7      7      0
nr_dirty 10
nr_writeback 0
nr_unstable 0
nr_page_table_pages 189
nr_mapped 6811
nr_slab 25974
pgpgin 12321778
pgpgout 5971354
pswpin 0
pswpout 0
pgalloc_high 3640914
pgalloc_normal 130923538
pgalloc_dma 2717458
pgfree 137566296
pgactivate 2013396
pgdeactivate 1719566
pgfault 4145489
pgmajfault 950
pgrefill_high 0
pgrefill_normal 1694966
pgrefill_dma 24600
pgsteal_high 0
pgsteal_normal 2415816
pgsteal_dma 52874
pgscan_kswapd_high 0
pgscan_kswapd_normal 2259582
pgscan_kswapd_dma 52964
pgscan_direct_high 0
pgscan_direct_normal 709564
pgscan_direct_dma 12812
pginodesteal 36838
slabs_scanned 73218791
kswapd_steal 1974234
kswapd_inodesteal 425845
pageoutrun 13329
allocstall 14250
pgrotated 15049



  -jf
