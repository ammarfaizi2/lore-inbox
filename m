Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269766AbUINVSN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269766AbUINVSN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 17:18:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269666AbUINVPG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 17:15:06 -0400
Received: from c7ns3.center7.com ([216.250.142.14]:1927 "EHLO
	smtp.slc03.viawest.net") by vger.kernel.org with ESMTP
	id S269165AbUINVGJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 17:06:09 -0400
Message-ID: <4147555C.7010809@drdos.com>
Date: Tue, 14 Sep 2004 14:32:28 -0600
From: "Jeff V. Merkey" <jmerkey@drdos.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nick Piggin <nickpiggin@yahoo.com.au>, linux-kernel@vger.kernel.org,
       jmerkey@comcast.net
Subject: Re: 2.6.8.1 mempool subsystem sickness
References: <091420042058.15928.41475B8000002BA100003E382200763704970A059D0A0306@comcast.net>
In-Reply-To: <091420042058.15928.41475B8000002BA100003E382200763704970A059D0A0306@comcast.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Jeff,

> Can you give us a few more details please? Post the allocation failure
> messages in full, and post /proc/meminfo, etc. Thanks.
> -
>
Here you go.

Jeff

Sep 14 14:18:59 datascout4 kernel: if_regen2: page allocation failure. order:3, 
mode:0x20
Sep 14 14:18:59 datascout4 kernel:  [<80106c7e>] dump_stack+0x1e/0x30
Sep 14 14:18:59 datascout4 kernel:  [<80134aac>] __alloc_pages+0x2dc/0x350
Sep 14 14:18:59 datascout4 kernel:  [<80134b42>] __get_free_pages+0x22/0x50
Sep 14 14:18:59 datascout4 kernel:  [<80137d9f>] kmem_getpages+0x1f/0xd0
Sep 14 14:18:59 datascout4 kernel:  [<8013897a>] cache_grow+0x9a/0x130
Sep 14 14:18:59 datascout4 kernel:  [<80138b4b>] cache_alloc_refill+0x13b/0x1e0
Sep 14 14:18:59 datascout4 kernel:  [<80138fa4>] __kmalloc+0x74/0x80
Sep 14 14:18:59 datascout4 kernel:  [<80299298>] alloc_skb+0x48/0xf0
Sep 14 14:18:59 datascout4 kernel:  [<f8972e67>] create_xmit_packet+0x57/0x100 
[dsfs]
Sep 14 14:18:59 datascout4 kernel:  [<f8973150>] regen_data+0x60/0x1d0 [dsfs]
Sep 14 14:18:59 datascout4 kernel:  [<80104355>] kernel_thread_helper+0x5/0x10
Sep 14 14:18:59 datascout4 kernel: printk: 12 messages suppressed.

MemTotal:      1944860 kB
MemFree:        200008 kB
Buffers:        133772 kB
Cached:         678268 kB
SwapCached:        208 kB
Active:         435712 kB
Inactive:       436756 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:      1944860 kB
LowFree:        200008 kB
SwapTotal:     1052248 kB
SwapFree:      1051976 kB
Dirty:            7960 kB
Writeback:           0 kB
Mapped:          68160 kB
Slab:           863556 kB
Committed_AS:    92220 kB
PageTables:       1344 kB
VmallocTotal:   122804 kB
VmallocUsed:      2872 kB
VmallocChunk:   119856 kB

evdev 7552 0 - Live 0xf8aa3000
ipx 24364 0 - Live 0xf89f5000
appletalk 29748 0 - Live 0xf8ad8000
parport_pc 22464 1 - Live 0xf89e3000
lp 9644 0 - Live 0xf880f000
parport 34376 2 parport_pc,lp, Live 0xf8aab000
autofs4 15492 0 - Live 0xf89f0000
rfcomm 32412 0 - Live 0xf8a96000
l2cap 19460 5 rfcomm, Live 0xf89ea000
bluetooth 39812 4 rfcomm,l2cap, Live 0xf89ce000
sunrpc 126436 1 - Live 0xf8ab8000
e1000 83460 0 - Live 0xf89fc000
sg 33568 0 - Live 0xf89d9000
microcode 5536 0 - Live 0xf8851000
ide_cd 36512 0 - Live 0xf890c000
cdrom 35868 1 ide_cd, Live 0xf8867000
dsfs 269912 1 - Live 0xf896d000
sd_mod 17280 2 - Live 0xf8861000
3w_xxxx 35108 2 - Live 0xf8822000
scsi_mod 103244 3 sg,sd_mod,3w_xxxx, Live 0xf8923000
dm_mod 49788 0 - Live 0xf8871000
orinoco_usb 22440 0 - Live 0xf8847000
firmware_class 7424 1 orinoco_usb, Live 0xf8813000
orinoco 44048 1 orinoco_usb, Live 0xf8855000
uhci_hcd 28944 0 - Live 0xf8819000
usbcore 99300 4 orinoco_usb,uhci_hcd, Live 0xf882d000

slabinfo - version: 2.0
# name            <active_objs> <num_objs> <objsize> <objperslab> <pagesperslab> 
: tunables <batchcount> <limit> <sharedfactor> : slabdata <active_slabs> 
<num_slabs> <sharedavail>
bt_sock                3     10    384   10    1 : tunables   54   27    0 : 
slabdata      1      1      0
rpc_buffers            8      8   2048    2    1 : tunables   24   12    0 : 
slabdata      4      4      0
rpc_tasks              8     15    256   15    1 : tunables  120   60    0 : 
slabdata      1      1      0
rpc_inode_cache        6      7    512    7    1 : tunables   54   27    0 : 
slabdata      1      1      0
ip_fib_hash           11    226     16  226    1 : tunables  120   60    0 : 
slabdata      1      1      0
scsi_cmd_cache       160    160    384   10    1 : tunables   54   27    0 : 
slabdata     16     16      0
sgpool-128            32     32   2048    2    1 : tunables   24   12    0 : 
slabdata     16     16      0
sgpool-64             32     32   1024    4    1 : tunables   54   27    0 : 
slabdata      8      8      0
sgpool-32             32     32    512    8    1 : tunables   54   27    0 : 
slabdata      4      4      0
sgpool-16             32     45    256   15    1 : tunables  120   60    0 : 
slabdata      3      3      0
sgpool-8             217    217    128   31    1 : tunables  120   60    0 : 
slabdata      7      7      0
dm_tio                 0      0     16  226    1 : tunables  120   60    0 : 
slabdata      0      0      0
dm_io                  0      0     16  226    1 : tunables  120   60    0 : 
slabdata      0      0      0
uhci_urb_priv          1     88     44   88    1 : tunables  120   60    0 : 
slabdata      1      1      0
dn_fib_info_cache      0      0    128   31    1 : tunables  120   60    0 : 
slabdata      0      0      0
dn_dst_cache           0      0    256   15    1 : tunables  120   60    0 : 
slabdata      0      0      0
dn_neigh_cache         0      0    256   15    1 : tunables  120   60    0 : 
slabdata      0      0      0
decnet_socket_cache      0      0    768    5    1 : tunables   54   27    0 : 
slabdata      0      0      0
clip_arp_cache         0      0    256   15    1 : tunables  120   60    0 : 
slabdata      0      0      0
xfrm6_tunnel_spi       0      0     64   61    1 : tunables  120   60    0 : 
slabdata      0      0      0
fib6_nodes            15    119     32  119    1 : tunables  120   60    0 : 
slabdata      1      1      0
ip6_dst_cache         60    105    256   15    1 : tunables  120   60    0 : 
slabdata      7      7      0
ndisc_cache            5     15    256   15    1 : tunables  120   60    0 : 
slabdata      1      1      0
raw6_sock              0      0    640    6    1 : tunables   54   27    0 : 
slabdata      0      0      0
udp6_sock              0      0    640    6    1 : tunables   54   27    0 : 
slabdata      0      0      0
tcp6_sock              7      7   1152    7    2 : tunables   24   12    0 : 
slabdata      1      1      0
unix_sock             50     50    384   10    1 : tunables   54   27    0 : 
slabdata      5      5      0
ip_mrt_cache           0      0    128   31    1 : tunables  120   60    0 : 
slabdata      0      0      0
tcp_tw_bucket          0      0    128   31    1 : tunables  120   60    0 : 
slabdata      0      0      0
tcp_bind_bucket        8    226     16  226    1 : tunables  120   60    0 : 
slabdata      1      1      0
tcp_open_request       0      0    128   31    1 : tunables  120   60    0 : 
slabdata      0      0      0
inet_peer_cache        0      0     64   61    1 : tunables  120   60    0 : 
slabdata      0      0      0
secpath_cache          0      0    128   31    1 : tunables  120   60    0 : 
slabdata      0      0      0
xfrm_dst_cache         0      0    256   15    1 : tunables  120   60    0 : 
slabdata      0      0      0
ip_dst_cache          20     30    256   15    1 : tunables  120   60    0 : 
slabdata      2      2      0
arp_cache              1     31    128   31    1 : tunables  120   60    0 : 
slabdata      1      1      0
raw4_sock              0      0    512    7    1 : tunables   54   27    0 : 
slabdata      0      0      0
udp_sock               3      7    512    7    1 : tunables   54   27    0 : 
slabdata      1      1      0
tcp_sock              16     16   1024    4    1 : tunables   54   27    0 : 
slabdata      4      4      0
flow_cache             0      0    128   31    1 : tunables  120   60    0 : 
slabdata      0      0      0
isofs_inode_cache      0      0    384   10    1 : tunables   54   27    0 : 
slabdata      0      0      0
fat_inode_cache        0      0    384   10    1 : tunables   54   27    0 : 
slabdata      0      0      0
ext2_inode_cache       0      0    512    7    1 : tunables   54   27    0 : 
slabdata      0      0      0
journal_handle         8    135     28  135    1 : tunables  120   60    0 : 
slabdata      1      1      0
journal_head         456   2349     48   81    1 : tunables  120   60    0 : 
slabdata     29     29      0
revoke_table           4    290     12  290    1 : tunables  120   60    0 : 
slabdata      1      1      0
revoke_record          0      0     16  226    1 : tunables  120   60    0 : 
slabdata      0      0      0
ext3_inode_cache  336400 340655    512    7    1 : tunables   54   27    0 : 
slabdata  48665  48665      0
ext3_xattr             0      0     44   88    1 : tunables  120   60    0 : 
slabdata      0      0      0
reiser_inode_cache      0      0    384   10    1 : tunables   54   27    0 : 
slabdata      0      0      0
dquot                  0      0    128   31    1 : tunables  120   60    0 : 
slabdata      0      0      0
eventpoll_pwq          0      0     36  107    1 : tunables  120   60    0 : 
slabdata      0      0      0
eventpoll_epi          0      0    128   31    1 : tunables  120   60    0 : 
slabdata      0      0      0
kioctx                 0      0    256   15    1 : tunables  120   60    0 : 
slabdata      0      0      0
kiocb                  0      0    128   31    1 : tunables  120   60    0 : 
slabdata      0      0      0
dnotify_cache          1    185     20  185    1 : tunables  120   60    0 : 
slabdata      1      1      0
file_lock_cache        2     43     92   43    1 : tunables  120   60    0 : 
slabdata      1      1      0
fasync_cache           0      0     16  226    1 : tunables  120   60    0 : 
slabdata      0      0      0
shmem_inode_cache      8     14    512    7    1 : tunables   54   27    0 : 
slabdata      2      2      0
posix_timers_cache      0      0     96   41    1 : tunables  120   60    0 : 
slabdata      0      0      0
uid_cache              9    119     32  119    1 : tunables  120   60    0 : 
slabdata      1      1      0
cfq_pool              64    119     32  119    1 : tunables  120   60    0 : 
slabdata      1      1      0
crq_pool               0      0     36  107    1 : tunables  120   60    0 : 
slabdata      0      0      0
deadline_drq           0      0     48   81    1 : tunables  120   60    0 : 
slabdata      0      0      0
as_arq               200    260     60   65    1 : tunables  120   60    0 : 
slabdata      4      4      0
blkdev_ioc            35    185     20  185    1 : tunables  120   60    0 : 
slabdata      1      1      0
blkdev_queue          21     27    448    9    1 : tunables   54   27    0 : 
slabdata      3      3      0
blkdev_requests      252    286    152   26    1 : tunables  120   60    0 : 
slabdata     11     11      0
biovec-(256)         256    256   3072    2    2 : tunables   24   12    0 : 
slabdata    128    128      0
biovec-128           256    260   1536    5    2 : tunables   24   12    0 : 
slabdata     52     52      0
biovec-64            256    260    768    5    1 : tunables   54   27    0 : 
slabdata     52     52      0
biovec-16         131328 131340    256   15    1 : tunables  120   60    0 : 
slabdata   8756   8756      0
biovec-4             256    305     64   61    1 : tunables  120   60    0 : 
slabdata      5      5      0
biovec-1             404    678     16  226    1 : tunables  120   60    0 : 
slabdata      3      3      0
bio               131457 131577     64   61    1 : tunables  120   60    0 : 
slabdata   2157   2157      0
sock_inode_cache      60     60    384   10    1 : tunables   54   27    0 : 
slabdata      6      6      0
skbuff_head_cache   2130   2370    256   15    1 : tunables  120   60    0 : 
slabdata    158    158      0
sock                   4     10    384   10    1 : tunables   54   27    0 : 
slabdata      1      1      0
proc_inode_cache     409    470    384   10    1 : tunables   54   27    0 : 
slabdata     47     47      0
sigqueue              27     27    148   27    1 : tunables  120   60    0 : 
slabdata      1      1      0
radix_tree_node    53400  57358    276   14    1 : tunables   54   27    0 : 
slabdata   4097   4097      0
bdev_cache             8     14    512    7    1 : tunables   54   27    0 : 
slabdata      2      2      0
mnt_cache             21     31    128   31    1 : tunables  120   60    0 : 
slabdata      1      1      0
inode_cache         3299   3310    384   10    1 : tunables   54   27    0 : 
slabdata    331    331      0
dentry_cache      198368 254576    140   28    1 : tunables  120   60    0 : 
slabdata   9092   9092      0
filp                 675    675    256   15    1 : tunables  120   60    0 : 
slabdata     45     45      0
names_cache            4      4   4096    1    1 : tunables   24   12    0 : 
slabdata      4      4      0
idr_layer_cache       88    116    136   29    1 : tunables  120   60    0 : 
slabdata      4      4      0
buffer_head       193153 230931     48   81    1 : tunables  120   60    0 : 
slabdata   2851   2851      0
mm_struct             70     70    512    7    1 : tunables   54   27    0 : 
slabdata     10     10      0
vm_area_struct      1726   1786     84   47    1 : tunables  120   60    0 : 
slabdata     38     38      0
fs_cache             106    119     32  119    1 : tunables  120   60    0 : 
slabdata      1      1      0
files_cache           70     70    512    7    1 : tunables   54   27    0 : 
slabdata     10     10      0
signal_cache         124    124    128   31    1 : tunables  120   60    0 : 
slabdata      4      4      0
sighand_cache         90     90   1408    5    2 : tunables   24   12    0 : 
slabdata     18     18      0
task_struct           95     95   1424    5    2 : tunables   24   12    0 : 
slabdata     19     19      0
anon_vma             814    814      8  407    1 : tunables  120   60    0 : 
slabdata      2      2      0
pgd                   65     65   4096    1    1 : tunables   24   12    0 : 
slabdata     65     65      0
size-131072(DMA)       0      0 131072    1   32 : tunables    8    4    0 : 
slabdata      0      0      0
size-131072            2      2 131072    1   32 : tunables    8    4    0 : 
slabdata      2      2      0
size-65536(DMA)        0      0  65536    1   16 : tunables    8    4    0 : 
slabdata      0      0      0
size-65536          8234   8234  65536    1   16 : tunables    8    4    0 : 
slabdata   8234   8234      0
size-32768(DMA)        0      0  32768    1    8 : tunables    8    4    0 : 
slabdata      0      0      0
size-32768             7     16  32768    1    8 : tunables    8    4    0 : 
slabdata      7     16      0
size-16384(DMA)        0      0  16384    1    4 : tunables    8    4    0 : 
slabdata      0      0      0
size-16384             6      6  16384    1    4 : tunables    8    4    0 : 
slabdata      6      6      0
size-8192(DMA)         0      0   8192    1    2 : tunables    8    4    0 : 
slabdata      0      0      0
size-8192            105    109   8192    1    2 : tunables    8    4    0 : 
slabdata    105    109      0
size-4096(DMA)         0      0   4096    1    1 : tunables   24   12    0 : 
slabdata      0      0      0
size-4096           2099   2111   4096    1    1 : tunables   24   12    0 : 
slabdata   2099   2111      0
size-2048(DMA)         0      0   2048    2    1 : tunables   24   12    0 : 
slabdata      0      0      0
size-2048           8276   8276   2048    2    1 : tunables   24   12    0 : 
slabdata   4138   4138      0
size-1024(DMA)         0      0   1024    4    1 : tunables   54   27    0 : 
slabdata      0      0      0
size-1024            140    140   1024    4    1 : tunables   54   27    0 : 
slabdata     35     35      0
size-512(DMA)          0      0    512    8    1 : tunables   54   27    0 : 
slabdata      0      0      0
size-512             176    560    512    8    1 : tunables   54   27    0 : 
slabdata     70     70      0
size-256(DMA)          0      0    256   15    1 : tunables  120   60    0 : 
slabdata      0      0      0
size-256             222    480    256   15    1 : tunables  120   60    0 : 
slabdata     32     32      0
size-128(DMA)          0      0    128   31    1 : tunables  120   60    0 : 
slabdata      0      0      0
size-128            1807   1829    128   31    1 : tunables  120   60    0 : 
slabdata     59     59      0
size-64(DMA)           0      0     64   61    1 : tunables  120   60    0 : 
slabdata      0      0      0
size-64             7762   8662     64   61    1 : tunables  120   60    0 : 
slabdata    142    142      0
size-32(DMA)           0      0     32  119    1 : tunables  120   60    0 : 
slabdata      0      0      0
size-32            15764  16184     32  119    1 : tunables  120   60    0 : 
slabdata    136    136      0
kmem_cache           124    124    128   31    1 : tunables  120   60    0 : 
slabdata      4      4      0

nr_dirty 1316
nr_writeback 0
nr_unstable 0
nr_page_table_pages 336
nr_mapped 18227
nr_slab 215890
pgpgin 1496713
pgpgout 1020309568
pswpin 365
pswpout 3752
pgalloc_high 0
pgalloc_normal 1578465026
pgalloc_dma 319286
pgfree 1578828064
pgactivate 592523
pgdeactivate 198222
pgfault 118936465
pgmajfault 1721
pgrefill_high 0
pgrefill_normal 199636
pgrefill_dma 50800
pgsteal_high 0
pgsteal_normal 172811
pgsteal_dma 26364
pgscan_kswapd_high 0
pgscan_kswapd_normal 79497
pgscan_kswapd_dma 140076
pgscan_direct_high 0
pgscan_direct_normal 99231
pgscan_direct_dma 3795
pginodesteal 3837
slabs_scanned 847283
kswapd_steal 101698
kswapd_inodesteal 35700
pageoutrun 282
allocstall 2977
pgrotated 20310

