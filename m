Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932584AbWASJQW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932584AbWASJQW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 04:16:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932588AbWASJQV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 04:16:21 -0500
Received: from relay00.pair.com ([209.68.5.9]:22533 "HELO relay00.pair.com")
	by vger.kernel.org with SMTP id S932585AbWASJQS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 04:16:18 -0500
X-pair-Authenticated: 67.163.102.102
From: Chase Venters <chase.venters@clientec.com>
Organization: Clientec, Inc.
To: Con Kolivas <kernel@kolivas.org>
Subject: scsi cmd slab leak? (Was Re: [ck] Anyone been having OOM killer problems lately?)
Date: Thu, 19 Jan 2006 03:15:42 -0600
User-Agent: KMail/1.9
Cc: ck@vds.kolivas.org, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
References: <200601181951.16708.chase.venters@clientec.com> <200601190113.32153.chase.venters@clientec.com> <200601191849.45002.kernel@kolivas.org>
In-Reply-To: <200601191849.45002.kernel@kolivas.org>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_rj1zDkYInabl2n/"
Message-Id: <200601190316.05247.chase.venters@clientec.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_rj1zDkYInabl2n/
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Thursday 19 January 2006 01:49, Con Kolivas wrote:
> > 	Do I have something madly leaking in my kernel?
>
> Yes! post /proc/slabinfo

(attached). Looks like quite a few scsi commands! Next steps?

> Con

Thanks!
Chase

--Boundary-00=_rj1zDkYInabl2n/
Content-Type: application/x-zerosize;
  name="slabinfo"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="slabinfo"

