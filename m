Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266881AbUGVSBH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266881AbUGVSBH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jul 2004 14:01:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266874AbUGVR66
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jul 2004 13:58:58 -0400
Received: from BACHE.ECE.CMU.EDU ([128.2.129.23]:4003 "EHLO bache.ece.cmu.edu")
	by vger.kernel.org with ESMTP id S266864AbUGVRyU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jul 2004 13:54:20 -0400
Subject: nvidia and rmap (again)
From: John Bucy <bucy@gloop.org>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1090518856.9869.22.camel@catalepsy.pdl.cmu.edu>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 22 Jul 2004 13:54:16 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I'm sure everyone's sick of hearing about nvidia problems by now...

On my 2.6.7 + nvidia 1.0-6106 box, openGL stuff leaks a lot.  
What I've noticed is that the memory seems to be freed if I
kill the X server so maybe it isn't being totally leaked.

NVidia says:

Q: OpenGL applications leak significant amounts of memory on my system!

A: If your kernel is making use of the -rmap VM, the system may be leaking
   memory due to a memory management optimization introduced in -rmap14a.
   The -rmap VM has been adopted by several popular distributions, the
   memory leak is known to be present in some of the distribution kernels;
   it has been fixed in -rmap15e.

   If you suspect that your system is affected, please try upgrading your
   kernel or contact the distribution's vendor for assistance.

I don't quite know how to divine the right info out of slabinfo;
I've attached it below.

Is this in fact an rmap problem?  Should I be pestering nvidia 
instead?



thanks
john


