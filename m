Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261992AbUD1VeO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261992AbUD1VeO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 17:34:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261440AbUD1Vdy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 17:33:54 -0400
Received: from mail.fastclick.com ([205.180.85.17]:30420 "EHLO
	mail.fastclick.net") by vger.kernel.org with ESMTP id S261992AbUD1V1u
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 17:27:50 -0400
Message-ID: <409021D3.4060305@fastclick.com>
Date: Wed, 28 Apr 2004 14:27:47 -0700
From: "Brett E." <brettspamacct@fastclick.com>
Reply-To: brettspamacct@fastclick.com
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: ~500 megs cached yet 2.6.5 goes into swap hell
Content-Type: multipart/mixed;
 boundary="------------030707060307060105000606"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030707060307060105000606
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Same thing happens on 2.4.18.

I attached sar, slabinfo and /proc/meminfo data on the 2.6.5 machine.  I 
reproduce this behavior by simply untarring a 260meg file on a 
production server, the machine becomes sluggish as it swaps to disk. Is 
there a way to limit the cache so this machine, which has 1 gigabyte of 
memory, doesn't dip into swap?

Thanks,

Brett

--------------030707060307060105000606
Content-Type: text/plain;
 name="attach.1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="attach.1"

06:18:52 PM kbmemfree kbmemused  %memused kbbuffers  kbcached kbswpfree kbswpused  %swpused  kbswpcad
06:18:53 PM     55332   1238644     95.72     14660    497888    450740     79364     14.97      9692
06:18:54 PM     55268   1238708     95.73     14660    497888    450740     79364     14.97      9692
06:18:55 PM     40060   1253916     96.90     14860    512920    450740     79364     14.97      9692
06:18:57 PM      6120   1287856     99.53     15340    546644    450740     79364     14.97      9692
06:18:59 PM      6632   1287344     99.49     15864    550880    450740     79364     14.97      9692
06:19:00 PM      6440   1287536     99.50     16020    552628    450740     79364     14.97      9692
06:19:02 PM      7648   1286328     99.41     15980    548452    450740     79364     14.97      9692
06:19:03 PM      6504   1287472     99.50     16008    548832    450740     79364     14.97      9692
06:19:04 PM      7592   1286384     99.41     15980    530160    450740     79364     14.97      9692
06:19:05 PM      6192   1287784     99.52     15716    499008    450740     79364     14.97      9692
06:19:06 PM      6544   1287432     99.49     15732    494640    450740     79364     14.97      9692
06:19:07 PM      7104   1286872     99.45     15768    488756    450740     79364     14.97      9692
06:19:08 PM      7592   1286384     99.41     15844    488680    450740     79364     14.97      9692
06:19:10 PM      7416   1286560     99.43     15936    479136    450740     79364     14.97      9692
06:19:13 PM      7024   1286952     99.46     15912    467808    450744     79360     14.97      9688
06:19:14 PM      7096   1286880     99.45     15664    427736    450744     79360     14.97      9684
06:19:15 PM      7240   1286736     99.44     15604    415692    450744     79360     14.97      9684
06:19:16 PM      6712   1287264     99.48     15616    414524    450744     79360     14.97      9684
06:19:18 PM      6200   1287776     99.52     15652    409660    450744     79360     14.97      9684
06:19:19 PM     10600   1283376     99.18     15724    407004    450744     79360     14.97      9684


06:18:52 PM  pgpgin/s pgpgout/s   fault/s  majflt/s
06:18:53 PM      0.00    712.00   1236.00      0.00
06:18:54 PM     12.12      8.08   1067.68      0.00
06:18:55 PM   7497.03     11.88   2844.55      0.00
06:18:57 PM  10626.00    310.00   1422.50      0.00
06:18:59 PM  11758.00    196.00    346.50      0.00
06:19:00 PM   7828.00    608.00    136.00      0.00
06:19:02 PM    145.27   1136.32   1108.96      0.00
06:19:03 PM    905.05  13822.22    663.64      0.00
06:19:04 PM    689.11   2384.16   9437.62      0.00
06:19:05 PM    499.01   9572.28  13467.33      0.00
06:19:06 PM   3444.00   1340.00   1825.00      0.00
06:19:07 PM   7720.00   2032.00   3034.00      0.00
06:19:08 PM   5420.00   1304.00    688.00      0.00
06:19:10 PM   4045.77   4304.48   2188.56      0.00
06:19:13 PM   1079.07   5528.68   2046.90      0.00
06:19:14 PM    696.00    920.00  15650.00      0.00
06:19:15 PM   1478.79   1187.88   5046.46      0.00
06:19:16 PM   1000.00   2752.94    539.22      0.00


meminfo:
meminfo:

MemTotal:      1293976 kB
MemFree:          8320 kB
Buffers:         13396 kB
Cached:         436428 kB
SwapCached:       9516 kB
Active:         810472 kB
Inactive:       346816 kB
HighTotal:      393216 kB
HighFree:         1152 kB
LowTotal:       900760 kB
LowFree:          7168 kB
SwapTotal:      530104 kB
SwapFree:       450796 kB
Dirty:           33704 kB
Writeback:       10268 kB
Mapped:         710732 kB
Slab:           115240 kB
Committed_AS:   942592 kB
PageTables:       4612 kB
VmallocTotal:   114680 kB
VmallocUsed:       560 kB
VmallocChunk:   114120 kB



slabinfo - version: 2.0
# name            <active_objs> <num_objs> <objsize> <objperslab> <pagesperslab> : tunables <batchcount> <limit> <sharedfactor> : slabdata <active_slabs> <num_slabs> <sharedavail>
rpc_buffers            8      8   2048    2    1 : tunables   24   12    8 : slabdata      4      4      0
rpc_tasks              8     15    256   15    1 : tunables  120   60    8 : slabdata      1      1      0
rpc_inode_cache       12     14    512    7    1 : tunables   54   27    8 : slabdata      2      2      0
unix_sock            192    203    512    7    1 : tunables   54   27    8 : slabdata     29     29      0
ip_conntrack        9926  14860    384   10    1 : tunables   54   27    8 : slabdata   1486   1486    216
tcp_tw_bucket       2028   6450    128   30    1 : tunables  120   60    8 : slabdata    215    215    384
tcp_bind_bucket      207    800     16  200    1 : tunables  120   60    8 : slabdata      4      4     16
tcp_open_request     113    290     64   58    1 : tunables  120   60    8 : slabdata      5      5      3
inet_peer_cache        2     58     64   58    1 : tunables  120   60    8 : slabdata      1      1      0
ip_fib_hash           18    200     16  200    1 : tunables  120   60    8 : slabdata      1      1      0
ip_dst_cache       23046  23145    256   15    1 : tunables  120   60    8 : slabdata   1543   1543      0
arp_cache             11     30    256   15    1 : tunables  120   60    8 : slabdata      2      2      0
raw4_sock              0      0    512    7    1 : tunables   54   27    8 : slabdata      0      0      0
udp_sock              10     21    512    7    1 : tunables   54   27    8 : slabdata      3      3      0
tcp_sock             248    408   1024    4    1 : tunables   54   27    8 : slabdata    102    102      0
flow_cache             0      0    128   30    1 : tunables  120   60    8 : slabdata      0      0      0
udf_inode_cache        0      0    512    7    1 : tunables   54   27    8 : slabdata      0      0      0
nfs_write_data        36     42    512    7    1 : tunables   54   27    8 : slabdata      6      6      0
nfs_read_data         32     35    512    7    1 : tunables   54   27    8 : slabdata      5      5      0
nfs_inode_cache       15     24    640    6    1 : tunables   54   27    8 : slabdata      4      4      0
nfs_page               0      0    128   30    1 : tunables  120   60    8 : slabdata      0      0      0
isofs_inode_cache      0      0    384   10    1 : tunables   54   27    8 : slabdata      0      0      0
fat_inode_cache        0      0    512    7    1 : tunables   54   27    8 : slabdata      0      0      0
ext2_inode_cache    7294   7294    512    7    1 : tunables   54   27    8 : slabdata   1042   1042      0
journal_handle         0      0     28  123    1 : tunables  120   60    8 : slabdata      0      0      0
journal_head           0      0     48   77    1 : tunables  120   60    8 : slabdata      0      0      0
revoke_table           0      0     12  250    1 : tunables  120   60    8 : slabdata      0      0      0
revoke_record          0      0     16  200    1 : tunables  120   60    8 : slabdata      0      0      0
ext3_inode_cache       0      0    512    7    1 : tunables   54   27    8 : slabdata      0      0      0
ext3_xattr             0      0     48   77    1 : tunables  120   60    8 : slabdata      0      0      0
eventpoll_pwq          0      0     36   99    1 : tunables  120   60    8 : slabdata      0      0      0
eventpoll_epi          0      0    128   30    1 : tunables  120   60    8 : slabdata      0      0      0
kioctx                 0      0    256   15    1 : tunables  120   60    8 : slabdata      0      0      0
kiocb                  0      0    256   15    1 : tunables  120   60    8 : slabdata      0      0      0
dnotify_cache          0      0     20  166    1 : tunables  120   60    8 : slabdata      0      0      0
file_lock_cache        9     40     96   40    1 : tunables  120   60    8 : slabdata      1      1      0
fasync_cache           0      0     16  200    1 : tunables  120   60    8 : slabdata      0      0      0
shmem_inode_cache      3      7    512    7    1 : tunables   54   27    8 : slabdata      1      1      0
posix_timers_cache      0      0     88   43    1 : tunables  120   60    8 : slabdata      0      0      0
uid_cache              5    112     32  112    1 : tunables  120   60    8 : slabdata      1      1      0
sgpool-128            32     32   2048    2    1 : tunables   24   12    8 : slabdata     16     16      0
sgpool-64             32     32   1024    4    1 : tunables   54   27    8 : slabdata      8      8      0
sgpool-32             32     32    512    8    1 : tunables   54   27    8 : slabdata      4      4      0
sgpool-16             32     45    256   15    1 : tunables  120   60    8 : slabdata      3      3      0
sgpool-8              32     60    128   30    1 : tunables  120   60    8 : slabdata      2      2      0
deadline_drq           0      0     52   71    1 : tunables  120   60    8 : slabdata      0      0      0
as_arq               296    348     64   58    1 : tunables  120   60    8 : slabdata      6      6     60
blkdev_requests      312    312    160   24    1 : tunables  120   60    8 : slabdata     13     13     60
biovec-BIO_MAX_PAGES    256    256   3072    2    2 : tunables   24   12    8 : slabdata    128    128      0
biovec-128           256    260   1536    5    2 : tunables   24   12    8 : slabdata     52     52      0
biovec-64            629    640    768    5    1 : tunables   54   27    8 : slabdata    128    128     38
biovec-16            315    315    256   15    1 : tunables  120   60    8 : slabdata     21     21      0
biovec-4             348    348     64   58    1 : tunables  120   60    8 : slabdata      6      6      0
biovec-1             520    600     16  200    1 : tunables  120   60    8 : slabdata      3      3     60
bio                  870    870     64   58    1 : tunables  120   60    8 : slabdata     15     15    180
sock_inode_cache     573    910    512    7    1 : tunables   54   27    8 : slabdata    130    130      0
skbuff_head_cache    296    870    256   15    1 : tunables  120   60    8 : slabdata     58     58     30
sock                   4     10    384   10    1 : tunables   54   27    8 : slabdata      1      1      0
proc_inode_cache    1417   1530    384   10    1 : tunables   54   27    8 : slabdata    153    153      0
sigqueue             130    130    144   26    1 : tunables  120   60    8 : slabdata      5      5      0
radix_tree_node     7117   8955    260   15    1 : tunables   54   27    8 : slabdata    597    597    189
bdev_cache             6      7    512    7    1 : tunables   54   27    8 : slabdata      1      1      0
mnt_cache             20     58     64   58    1 : tunables  120   60    8 : slabdata      1      1      0
inode_cache          566    580    384   10    1 : tunables   54   27    8 : slabdata     58     58      0
dentry_cache      167775 176055    256   15    1 : tunables  120   60    8 : slabdata  11737  11737      0
filp                2057   2790    256   15    1 : tunables  120   60    8 : slabdata    186    186      0
names_cache           25     25   4096    1    1 : tunables   24   12    8 : slabdata     25     25      0
idr_layer_cache        3     28    136   28    1 : tunables  120   60    8 : slabdata      1      1      0
buffer_head        35463  50481     52   71    1 : tunables  120   60    8 : slabdata    711    711      0
mm_struct            331    360    640    6    1 : tunables   54   27    8 : slabdata     60     60      0
vm_area_struct     10667  12586     64   58    1 : tunables  120   60    8 : slabdata    217    217      0
fs_cache             331    464     64   58    1 : tunables  120   60    8 : slabdata      8      8      0
files_cache          346    371    512    7    1 : tunables   54   27    8 : slabdata     53     53      0
signal_cache         447    696     64   58    1 : tunables  120   60    8 : slabdata     12     12      0
sighand_cache        345    380   1408    5    2 : tunables   24   12    8 : slabdata     76     76      0
task_struct          434    450   1456    5    2 : tunables   24   12    8 : slabdata     90     90      0
pte_chain         139628 145500    128   30    1 : tunables  120   60    8 : slabdata   4850   4850      0
pgd                  330    330   4096    1    1 : tunables   24   12    8 : slabdata    330    330      0
size-131072(DMA)       0      0 131072    1   32 : tunables    8    4    0 : slabdata      0      0      0
size-131072            0      0 131072    1   32 : tunables    8    4    0 : slabdata      0      0      0
size-65536(DMA)        0      0  65536    1   16 : tunables    8    4    0 : slabdata      0      0      0
size-65536             0      0  65536    1   16 : tunables    8    4    0 : slabdata      0      0      0
size-32768(DMA)        0      0  32768    1    8 : tunables    8    4    0 : slabdata      0      0      0
size-32768             0      0  32768    1    8 : tunables    8    4    0 : slabdata      0      0      0
size-16384(DMA)        0      0  16384    1    4 : tunables    8    4    0 : slabdata      0      0      0
size-16384             1      1  16384    1    4 : tunables    8    4    0 : slabdata      1      1      0
size-8192(DMA)         0      0   8192    1    2 : tunables    8    4    0 : slabdata      0      0      0
size-8192            446    446   8192    1    2 : tunables    8    4    0 : slabdata    446    446      0
size-4096(DMA)         0      0   4096    1    1 : tunables   24   12    8 : slabdata      0      0      0
size-4096             65     66   4096    1    1 : tunables   24   12    8 : slabdata     65     66      0
size-2048(DMA)         0      0   2048    2    1 : tunables   24   12    8 : slabdata      0      0      0
size-2048            245    294   2048    2    1 : tunables   24   12    8 : slabdata    147    147      4
size-1024(DMA)         0      0   1024    4    1 : tunables   54   27    8 : slabdata      0      0      0
size-1024            109    128   1024    4    1 : tunables   54   27    8 : slabdata     32     32      0
size-512(DMA)          0      0    512    8    1 : tunables   54   27    8 : slabdata      0      0      0
size-512             268    488    512    8    1 : tunables   54   27    8 : slabdata     61     61      0
size-256(DMA)          0      0    256   15    1 : tunables  120   60    8 : slabdata      0      0      0
size-256             424    465    256   15    1 : tunables  120   60    8 : slabdata     31     31      0
size-128(DMA)          0      0    128   30    1 : tunables  120   60    8 : slabdata      0      0      0
size-128            2387   3090    128   30    1 : tunables  120   60    8 : slabdata    103    103      0
size-64(DMA)           0      0     64   58    1 : tunables  120   60    8 : slabdata      0      0      0
size-64              334    406     64   58    1 : tunables  120   60    8 : slabdata      7      7      0
size-32(DMA)           0      0     32  112    1 : tunables  120   60    8 : slabdata      0      0      0
size-32              744    784     32  112    1 : tunables  120   60    8 : slabdata      7      7      0
kmem_cache           104    104    148   26    1 : tunables  120   60    8 : slabdata      4      4      0

--------------030707060307060105000606--