slabinfo - version: 2.1
# name            <active_objs> <num_objs> <objsize> <objperslab> <pagesperslab> : tunables <limit> <batchcount> <sharedfactor> : slabdata <active_slabs> <num_slabs> <sharedavail>
nv_pte_t             140    254     12  254    1 : tunables  120   60    8 : slabdata      1      1      0
li_hist_ccid3          0      0     32  113    1 : tunables  120   60    8 : slabdata      0      0      0
tx_hist_ccid3          0      0     32  113    1 : tunables  120   60    8 : slabdata      0      0      0
rx_hist_ccid3          0      0     32  113    1 : tunables  120   60    8 : slabdata      0      0      0
dccp_bind_bucket       0      0     16  203    1 : tunables  120   60    8 : slabdata      0      0      0
tw_sock_DCCP           0      0    128   30    1 : tunables  120   60    8 : slabdata      0      0      0
request_sock_DCCP      0      0    128   30    1 : tunables  120   60    8 : slabdata      0      0      0
DCCP                   1      4    896    4    1 : tunables   54   27    8 : slabdata      1      1      0
rpc_buffers            8      8   2048    2    1 : tunables   24   12    8 : slabdata      4      4      0
rpc_tasks              8     15    256   15    1 : tunables  120   60    8 : slabdata      1      1      0
rpc_inode_cache        0      0    512    7    1 : tunables   54   27    8 : slabdata      0      0      0
bridge_fdb_cache       0      0     64   59    1 : tunables  120   60    8 : slabdata      0      0      0
xfrm6_tunnel_spi       0      0     64   59    1 : tunables  120   60    8 : slabdata      0      0      0
fib6_nodes             5    113     32  113    1 : tunables  120   60    8 : slabdata      1      1      0
ip6_dst_cache          4     15    256   15    1 : tunables  120   60    8 : slabdata      1      1      0
ndisc_cache            1     15    256   15    1 : tunables  120   60    8 : slabdata      1      1      0
RAWv6                  3      5    768    5    1 : tunables   54   27    8 : slabdata      1      1      0
UDPv6                  0      0    640    6    1 : tunables   54   27    8 : slabdata      0      0      0
tw_sock_TCPv6          0      0    128   30    1 : tunables  120   60    8 : slabdata      0      0      0
request_sock_TCPv6      0      0    128   30    1 : tunables  120   60    8 : slabdata      0      0      0
TCPv6                  1      3   1280    3    1 : tunables   24   12    8 : slabdata      1      1      0
UNIX                 328    336    512    7    1 : tunables   54   27    8 : slabdata     48     48      0
tcp_bind_bucket       27    203     16  203    1 : tunables  120   60    8 : slabdata      1      1      0
inet_peer_cache        1     59     64   59    1 : tunables  120   60    8 : slabdata      1      1      0
secpath_cache          0      0    128   30    1 : tunables  120   60    8 : slabdata      0      0      0
xfrm_dst_cache         0      0    384   10    1 : tunables   54   27    8 : slabdata      0      0      0
ip_fib_alias          10    113     32  113    1 : tunables  120   60    8 : slabdata      1      1      0
ip_fib_hash           10    113     32  113    1 : tunables  120   60    8 : slabdata      1      1      0
ip_dst_cache          30     45    256   15    1 : tunables  120   60    8 : slabdata      3      3      0
arp_cache              3     15    256   15    1 : tunables  120   60    8 : slabdata      1      1      0
RAW                    2      7    512    7    1 : tunables   54   27    8 : slabdata      1      1      0
UDP                    4     14    512    7    1 : tunables   54   27    8 : slabdata      2      2      0
tw_sock_TCP            0      0    128   30    1 : tunables  120   60    8 : slabdata      0      0      0
request_sock_TCP       0      0     64   59    1 : tunables  120   60    8 : slabdata      0      0      0
TCP                   27     35   1152    7    2 : tunables   24   12    8 : slabdata      5      5      0
flow_cache             0      0    128   30    1 : tunables  120   60    8 : slabdata      0      0      0
dm-snapshot-in       128    134     56   67    1 : tunables  120   60    8 : slabdata      2      2      0
dm-snapshot-ex         0      0     24  145    1 : tunables  120   60    8 : slabdata      0      0      0
dm_mpath               0      0     28  127    1 : tunables  120   60    8 : slabdata      0      0      0
dm-crypt_io            0      0     68   56    1 : tunables  120   60    8 : slabdata      0      0      0
dm_tio                 0      0     16  203    1 : tunables  120   60    8 : slabdata      0      0      0
dm_io                  0      0     16  203    1 : tunables  120   60    8 : slabdata      0      0      0
i2o_block_req         32     33   2176    3    2 : tunables   24   12    8 : slabdata     11     11      0
uhci_urb_priv         13     92     40   92    1 : tunables  120   60    8 : slabdata      1      1      0
scsi_cmd_cache    1547440 1547440    384   10    1 : tunables   54   27    8 : slabdata 154744 154744      0
msi_cache              3      3   3840    1    1 : tunables   24   12    8 : slabdata      3      3      0
cfq_ioc_pool         468    468     48   78    1 : tunables  120   60    8 : slabdata      6      6      0
cfq_pool             480    480     96   40    1 : tunables  120   60    8 : slabdata     12     12      0
crq_pool             156    234     48   78    1 : tunables  120   60    8 : slabdata      3      3      0
deadline_drq           0      0     52   72    1 : tunables  120   60    8 : slabdata      0      0      0
as_arq                 0      0     64   59    1 : tunables  120   60    8 : slabdata      0      0      0
mqueue_inode_cache      1      6    640    6    1 : tunables   54   27    8 : slabdata      1      1      0
xfs_acl                0      0    304   13    1 : tunables   54   27    8 : slabdata      0      0      0
xfs_chashlist          0      0     20  169    1 : tunables  120   60    8 : slabdata      0      0      0
xfs_ili                0      0    140   28    1 : tunables  120   60    8 : slabdata      0      0      0
xfs_ifork              0      0     56   67    1 : tunables  120   60    8 : slabdata      0      0      0
xfs_efi_item           0      0    260   15    1 : tunables   54   27    8 : slabdata      0      0      0
xfs_efd_item           0      0    260   15    1 : tunables   54   27    8 : slabdata      0      0      0
xfs_buf_item           0      0    148   26    1 : tunables  120   60    8 : slabdata      0      0      0
xfs_dabuf              0      0     16  203    1 : tunables  120   60    8 : slabdata      0      0      0
xfs_da_state           0      0    336   11    1 : tunables   54   27    8 : slabdata      0      0      0
xfs_trans              0      0    600    6    1 : tunables   54   27    8 : slabdata      0      0      0
xfs_inode              0      0    384   10    1 : tunables   54   27    8 : slabdata      0      0      0
xfs_btree_cur          0      0    140   28    1 : tunables  120   60    8 : slabdata      0      0      0
xfs_bmap_free_item      0      0     16  203    1 : tunables  120   60    8 : slabdata      0      0      0
xfs_buf                0      0    232   17    1 : tunables  120   60    8 : slabdata      0      0      0
xfs_ioend             32     50     76   50    1 : tunables  120   60    8 : slabdata      1      1      0
xfs_vnode              0      0    420    9    1 : tunables   54   27    8 : slabdata      0      0      0
jfs_mp                32     50     76   50    1 : tunables  120   60    8 : slabdata      1      1      0
jfs_ip                 0      0    948    4    1 : tunables   54   27    8 : slabdata      0      0      0
relayfs_inode_cache      0      0    388   10    1 : tunables   54   27    8 : slabdata      0      0      0
udf_inode_cache        0      0    440    9    1 : tunables   54   27    8 : slabdata      0      0      0
fuse_request           0      0    324   12    1 : tunables   54   27    8 : slabdata      0      0      0
fuse_inode             0      0    512    7    1 : tunables   54   27    8 : slabdata      0      0      0
romfs_inode_cache      0      0    392   10    1 : tunables   54   27    8 : slabdata      0      0      0
cifs_small_rq         30     30    256   15    1 : tunables  120   60    8 : slabdata      2      2      0
cifs_request           4      4  16640    1    8 : tunables    8    4    0 : slabdata      4      4      0
cifs_oplock_structs      0      0     32  113    1 : tunables  120   60    8 : slabdata      0      0      0
cifs_mpx_ids           3     59     64   59    1 : tunables  120   60    8 : slabdata      1      1      0
cifs_inode_cache       0      0    420    9    1 : tunables   54   27    8 : slabdata      0      0      0
smb_request            0      0    256   15    1 : tunables  120   60    8 : slabdata      0      0      0
smb_inode_cache        0      0    408    9    1 : tunables   54   27    8 : slabdata      0      0      0
nfs_direct_cache       0      0     48   78    1 : tunables  120   60    8 : slabdata      0      0      0
nfs_write_data        36     42    512    7    1 : tunables   54   27    8 : slabdata      6      6      0
nfs_read_data         32     35    512    7    1 : tunables   54   27    8 : slabdata      5      5      0
nfs_inode_cache        0      0    688    5    1 : tunables   54   27    8 : slabdata      0      0      0
nfs_page               0      0     64   59    1 : tunables  120   60    8 : slabdata      0      0      0
hfs_inode_cache        0      0    640    6    1 : tunables   54   27    8 : slabdata      0      0      0
hfsplus_icache         0      0    640    6    1 : tunables   54   27    8 : slabdata      0      0      0
isofs_inode_cache      0      0    412    9    1 : tunables   54   27    8 : slabdata      0      0      0
fat_inode_cache        0      0    444    9    1 : tunables   54   27    8 : slabdata      0      0      0
fat_cache              0      0     20  169    1 : tunables  120   60    8 : slabdata      0      0      0
hugetlbfs_inode_cache      1     10    384   10    1 : tunables   54   27    8 : slabdata      1      1      0
ext2_inode_cache       0      0    528    7    1 : tunables   54   27    8 : slabdata      0      0      0
ext2_xattr             0      0     48   78    1 : tunables  120   60    8 : slabdata      0      0      0
journal_handle         0      0     20  169    1 : tunables  120   60    8 : slabdata      0      0      0
journal_head           0      0     52   72    1 : tunables  120   60    8 : slabdata      0      0      0
revoke_table           0      0     12  254    1 : tunables  120   60    8 : slabdata      0      0      0
revoke_record          0      0     16  203    1 : tunables  120   60    8 : slabdata      0      0      0
ext3_inode_cache       0      0    548    7    1 : tunables   54   27    8 : slabdata      0      0      0
ext3_xattr             0      0     48   78    1 : tunables  120   60    8 : slabdata      0      0      0
reiser_inode_cache  31988  47944    468    8    1 : tunables   54   27    8 : slabdata   5993   5993      0
dnotify_cache        262    338     20  169    1 : tunables  120   60    8 : slabdata      2      2      0
dquot                  0      0    256   15    1 : tunables  120   60    8 : slabdata      0      0      0
eventpoll_pwq          0      0     36  101    1 : tunables  120   60    8 : slabdata      0      0      0
eventpoll_epi          0      0    128   30    1 : tunables  120   60    8 : slabdata      0      0      0
inotify_event_cache      0      0     28  127    1 : tunables  120   60    8 : slabdata      0      0      0
inotify_watch_cache      0      0     36  101    1 : tunables  120   60    8 : slabdata      0      0      0
kioctx                 0      0    256   15    1 : tunables  120   60    8 : slabdata      0      0      0
kiocb                  0      0    128   30    1 : tunables  120   60    8 : slabdata      0      0      0
fasync_cache           1    203     16  203    1 : tunables  120   60    8 : slabdata      1      1      0
shmem_inode_cache   5277   5288    484    8    1 : tunables   54   27    8 : slabdata    661    661      0
swapped_entry     101291 124460     12  254    1 : tunables  120   60    8 : slabdata    490    490     54
posix_timers_cache      0      0    100   39    1 : tunables  120   60    8 : slabdata      0      0      0
uid_cache              5     59     64   59    1 : tunables  120   60    8 : slabdata      1      1      0
sgpool-128            32     32   2048    2    1 : tunables   24   12    8 : slabdata     16     16      0
sgpool-64             32     32   1024    4    1 : tunables   54   27    8 : slabdata      8      8      0
sgpool-32             40     40    512    8    1 : tunables   54   27    8 : slabdata      5      5      0
sgpool-16             38     45    256   15    1 : tunables  120   60    8 : slabdata      3      3      0
sgpool-8              48     60    128   30    1 : tunables  120   60    8 : slabdata      2      2      0
blkdev_ioc           149    254     28  127    1 : tunables  120   60    8 : slabdata      2      2      0
blkdev_queue          15     20    400   10    1 : tunables   54   27    8 : slabdata      2      2      0
blkdev_requests      132    192    160   24    1 : tunables  120   60    8 : slabdata      8      8      0
biovec-(256)         260    260   3072    2    2 : tunables   24   12    8 : slabdata    130    130      0
biovec-128           264    265   1536    5    2 : tunables   24   12    8 : slabdata     53     53      0
biovec-64            360    360    768    5    1 : tunables   54   27    8 : slabdata     72     72     54
biovec-16            300    300    256   15    1 : tunables  120   60    8 : slabdata     20     20      0
biovec-4             288    295     64   59    1 : tunables  120   60    8 : slabdata      5      5      0
biovec-1             391   1015     16  203    1 : tunables  120   60    8 : slabdata      5      5      6
bio                  468    660    128   30    1 : tunables  120   60    8 : slabdata     22     22    108
file_lock_cache       31     40     96   40    1 : tunables  120   60    8 : slabdata      1      1      0
sock_inode_cache     373    385    512    7    1 : tunables   54   27    8 : slabdata     55     55      0
skbuff_fclone_cache     20     20    384   10    1 : tunables   54   27    8 : slabdata      2      2      0
skbuff_head_cache   1067   1590    256   15    1 : tunables  120   60    8 : slabdata    106    106      0
proc_inode_cache     190    190    400   10    1 : tunables   54   27    8 : slabdata     19     19      0
sigqueue             102    135    144   27    1 : tunables  120   60    8 : slabdata      5      5      0
radix_tree_node    15802  17640    276   14    1 : tunables   54   27    8 : slabdata   1260   1260    216
bdev_cache            17     21    512    7    1 : tunables   54   27    8 : slabdata      3      3      0
sysfs_dir_cache     4723   4784     40   92    1 : tunables  120   60    8 : slabdata     52     52      0
mnt_cache             24     30    128   30    1 : tunables  120   60    8 : slabdata      1      1      0
inode_cache         1325   1340    384   10    1 : tunables   54   27    8 : slabdata    134    134      0
dentry_cache       28586  45522    144   27    1 : tunables  120   60    8 : slabdata   1686   1686      0
filp                4246   4590    256   15    1 : tunables  120   60    8 : slabdata    306    306     15
names_cache            8      8   4096    1    1 : tunables   24   12    8 : slabdata      8      8      0
idr_layer_cache      116    116    136   29    1 : tunables  120   60    8 : slabdata      4      4      0
buffer_head         6726  12960     52   72    1 : tunables  120   60    8 : slabdata    180    180    300
mm_struct            131    133    512    7    1 : tunables   54   27    8 : slabdata     19     19      0
vm_area_struct     10607  11132     88   44    1 : tunables  120   60    8 : slabdata    253    253    150
fs_cache             135    177     64   59    1 : tunables  120   60    8 : slabdata      3      3      0
files_cache          131    133    512    7    1 : tunables   54   27    8 : slabdata     19     19      0
signal_cache         168    170    384   10    1 : tunables   54   27    8 : slabdata     17     17      0
sighand_cache        163    165   1408    5    2 : tunables   24   12    8 : slabdata     33     33      0
task_struct          186    186   1312    3    1 : tunables   24   12    8 : slabdata     62     62      0
anon_vma            3892   4263     16  203    1 : tunables  120   60    8 : slabdata     21     21      0
pgd                  130    131   4096    1    1 : tunables   24   12    8 : slabdata    130    131      0
size-131072(DMA)       0      0 131072    1   32 : tunables    8    4    0 : slabdata      0      0      0
size-131072            0      0 131072    1   32 : tunables    8    4    0 : slabdata      0      0      0
size-65536(DMA)        0      0  65536    1   16 : tunables    8    4    0 : slabdata      0      0      0
size-65536             8      8  65536    1   16 : tunables    8    4    0 : slabdata      8      8      0
size-32768(DMA)        0      0  32768    1    8 : tunables    8    4    0 : slabdata      0      0      0
size-32768             1      1  32768    1    8 : tunables    8    4    0 : slabdata      1      1      0
size-16384(DMA)        0      0  16384    1    4 : tunables    8    4    0 : slabdata      0      0      0
size-16384            10     10  16384    1    4 : tunables    8    4    0 : slabdata     10     10      0
size-8192(DMA)         0      0   8192    1    2 : tunables    8    4    0 : slabdata      0      0      0
size-8192             13     13   8192    1    2 : tunables    8    4    0 : slabdata     13     13      0
size-4096(DMA)         0      0   4096    1    1 : tunables   24   12    8 : slabdata      0      0      0
size-4096            481    481   4096    1    1 : tunables   24   12    8 : slabdata    481    481      0
size-2048(DMA)         0      0   2048    2    1 : tunables   24   12    8 : slabdata      0      0      0
size-2048            353    366   2048    2    1 : tunables   24   12    8 : slabdata    183    183      0
size-1024(DMA)         0      0   1024    4    1 : tunables   54   27    8 : slabdata      0      0      0
size-1024            272    272   1024    4    1 : tunables   54   27    8 : slabdata     68     68      0
size-512(DMA)          0      0    512    8    1 : tunables   54   27    8 : slabdata      0      0      0
size-512            1372   1776    512    8    1 : tunables   54   27    8 : slabdata    222    222     27
size-256(DMA)          0      0    256   15    1 : tunables  120   60    8 : slabdata      0      0      0
size-256            1076   1080    256   15    1 : tunables  120   60    8 : slabdata     72     72      0
size-128(DMA)          0      0    128   30    1 : tunables  120   60    8 : slabdata      0      0      0
size-128            1970   2700    128   30    1 : tunables  120   60    8 : slabdata     90     90     22
size-64(DMA)           0      0     64   59    1 : tunables  120   60    8 : slabdata      0      0      0
size-32(DMA)           0      0     32  113    1 : tunables  120   60    8 : slabdata      0      0      0
size-64             8535  12272     64   59    1 : tunables  120   60    8 : slabdata    208    208    480
size-32             3159   4407     32  113    1 : tunables  120   60    8 : slabdata     39     39      7
kmem_cache           210    210    128   30    1 : tunables  120   60    8 : slabdata      7      7      0

--Boundary-00=_rj1zDkYInabl2n/--
