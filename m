Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272646AbTG1EUt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jul 2003 00:20:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272648AbTG1EUt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jul 2003 00:20:49 -0400
Received: from smtp015.mail.yahoo.com ([216.136.173.59]:7689 "HELO
	smtp015.mail.yahoo.com") by vger.kernel.org with SMTP
	id S272646AbTG1EUo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jul 2003 00:20:44 -0400
From: Marino Fernandez <mjferna@yahoo.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: Memory runs out fast with 2.6.0-test2 (and test1)
Date: Sun, 27 Jul 2003 23:35:55 -0500
User-Agent: KMail/1.5.2
Cc: linux-kernel@vger.kernel.org
References: <200307272117.23398.mjferna@yahoo.com> <20030727205912.1bb4a635.akpm@osdl.org>
In-Reply-To: <20030727205912.1bb4a635.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_rgKJ/C9gFEaLQFD"
Message-Id: <200307272335.55550.mjferna@yahoo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_rgKJ/C9gFEaLQFD
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Sunday 27 July 2003 10:59 pm, Andrew Morton wrote:
> Marino Fernandez <mjferna@yahoo.com> wrote:
> > Everything works OK in my system... my only gripe is that I run out of
> > memory quickly.
>
> Please monitor /proc/meminfo and /proc/slabinfo, see if you can work out
> where the memory has gone and post the results.
>
> What filesystems are you using there?

ext3

The rest of the info is attached

--Boundary-00=_rgKJ/C9gFEaLQFD
Content-Type: text/plain;
  charset="iso-8859-1";
  name="filesystems"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="filesystems"

This is from my config file:
# File systems
#
CONFIG_EXT2_FS=y
CONFIG_EXT3_FS=y
CONFIG_EXT3_FS_XATTR=y
CONFIG_JBD=y
CONFIG_JBD_DEBUG=y
CONFIG_FS_MBCACHE=y
CONFIG_REISERFS_FS=m
CONFIG_JFS_FS=m
CONFIG_MINIX_FS=m
CONFIG_ROMFS_FS=m
CONFIG_QUOTA=y
CONFIG_QUOTACTL=y

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=y
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
CONFIG_ZISOFS_FS=y
CONFIG_UDF_FS=m

#
# DOS/FAT/NT Filesystems
#
CONFIG_FAT_FS=y
CONFIG_MSDOS_FS=y
CONFIG_VFAT_FS=y
CONFIG_NTFS_FS=m

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
CONFIG_DEVPTS_FS=y
CONFIG_TMPFS=y
CONFIG_RAMFS=y

#
# Miscellaneous filesystems
#
CONFIG_ADFS_FS=m
CONFIG_ADFS_FS_RW=y
CONFIG_AFFS_FS=m
CONFIG_HFS_FS=m
CONFIG_BEFS_FS=m
CONFIG_BFS_FS=m
CONFIG_EFS_FS=m
CONFIG_CRAMFS=m
CONFIG_VXFS_FS=m
CONFIG_HPFS_FS=m
CONFIG_QNX4FS_FS=m
CONFIG_QNX4FS_RW=y
CONFIG_SYSV_FS=m
CONFIG_UFS_FS=m
CONFIG_UFS_FS_WRITE=y
--Boundary-00=_rgKJ/C9gFEaLQFD
Content-Type: text/plain;
  charset="iso-8859-1";
  name="meminfo and slabinfo"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="meminfo and slabinfo"

Marino@lifebook:~$ cat /proc/meminfo
MemTotal:       507012 kB
MemFree:         15176 kB
Buffers:         21988 kB
Cached:         242712 kB
SwapCached:          0 kB
Active:         314124 kB
Inactive:        56116 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:       507012 kB
LowFree:         15176 kB
SwapTotal:      305196 kB
SwapFree:       305196 kB
Dirty:            1936 kB
Writeback:           0 kB
Mapped:         135904 kB
Slab:            23976 kB
Committed_AS:   144028 kB
PageTables:       2824 kB
VmallocTotal:   524216 kB
VmallocUsed:     15116 kB
VmallocChunk:   509044 kB

Marino@lifebook:~$ cat /proc/slabinfo
slabinfo - version: 2.0
# name            <active_objs> <num_objs> <objsize> <objperslab> <pagesperslab> : tunables <batchcount> <limit> <sharedfactor> : slabdata <active_slabs> <num_slabs> <sharedavail>
secpath6_cache         0      0    128   30    1 : tunables  120   60    0 : slabdata      0      0      0
fib6_nodes             5    113     32  113    1 : tunables  120   60    0 : slabdata      1      1      0
ip6_dst_cache          5     17    224   17    1 : tunables  120   60    0 : slabdata      1      1      0
ndisc_cache            1     24    160   24    1 : tunables  120   60    0 : slabdata      1      1      0
raw6_sock              0      0    576    7    1 : tunables   54   27    0 : slabdata      0      0      0
udp6_sock              0      0    576    7    1 : tunables   54   27    0 : slabdata      0      0      0
tcp6_sock              7     12    992    4    1 : tunables   54   27    0 : slabdata      3      3      0
ip_conntrack          11     12    320   12    1 : tunables   54   27    0 : slabdata      1      1      0
ip_fib_hash            9    202     16  202    1 : tunables  120   60    0 : slabdata      1      1      0
uhci_urb_priv          0      0     60   63    1 : tunables  120   60    0 : slabdata      0      0      0
ntfs_big_inode_cache    585    588    512    7    1 : tunables   54   27    0 : slabdata     84     84      0
ntfs_inode_cache       3     20    192   20    1 : tunables  120   60    0 : slabdata      1      1      0
ntfs_name_cache        0      0    512    8    1 : tunables   54   27    0 : slabdata      0      0      0
ntfs_attr_ctx_cache      0      0     32  113    1 : tunables  120   60    0 : slabdata      0      0      0
clip_arp_cache         0      0    160   24    1 : tunables  120   60    0 : slabdata      0      0      0
unix_sock            205    210    384   10    1 : tunables   54   27    0 : slabdata     21     21      0
tcp_tw_bucket          0      0    128   30    1 : tunables  120   60    0 : slabdata      0      0      0
tcp_bind_bucket       11    202     16  202    1 : tunables  120   60    0 : slabdata      1      1      0
tcp_open_request       0      0     96   40    1 : tunables  120   60    0 : slabdata      0      0      0
inet_peer_cache        0      0     64   59    1 : tunables  120   60    0 : slabdata      0      0      0
secpath4_cache         0      0    128   30    1 : tunables  120   60    0 : slabdata      0      0      0
xfrm_dst_cache         0      0    256   15    1 : tunables  120   60    0 : slabdata      0      0      0
ip_dst_cache          13     15    256   15    1 : tunables  120   60    0 : slabdata      1      1      0
arp_cache              2     24    160   24    1 : tunables  120   60    0 : slabdata      1      1      0
raw4_sock              0      0    448    9    1 : tunables   54   27    0 : slabdata      0      0      0
udp_sock               5      9    448    9    1 : tunables   54   27    0 : slabdata      1      1      0
tcp_sock              22     24    896    4    1 : tunables   54   27    0 : slabdata      6      6      0
flow_cache             0      0     96   40    1 : tunables  120   60    0 : slabdata      0      0      0
scsi_cmd_cache         1     12    320   12    1 : tunables   54   27    0 : slabdata      1      1      0
isofs_inode_cache      0      0    384   10    1 : tunables   54   27    0 : slabdata      0      0      0
fat_inode_cache      497    504    416    9    1 : tunables   54   27    0 : slabdata     56     56      0
ext2_inode_cache       0      0    480    8    1 : tunables   54   27    0 : slabdata      0      0      0
journal_handle         2    126     28  126    1 : tunables  120   60    0 : slabdata      1      1      0
journal_head         306    858     48   78    1 : tunables  120   60    0 : slabdata     11     11      0
revoke_table          10    253     12  253    1 : tunables  120   60    0 : slabdata      1      1      0
revoke_record          0      0     16  202    1 : tunables  120   60    0 : slabdata      0      0      0
ext3_inode_cache   14907  15050    512    7    1 : tunables   54   27    0 : slabdata   2150   2150      0
ext3_xattr             0      0     44   84    1 : tunables  120   60    0 : slabdata      0      0      0
dquot                  0      0    128   30    1 : tunables  120   60    0 : slabdata      0      0      0
eventpoll_pwq          0      0     36  101    1 : tunables  120   60    0 : slabdata      0      0      0
eventpoll_epi          0      0     96   40    1 : tunables  120   60    0 : slabdata      0      0      0
kioctx                 0      0    192   20    1 : tunables  120   60    0 : slabdata      0      0      0
kiocb                  0      0    160   24    1 : tunables  120   60    0 : slabdata      0      0      0
dnotify_cache          0      0     20  169    1 : tunables  120   60    0 : slabdata      0      0      0
file_lock_cache      107    120     96   40    1 : tunables  120   60    0 : slabdata      3      3      0
fasync_cache           2    202     16  202    1 : tunables  120   60    0 : slabdata      1      1      0
shmem_inode_cache      3      9    448    9    1 : tunables   54   27    0 : slabdata      1      1      0
idr_layer_cache        0      0    136   28    1 : tunables  120   60    0 : slabdata      0      0      0
posix_timers_cache      0      0     88   44    1 : tunables  120   60    0 : slabdata      0      0      0
uid_cache              3    113     32  113    1 : tunables  120   60    0 : slabdata      1      1      0
sgpool-MAX_PHYS_SEGMENTS     32     32   2048    2    1 : tunables   24   12    0 : slabdata     16     16      0
sgpool-64             32     32   1024    4    1 : tunables   54   27    0 : slabdata      8      8      0
sgpool-32             32     32    512    8    1 : tunables   54   27    0 : slabdata      4      4      0
sgpool-16             32     45    256   15    1 : tunables  120   60    0 : slabdata      3      3      0
sgpool-8              32     60    128   30    1 : tunables  120   60    0 : slabdata      2      2      0
deadline_drq           0      0     48   78    1 : tunables  120   60    0 : slabdata      0      0      0
as_arq                78    189     60   63    1 : tunables  120   60    0 : slabdata      2      3      0
blkdev_requests       82    130    152   26    1 : tunables  120   60    0 : slabdata      5      5      0
biovec-BIO_MAX_PAGES    256    260   3072    5    4 : tunables   24   12    0 : slabdata     52     52      0
biovec-128           256    260   1536    5    2 : tunables   24   12    0 : slabdata     52     52      0
biovec-64            256    260    768    5    1 : tunables   54   27    0 : slabdata     52     52      0
biovec-16            256    260    192   20    1 : tunables  120   60    0 : slabdata     13     13      0
biovec-4             256    295     64   59    1 : tunables  120   60    0 : slabdata      5      5      0
biovec-1             342    606     16  202    1 : tunables  120   60    0 : slabdata      3      3      0
bio                  291    531     64   59    1 : tunables  120   60    0 : slabdata      9      9      0
sock_inode_cache     241    250    384   10    1 : tunables   54   27    0 : slabdata     25     25      0
skbuff_head_cache    120    120    192   20    1 : tunables  120   60    0 : slabdata      6      6      0
sock                   4     11    352   11    1 : tunables   54   27    0 : slabdata      1      1      0
proc_inode_cache     267    390    384   10    1 : tunables   54   27    0 : slabdata     39     39      0
sigqueue              27     27    144   27    1 : tunables  120   60    0 : slabdata      1      1      0
radix_tree_node     7174   7515    260   15    1 : tunables   54   27    0 : slabdata    501    501      0
bdev_cache            12     40     96   40    1 : tunables  120   60    0 : slabdata      1      1      0
mnt_cache             26     59     64   59    1 : tunables  120   60    0 : slabdata      1      1      0
inode_cache         1144   1144    352   11    1 : tunables   54   27    0 : slabdata    104    104      0
dentry_cache       21120  21120    160   24    1 : tunables  120   60    0 : slabdata    880    880      0
filp                1248   1248    160   24    1 : tunables  120   60    0 : slabdata     52     52      0
names_cache            7      7   4096    1    1 : tunables   24   12    0 : slabdata      7      7      0
buffer_head        53766  56784     48   78    1 : tunables  120   60    0 : slabdata    728    728      0
mm_struct             70     70    384   10    1 : tunables   54   27    0 : slabdata      7      7      0
vm_area_struct      3658   3658     64   59    1 : tunables  120   60    0 : slabdata     62     62      0
fs_cache              74    118     64   59    1 : tunables  120   60    0 : slabdata      2      2      0
files_cache           63     63    416    9    1 : tunables   54   27    0 : slabdata      7      7      0
signal_cache          96    118     64   59    1 : tunables  120   60    0 : slabdata      2      2      0
sighand_cache         78     78   1312    3    1 : tunables   24   12    0 : slabdata     26     26      0
task_struct           85     85   1568    5    2 : tunables   24   12    0 : slabdata     17     17      0
pte_chain          28473  28702     32  113    1 : tunables  120   60    0 : slabdata    254    254      0
size-131072(DMA)       0      0 131072    1   32 : tunables    8    4    0 : slabdata      0      0      0
size-131072            0      0 131072    1   32 : tunables    8    4    0 : slabdata      0      0      0
size-65536(DMA)        0      0  65536    1   16 : tunables    8    4    0 : slabdata      0      0      0
size-65536             0      0  65536    1   16 : tunables    8    4    0 : slabdata      0      0      0
size-32768(DMA)        0      0  32768    1    8 : tunables    8    4    0 : slabdata      0      0      0
size-32768             2      2  32768    1    8 : tunables    8    4    0 : slabdata      2      2      0
size-16384(DMA)        0      0  16384    1    4 : tunables    8    4    0 : slabdata      0      0      0
size-16384             7      7  16384    1    4 : tunables    8    4    0 : slabdata      7      7      0
size-8192(DMA)         0      0   8192    1    2 : tunables    8    4    0 : slabdata      0      0      0
size-8192             87     87   8192    1    2 : tunables    8    4    0 : slabdata     87     87      0
size-4096(DMA)         0      0   4096    1    1 : tunables   24   12    0 : slabdata      0      0      0
size-4096             94     94   4096    1    1 : tunables   24   12    0 : slabdata     94     94      0
size-2048(DMA)         0      0   2048    2    1 : tunables   24   12    0 : slabdata      0      0      0
size-2048             28     28   2048    2    1 : tunables   24   12    0 : slabdata     14     14      0
size-1024(DMA)         0      0   1024    4    1 : tunables   54   27    0 : slabdata      0      0      0
size-1024             80     80   1024    4    1 : tunables   54   27    0 : slabdata     20     20      0
size-512(DMA)          0      0    512    8    1 : tunables   54   27    0 : slabdata      0      0      0
size-512             209    224    512    8    1 : tunables   54   27    0 : slabdata     28     28      0
size-256(DMA)          0      0    256   15    1 : tunables  120   60    0 : slabdata      0      0      0
size-256             102    150    256   15    1 : tunables  120   60    0 : slabdata     10     10      0
size-192(DMA)          0      0    192   20    1 : tunables  120   60    0 : slabdata      0      0      0
size-192             100    180    192   20    1 : tunables  120   60    0 : slabdata      9      9      0
size-128(DMA)          0      0    128   30    1 : tunables  120   60    0 : slabdata      0      0      0
size-128             175    210    128   30    1 : tunables  120   60    0 : slabdata      7      7      0
size-96(DMA)           0      0     96   40    1 : tunables  120   60    0 : slabdata      0      0      0
size-96              806    840     96   40    1 : tunables  120   60    0 : slabdata     21     21      0
size-64(DMA)           0      0     64   59    1 : tunables  120   60    0 : slabdata      0      0      0
size-64             1946   2006     64   59    1 : tunables  120   60    0 : slabdata     34     34      0
size-32(DMA)           0      0     32  113    1 : tunables  120   60    0 : slabdata      0      0      0
size-32             2659   2712     32  113    1 : tunables  120   60    0 : slabdata     24     24      0
kmem_cache           128    128    120   32    1 : tunables  120   60    0 : slabdata      4      4      0

--Boundary-00=_rgKJ/C9gFEaLQFD--