slabinfo - version: 2.0
# name            <active_objs> <num_objs> <objsize> <objperslab> <pagesperslab> : tunables <batchcount> <limit> <sharedfactor> : slabdata <active_slabs> <num_slabs> <sharedavail>
fib6_nodes             5    119     32  119    1 : tunables  120   60    0 : slabdata      1      1      0
ip6_dst_cache          5     15    256   15    1 : tunables  120   60    0 : slabdata      1      1      0
ndisc_cache            1     15    256   15    1 : tunables  120   60    0 : slabdata      1      1      0
raw6_sock              0      0    640    6    1 : tunables   54   27    0 : slabdata      0      0      0
udp6_sock              0      0    640    6    1 : tunables   54   27    0 : slabdata      0      0      0
tcp6_sock              4      7   1152    7    2 : tunables   24   12    0 : slabdata      1      1      0
nfs_write_data        36     42    512    7    1 : tunables   54   27    0 : slabdata      6      6      0
nfs_read_data         32     35    512    7    1 : tunables   54   27    0 : slabdata      5      5      0
nfs_inode_cache        5     24    640    6    1 : tunables   54   27    0 : slabdata      4      4      0
nfs_page               0      0    128   31    1 : tunables  120   60    0 : slabdata      0      0      0
rpc_buffers            8      8   2048    2    1 : tunables   24   12    0 : slabdata      4      4      0
rpc_tasks              8     15    256   15    1 : tunables  120   60    0 : slabdata      1      1      0
rpc_inode_cache        8     14    512    7    1 : tunables   54   27    0 : slabdata      2      2      0
dm_tio                 0      0     16  226    1 : tunables  120   60    0 : slabdata      0      0      0
dm_io                  0      0     16  226    1 : tunables  120   60    0 : slabdata      0      0      0
unix_sock            177    180    384   10    1 : tunables   54   27    0 : slabdata     18     18      0
tcp_tw_bucket          0      0    128   31    1 : tunables  120   60    0 : slabdata      0      0      0
tcp_bind_bucket       18    226     16  226    1 : tunables  120   60    0 : slabdata      1      1      0
tcp_open_request       0      0    128   31    1 : tunables  120   60    0 : slabdata      0      0      0
inet_peer_cache       16    183     64   61    1 : tunables  120   60    0 : slabdata      3      3      0
secpath_cache          0      0    128   31    1 : tunables  120   60    0 : slabdata      0      0      0
xfrm_dst_cache         0      0    256   15    1 : tunables  120   60    0 : slabdata      0      0      0
ip_fib_hash            9    226     16  226    1 : tunables  120   60    0 : slabdata      1      1      0
ip_dst_cache          86     90    256   15    1 : tunables  120   60    0 : slabdata      6      6      0
arp_cache              2     31    128   31    1 : tunables  120   60    0 : slabdata      1      1      0
raw4_sock              0      0    512    7    1 : tunables   54   27    0 : slabdata      0      0      0
udp_sock               6      7    512    7    1 : tunables   54   27    0 : slabdata      1      1      0
tcp_sock              25     28   1024    4    1 : tunables   54   27    0 : slabdata      7      7      0
flow_cache             0      0    128   31    1 : tunables  120   60    0 : slabdata      0      0      0
xfs_acl                0      0    304   13    1 : tunables   54   27    0 : slabdata      0      0      0
xfs_chashlist       4794   6290     20  185    1 : tunables  120   60    0 : slabdata     34     34      0
xfs_ili              146   1176    140   28    1 : tunables  120   60    0 : slabdata     42     42      0
xfs_ifork              0      0     56   70    1 : tunables  120   60    0 : slabdata      0      0      0
xfs_efi_item           0      0    260   15    1 : tunables   54   27    0 : slabdata      0      0      0
xfs_efd_item           0      0    260   15    1 : tunables   54   27    0 : slabdata      0      0      0
xfs_buf_item           3     27    148   27    1 : tunables  120   60    0 : slabdata      1      1      0
xfs_dabuf              8    226     16  226    1 : tunables  120   60    0 : slabdata      1      1      0
xfs_da_state           0      0    336   12    1 : tunables   54   27    0 : slabdata      0      0      0
xfs_trans              0      0    592   13    2 : tunables   54   27    0 : slabdata      0      0      0
xfs_inode          69849 129151    352   11    1 : tunables   54   27    0 : slabdata  11741  11741      0
xfs_btree_cur          1     30    132   30    1 : tunables  120   60    0 : slabdata      1      1      0
xfs_bmap_free_item      0      0     12  290    1 : tunables  120   60    0 : slabdata      0      0      0
xfs_buf_t             15     30    256   15    1 : tunables  120   60    0 : slabdata      2      2      0
linvfs_icache      69849 124760    384   10    1 : tunables   54   27    0 : slabdata  12476  12476      0
devfsd_event           0      0     20  185    1 : tunables  120   60    0 : slabdata      0      0      0
ext2_inode_cache       0      0    512    7    1 : tunables   54   27    0 : slabdata      0      0      0
ext2_xattr             0      0     44   88    1 : tunables  120   60    0 : slabdata      0      0      0
journal_handle        16    135     28  135    1 : tunables  120   60    0 : slabdata      1      1      0
journal_head          16     81     48   81    1 : tunables  120   60    0 : slabdata      1      1      0
revoke_table           6    290     12  290    1 : tunables  120   60    0 : slabdata      1      1      0
revoke_record          0      0     16  226    1 : tunables  120   60    0 : slabdata      0      0      0
ext3_inode_cache   14466  22869    512    7    1 : tunables   54   27    0 : slabdata   3267   3267      0
ext3_xattr             0      0     44   88    1 : tunables  120   60    0 : slabdata      0      0      0
eventpoll_pwq          0      0     36  107    1 : tunables  120   60    0 : slabdata      0      0      0
eventpoll_epi          0      0    128   31    1 : tunables  120   60    0 : slabdata      0      0      0
kioctx                 0      0    256   15    1 : tunables  120   60    0 : slabdata      0      0      0
kiocb                  0      0    256   15    1 : tunables  120   60    0 : slabdata      0      0      0
dnotify_cache          0      0     20  185    1 : tunables  120   60    0 : slabdata      0      0      0
file_lock_cache        4     43     92   43    1 : tunables  120   60    0 : slabdata      1      1      0
fasync_cache           2    226     16  226    1 : tunables  120   60    0 : slabdata      1      1      0
shmem_inode_cache     30     30    384   10    1 : tunables   54   27    0 : slabdata      3      3      0
posix_timers_cache      0      0     80   49    1 : tunables  120   60    0 : slabdata      0      0      0
uid_cache              5    119     32  119    1 : tunables  120   60    0 : slabdata      1      1      0
cfq_pool              64    119     32  119    1 : tunables  120   60    0 : slabdata      1      1      0
crq_pool               0      0     36  107    1 : tunables  120   60    0 : slabdata      0      0      0
deadline_drq           0      0     48   81    1 : tunables  120   60    0 : slabdata      0      0      0
as_arq                16     65     60   65    1 : tunables  120   60    0 : slabdata      1      1      0
blkdev_ioc            88    185     20  185    1 : tunables  120   60    0 : slabdata      1      1      0
blkdev_queue           3      9    448    9    1 : tunables   54   27    0 : slabdata      1      1      0
blkdev_requests       15     26    152   26    1 : tunables  120   60    0 : slabdata      1      1      0
biovec-(256)         256    256   3072    2    2 : tunables   24   12    0 : slabdata    128    128      0
biovec-128           256    260   1536    5    2 : tunables   24   12    0 : slabdata     52     52      0
biovec-64            256    260    768    5    1 : tunables   54   27    0 : slabdata     52     52      0
biovec-16            263    270    256   15    1 : tunables  120   60    0 : slabdata     18     18      0
biovec-4             258    305     64   61    1 : tunables  120   60    0 : slabdata      5      5      0
biovec-1             256    452     16  226    1 : tunables  120   60    0 : slabdata      2      2      0
bio                  269    366     64   61    1 : tunables  120   60    0 : slabdata      6      6      0
sock_inode_cache     218    230    384   10    1 : tunables   54   27    0 : slabdata     23     23      0
skbuff_head_cache    150    360    256   15    1 : tunables  120   60    0 : slabdata     24     24      0
sock                   2     10    384   10    1 : tunables   54   27    0 : slabdata      1      1      0
proc_inode_cache      25     50    384   10    1 : tunables   54   27    0 : slabdata      5      5      0
sigqueue              16     27    144   27    1 : tunables  120   60    0 : slabdata      1      1      0
radix_tree_node     4492   5082    276   14    1 : tunables   54   27    0 : slabdata    363    363      0
bdev_cache             7      7    512    7    1 : tunables   54   27    0 : slabdata      1      1      0
mnt_cache             18     61     64   61    1 : tunables  120   60    0 : slabdata      1      1      0
inode_cache         3133   3140    384   10    1 : tunables   54   27    0 : slabdata    314    314      0
dentry_cache       44391 136674    148   27    1 : tunables  120   60    0 : slabdata   5062   5062      0
filp                1867   1935    256   15    1 : tunables  120   60    0 : slabdata    129    129      0
names_cache            5      5   4096    1    1 : tunables   24   12    0 : slabdata      5      5      0
idr_layer_cache       44     58    136   29    1 : tunables  120   60    0 : slabdata      2      2      0
buffer_head        10600  12393     48   81    1 : tunables  120   60    0 : slabdata    153    153      0
mm_struct             57     63    512    7    1 : tunables   54   27    0 : slabdata      9      9      0
vm_area_struct      3556   3760     84   47    1 : tunables  120   60    0 : slabdata     80     80      0
fs_cache              56    119     32  119    1 : tunables  120   60    0 : slabdata      1      1      0
files_cache           57     63    512    7    1 : tunables   54   27    0 : slabdata      9      9      0
signal_cache          75     93    128   31    1 : tunables  120   60    0 : slabdata      3      3      0
sighand_cache         73     85   1408    5    2 : tunables   24   12    0 : slabdata     17     17      0
task_struct           97    105   1408    5    2 : tunables   24   12    0 : slabdata     21     21      0
anon_vma            1922   2442      8  407    1 : tunables  120   60    0 : slabdata      6      6      0
pgd                   57     57   4096    1    1 : tunables   24   12    0 : slabdata     57     57      0
size-131072(DMA)       0      0 131072    1   32 : tunables    8    4    0 : slabdata      0      0      0
size-131072            0      0 131072    1   32 : tunables    8    4    0 : slabdata      0      0      0
size-65536(DMA)        0      0  65536    1   16 : tunables    8    4    0 : slabdata      0      0      0
size-65536             2      2  65536    1   16 : tunables    8    4    0 : slabdata      2      2      0
size-32768(DMA)        0      0  32768    1    8 : tunables    8    4    0 : slabdata      0      0      0
size-32768            11     11  32768    1    8 : tunables    8    4    0 : slabdata     11     11      0
size-16384(DMA)        0      0  16384    1    4 : tunables    8    4    0 : slabdata      0      0      0
size-16384             5      5  16384    1    4 : tunables    8    4    0 : slabdata      5      5      0
size-8192(DMA)         0      0   8192    1    2 : tunables    8    4    0 : slabdata      0      0      0
size-8192            113    114   8192    1    2 : tunables    8    4    0 : slabdata    113    114      0
size-4096(DMA)         0      0   4096    1    1 : tunables   24   12    0 : slabdata      0      0      0
size-4096             39     39   4096    1    1 : tunables   24   12    0 : slabdata     39     39      0
size-2048(DMA)         0      0   2048    2    1 : tunables   24   12    0 : slabdata      0      0      0
size-2048             66     66   2048    2    1 : tunables   24   12    0 : slabdata     33     33      0
size-1024(DMA)         0      0   1024    4    1 : tunables   54   27    0 : slabdata      0      0      0
size-1024             84     84   1024    4    1 : tunables   54   27    0 : slabdata     21     21      0
size-512(DMA)          0      0    512    8    1 : tunables   54   27    0 : slabdata      0      0      0
size-512             214    576    512    8    1 : tunables   54   27    0 : slabdata     72     72      0
size-256(DMA)          0      0    256   15    1 : tunables  120   60    0 : slabdata      0      0      0
size-256            1035   1035    256   15    1 : tunables  120   60    0 : slabdata     69     69      0
size-128(DMA)          0      0    128   31    1 : tunables  120   60    0 : slabdata      0      0      0
size-128            3565   3565    128   31    1 : tunables  120   60    0 : slabdata    115    115      0
size-64(DMA)           0      0     64   61    1 : tunables  120   60    0 : slabdata      0      0      0
size-64             3044   4148     64   61    1 : tunables  120   60    0 : slabdata     68     68      0
size-32(DMA)           0      0     32  119    1 : tunables  120   60    0 : slabdata      0      0      0
size-32             1070   1309     32  119    1 : tunables  120   60    0 : slabdata     11     11      0
kmem_cache           155    155    128   31    1 : tunables  120   60    0 : slabdata      5      5      0

