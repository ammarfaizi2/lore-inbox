Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261905AbTCTThR>; Thu, 20 Mar 2003 14:37:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261907AbTCTThR>; Thu, 20 Mar 2003 14:37:17 -0500
Received: from freeside.toyota.com ([63.87.74.7]:41409 "EHLO
	freeside.toyota.com") by vger.kernel.org with ESMTP
	id <S261905AbTCTTg1>; Thu, 20 Mar 2003 14:36:27 -0500
Message-ID: <3E7A1ABF.7050402@tmsusa.com>
Date: Thu, 20 Mar 2003 11:47:11 -0800
From: jjs <jjs@tmsusa.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.2) Gecko/20030208 Netscape/7.02
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux kernel <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@digeo.com>
Subject: An oops while running 2.5.65-mm2
Content-Type: multipart/mixed;
 boundary="------------080705040606050800070003"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080705040606050800070003
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Greetings -

Here is some info about an oops from 2.5.65-mm2

Platform: Red Hat 8.0 + updates on genuine Intel mobo
Celeron 1.2 Ghz, 512M RAM, 1x40GB IDE, 2 e100 nics

Workload: iptables firewall and squid proxy for local lan

2.5.65-mm2 booted up and ran normally for 21-22 hours.
internal hosts were natted properly, no complaints.

After 22 hours or so named went catatonic, and the squid
proxy became unable to resolve URLS -

I restarted named and it resumed normal operation.

Within less than an hour, the oops appeared in the log -
I took a quick look at /proc/meminfo and /proc/slabinfo
and saved them before booting back into 2.4-ac

slabinfo, meminfo, the kernel log and the .config attached

Thanks for your time and patience -

Joe



--------------080705040606050800070003
Content-Type: text/plain;
 name="slabinfo.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="slabinfo.txt"

slabinfo - version: 1.2 (statistics)
ip_conntrack          47     66    336    6    6    1 :   32   16 :    385   66985   824  205    0    2   43 :  25251   5266  30169    320
ip_fib_hash           24    126     28    1    1    1 :   32   16 :     32      64     1    0    0    0  158 :     32      4     12      0
rpc_buffers            8     14   2060    2    2    4 :   32   16 :     14      14     2    0    0    0   39 :      6      2      0      0
rpc_tasks              8     19    204    1    1    1 :   32   16 :     16      16     1    0    0    0   51 :      7      1      0      0
rpc_inode_cache        0      0    476    0    0    1 :   32   16 :      0       0     0    0    0    0   40 :      0      0      0      0
unix_sock            108    126    548   18   18    1 :   32   16 :    147    5440    39   10    0    2   39 :  15972    405  16259     10
tcp_tw_bucket          0      0    100    0    0    1 :   32   16 :    117   14759   311  302    0    1   71 :   2162    938   3082     18
tcp_bind_bucket       15    126     28    1    1    1 :   32   16 :     98   15600     1    0    0    0  158 :   6199    975   7150      9
tcp_open_request       0      0     68    0    0    1 :   32   16 :     18   13056   791  791    0    0   88 :   2075    816   2891      0
inet_peer_cache        1     72     52    1    1    1 :   32   16 :     20     112     5    4    0    0  104 :      3      7      9      0
secpath_cache          0      0     32    0    0    1 :   32   16 :      0       0     0    0    0    0  145 :      0      0      0      0
flow_cache             0      0     60    0    0    1 :   32   16 :      0       0     0    0    0    0   95 :      0      0      0      0
xfrm4_dst_cache        0      0    224    0    0    1 :   32   16 :      0       0     0    0    0    0   49 :      0      0      0      0
ip_dst_cache         208    288    220   16   16    1 :   32   16 :    646   52091   219    0    0    0   50 :  19387   3465  22278    378
arp_cache             10     21    188    1    1    1 :   32   16 :     21    2737     1    0    0    0   53 :      8    225    223      0
raw4_sock              0      0    540    0    0    1 :   32   16 :      7      21     3    3    0    0   39 :     37      3     40      0
udp_sock              14     14    560    2    2    1 :   32   16 :     28    2859   129  127    0    0   39 :    167    480    633      0
tcp_sock              34     42   1064    6    6    2 :   32   16 :     63   14508   158  152    0    0   39 :  13036   1720  14722      0
reiser_inode_cache    267    272    472   34   34    1 :   32   16 :    272     279    34    0    0    0   40 :    232     35      0      0
udf_inode_cache        0      0    476    0    0    1 :   32   16 :      0       0     0    0    0    0   40 :      0      0      0      0
nfs_write_data        36     40    456    5    5    1 :   32   16 :     40      40     5    0    0    0   40 :     31      5      0      0
nfs_read_data         32     36    440    4    4    1 :   32   16 :     36      36     4    0    0    0   41 :     28      4      0      0
nfs_inode_cache        0      0    708    0    0    2 :   32   16 :      0       0     0    0    0    0   43 :      0      0      0      0
nfs_page             128    144    108    4    4    1 :   32   16 :    140     140     4    0    0    0   68 :    117     11      0      0
isofs_inode_cache      0      0    436    0    0    1 :   32   16 :      0       0     0    0    0    0   41 :      0      0      0      0
ext2_inode_cache       0      0    528    0    0    1 :   32   16 :      0       0     0    0    0    0   39 :      0      0      0      0
ext2_xattr             0      0     56    0    0    1 :   32   16 :      0       0     0    0    0    0   99 :      0      0      0      0
journal_head          28     63     60    1    1    1 :   32   16 :   1229  104871   153   59    0    1   95 :  94912   6625 100328   1189
revoke_table           5    145     24    1    1    1 :   32   16 :     18      32     1    0    0    0  177 :      3      2      0      0
revoke_record          0      0     28    0    0    1 :   32   16 :    112    1392    70   70    0    0  158 :    353     87    428     12
ext3_inode_cache  219408 225106    576 32158 32158    1 :   32   16 : 294686  343555 46595   70    0    5   39 : 293664  49301 116490   7067
ext3_xattr             0      0     56    0    0    1 :   32   16 :      0       0     0    0    0    0   99 :      0      0      0      0
dquot                  0      0    140    0    0    1 :   32   16 :      0       0     0    0    0    0   60 :      0      0      0      0
eventpoll_pwq          0      0     48    0    0    1 :   32   16 :      0       0     0    0    0    0  110 :      0      0      0      0
eventpoll_epi          0      0     72    0    0    1 :   32   16 :      0       0     0    0    0    0   85 :      0      0      0      0
kioctx                 0      0    268    0    0    1 :   32   16 :      0       0     0    0    0    0   46 :      0      0      0      0
kiocb                  0      0    172    0    0    1 :   32   16 :      0       0     0    0    0    0   55 :      0      0      0      0
dnotify_cache          0      0     32    0    0    1 :   32   16 :      0       0     0    0    0    0  145 :      0      0      0      0
file_lock_cache     7663   7680    128  256  256    1 :   32   16 :   7670   19619   258    2    0    0   62 : 116692   1310 110339      0
fasync_cache           2    126     28    1    1    1 :   32   16 :     16      16     1    0    0    0  158 :      1      1      0      0
shmem_inode_cache      7     14    536    2    2    1 :   32   16 :     14     133    11    9    0    0   39 :     19     27     39      0
idr_layer_cache        0      0    148    0    0    1 :   32   16 :      0       0     0    0    0    0   58 :      0      0      0      0
posix_timers_cache      0      0    136    0    0    1 :   32   16 :      0       0     0    0    0    0   60 :      0      0      0      0
uid_cache             13    101     36    1    1    1 :   32   16 :     27     128     1    0    0    0  133 :      5      8      0      0
cfq_pool              64     84     44    1    1    1 :   32   16 :     64      64     1    0    0    0  116 :      0     64      0      0
crq_pool               0      0     48    0    0    1 :   32   16 :      0       0     0    0    0    0  110 :      0      0      0      0
as_arq               768    784     68   14   14    1 :   32   16 :    776     776    14    0    0    0   88 :    713     55      0      0
deadline_drq           0      0     60    0    0    1 :   32   16 :      0       0     0    0    0    0   95 :      0      0      0      0
blkdev_requests      768    780    148   30   30    1 :   32   16 :    770     770    30    0    0    0   58 :    709     59      0      0
biovec-BIO_MAX_PAGES    256    260   3084   52   52    4 :   32   16 :    270     335    60    8    0    0   37 :     65    272     81      0
biovec-128           256    260   1548   52   52    2 :   32   16 :    270     309    54    2    0    0   37 :     74    271     89      0
biovec-64            256    260    780   52   52    1 :   32   16 :    280     480    62   10    0    0   37 :   1188    305   1237      0
biovec-16            256    266    204   14   14    1 :   32   16 :    282    1731    17    3    0    0   51 :   2083    402   2229      0
biovec-4             256    315     60    5    5    1 :   32   16 :    274    4112     5    0    0    0   95 :   2341    497   2582      0
biovec-1             274    290     24    2    2    1 :   32   16 :   1643  149621   256   91    0    1  177 : 154230   9768 161220   2522
bio                  259    336     68    6    6    1 :   32   16 :   1640  143351   542  299    0    1   88 : 161702   9604 168956   2094
sock_inode_cache     162    200    480   25   25    1 :   32   16 :    208   29288    48   14    0    2   40 :  26997   1915  28741      9
skbuff_head_cache    256    286    176   13   13    1 :   32   16 :    286     334    13    0    0    0   54 :    252     32     28      0
sock                   4      9    448    1    1    1 :   32   16 :      9      34     1    0    0    0   41 :     16      6     18      0
proc_inode_cache     612    612    436   68   68    1 :   32   16 :    657   15073    95   11    0    0   41 :   9606   1026  10003     25
sigqueue              16     27    144    1    1    1 :   32   16 :     16      32     2    1    0    0   59 : 316127      2 316129      0
radix_tree_node     5700   7238    272  517  517    1 :   32   16 :   7854   16574   566    0    0    0   46 :  13976   1455   9462    269
bdev_cache             8     33    116    1    1    1 :   32   16 :     24      64     1    0    0    0   65 :     19      4     15      0
mnt_cache             20     53     72    1    1    1 :   32   16 :     35      54     1    0    0    0   85 :     13      9      2      0
inode_cache          468    468    420   52   52    1 :   32   16 :    486    4805   309  257    0    0   41 :   3458   1110   4107      0
dentry_cache      168480 173717    204 9143 9143    1 :   32   16 : 231151  406232 17115  203    0    2   51 : 363267  39975 222732  12039
filp                 840   1025    156   41   41    1 :   32   16 :   1175  118702    73    6    0    1   57 : 540018   7464 544962   1689
names_cache            1      1   4096    1    1    1 :   32   16 :     17   14392  5443 5442    0    0   33 : 1154738  14332 1169070      0
buffer_head        27573  41076     60  652  652    1 :   32   16 :  41754  161699   861  137    0    1   95 : 129366  10760 109162   3393
mm_struct             63     63    536    9    9    1 :   32   16 :     77   10498    20   11    0    0   39 :  15851    779  16577      0
vm_area_struct      3183   3250     76   65   65    1 :   32   16 :   3982  188239   243   20    0    1   82 : 448257  11924 447289   9721
fs_cache              66     84     44    1    1    1 :   32   16 :     81   11232     1    0    0    0  116 :   8236    702   8886      0
files_cache           63     63    424    7    7    1 :   32   16 :     72   10466    11    4    0    0   41 :   8206    732   8886      0
signal_cache         102    144     52    2    2    1 :   32   16 :    117   11282     2    0    0    0  104 :   8430    711   9053      0
sighand_cache         63     63   1320   21   21    1 :   32   16 :     84    4898   105   84    0    0   35 :   8135    813   8886      0
task_struct           95     95   1632   19   19    2 :   32   16 :    110    7999    57   38    0    0   37 :   8370    771   9052      0
pte_chain           1716   5040     44   60   60    1 :   32   16 :   9740   78896   148    0    0    1  116 :  93830   5024  92901   4255
pgd                   55     55   4096   55   55    1 :   32   16 :     73    2705  2545 2490    0    0   33 :  13999   2631  16577      0
size-131072(DMA)       0      0 131072    0    0   32 :    8    4 :      0       0     0    0    0    0    9 :      0      0      0      0
size-131072            0      0 131072    0    0   32 :    8    4 :      0       0     0    0    0    0    9 :      0      0      0      0
size-65536(DMA)        0      0  65536    0    0   16 :    8    4 :      0       0     0    0    0    0    9 :      0      0      0      0
size-65536             0      0  65536    0    0   16 :    8    4 :      0       0     0    0    0    0    9 :      0      0      0      0
size-32768(DMA)        0      0  32768    0    0    8 :    8    4 :      0       0     0    0    0    0    9 :      0      0      0      0
size-32768             1      1  32768    1    1    8 :    8    4 :      1       2     2    1    0    0    9 :      0      2      1      0
size-16384(DMA)        0      0  16384    0    0    4 :    8    4 :      0       0     0    0    0    0    9 :      0      0      0      0
size-16384             0      0  16384    0    0    4 :    8    4 :      1       4     4    4    0    0    9 :      1      4      5      0
size-8192(DMA)         0      0   8192    0    0    2 :    8    4 :      0       0     0    0    0    0    9 :      0      0      0      0
size-8192              8      8   8192    8    8    2 :    8    4 :     11      51    50   42    0    0    9 :    743     51    786      0
size-4096(DMA)         0      0   4096    0    0    1 :   32   16 :      0       0     0    0    0    0   33 :      0      0      0      0
size-4096             73     73   4096   73   73    1 :   32   16 :    113    3317  3077 3000    0   23   33 :   4797   3227   7948      3
size-2048(DMA)         0      0   2060    0    0    4 :   32   16 :      0       0     0    0    0    0   39 :      0      0      0      0
size-2048            176    252   2060   36   36    4 :   32   16 :    308    6280    55    1    0    1   39 : 583790    434 583919    154
size-1024(DMA)         0      0   1036    0    0    2 :   32   16 :      0       0     0    0    0    0   39 :      0      0      0      0
size-1024             63     63   1036    9    9    2 :   32   16 :     63      84     9    0    0    0   39 : 155490     38 155480      5
size-512(DMA)          0      0    524    0    0    1 :   32   16 :      0       0     0    0    0    0   39 :      0      0      0      0
size-512             100    105    524   15   15    1 :   32   16 :    119   36205    94   79    0    0   39 : 143932   6206 150039      0
size-256(DMA)          0      0    268    0    0    1 :   32   16 :      0       0     0    0    0    0   46 :      0      0      0      0
size-256              20     42    268    3    3    1 :   32   16 :    154   59286    13    3    0    0   46 :  35972   3713  39657      9
size-192(DMA)          0      0    204    0    0    1 :   32   16 :      0       0     0    0    0    0   51 :      0      0      0      0
size-192             209    228    204   12   12    1 :   32   16 :    225     265    12    0    0    0   51 : 571487     75 571368      2
size-128(DMA)          0      0    140    0    0    1 :   32   16 :      0       0     0    0    0    0   60 :      0      0      0      0
size-128              95    112    140    4    4    1 :   32   16 :    112    4939     4    0    0    0   60 : 260955    337 261196      1
size-96(DMA)           0      0    108    0    0    1 :   32   16 :      0       0     0    0    0    0   68 :      0      0      0      0
size-96             2320   2376    108   66   66    1 :   32   16 :   2444   76710    70    1    0    1   68 : 991160   6616 995259    206
size-64(DMA)           0      0     76    0    0    1 :   32   16 :      0       0     0    0    0    0   82 :      0      0      0      0
size-64              388    450     76    9    9    1 :   32   16 :    618    9286    13    0    0    1   82 : 1487319    778 1487559    150
size-32(DMA)           0      0     44    0    0    1 :   32   16 :      0       0     0    0    0    0  116 :      0      0      0      0
size-32             1260   1344     44   16   16    1 :   32   16 :   1308    1820    16    0    0    0  116 : 6540750    321 6539658    169
kmem_cache           110    110    180    5    5    1 :   32   16 :    110     110     5    0    0    0   54 :     37     71      0      0


--------------080705040606050800070003
Content-Type: text/plain;
 name="meminfo.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="meminfo.txt"

MemTotal:       513612 kB
MemFree:          8588 kB
Buffers:         78604 kB
Cached:         148700 kB
SwapCached:          0 kB
Active:         208488 kB
Inactive:       106656 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:       513612 kB
LowFree:          8588 kB
SwapTotal:      514072 kB
SwapFree:       514072 kB
Dirty:             112 kB
Writeback:           0 kB
Mapped:         116024 kB
Slab:           176516 kB
Committed_AS:   183548 kB
PageTables:       1148 kB
ReverseMaps:     26409


--------------080705040606050800070003
Content-Type: text/plain;
 name="kernel-log-2.5.65-mm2.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="kernel-log-2.5.65-mm2.txt"

Mar 19 11:20:39 jyro kernel: klogd 1.4.1, log source = /proc/kmsg started.
Mar 19 11:20:39 jyro kernel: Linux version 2.5.65-mm2 (root@jyro.mirai.cx) (gcc version 3.2 20020903 (Red Hat Linux 8.0 3.2-7)) #1 Wed Mar 19 10:54:00 PST 2003
Mar 19 11:20:39 jyro kernel: Video mode to be used for restore is ffff
Mar 19 11:20:39 jyro kernel: BIOS-provided physical RAM map:
Mar 19 11:20:39 jyro kernel:  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
Mar 19 11:20:39 jyro kernel:  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
Mar 19 11:20:39 jyro kernel:  BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
Mar 19 11:20:39 jyro kernel:  BIOS-e820: 0000000000100000 - 000000001fec0000 (usable)
Mar 19 11:20:39 jyro kernel:  BIOS-e820: 000000001fec0000 - 000000001fef8000 (ACPI data)
Mar 19 11:20:39 jyro kernel:  BIOS-e820: 000000001fef8000 - 000000001ff00000 (ACPI NVS)
Mar 19 11:20:39 jyro kernel:  BIOS-e820: 00000000ffb80000 - 00000000ffc00000 (reserved)
Mar 19 11:20:39 jyro kernel:  BIOS-e820: 00000000fff00000 - 0000000100000000 (reserved)
Mar 19 11:20:39 jyro kernel: 510MB LOWMEM available.
Mar 19 11:20:39 jyro kernel: On node 0 totalpages: 130752
Mar 19 11:20:39 jyro kernel:   DMA zone: 4096 pages, LIFO batch:1
Mar 19 11:20:39 jyro kernel:   Normal zone: 126656 pages, LIFO batch:16
Mar 19 11:20:39 jyro kernel:   HighMem zone: 0 pages, LIFO batch:1
Mar 19 11:20:39 jyro kernel: ACPI: RSDP (v000 AMI                        ) @ 0x000ff980
Mar 19 11:20:39 jyro kernel: ACPI: RSDT (v001 D815EA D815EPE2 08193.02328) @ 0x1fef0000
Mar 19 11:20:39 jyro kernel: ACPI: FADT (v001 D815EA EA81510A 08193.02328) @ 0x1fef1000
Mar 19 11:20:39 jyro kernel: ACPI: MADT (v001 D815EA EA81510A 08193.02328) @ 0x1fee30e4
Mar 19 11:20:39 jyro kernel: ACPI: DSDT (v001 D815E2 EA81520A 00000.00035) @ 0x00000000
Mar 19 11:20:39 jyro kernel: ACPI: BIOS passes blacklist
Mar 19 11:20:39 jyro kernel: ACPI: Local APIC address 0xfee00000
Mar 19 11:20:39 jyro kernel: ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Mar 19 11:20:39 jyro kernel: Processor #0 6:11 APIC version 16
Mar 19 11:20:39 jyro kernel: ACPI: IOAPIC (id[0x01] address[0xfec00000] global_irq_base[0x0])
Mar 19 11:20:39 jyro kernel: IOAPIC[0]: Assigned apic_id 1
Mar 19 11:20:39 jyro kernel: IOAPIC[0]: apic_id 1, version 32, address 0xfec00000, IRQ 0-23
Mar 19 11:20:39 jyro kernel: ACPI: INT_SRC_OVR (bus[0] irq[0x9] global_irq[0x9] polarity[0x1] trigger[0x3])
Mar 19 11:20:39 jyro kernel: ACPI: INT_SRC_OVR (bus[0] irq[0x0] global_irq[0x2] polarity[0x0] trigger[0x0])
Mar 19 11:20:39 jyro kernel: Enabling APIC mode:  Flat.  Using 1 I/O APICs
Mar 19 11:20:39 jyro kernel: Using ACPI (MADT) for SMP configuration information
Mar 19 11:20:39 jyro kernel: Building zonelist for node : 0
Mar 19 11:20:39 jyro kernel: Kernel command line: ro root=/dev/hda3 hdc=ide-scsi
Mar 19 11:20:39 jyro kernel: ide_setup: hdc=ide-scsi
Mar 19 11:20:39 jyro kernel: Initializing CPU#0
Mar 19 11:20:39 jyro kernel: PID hash table entries: 2048 (order 11: 16384 bytes)
Mar 19 11:20:39 jyro kernel: Detected 1195.427 MHz processor.
Mar 19 11:20:39 jyro kernel: Console: colour VGA+ 80x25
Mar 19 11:20:39 jyro kernel: Calibrating delay loop... 2359.29 BogoMIPS
Mar 19 11:20:39 jyro kernel: Memory: 512940k/523008k available (2834k kernel code, 9320k reserved, 705k data, 312k init, 0k highmem)
Mar 19 11:20:39 jyro kernel: Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Mar 19 11:20:39 jyro kernel: Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Mar 19 11:20:39 jyro kernel: Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
Mar 19 11:20:39 jyro kernel: -> /dev
Mar 19 11:20:39 jyro kernel: -> /dev/console
Mar 19 11:20:39 jyro kernel: -> /root
Mar 19 11:20:39 jyro kernel: CPU: L1 I cache: 16K, L1 D cache: 16K
Mar 19 11:20:39 jyro kernel: CPU: L2 cache: 256K
Mar 19 11:20:39 jyro kernel: CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000
Mar 19 11:20:39 jyro kernel: Intel machine check architecture supported.
Mar 19 11:20:39 jyro kernel: Intel machine check reporting enabled on CPU#0.
Mar 19 11:20:39 jyro kernel: CPU: Intel(R) Celeron(TM) CPU                1200MHz stepping 01
Mar 19 11:20:39 jyro kernel: Enabling fast FPU save and restore... done.
Mar 19 11:20:39 jyro kernel: Enabling unmasked SIMD FPU exception support... done.
Mar 19 11:20:39 jyro kernel: Checking 'hlt' instruction... OK.
Mar 19 11:20:39 jyro kernel: POSIX conformance testing by UNIFIX
Mar 19 11:20:39 jyro kernel: enabled ExtINT on CPU#0
Mar 19 11:20:39 jyro kernel: ESR value before enabling vector: 00000004
Mar 19 11:20:39 jyro kernel: ESR value after enabling vector: 00000000
Mar 19 11:20:39 jyro kernel: ENABLING IO-APIC IRQs
Mar 19 11:20:39 jyro kernel: init IO_APIC IRQs
Mar 19 11:20:39 jyro kernel:  IO-APIC (apicid-pin) 1-0, 1-16, 1-17, 1-18, 1-19, 1-20, 1-21, 1-22, 1-23 not connected.
Mar 19 11:20:39 jyro kernel: ..TIMER: vector=0x31 pin1=2 pin2=0
Mar 19 11:20:39 jyro kernel: number of MP IRQ sources: 16.
Mar 19 11:20:39 jyro kernel: number of IO-APIC #1 registers: 24.
Mar 19 11:20:39 jyro kernel: testing the IO APIC.......................
Mar 19 11:20:39 jyro kernel: 
Mar 19 11:20:39 jyro kernel: IO APIC #1......
Mar 19 11:20:39 jyro kernel: .... register #00: 01000000
Mar 19 11:20:39 jyro kernel: .......    : physical APIC id: 01
Mar 19 11:20:39 jyro kernel: .......    : Delivery Type: 0
Mar 19 11:20:39 jyro kernel: .......    : LTS          : 0
Mar 19 11:20:39 jyro kernel: .... register #01: 00178020
Mar 19 11:20:39 jyro kernel: .......     : max redirection entries: 0017
Mar 19 11:20:39 jyro kernel: .......     : PRQ implemented: 1
Mar 19 11:20:39 jyro kernel: .......     : IO APIC version: 0020
Mar 19 11:20:39 jyro kernel: .... register #02: 00000000
Mar 19 11:20:39 jyro kernel: .......     : arbitration: 00
Mar 19 11:20:39 jyro kernel: .... IRQ redirection table:
Mar 19 11:20:39 jyro kernel:  NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
Mar 19 11:20:39 jyro kernel:  00 000 00  1    0    0   0   0    0    0    00
Mar 19 11:20:39 jyro kernel:  01 001 01  0    0    0   0   0    1    1    39
Mar 19 11:20:39 jyro kernel:  02 001 01  0    0    0   0   0    1    1    31
Mar 19 11:20:39 jyro kernel:  03 001 01  0    0    0   0   0    1    1    41
Mar 19 11:20:39 jyro kernel:  04 001 01  0    0    0   0   0    1    1    49
Mar 19 11:20:39 jyro kernel:  05 001 01  0    0    0   0   0    1    1    51
Mar 19 11:20:39 jyro kernel:  06 001 01  0    0    0   0   0    1    1    59
Mar 19 11:20:39 jyro kernel:  07 001 01  0    0    0   0   0    1    1    61
Mar 19 11:20:39 jyro kernel:  08 001 01  0    0    0   0   0    1    1    69
Mar 19 11:20:39 jyro kernel:  09 001 01  1    1    0   0   0    1    1    71
Mar 19 11:20:39 jyro kernel:  0a 001 01  0    0    0   0   0    1    1    79
Mar 19 11:20:39 jyro kernel:  0b 001 01  0    0    0   0   0    1    1    81
Mar 19 11:20:39 jyro kernel:  0c 001 01  0    0    0   0   0    1    1    89
Mar 19 11:20:39 jyro kernel:  0d 001 01  0    0    0   0   0    1    1    91
Mar 19 11:20:39 jyro kernel:  0e 001 01  0    0    0   0   0    1    1    99
Mar 19 11:20:39 jyro kernel:  0f 001 01  0    0    0   0   0    1    1    A1
Mar 19 11:20:39 jyro kernel:  10 000 00  1    0    0   0   0    0    0    00
Mar 19 11:20:39 jyro kernel:  11 000 00  1    0    0   0   0    0    0    00
Mar 19 11:20:39 jyro kernel:  12 000 00  1    0    0   0   0    0    0    00
Mar 19 11:20:39 jyro kernel:  13 000 00  1    0    0   0   0    0    0    00
Mar 19 11:20:39 jyro kernel:  14 000 00  1    0    0   0   0    0    0    00
Mar 19 11:20:39 jyro kernel:  15 000 00  1    0    0   0   0    0    0    00
Mar 19 11:20:39 jyro kernel:  16 000 00  1    0    0   0   0    0    0    00
Mar 19 11:20:39 jyro kernel:  17 000 00  1    0    0   0   0    0    0    00
Mar 19 11:20:39 jyro kernel: IRQ to pin mappings:
Mar 19 11:20:39 jyro kernel: IRQ0 -> 0:2
Mar 19 11:20:39 jyro kernel: IRQ1 -> 0:1
Mar 19 11:20:39 jyro kernel: IRQ3 -> 0:3
Mar 19 11:20:39 jyro kernel: IRQ4 -> 0:4
Mar 19 11:20:39 jyro kernel: IRQ5 -> 0:5
Mar 19 11:20:39 jyro kernel: IRQ6 -> 0:6
Mar 19 11:20:39 jyro kernel: IRQ7 -> 0:7
Mar 19 11:20:39 jyro kernel: IRQ8 -> 0:8
Mar 19 11:20:39 jyro kernel: IRQ9 -> 0:9
Mar 19 11:20:39 jyro kernel: IRQ10 -> 0:10
Mar 19 11:20:39 jyro kernel: IRQ11 -> 0:11
Mar 19 11:20:39 jyro kernel: IRQ12 -> 0:12
Mar 19 11:20:39 jyro kernel: IRQ13 -> 0:13
Mar 19 11:20:39 jyro kernel: IRQ14 -> 0:14
Mar 19 11:20:39 jyro kernel: IRQ15 -> 0:15
Mar 19 11:20:39 jyro kernel: .................................... done.
Mar 19 11:20:39 jyro kernel: Using local APIC timer interrupts.
Mar 19 11:20:39 jyro kernel: calibrating APIC timer ...
Mar 19 11:20:39 jyro kernel: ..... CPU clock speed is 1207.0329 MHz.
Mar 19 11:20:39 jyro kernel: ..... host bus clock speed is 100.0610 MHz.
Mar 19 11:20:39 jyro kernel: Linux NET4.0 for Linux 2.4
Mar 19 11:20:39 jyro kernel: Based upon Swansea University Computer Society NET3.039
Mar 19 11:20:39 jyro kernel: Initializing RT netlink socket
Mar 19 11:20:39 jyro kernel: mtrr: v2.0 (20020519)
Mar 19 11:20:39 jyro kernel: PCI: PCI BIOS revision 2.10 entry at 0xfda95, last bus=1
Mar 19 11:20:39 jyro kernel: PCI: Using configuration type 1
Mar 19 11:20:39 jyro kernel: BIO: pool of 256 setup, 14Kb (56 bytes/bio)
Mar 19 11:20:39 jyro kernel: biovec pool[0]:   1 bvecs: 256 entries (12 bytes)
Mar 19 11:20:39 jyro kernel: biovec pool[1]:   4 bvecs: 256 entries (48 bytes)
Mar 19 11:20:39 jyro kernel: biovec pool[2]:  16 bvecs: 256 entries (192 bytes)
Mar 19 11:20:39 jyro kernel: biovec pool[3]:  64 bvecs: 256 entries (768 bytes)
Mar 19 11:20:39 jyro kernel: biovec pool[4]: 128 bvecs: 256 entries (1536 bytes)
Mar 19 11:20:39 jyro kernel: biovec pool[5]: 256 bvecs: 256 entries (3072 bytes)
Mar 19 11:20:39 jyro kernel: ACPI: Subsystem revision 20030228
Mar 19 11:20:39 jyro kernel:  tbxface-0117 [03] acpi_load_tables      : ACPI Tables successfully acquired
Mar 19 11:20:39 jyro kernel: Parsing all Control Methods:..........................................................................................................................................................
Mar 19 11:20:39 jyro kernel: Table [DSDT] - 462 Objects with 42 Devices 154 Methods 21 Regions
Mar 19 11:20:39 jyro kernel: ACPI Namespace successfully loaded at root c04ddb3c
Mar 19 11:20:39 jyro kernel: evxfevnt-0092 [04] acpi_enable           : Transition to ACPI mode successful
Mar 19 11:20:39 jyro kernel:    evgpe-0416 [06] ev_create_gpe_block   : GPE Block: 2 registers at 0000000000000428
Mar 19 11:20:39 jyro kernel:    evgpe-0421 [06] ev_create_gpe_block   : GPE Block defined as GPE0 to GPE15
Mar 19 11:20:39 jyro kernel:    evgpe-0138 [08] ev_save_method_info   : GPE number associated with method _L1C is not valid
Mar 19 11:20:39 jyro kernel:    evgpe-0416 [06] ev_create_gpe_block   : GPE Block: 2 registers at 000000000000042C
Mar 19 11:20:39 jyro kernel:    evgpe-0421 [06] ev_create_gpe_block   : GPE Block defined as GPE16 to GPE31
Mar 19 11:20:39 jyro kernel:    evgpe-0138 [08] ev_save_method_info   : GPE number associated with method _L03 is not valid
Mar 19 11:20:39 jyro kernel:    evgpe-0138 [08] ev_save_method_info   : GPE number associated with method _L04 is not valid
Mar 19 11:20:39 jyro kernel:    evgpe-0138 [08] ev_save_method_info   : GPE number associated with method _L05 is not valid
Mar 19 11:20:39 jyro kernel:    evgpe-0138 [08] ev_save_method_info   : GPE number associated with method _L07 is not valid
Mar 19 11:20:39 jyro kernel:    evgpe-0138 [08] ev_save_method_info   : GPE number associated with method _L0B is not valid
Mar 19 11:20:39 jyro kernel:    evgpe-0138 [08] ev_save_method_info   : GPE number associated with method _L1C is not valid
Mar 19 11:20:39 jyro kernel: Executing all Device _STA and_INI methods:..........................................
Mar 19 11:20:39 jyro kernel: 42 Devices found containing: 42 _STA, 2 _INI methods
Mar 19 11:20:39 jyro kernel: Completing Region/Field/Buffer/Package initialization:...................................................................
Mar 19 11:20:39 jyro kernel: Initialized 13/21 Regions 7/7 Fields 37/37 Buffers 10/10 Packages (462 nodes)
Mar 19 11:20:39 jyro kernel: ACPI: Interpreter enabled
Mar 19 11:20:39 jyro kernel: ACPI: Using IOAPIC for interrupt routing
Mar 19 11:20:39 jyro kernel: ACPI: PCI Root Bridge [PCI0] (00:00)
Mar 19 11:20:39 jyro kernel: PCI: Probing PCI hardware (bus 00)
Mar 19 11:20:39 jyro kernel: Transparent bridge - Intel Corp. 82801BA/CA/DB PCI Br
Mar 19 11:20:39 jyro kernel: ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
Mar 19 11:20:39 jyro kernel: ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI1._PRT]
Mar 19 11:20:39 jyro kernel: ACPI: Power Resource [FDDP] (off)
Mar 19 11:20:39 jyro kernel: ACPI: Power Resource [URP1] (off)
Mar 19 11:20:39 jyro kernel: ACPI: Power Resource [URP2] (off)
Mar 19 11:20:39 jyro kernel: ACPI: Power Resource [LPTP] (off)
Mar 19 11:20:39 jyro kernel: ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 *11 12)
Mar 19 11:20:39 jyro kernel: ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 *9 10 11 12)
Mar 19 11:20:39 jyro kernel: ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 9 10 11 12, disabled)
Mar 19 11:20:39 jyro kernel: ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 9 10 *11 12)
Mar 19 11:20:39 jyro kernel: ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 9 10 *11 12)
Mar 19 11:20:39 jyro kernel: ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 9 10 11 12, disabled)
Mar 19 11:20:39 jyro kernel: ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 9 10 11 12, disabled)
Mar 19 11:20:39 jyro kernel: ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 9 *10 11 12)
Mar 19 11:20:39 jyro kernel: Linux Plug and Play Support v0.95 (c) Adam Belay
Mar 19 11:20:39 jyro kernel: block request queues:
Mar 19 11:20:39 jyro kernel:  128 requests per read queue
Mar 19 11:20:39 jyro kernel:  128 requests per write queue
Mar 19 11:20:39 jyro kernel:  8 requests per batch
Mar 19 11:20:39 jyro kernel:  enter congestion at 15
Mar 19 11:20:39 jyro kernel:  exit congestion at 17
Mar 19 11:20:39 jyro kernel: ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 5
Mar 19 11:20:39 jyro kernel: ACPI: PCI Interrupt Link [LNKF] enabled at IRQ 10
Mar 19 11:20:39 jyro kernel: ACPI: PCI Interrupt Link [LNKG] enabled at IRQ 9
Mar 19 11:20:39 jyro kernel: IOAPIC[0]: Set PCI routing entry (1-17 -> 0xa9 -> IRQ 17)
Mar 19 11:20:39 jyro kernel: 00:00:1f[B] -> 1-17 -> IRQ 17
Mar 19 11:20:39 jyro kernel: IOAPIC[0]: Set PCI routing entry (1-23 -> 0xb1 -> IRQ 23)
Mar 19 11:20:39 jyro kernel: 00:00:1f[C] -> 1-23 -> IRQ 23
Mar 19 11:20:39 jyro kernel: IOAPIC[0]: Set PCI routing entry (1-19 -> 0xb9 -> IRQ 19)
Mar 19 11:20:39 jyro kernel: 00:00:1f[D] -> 1-19 -> IRQ 19
Mar 19 11:20:39 jyro kernel: IOAPIC[0]: Set PCI routing entry (1-16 -> 0xc1 -> IRQ 16)
Mar 19 11:20:39 jyro kernel: 00:00:01[A] -> 1-16 -> IRQ 16
Mar 19 11:20:39 jyro kernel: Pin 1-17 already programmed
Mar 19 11:20:39 jyro kernel: Pin 1-16 already programmed
Mar 19 11:20:39 jyro kernel: Pin 1-17 already programmed
Mar 19 11:20:39 jyro kernel: Pin 1-17 already programmed
Mar 19 11:20:39 jyro kernel: IOAPIC[0]: Set PCI routing entry (1-20 -> 0xc9 -> IRQ 20)
Mar 19 11:20:39 jyro kernel: 00:01:08[A] -> 1-20 -> IRQ 20
Mar 19 11:20:39 jyro kernel: IOAPIC[0]: Set PCI routing entry (1-21 -> 0xd1 -> IRQ 21)
Mar 19 11:20:39 jyro kernel: 00:01:09[A] -> 1-21 -> IRQ 21
Mar 19 11:20:39 jyro kernel: IOAPIC[0]: Set PCI routing entry (1-22 -> 0xd9 -> IRQ 22)
Mar 19 11:20:39 jyro kernel: 00:01:09[B] -> 1-22 -> IRQ 22
Mar 19 11:20:39 jyro kernel: Pin 1-23 already programmed
Mar 19 11:20:39 jyro kernel: Pin 1-17 already programmed
Mar 19 11:20:39 jyro kernel: Pin 1-22 already programmed
Mar 19 11:20:39 jyro kernel: Pin 1-23 already programmed
Mar 19 11:20:39 jyro kernel: Pin 1-17 already programmed
Mar 19 11:20:39 jyro kernel: Pin 1-21 already programmed
Mar 19 11:20:39 jyro kernel: Pin 1-23 already programmed
Mar 19 11:20:39 jyro kernel: Pin 1-17 already programmed
Mar 19 11:20:39 jyro kernel: Pin 1-21 already programmed
Mar 19 11:20:39 jyro kernel: Pin 1-22 already programmed
Mar 19 11:20:39 jyro kernel: Pin 1-17 already programmed
Mar 19 11:20:39 jyro kernel: Pin 1-21 already programmed
Mar 19 11:20:39 jyro kernel: Pin 1-22 already programmed
Mar 19 11:20:39 jyro kernel: Pin 1-23 already programmed
Mar 19 11:20:39 jyro kernel: Pin 1-21 already programmed
Mar 19 11:20:39 jyro kernel: Pin 1-22 already programmed
Mar 19 11:20:39 jyro kernel: Pin 1-23 already programmed
Mar 19 11:20:39 jyro kernel: Pin 1-17 already programmed
Mar 19 11:20:39 jyro kernel: PCI: Using ACPI for IRQ routing
Mar 19 11:20:39 jyro kernel: PCI: if you experience problems, try using option 'pci=noacpi' or even 'acpi=off'
Mar 19 11:20:39 jyro kernel: Enabling SEP on CPU 0
Mar 19 11:20:39 jyro kernel: VFS: Disk quotas dquot_6.5.1
Mar 19 11:20:39 jyro kernel: Journalled Block Device driver loaded
Mar 19 11:20:39 jyro kernel: Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
Mar 19 11:20:39 jyro kernel: udf: registering filesystem
Mar 19 11:20:39 jyro kernel: Initializing Cryptographic API
Mar 19 11:20:39 jyro kernel: ACPI: Power Button (FF) [PWRF]
Mar 19 11:20:39 jyro kernel: ACPI: Processor [CPU1] (supports C1)
Mar 19 11:20:39 jyro kernel: pty: 256 Unix98 ptys configured
Mar 19 11:20:39 jyro kernel: Real Time Clock Driver v1.11
Mar 19 11:20:39 jyro kernel: Linux agpgart interface v0.100 (c) Dave Jones
Mar 19 11:20:39 jyro kernel: agpgart: agpgart: Detected an Intel i815 Chipset.
Mar 19 11:20:39 jyro kernel: agpgart: Maximum main memory to use for agp memory: 438M
Mar 19 11:20:39 jyro kernel: agpgart: AGP aperture is 64M @ 0xf8000000
Mar 19 11:20:39 jyro kernel: [drm] Initialized i810 1.2.1 20020211 on minor 0
Mar 19 11:20:39 jyro kernel: Serial: 8250/16550 driver $Revision: 1.90 $ IRQ sharing disabled
Mar 19 11:20:39 jyro kernel: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
Mar 19 11:20:39 jyro kernel: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
Mar 19 11:20:39 jyro kernel: anticipatory scheduling elevator
Mar 19 11:20:39 jyro kernel: Floppy drive(s): fd0 is 1.44M
Mar 19 11:20:39 jyro kernel: FDC 0 is a post-1991 82077
Mar 19 11:20:39 jyro kernel: loop: loaded (max 8 devices)
Mar 19 11:20:39 jyro kernel: Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
Mar 19 11:20:39 jyro kernel: ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
Mar 19 11:20:39 jyro kernel: ICH2: IDE controller at PCI slot 00:1f.1
Mar 19 11:20:39 jyro kernel: ICH2: chipset revision 17
Mar 19 11:20:39 jyro kernel: ICH2: not 100%% native mode: will probe irqs later
Mar 19 11:20:39 jyro kernel:     ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:DMA, hdb:pio
Mar 19 11:20:39 jyro kernel:     ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:DMA, hdd:pio
Mar 19 11:20:39 jyro kernel: hda: WDC WD400EB-00CPF0, ATA DISK drive
Mar 19 11:20:39 jyro kernel: anticipatory scheduling elevator
Mar 19 11:20:39 jyro kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Mar 19 11:20:39 jyro kernel: hdc: SONY CD-RW CRX185E1, ATAPI CD/DVD-ROM drive
Mar 19 11:20:39 jyro kernel: anticipatory scheduling elevator
Mar 19 11:20:39 jyro kernel: ide1 at 0x170-0x177,0x376 on irq 15
Mar 19 11:20:39 jyro kernel: hda: host protected area => 1
Mar 19 11:20:39 jyro kernel: hda: 78165360 sectors (40021 MB) w/2048KiB Cache, CHS=77545/16/63, UDMA(100)
Mar 19 11:20:39 jyro kernel:  hda: hda1 hda2 hda3 hda4 < hda5 hda6 hda7 hda8 >
Mar 19 11:20:39 jyro kernel: mice: PS/2 mouse device common for all mice
Mar 19 11:20:39 jyro kernel: input: ImExPS/2 Generic Explorer Mouse on isa0060/serio1
Mar 19 11:20:39 jyro kernel: serio: i8042 AUX port at 0x60,0x64 irq 12
Mar 19 11:20:39 jyro kernel: input: AT Set 2 keyboard on isa0060/serio0
Mar 19 11:20:39 jyro kernel: serio: i8042 KBD port at 0x60,0x64 irq 1
Mar 19 11:20:39 jyro kernel: NET4: Linux TCP/IP 1.0 for NET4.0
Mar 19 11:20:39 jyro kernel: IP: routing cache hash table of 1024 buckets, 32Kbytes
Mar 19 11:20:39 jyro kernel: TCP: Hash tables configured (established 32768 bind 9362)
Mar 19 11:20:39 jyro kernel: NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
Mar 19 11:20:39 jyro kernel: kjournald starting.  Commit interval 5 seconds
Mar 19 11:20:39 jyro kernel: EXT3-fs: mounted filesystem with ordered data mode.
Mar 19 11:20:39 jyro kernel: VFS: Mounted root (ext3 filesystem) readonly.
Mar 19 11:20:39 jyro kernel: Freeing unused kernel memory: 312k freed
Mar 19 11:20:39 jyro kernel: EXT3 FS 2.4-0.9.16, 02 Dec 2001 on ide0(3,3), internal journal
Mar 19 11:20:39 jyro kernel: Adding 514072k swap on /dev/hda2.  Priority:42 extents:1
Mar 19 11:20:39 jyro kernel: kjournald starting.  Commit interval 5 seconds
Mar 19 11:20:39 jyro kernel: EXT3 FS 2.4-0.9.16, 02 Dec 2001 on ide0(3,1), internal journal
Mar 19 11:20:39 jyro kernel: EXT3-fs: mounted filesystem with ordered data mode.
Mar 19 11:20:39 jyro kernel: kjournald starting.  Commit interval 5 seconds
Mar 19 11:20:39 jyro kernel: EXT3 FS 2.4-0.9.16, 02 Dec 2001 on ide0(3,5), internal journal
Mar 19 11:20:39 jyro kernel: EXT3-fs: mounted filesystem with writeback data mode.
Mar 19 11:20:39 jyro kernel: kjournald starting.  Commit interval 5 seconds
Mar 19 11:20:39 jyro kernel: EXT3 FS 2.4-0.9.16, 02 Dec 2001 on ide0(3,6), internal journal
Mar 19 11:20:39 jyro kernel: EXT3-fs: mounted filesystem with writeback data mode.
Mar 19 11:20:39 jyro kernel: kjournald starting.  Commit interval 5 seconds
Mar 19 11:20:39 jyro kernel: EXT3 FS 2.4-0.9.16, 02 Dec 2001 on ide0(3,7), internal journal
Mar 19 11:20:39 jyro kernel: EXT3-fs: mounted filesystem with writeback data mode.
Mar 19 11:20:39 jyro kernel: found reiserfs format "3.6" with standard journal
Mar 19 11:20:39 jyro kernel: Reiserfs journal params: device ide0(3,8), size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
Mar 19 11:20:39 jyro kernel: reiserfs: checking transaction log (ide0(3,8)) for (ide0(3,8))
Mar 19 11:20:39 jyro kernel: Using r5 hash to sort names
Mar 19 11:20:39 jyro kernel: blk: queue c04eba9c, I/O limit 4095Mb (mask 0xffffffff)
Mar 19 11:20:39 jyro kernel: IA-32 Microcode Update Driver: v1.11 <tigran@veritas.com>
Mar 19 11:20:39 jyro kernel: microcode: CPU0 already at revision 28 (current=28)
Mar 19 11:20:39 jyro kernel: microcode: freed 2048 bytes
Mar 19 11:20:39 jyro kernel: parport0: PC-style at 0x378 [PCSPP,TRISTATE,EPP]
Mar 19 11:20:39 jyro kernel: parport0: cpp_daisy: aa5500ff(38)
Mar 19 11:20:39 jyro kernel: parport0: assign_addrs: aa5500ff(38)
Mar 19 11:20:39 jyro kernel: Module parport cannot be unloaded due to unsafe usage in include/linux/module.h:457
Mar 19 11:20:39 jyro kernel: Module parport_pc cannot be unloaded due to unsafe usage in include/linux/module.h:457
Mar 19 11:20:39 jyro kernel: parport0: cpp_daisy: aa5500ff(38)
Mar 19 11:20:39 jyro kernel: parport0: assign_addrs: aa5500ff(38)
Mar 19 11:20:39 jyro kernel: ip_tables: (C) 2000-2002 Netfilter core team
Mar 19 11:20:39 jyro kernel: Intel(R) PRO/100 Network Driver - version 2.1.29-k4
Mar 19 11:20:39 jyro kernel: Copyright (c) 2002 Intel Corporation
Mar 19 11:20:39 jyro kernel: 
Mar 19 11:20:39 jyro kernel: e100: selftest OK.
Mar 19 11:20:39 jyro kernel: Freeing alive device defa907c, eth%%d
Mar 19 11:20:39 jyro kernel: e100: eth0: Intel(R) PRO/100 VE Network Connection
Mar 19 11:20:39 jyro kernel:   Hardware receive checksums enabled
Mar 19 11:20:39 jyro kernel: 
Mar 19 11:20:39 jyro kernel: e100: selftest OK.
Mar 19 11:20:39 jyro kernel: e100: eth1: Intel(R) PRO/100 S Desktop Adapter
Mar 19 11:20:39 jyro kernel:   Hardware receive checksums enabled
Mar 19 11:20:39 jyro kernel:   cpu cycle saver enabled
Mar 19 11:20:39 jyro kernel: 
Mar 19 11:20:39 jyro kernel: e100: eth0 NIC Link is Up 100 Mbps Full duplex
Mar 19 11:20:39 jyro kernel: e100: eth1 NIC Link is Up 10 Mbps Half duplex
Mar 19 11:20:40 jyro kernel: process `named' is using obsolete setsockopt SO_BSDCOMPAT
Mar 19 11:20:40 jyro last message repeated 10 times
Mar 19 11:20:46 jyro kernel: 24.55.66.1 sent an invalid ICMP error to a broadcast.
Mar 19 11:20:47 jyro kernel: Universal TUN/TAP device driver 1.5 (C)1999-2002 Maxim Krasnyansky
Mar 19 11:20:47 jyro kernel: Module tun cannot be unloaded due to unsafe usage in include/linux/module.h:457
Mar 19 11:20:55 jyro kernel: process `named' is using obsolete setsockopt SO_BSDCOMPAT
Mar 19 11:21:02 jyro kernel: ip_conntrack version 2.1 (4086 buckets, 32688 max) - 324 bytes per conntrack
Mar 19 11:21:02 jyro kernel: Module iptable_filter cannot be unloaded due to unsafe usage in include/linux/module.h:423
Mar 19 11:21:03 jyro kernel: Module iptable_nat cannot be unloaded due to unsafe usage in include/linux/module.h:423
Mar 19 11:21:03 jyro kernel: Module iptable_mangle cannot be unloaded due to unsafe usage in include/linux/module.h:423
Mar 19 11:21:09 jyro kernel: warning: process `update' used the obsolete bdflush system call
Mar 19 11:21:09 jyro kernel: Fix your initscripts?
Mar 19 11:21:11 jyro kernel: mtrr: base(0xf8000000) is not aligned on a size(0x180000) boundary
Mar 19 11:21:14 jyro kernel: warning: process `update' used the obsolete bdflush system call
Mar 19 11:21:14 jyro kernel: Fix your initscripts?
Mar 19 11:22:24 jyro kernel: process `nslookup' is using obsolete setsockopt SO_BSDCOMPAT
Mar 19 11:22:25 jyro kernel: process `nslookup' is using obsolete setsockopt SO_BSDCOMPAT
Mar 19 11:26:47 jyro kernel: process `named' is using obsolete setsockopt SO_BSDCOMPAT
Mar 19 11:27:32 jyro last message repeated 4 times
Mar 19 11:41:14 jyro kernel: process `named' is using obsolete setsockopt SO_BSDCOMPAT
Mar 19 11:41:59 jyro last message repeated 4 times
Mar 19 11:52:08 jyro kernel: process `nslookup' is using obsolete setsockopt SO_BSDCOMPAT
Mar 19 11:52:50 jyro kernel: process `named' is using obsolete setsockopt SO_BSDCOMPAT
Mar 19 11:53:35 jyro last message repeated 4 times
Mar 19 12:05:59 jyro kernel: hda: dma_timer_expiry: dma status == 0x24
Mar 19 12:05:59 jyro kernel: drivers/ide/ide-io.c:109: spin_lock(drivers/ide/ide.c:c0443328) already locked by drivers/ide/ide-io.c/936
Mar 19 12:05:59 jyro kernel: drivers/ide/ide-io.c:978: spin_unlock(drivers/ide/ide.c:c0443328) not locked
Mar 19 12:05:59 jyro kernel: hda: lost interrupt
Mar 19 12:05:59 jyro kernel: hda: dma_intr: bad DMA status (dma_stat=30)
Mar 19 12:05:59 jyro kernel: hda: dma_intr: status=0x50 { DriveReady SeekComplete }
Mar 19 12:05:59 jyro kernel: 
Mar 19 12:06:07 jyro kernel: process `named' is using obsolete setsockopt SO_BSDCOMPAT
Mar 19 12:06:52 jyro last message repeated 4 times
Mar 19 12:17:54 jyro kernel: process `named' is using obsolete setsockopt SO_BSDCOMPAT
Mar 19 12:20:40 jyro last message repeated 5 times
Mar 19 12:31:24 jyro last message repeated 4 times
Mar 19 12:44:55 jyro last message repeated 5 times
Mar 19 12:57:16 jyro last message repeated 5 times
Mar 19 13:08:33 jyro last message repeated 5 times
Mar 19 13:21:03 jyro last message repeated 5 times
Mar 19 13:32:55 jyro last message repeated 5 times
Mar 19 13:47:52 jyro last message repeated 5 times
Mar 19 14:00:52 jyro last message repeated 5 times
Mar 19 14:01:07 jyro last message repeated 2 times
Mar 19 14:01:21 jyro kernel: process `nslookup' is using obsolete setsockopt SO_BSDCOMPAT
Mar 19 14:01:22 jyro kernel: process `named' is using obsolete setsockopt SO_BSDCOMPAT
Mar 19 14:01:37 jyro kernel: process `named' is using obsolete setsockopt SO_BSDCOMPAT
Mar 19 14:07:07 jyro kernel: process `nslookup' is using obsolete setsockopt SO_BSDCOMPAT
Mar 19 14:07:14 jyro last message repeated 2 times
Mar 19 14:14:40 jyro kernel: process `named' is using obsolete setsockopt SO_BSDCOMPAT
Mar 19 14:15:25 jyro last message repeated 4 times
Mar 19 14:28:06 jyro kernel: process `named' is using obsolete setsockopt SO_BSDCOMPAT
Mar 19 14:39:31 jyro last message repeated 5 times
Mar 19 14:54:18 jyro last message repeated 5 times
Mar 19 15:06:55 jyro last message repeated 5 times
Mar 19 15:21:36 jyro last message repeated 5 times
Mar 19 15:33:23 jyro last message repeated 5 times
Mar 19 15:46:20 jyro last message repeated 5 times
Mar 19 15:58:44 jyro last message repeated 5 times
Mar 19 16:12:14 jyro last message repeated 5 times
Mar 19 16:23:56 jyro last message repeated 5 times
Mar 19 16:35:35 jyro last message repeated 5 times
Mar 19 16:46:57 jyro last message repeated 5 times
Mar 19 16:47:43 jyro last message repeated 4 times
Mar 19 16:58:32 jyro kernel: process `nslookup' is using obsolete setsockopt SO_BSDCOMPAT
Mar 19 16:59:53 jyro kernel: process `named' is using obsolete setsockopt SO_BSDCOMPAT
Mar 19 17:00:24 jyro last message repeated 3 times
Mar 19 17:11:25 jyro last message repeated 2 times
Mar 19 17:25:54 jyro last message repeated 5 times
Mar 19 17:39:39 jyro last message repeated 5 times
Mar 19 17:54:37 jyro last message repeated 5 times
Mar 19 18:06:39 jyro last message repeated 5 times
Mar 19 18:19:55 jyro last message repeated 5 times
Mar 19 18:32:08 jyro last message repeated 5 times
Mar 19 18:45:19 jyro last message repeated 5 times
Mar 19 18:59:03 jyro last message repeated 5 times
Mar 19 19:12:21 jyro last message repeated 5 times
Mar 19 19:24:09 jyro last message repeated 5 times
Mar 19 19:36:36 jyro last message repeated 5 times
Mar 19 19:48:18 jyro last message repeated 5 times
Mar 19 20:02:40 jyro last message repeated 5 times
Mar 19 20:14:53 jyro last message repeated 5 times
Mar 19 20:28:18 jyro last message repeated 5 times
Mar 19 20:42:14 jyro last message repeated 5 times
Mar 19 20:53:33 jyro last message repeated 5 times
Mar 19 20:54:18 jyro last message repeated 4 times
Mar 19 21:05:34 jyro kernel: process `nslookup' is using obsolete setsockopt SO_BSDCOMPAT
Mar 19 21:05:41 jyro last message repeated 2 times
Mar 19 21:07:18 jyro kernel: process `named' is using obsolete setsockopt SO_BSDCOMPAT
Mar 19 21:08:03 jyro last message repeated 4 times
Mar 19 21:20:45 jyro kernel: process `named' is using obsolete setsockopt SO_BSDCOMPAT
Mar 19 21:21:30 jyro last message repeated 4 times
Mar 19 21:27:27 jyro kernel: process `nslookup' is using obsolete setsockopt SO_BSDCOMPAT
Mar 19 21:33:10 jyro kernel: process `named' is using obsolete setsockopt SO_BSDCOMPAT
Mar 19 21:33:55 jyro last message repeated 4 times
Mar 19 21:47:37 jyro kernel: process `named' is using obsolete setsockopt SO_BSDCOMPAT
Mar 19 22:01:49 jyro last message repeated 5 times
Mar 19 22:16:28 jyro last message repeated 5 times
Mar 19 22:29:48 jyro last message repeated 5 times
Mar 19 22:43:40 jyro last message repeated 5 times
Mar 19 22:56:57 jyro last message repeated 5 times
Mar 19 23:08:37 jyro last message repeated 5 times
Mar 19 23:23:23 jyro last message repeated 5 times
Mar 19 23:36:30 jyro last message repeated 5 times
Mar 19 23:50:58 jyro last message repeated 5 times
Mar 20 00:04:20 jyro last message repeated 5 times
Mar 20 00:16:43 jyro last message repeated 5 times
Mar 20 00:29:52 jyro last message repeated 5 times
Mar 20 00:41:45 jyro last message repeated 5 times
Mar 20 00:56:29 jyro last message repeated 5 times
Mar 20 01:08:18 jyro last message repeated 5 times
Mar 20 01:22:51 jyro last message repeated 5 times
Mar 20 01:34:10 jyro last message repeated 5 times
Mar 20 01:46:12 jyro last message repeated 5 times
Mar 20 01:59:51 jyro last message repeated 5 times
Mar 20 02:11:21 jyro last message repeated 5 times
Mar 20 02:25:56 jyro last message repeated 5 times
Mar 20 02:37:17 jyro last message repeated 5 times
Mar 20 02:51:40 jyro last message repeated 5 times
Mar 20 03:05:44 jyro last message repeated 5 times
Mar 20 03:17:38 jyro last message repeated 5 times
Mar 20 03:29:21 jyro last message repeated 5 times
Mar 20 03:43:24 jyro last message repeated 5 times
Mar 20 03:54:54 jyro last message repeated 5 times
Mar 20 04:07:01 jyro last message repeated 5 times
Mar 20 04:18:26 jyro last message repeated 5 times
Mar 20 04:32:07 jyro last message repeated 5 times
Mar 20 04:43:57 jyro last message repeated 5 times
Mar 20 04:58:57 jyro last message repeated 5 times
Mar 20 05:13:37 jyro last message repeated 5 times
Mar 20 05:27:22 jyro last message repeated 5 times
Mar 20 05:38:55 jyro last message repeated 5 times
Mar 20 05:52:42 jyro last message repeated 5 times
Mar 20 06:06:50 jyro last message repeated 5 times
Mar 20 06:20:19 jyro last message repeated 5 times
Mar 20 06:35:17 jyro last message repeated 5 times
Mar 20 06:49:31 jyro last message repeated 5 times
Mar 20 07:03:21 jyro last message repeated 5 times
Mar 20 07:16:45 jyro last message repeated 5 times
Mar 20 07:31:14 jyro last message repeated 5 times
Mar 20 07:44:33 jyro last message repeated 5 times
Mar 20 07:55:49 jyro last message repeated 5 times
Mar 20 08:09:01 jyro last message repeated 5 times
Mar 20 08:23:46 jyro last message repeated 5 times
Mar 20 08:38:21 jyro last message repeated 5 times
Mar 20 08:53:21 jyro last message repeated 5 times
Mar 20 09:08:07 jyro last message repeated 5 times
Mar 20 09:20:30 jyro last message repeated 5 times
Mar 20 09:34:59 jyro last message repeated 5 times
Mar 20 09:48:27 jyro last message repeated 5 times
Mar 20 10:00:23 jyro last message repeated 5 times
Mar 20 10:11:43 jyro last message repeated 5 times
Mar 20 10:24:57 jyro last message repeated 5 times
Mar 20 10:25:43 jyro last message repeated 4 times
Mar 20 10:29:02 jyro kernel: process `nslookup' is using obsolete setsockopt SO_BSDCOMPAT
Mar 20 10:29:08 jyro last message repeated 2 times
Mar 20 10:29:18 jyro kernel: process `rndc' is using obsolete setsockopt SO_BSDCOMPAT
Mar 20 10:29:19 jyro kernel: process `rndc' is using obsolete setsockopt SO_BSDCOMPAT
Mar 20 10:29:21 jyro kernel: process `named' is using obsolete setsockopt SO_BSDCOMPAT
Mar 20 10:29:21 jyro last message repeated 15 times
Mar 20 10:29:23 jyro kernel: process `nslookup' is using obsolete setsockopt SO_BSDCOMPAT
Mar 20 10:29:55 jyro last message repeated 4 times
Mar 20 10:34:57 jyro last message repeated 8 times
Mar 20 10:35:28 jyro kernel: process `named' is using obsolete setsockopt SO_BSDCOMPAT
Mar 20 10:36:13 jyro last message repeated 4 times
Mar 20 10:44:34 jyro kernel: process `nslookup' is using obsolete setsockopt SO_BSDCOMPAT
Mar 20 10:49:38 jyro kernel: process `named' is using obsolete setsockopt SO_BSDCOMPAT
Mar 20 10:50:23 jyro last message repeated 4 times
Mar 20 11:04:16 jyro kernel: process `named' is using obsolete setsockopt SO_BSDCOMPAT
Mar 20 11:05:01 jyro last message repeated 4 times
Mar 20 11:06:46 jyro kernel: Slab corruption: start=ceaa2234, expend=ceaa2377, problemat=ceaa22ac
Mar 20 11:06:46 jyro kernel: Last user: [<e0a12cb0>](destroy_conntrack+0xd0/0x140 [ip_conntrack])
Mar 20 11:06:46 jyro kernel: Data: ************************************************************************************************************************AC 22 AA CE AC 22 AA CE ***************************************************************************************************************************************************************************************************A5 
Mar 20 11:06:46 jyro kernel: Next: 71 F0 2C .B0 2C A1 E0 71 F0 2C .********************
Mar 20 11:06:46 jyro kernel: slab error in check_poison_obj(): cache `ip_conntrack': object was modified after freeing
Mar 20 11:06:46 jyro kernel: Call Trace:
Mar 20 11:06:46 jyro kernel:  [<c014ab9b>] check_poison_obj+0x15b/0x1b0
Mar 20 11:06:46 jyro kernel:  [<c014c9f2>] kmem_cache_alloc+0x132/0x170
Mar 20 11:06:46 jyro kernel:  [<e0a137d7>] init_conntrack+0x97/0x450 [ip_conntrack]
Mar 20 11:06:46 jyro kernel:  [<e0a19f20>] ip_conntrack_protocol_udp+0x0/0x40 [ip_conntrack]
Mar 20 11:06:46 jyro kernel:  [<e0a137d7>] init_conntrack+0x97/0x450 [ip_conntrack]
Mar 20 11:06:46 jyro kernel:  [<e0a19f20>] ip_conntrack_protocol_udp+0x0/0x40 [ip_conntrack]
Mar 20 11:06:46 jyro kernel:  [<e0a13db3>] ip_conntrack_in+0x223/0x2e0 [ip_conntrack]
Mar 20 11:06:46 jyro kernel:  [<e0a19f20>] ip_conntrack_protocol_udp+0x0/0x40 [ip_conntrack]
Mar 20 11:06:46 jyro kernel:  [<e0a19f20>] ip_conntrack_protocol_udp+0x0/0x40 [ip_conntrack]
Mar 20 11:06:46 jyro kernel:  [<c0340490>] skb_checksum_help+0x40/0xa0
Mar 20 11:06:46 jyro kernel:  [<e0a19a98>] ip_conntrack_local_out_ops+0x0/0x18 [ip_conntrack]
Mar 20 11:06:46 jyro kernel:  [<c034ae14>] nf_hook_slow+0x134/0x1b0
Mar 20 11:06:46 jyro kernel:  [<c0361490>] dst_output+0x0/0x30
Mar 20 11:06:46 jyro kernel:  [<c0360caa>] ip_push_pending_frames+0x3aa/0x400
Mar 20 11:06:46 jyro kernel:  [<c0361490>] dst_output+0x0/0x30
Mar 20 11:06:46 jyro kernel:  [<c0384d59>] udp_push_pending_frames+0x129/0x240
Mar 20 11:06:46 jyro kernel:  [<c03854dd>] udp_sendmsg+0x62d/0xf10
Mar 20 11:06:46 jyro kernel:  [<c0372c80>] tcp_rcv_established+0x280/0x7a0
Mar 20 11:06:46 jyro kernel:  [<c039078b>] inet_sendmsg+0x4b/0x60
Mar 20 11:06:46 jyro kernel:  [<c033724e>] sock_sendmsg+0x8e/0xb0
Mar 20 11:06:46 jyro kernel:  [<c014aa34>] fprob+0x34/0x40
Mar 20 11:06:46 jyro kernel:  [<c014aa7b>] check_poison_obj+0x3b/0x1b0
Mar 20 11:06:46 jyro kernel:  [<c014aa7b>] check_poison_obj+0x3b/0x1b0
Mar 20 11:06:46 jyro kernel:  [<c014c9f2>] kmem_cache_alloc+0x132/0x170
Mar 20 11:06:46 jyro kernel:  [<c0336cbb>] move_addr_to_kernel+0x6b/0x70
Mar 20 11:06:46 jyro kernel:  [<c0338b8e>] sys_sendto+0xde/0x100
Mar 20 11:06:46 jyro kernel:  [<c0337010>] sock_map_fd+0x120/0x140
Mar 20 11:06:46 jyro kernel:  [<c038e4d4>] inet_setsockopt+0x34/0x40
Mar 20 11:06:46 jyro kernel:  [<c0338d8c>] sys_setsockopt+0x6c/0xb0
Mar 20 11:06:46 jyro kernel:  [<c0339557>] sys_socketcall+0x197/0x270
Mar 20 11:06:46 jyro kernel:  [<c010a43b>] syscall_call+0x7/0xb
Mar 20 11:06:46 jyro kernel: 


--------------080705040606050800070003
Content-Type: text/plain;
 name=".config-2.5.65-mm2.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename=".config-2.5.65-mm2.txt"

#
# Automatically generated make config: don't edit
#
CONFIG_X86=y
CONFIG_MMU=y
CONFIG_UID16=y
CONFIG_GENERIC_ISA_DMA=y

#
# Code maturity level options
#
CONFIG_EXPERIMENTAL=y

#
# General setup
#
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
# CONFIG_BSD_PROCESS_ACCT is not set
CONFIG_SYSCTL=y
CONFIG_LOG_BUF_SHIFT=15

#
# Loadable module support
#
CONFIG_MODULES=y
CONFIG_MODULE_UNLOAD=y
CONFIG_MODULE_FORCE_UNLOAD=y
CONFIG_OBSOLETE_MODPARM=y
CONFIG_MODVERSIONS=y
CONFIG_KMOD=y

#
# Processor type and features
#
CONFIG_X86_PC=y
# CONFIG_X86_VOYAGER is not set
# CONFIG_X86_NUMAQ is not set
# CONFIG_X86_SUMMIT is not set
# CONFIG_X86_BIGSMP is not set
# CONFIG_X86_VISWS is not set
# CONFIG_M386 is not set
# CONFIG_M486 is not set
# CONFIG_M586 is not set
# CONFIG_M586TSC is not set
# CONFIG_M586MMX is not set
# CONFIG_M686 is not set
CONFIG_MPENTIUMII=y
# CONFIG_MPENTIUMIII is not set
# CONFIG_MPENTIUM4 is not set
# CONFIG_MK6 is not set
# CONFIG_MK7 is not set
# CONFIG_MK8 is not set
# CONFIG_MELAN is not set
# CONFIG_MCRUSOE is not set
# CONFIG_MWINCHIPC6 is not set
# CONFIG_MWINCHIP2 is not set
# CONFIG_MWINCHIP3D is not set
# CONFIG_MCYRIXIII is not set
# CONFIG_MVIAC3_2 is not set
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_L1_CACHE_SHIFT=5
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_INTEL_USERCOPY=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
# CONFIG_HUGETLB_PAGE is not set
# CONFIG_SMP is not set
CONFIG_PREEMPT=y
CONFIG_X86_UP_APIC=y
CONFIG_X86_UP_IOAPIC=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_TSC=y
CONFIG_X86_MCE=y
# CONFIG_X86_MCE_NONFATAL is not set
# CONFIG_X86_MCE_P4THERMAL is not set
# CONFIG_TOSHIBA is not set
# CONFIG_I8K is not set
CONFIG_MICROCODE=m
CONFIG_X86_MSR=m
CONFIG_X86_CPUID=m
# CONFIG_EDD is not set
CONFIG_NOHIGHMEM=y
# CONFIG_HIGHMEM4G is not set
# CONFIG_HIGHMEM64G is not set
# CONFIG_05GB is not set
CONFIG_1GB=y
# CONFIG_2GB is not set
# CONFIG_3GB is not set
# CONFIG_MATH_EMULATION is not set
CONFIG_MTRR=y
CONFIG_HAVE_DEC_LOCK=y

#
# Power management options (ACPI, APM)
#
# CONFIG_PM is not set

#
# ACPI Support
#
CONFIG_ACPI=y
# CONFIG_ACPI_HT_ONLY is not set
CONFIG_ACPI_BOOT=y
CONFIG_ACPI_AC=y
CONFIG_ACPI_BATTERY=y
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_FAN=y
CONFIG_ACPI_PROCESSOR=y
CONFIG_ACPI_THERMAL=y
# CONFIG_ACPI_TOSHIBA is not set
CONFIG_ACPI_DEBUG=y
CONFIG_ACPI_BUS=y
CONFIG_ACPI_INTERPRETER=y
CONFIG_ACPI_EC=y
CONFIG_ACPI_POWER=y
CONFIG_ACPI_PCI=y
CONFIG_ACPI_SYSTEM=y

#
# CPU Frequency scaling
#
# CONFIG_CPU_FREQ is not set

#
# Bus options (PCI, PCMCIA, EISA, MCA, ISA)
#
CONFIG_PCI=y
# CONFIG_PCI_GOBIOS is not set
# CONFIG_PCI_GODIRECT is not set
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
# CONFIG_SCx200 is not set
CONFIG_PCI_LEGACY_PROC=y
CONFIG_PCI_NAMES=y
CONFIG_ISA=y
# CONFIG_EISA is not set
# CONFIG_MCA is not set
# CONFIG_HOTPLUG is not set

#
# Executable file formats
#
CONFIG_KCORE_ELF=y
# CONFIG_KCORE_AOUT is not set
CONFIG_BINFMT_AOUT=m
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_MISC=m

#
# Memory Technology Devices (MTD)
#
# CONFIG_MTD is not set

#
# Parallel port support
#
CONFIG_PARPORT=m
CONFIG_PARPORT_PC=m
CONFIG_PARPORT_PC_CML1=m
# CONFIG_PARPORT_SERIAL is not set
CONFIG_PARPORT_PC_FIFO=y
# CONFIG_PARPORT_PC_SUPERIO is not set
# CONFIG_PARPORT_OTHER is not set
CONFIG_PARPORT_1284=y

#
# Plug and Play support
#
CONFIG_PNP=y
CONFIG_PNP_NAMES=y
# CONFIG_PNP_DEBUG is not set

#
# Protocols
#
# CONFIG_ISAPNP is not set
# CONFIG_PNPBIOS is not set

#
# Block devices
#
CONFIG_BLK_DEV_FD=y
# CONFIG_BLK_DEV_XD is not set
# CONFIG_PARIDE is not set
# CONFIG_BLK_CPQ_DA is not set
# CONFIG_BLK_CPQ_CISS_DA is not set
# CONFIG_BLK_DEV_DAC960 is not set
# CONFIG_BLK_DEV_UMEM is not set
CONFIG_BLK_DEV_LOOP=y
CONFIG_BLK_DEV_NBD=m
CONFIG_BLK_DEV_RAM=m
CONFIG_BLK_DEV_RAM_SIZE=4096
# CONFIG_LBD is not set

#
# ATA/ATAPI/MFM/RLL device support
#
CONFIG_IDE=y

#
# IDE, ATA and ATAPI Block devices
#
CONFIG_BLK_DEV_IDE=y

#
# Please see Documentation/ide.txt for help/info on IDE drives
#
# CONFIG_BLK_DEV_HD_IDE is not set
# CONFIG_BLK_DEV_HD is not set
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTI_MODE=y
# CONFIG_IDEDISK_STROKE is not set
CONFIG_BLK_DEV_IDECD=m
CONFIG_BLK_DEV_IDEFLOPPY=m
# CONFIG_BLK_DEV_IDESCSI is not set
# CONFIG_IDE_TASK_IOCTL is not set

#
# IDE chipset support/bugfixes
#
CONFIG_BLK_DEV_CMD640=y
# CONFIG_BLK_DEV_CMD640_ENHANCED is not set
# CONFIG_BLK_DEV_IDEPNP is not set
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_BLK_DEV_GENERIC=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
# CONFIG_BLK_DEV_IDE_TCQ is not set
# CONFIG_BLK_DEV_OFFBOARD is not set
# CONFIG_BLK_DEV_IDEDMA_FORCED is not set
CONFIG_IDEDMA_PCI_AUTO=y
# CONFIG_IDEDMA_ONLYDISK is not set
CONFIG_BLK_DEV_IDEDMA=y
# CONFIG_IDEDMA_PCI_WIP is not set
CONFIG_BLK_DEV_ADMA=y
# CONFIG_BLK_DEV_AEC62XX is not set
# CONFIG_BLK_DEV_ALI15X3 is not set
# CONFIG_BLK_DEV_AMD74XX is not set
# CONFIG_BLK_DEV_CMD64X is not set
# CONFIG_BLK_DEV_TRIFLEX is not set
# CONFIG_BLK_DEV_CY82C693 is not set
# CONFIG_BLK_DEV_CS5520 is not set
# CONFIG_BLK_DEV_HPT34X is not set
# CONFIG_BLK_DEV_HPT366 is not set
# CONFIG_BLK_DEV_SC1200 is not set
CONFIG_BLK_DEV_PIIX=y
# CONFIG_BLK_DEV_NS87415 is not set
# CONFIG_BLK_DEV_OPTI621 is not set
# CONFIG_BLK_DEV_PDC202XX_OLD is not set
# CONFIG_BLK_DEV_PDC202XX_NEW is not set
# CONFIG_BLK_DEV_RZ1000 is not set
# CONFIG_BLK_DEV_SVWKS is not set
# CONFIG_BLK_DEV_SIIMAGE is not set
# CONFIG_BLK_DEV_SIS5513 is not set
# CONFIG_BLK_DEV_SLC90E66 is not set
# CONFIG_BLK_DEV_TRM290 is not set
# CONFIG_BLK_DEV_VIA82CXXX is not set
# CONFIG_IDE_CHIPSETS is not set
CONFIG_IDEDMA_AUTO=y
# CONFIG_IDEDMA_IVB is not set
CONFIG_BLK_DEV_IDE_MODES=y

#
# SCSI device support
#
CONFIG_SCSI=m

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=m
# CONFIG_CHR_DEV_ST is not set
# CONFIG_CHR_DEV_OSST is not set
CONFIG_BLK_DEV_SR=m
# CONFIG_BLK_DEV_SR_VENDOR is not set
CONFIG_CHR_DEV_SG=m

#
# Some SCSI devices (e.g. CD jukebox) support multiple LUNs
#
# CONFIG_SCSI_MULTI_LUN is not set
# CONFIG_SCSI_REPORT_LUNS is not set
# CONFIG_SCSI_CONSTANTS is not set
# CONFIG_SCSI_LOGGING is not set

#
# SCSI low-level drivers
#
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
# CONFIG_SCSI_7000FASST is not set
# CONFIG_SCSI_ACARD is not set
# CONFIG_SCSI_AHA152X is not set
# CONFIG_SCSI_AHA1542 is not set
# CONFIG_SCSI_AACRAID is not set
# CONFIG_SCSI_AIC7XXX is not set
# CONFIG_SCSI_AIC7XXX_OLD is not set
# CONFIG_SCSI_AIC79XX is not set
# CONFIG_SCSI_DPT_I2O is not set
# CONFIG_SCSI_ADVANSYS is not set
# CONFIG_SCSI_IN2000 is not set
# CONFIG_SCSI_AM53C974 is not set
# CONFIG_SCSI_MEGARAID is not set
# CONFIG_SCSI_BUSLOGIC is not set
# CONFIG_SCSI_CPQFCTS is not set
# CONFIG_SCSI_DMX3191D is not set
# CONFIG_SCSI_DTC3280 is not set
# CONFIG_SCSI_EATA is not set
# CONFIG_SCSI_EATA_PIO is not set
# CONFIG_SCSI_FUTURE_DOMAIN is not set
# CONFIG_SCSI_GDTH is not set
# CONFIG_SCSI_GENERIC_NCR5380 is not set
# CONFIG_SCSI_GENERIC_NCR5380_MMIO is not set
# CONFIG_SCSI_IPS is not set
# CONFIG_SCSI_INITIO is not set
# CONFIG_SCSI_INIA100 is not set
# CONFIG_SCSI_PPA is not set
# CONFIG_SCSI_IMM is not set
# CONFIG_SCSI_NCR53C406A is not set
# CONFIG_SCSI_NCR53C7xx is not set
# CONFIG_SCSI_SYM53C8XX_2 is not set
# CONFIG_SCSI_NCR53C8XX is not set
# CONFIG_SCSI_SYM53C8XX is not set
# CONFIG_SCSI_PAS16 is not set
# CONFIG_SCSI_PCI2000 is not set
# CONFIG_SCSI_PCI2220I is not set
# CONFIG_SCSI_PSI240I is not set
# CONFIG_SCSI_QLOGIC_FAS is not set
# CONFIG_SCSI_QLOGIC_ISP is not set
# CONFIG_SCSI_QLOGIC_ISP_NEW is not set
# CONFIG_SCSI_QLOGIC_FC is not set
# CONFIG_SCSI_QLOGIC_1280 is not set
# CONFIG_SCSI_SEAGATE is not set
# CONFIG_SCSI_SYM53C416 is not set
# CONFIG_SCSI_DC390T is not set
# CONFIG_SCSI_T128 is not set
# CONFIG_SCSI_U14_34F is not set
# CONFIG_SCSI_ULTRASTOR is not set
# CONFIG_SCSI_NSP32 is not set
# CONFIG_SCSI_DEBUG is not set

#
# Old CD-ROM drivers (not SCSI, not IDE)
#
# CONFIG_CD_NO_IDESCSI is not set

#
# Multi-device support (RAID and LVM)
#
# CONFIG_MD is not set

#
# Fusion MPT device support
#
# CONFIG_FUSION is not set

#
# IEEE 1394 (FireWire) support (EXPERIMENTAL)
#
# CONFIG_IEEE1394 is not set

#
# I2O device support
#
# CONFIG_I2O is not set

#
# Networking support
#
CONFIG_NET=y

#
# Networking options
#
CONFIG_PACKET=y
CONFIG_PACKET_MMAP=y
CONFIG_NETLINK_DEV=y
CONFIG_NETFILTER=y
# CONFIG_NETFILTER_DEBUG is not set
CONFIG_FILTER=y
CONFIG_UNIX=y
CONFIG_NET_KEY=m
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_IP_ADVANCED_ROUTER=y
CONFIG_IP_MULTIPLE_TABLES=y
CONFIG_IP_ROUTE_FWMARK=y
CONFIG_IP_ROUTE_NAT=y
CONFIG_IP_ROUTE_MULTIPATH=y
CONFIG_IP_ROUTE_TOS=y
CONFIG_IP_ROUTE_VERBOSE=y
# CONFIG_IP_ROUTE_LARGE_TABLES is not set
# CONFIG_IP_PNP is not set
CONFIG_NET_IPIP=m
CONFIG_NET_IPGRE=m
CONFIG_NET_IPGRE_BROADCAST=y
# CONFIG_IP_MROUTE is not set
CONFIG_ARPD=y
CONFIG_INET_ECN=y
CONFIG_SYN_COOKIES=y
CONFIG_INET_AH=m
CONFIG_INET_ESP=m
CONFIG_XFRM_USER=m

#
# IP: Netfilter Configuration
#
CONFIG_IP_NF_CONNTRACK=m
CONFIG_IP_NF_FTP=m
CONFIG_IP_NF_IRC=m
CONFIG_IP_NF_QUEUE=m
CONFIG_IP_NF_IPTABLES=m
CONFIG_IP_NF_MATCH_LIMIT=m
CONFIG_IP_NF_MATCH_MAC=m
CONFIG_IP_NF_MATCH_PKTTYPE=m
CONFIG_IP_NF_MATCH_MARK=m
CONFIG_IP_NF_MATCH_MULTIPORT=m
CONFIG_IP_NF_MATCH_TOS=m
CONFIG_IP_NF_MATCH_ECN=m
CONFIG_IP_NF_MATCH_DSCP=m
CONFIG_IP_NF_MATCH_AH_ESP=m
CONFIG_IP_NF_MATCH_LENGTH=m
CONFIG_IP_NF_MATCH_TTL=m
CONFIG_IP_NF_MATCH_TCPMSS=m
CONFIG_IP_NF_MATCH_HELPER=m
CONFIG_IP_NF_MATCH_STATE=m
CONFIG_IP_NF_MATCH_CONNTRACK=m
CONFIG_IP_NF_MATCH_UNCLEAN=m
CONFIG_IP_NF_MATCH_OWNER=m
CONFIG_IP_NF_FILTER=m
CONFIG_IP_NF_TARGET_REJECT=m
CONFIG_IP_NF_TARGET_MIRROR=m
CONFIG_IP_NF_NAT=m
CONFIG_IP_NF_NAT_NEEDED=y
CONFIG_IP_NF_TARGET_MASQUERADE=m
CONFIG_IP_NF_TARGET_REDIRECT=m
CONFIG_IP_NF_NAT_LOCAL=y
CONFIG_IP_NF_NAT_SNMP_BASIC=m
CONFIG_IP_NF_NAT_IRC=m
CONFIG_IP_NF_NAT_FTP=m
CONFIG_IP_NF_MANGLE=m
CONFIG_IP_NF_TARGET_TOS=m
CONFIG_IP_NF_TARGET_ECN=m
CONFIG_IP_NF_TARGET_DSCP=m
CONFIG_IP_NF_TARGET_MARK=m
CONFIG_IP_NF_TARGET_LOG=m
CONFIG_IP_NF_TARGET_ULOG=m
CONFIG_IP_NF_TARGET_TCPMSS=m
CONFIG_IP_NF_ARPTABLES=m
CONFIG_IP_NF_ARPFILTER=m
# CONFIG_IP_NF_COMPAT_IPCHAINS is not set
# CONFIG_IP_NF_COMPAT_IPFWADM is not set
# CONFIG_IPV6 is not set

#
# SCTP Configuration (EXPERIMENTAL)
#
CONFIG_IPV6_SCTP__=y
# CONFIG_IP_SCTP is not set
# CONFIG_ATM is not set
# CONFIG_VLAN_8021Q is not set
# CONFIG_LLC is not set
# CONFIG_DECNET is not set
# CONFIG_BRIDGE is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_NET_DIVERT is not set
# CONFIG_ECONET is not set
# CONFIG_WAN_ROUTER is not set
# CONFIG_NET_FASTROUTE is not set
# CONFIG_NET_HW_FLOWCONTROL is not set

#
# QoS and/or fair queueing
#
CONFIG_NET_SCHED=y
CONFIG_NET_SCH_CBQ=m
CONFIG_NET_SCH_HTB=m
CONFIG_NET_SCH_CSZ=m
CONFIG_NET_SCH_PRIO=m
CONFIG_NET_SCH_RED=m
CONFIG_NET_SCH_SFQ=m
CONFIG_NET_SCH_TEQL=m
CONFIG_NET_SCH_TBF=m
CONFIG_NET_SCH_GRED=m
CONFIG_NET_SCH_DSMARK=m
CONFIG_NET_SCH_INGRESS=m
CONFIG_NET_QOS=y
CONFIG_NET_ESTIMATOR=y
CONFIG_NET_CLS=y
CONFIG_NET_CLS_TCINDEX=m
CONFIG_NET_CLS_ROUTE4=m
CONFIG_NET_CLS_ROUTE=y
CONFIG_NET_CLS_FW=m
CONFIG_NET_CLS_U32=m
CONFIG_NET_CLS_RSVP=m
CONFIG_NET_CLS_RSVP6=m
CONFIG_NET_CLS_POLICE=y

#
# Network testing
#
CONFIG_NET_PKTGEN=m
CONFIG_NETDEVICES=y

#
# ARCnet devices
#
# CONFIG_ARCNET is not set
# CONFIG_DUMMY is not set
# CONFIG_BONDING is not set
# CONFIG_EQUALIZER is not set
CONFIG_TUN=m
# CONFIG_ETHERTAP is not set

#
# Ethernet (10 or 100Mbit)
#
CONFIG_NET_ETHERNET=y
CONFIG_MII=m
# CONFIG_HAPPYMEAL is not set
# CONFIG_SUNGEM is not set
CONFIG_NET_VENDOR_3COM=y
# CONFIG_EL1 is not set
# CONFIG_EL2 is not set
# CONFIG_ELPLUS is not set
# CONFIG_EL16 is not set
# CONFIG_EL3 is not set
CONFIG_3C515=m
CONFIG_VORTEX=m
# CONFIG_TYPHOON is not set
# CONFIG_LANCE is not set
# CONFIG_NET_VENDOR_SMC is not set
# CONFIG_NET_VENDOR_RACAL is not set

#
# Tulip family network device support
#
# CONFIG_NET_TULIP is not set
# CONFIG_AT1700 is not set
# CONFIG_DEPCA is not set
# CONFIG_HP100 is not set
# CONFIG_NET_ISA is not set
CONFIG_NET_PCI=y
# CONFIG_PCNET32 is not set
# CONFIG_AMD8111_ETH is not set
# CONFIG_ADAPTEC_STARFIRE is not set
# CONFIG_AC3200 is not set
# CONFIG_APRICOT is not set
# CONFIG_B44 is not set
# CONFIG_CS89x0 is not set
# CONFIG_DGRS is not set
CONFIG_EEPRO100=m
# CONFIG_EEPRO100_PIO is not set
CONFIG_E100=m
# CONFIG_FEALNX is not set
# CONFIG_NATSEMI is not set
# CONFIG_NE2K_PCI is not set
# CONFIG_8139CP is not set
# CONFIG_8139TOO is not set
# CONFIG_SIS900 is not set
# CONFIG_EPIC100 is not set
# CONFIG_SUNDANCE is not set
# CONFIG_TLAN is not set
# CONFIG_VIA_RHINE is not set
# CONFIG_NET_POCKET is not set

#
# Ethernet (1000 Mbit)
#
# CONFIG_ACENIC is not set
# CONFIG_DL2K is not set
CONFIG_E1000=m
CONFIG_E1000_NAPI=y
# CONFIG_NS83820 is not set
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
# CONFIG_R8169 is not set
# CONFIG_SK98LIN is not set
# CONFIG_TIGON3 is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_PLIP is not set
CONFIG_PPP=m
# CONFIG_PPP_MULTILINK is not set
CONFIG_PPP_FILTER=y
CONFIG_PPP_ASYNC=m
CONFIG_PPP_SYNC_TTY=m
CONFIG_PPP_DEFLATE=m
CONFIG_PPP_BSDCOMP=m
CONFIG_PPPOE=m
# CONFIG_SLIP is not set

#
# Wireless LAN (non-hamradio)
#
# CONFIG_NET_RADIO is not set

#
# Token Ring devices (depends on LLC=y)
#
# CONFIG_NET_FC is not set
# CONFIG_RCPCI is not set
# CONFIG_SHAPER is not set

#
# Wan interfaces
#
# CONFIG_WAN is not set

#
# Amateur Radio support
#
# CONFIG_HAMRADIO is not set

#
# IrDA (infrared) support
#
# CONFIG_IRDA is not set

#
# ISDN subsystem
#
# CONFIG_ISDN_BOOL is not set

#
# Telephony Support
#
# CONFIG_PHONE is not set

#
# Input device support
#
CONFIG_INPUT=y

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=y
CONFIG_INPUT_MOUSEDEV_PSAUX=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
CONFIG_INPUT_JOYDEV=m
# CONFIG_INPUT_TSDEV is not set
CONFIG_INPUT_EVDEV=m
CONFIG_INPUT_EVBUG=m

#
# Input I/O drivers
#
# CONFIG_GAMEPORT is not set
CONFIG_SOUND_GAMEPORT=y
CONFIG_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=m
# CONFIG_SERIO_CT82C710 is not set
# CONFIG_SERIO_PARKBD is not set

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ATKBD=y
CONFIG_KEYBOARD_SUNKBD=m
CONFIG_KEYBOARD_XTKBD=m
# CONFIG_KEYBOARD_NEWTON is not set
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y
CONFIG_MOUSE_SERIAL=m
# CONFIG_MOUSE_INPORT is not set
# CONFIG_MOUSE_LOGIBM is not set
# CONFIG_MOUSE_PC110PAD is not set
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
# CONFIG_INPUT_MISC is not set

#
# Character devices
#
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_HW_CONSOLE=y
# CONFIG_SERIAL_NONSTANDARD is not set

#
# Serial drivers
#
CONFIG_SERIAL_8250=y
# CONFIG_SERIAL_8250_CONSOLE is not set
# CONFIG_SERIAL_8250_EXTENDED is not set

#
# Non-8250 serial port support
#
CONFIG_SERIAL_CORE=y
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=256
CONFIG_PRINTER=m
# CONFIG_LP_CONSOLE is not set
# CONFIG_PPDEV is not set
# CONFIG_TIPAR is not set

#
# I2C support
#
# CONFIG_I2C is not set

#
# I2C Hardware Sensors Mainboard support
#

#
# I2C Hardware Sensors Chip support
#

#
# Mice
#
# CONFIG_BUSMOUSE is not set
# CONFIG_QIC02_TAPE is not set

#
# IPMI
#
# CONFIG_IPMI_HANDLER is not set

#
# Watchdog Cards
#
# CONFIG_WATCHDOG is not set
# CONFIG_HW_RANDOM is not set
CONFIG_NVRAM=m
CONFIG_RTC=y
# CONFIG_DTLK is not set
# CONFIG_R3964 is not set
# CONFIG_APPLICOM is not set
# CONFIG_SONYPI is not set

#
# Ftape, the floppy tape device driver
#
# CONFIG_FTAPE is not set
CONFIG_AGP=y
# CONFIG_AGP3 is not set
CONFIG_AGP_INTEL=y
# CONFIG_AGP_VIA is not set
# CONFIG_AGP_AMD is not set
# CONFIG_AGP_SIS is not set
# CONFIG_AGP_ALI is not set
# CONFIG_AGP_SWORKS is not set
# CONFIG_AGP_AMD_8151 is not set
CONFIG_DRM=y
CONFIG_DRM_TDFX=m
CONFIG_DRM_R128=m
# CONFIG_DRM_RADEON is not set
CONFIG_DRM_I810=y
# CONFIG_DRM_I830 is not set
# CONFIG_DRM_MGA is not set
# CONFIG_MWAVE is not set
# CONFIG_RAW_DRIVER is not set
CONFIG_HANGCHECK_TIMER=m

#
# Multimedia devices
#
# CONFIG_VIDEO_DEV is not set

#
# File systems
#
CONFIG_EXT2_FS=y
CONFIG_EXT2_FS_XATTR=y
# CONFIG_EXT2_FS_POSIX_ACL is not set
CONFIG_EXT3_FS=y
CONFIG_EXT3_FS_XATTR=y
CONFIG_EXT3_FS_POSIX_ACL=y
CONFIG_JBD=y
CONFIG_JBD_DEBUG=y
CONFIG_FS_MBCACHE=y
CONFIG_REISERFS_FS=y
# CONFIG_REISERFS_CHECK is not set
CONFIG_REISERFS_PROC_INFO=y
# CONFIG_JFS_FS is not set
CONFIG_FS_POSIX_ACL=y
# CONFIG_XFS_FS is not set
# CONFIG_MINIX_FS is not set
# CONFIG_ROMFS_FS is not set
CONFIG_QUOTA=y
CONFIG_QFMT_V1=m
CONFIG_QFMT_V2=m
CONFIG_QUOTACTL=y
CONFIG_AUTOFS_FS=m
CONFIG_AUTOFS4_FS=y

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=y
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
CONFIG_ZISOFS_FS=y
CONFIG_UDF_FS=y

#
# DOS/FAT/NT Filesystems
#
# CONFIG_FAT_FS is not set
# CONFIG_NTFS_FS is not set

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
# CONFIG_DEVFS_FS is not set
CONFIG_DEVPTS_FS=y
CONFIG_TMPFS=y
CONFIG_RAMFS=y

#
# Miscellaneous filesystems
#
# CONFIG_ADFS_FS is not set
# CONFIG_AFFS_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_BEFS_FS is not set
# CONFIG_BFS_FS is not set
# CONFIG_EFS_FS is not set
# CONFIG_CRAMFS is not set
# CONFIG_VXFS_FS is not set
# CONFIG_HPFS_FS is not set
# CONFIG_QNX4FS_FS is not set
# CONFIG_SYSV_FS is not set
# CONFIG_UFS_FS is not set

#
# Network File Systems
#
CONFIG_NFS_FS=y
CONFIG_NFS_V3=y
CONFIG_NFS_V4=y
CONFIG_NFSD=y
CONFIG_NFSD_V3=y
CONFIG_NFSD_V4=y
CONFIG_NFSD_TCP=y
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y
CONFIG_EXPORTFS=y
CONFIG_SMB_FS=m
CONFIG_SMB_NLS_DEFAULT=y
CONFIG_SMB_NLS_REMOTE="cp437"
# CONFIG_CIFS is not set
# CONFIG_NCP_FS is not set
# CONFIG_CODA_FS is not set
# CONFIG_INTERMEZZO_FS is not set
CONFIG_SUNRPC=y
CONFIG_SUNRPC_GSS=m
CONFIG_RPCSEC_GSS_KRB5=m
# CONFIG_AFS_FS is not set

#
# Partition Types
#
CONFIG_PARTITION_ADVANCED=y
# CONFIG_ACORN_PARTITION is not set
# CONFIG_OSF_PARTITION is not set
# CONFIG_AMIGA_PARTITION is not set
# CONFIG_ATARI_PARTITION is not set
# CONFIG_MAC_PARTITION is not set
CONFIG_MSDOS_PARTITION=y
CONFIG_BSD_DISKLABEL=y
# CONFIG_MINIX_SUBPARTITION is not set
CONFIG_SOLARIS_X86_PARTITION=y
CONFIG_UNIXWARE_DISKLABEL=y
# CONFIG_LDM_PARTITION is not set
CONFIG_SGI_PARTITION=y
# CONFIG_ULTRIX_PARTITION is not set
CONFIG_SUN_PARTITION=y
# CONFIG_EFI_PARTITION is not set
CONFIG_SMB_NLS=y
CONFIG_NLS=y

#
# Native Language Support
#
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=y
CONFIG_NLS_CODEPAGE_737=m
CONFIG_NLS_CODEPAGE_775=m
CONFIG_NLS_CODEPAGE_850=m
CONFIG_NLS_CODEPAGE_852=m
CONFIG_NLS_CODEPAGE_855=m
CONFIG_NLS_CODEPAGE_857=m
CONFIG_NLS_CODEPAGE_860=m
CONFIG_NLS_CODEPAGE_861=m
CONFIG_NLS_CODEPAGE_862=m
CONFIG_NLS_CODEPAGE_863=m
CONFIG_NLS_CODEPAGE_864=m
CONFIG_NLS_CODEPAGE_865=m
CONFIG_NLS_CODEPAGE_866=m
CONFIG_NLS_CODEPAGE_869=m
CONFIG_NLS_CODEPAGE_936=m
CONFIG_NLS_CODEPAGE_950=m
CONFIG_NLS_CODEPAGE_932=m
CONFIG_NLS_CODEPAGE_949=m
CONFIG_NLS_CODEPAGE_874=m
CONFIG_NLS_ISO8859_8=m
CONFIG_NLS_CODEPAGE_1250=m
CONFIG_NLS_CODEPAGE_1251=m
CONFIG_NLS_ISO8859_1=m
CONFIG_NLS_ISO8859_2=m
CONFIG_NLS_ISO8859_3=m
CONFIG_NLS_ISO8859_4=m
CONFIG_NLS_ISO8859_5=m
CONFIG_NLS_ISO8859_6=m
CONFIG_NLS_ISO8859_7=m
CONFIG_NLS_ISO8859_9=m
CONFIG_NLS_ISO8859_13=m
CONFIG_NLS_ISO8859_14=m
CONFIG_NLS_ISO8859_15=m
CONFIG_NLS_KOI8_R=m
CONFIG_NLS_KOI8_U=m
CONFIG_NLS_UTF8=m

#
# Graphics support
#
# CONFIG_FB is not set
# CONFIG_VIDEO_SELECT is not set

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=y
# CONFIG_MDA_CONSOLE is not set
CONFIG_DUMMY_CONSOLE=y

#
# Sound
#
CONFIG_SOUND=m

#
# Advanced Linux Sound Architecture
#
CONFIG_SND=m
CONFIG_SND_SEQUENCER=m
CONFIG_SND_SEQ_DUMMY=m
CONFIG_SND_OSSEMUL=y
CONFIG_SND_MIXER_OSS=m
CONFIG_SND_PCM_OSS=m
CONFIG_SND_SEQUENCER_OSS=y
CONFIG_SND_RTCTIMER=m
CONFIG_SND_VERBOSE_PRINTK=y
# CONFIG_SND_DEBUG is not set

#
# Generic devices
#
CONFIG_SND_DUMMY=m
CONFIG_SND_VIRMIDI=m
CONFIG_SND_MTPAV=m
CONFIG_SND_SERIAL_U16550=m
CONFIG_SND_MPU401=m

#
# ISA devices
#
# CONFIG_SND_AD1848 is not set
# CONFIG_SND_CS4231 is not set
# CONFIG_SND_CS4232 is not set
# CONFIG_SND_CS4236 is not set
# CONFIG_SND_ES1688 is not set
# CONFIG_SND_ES18XX is not set
# CONFIG_SND_GUSCLASSIC is not set
# CONFIG_SND_GUSEXTREME is not set
# CONFIG_SND_GUSMAX is not set
# CONFIG_SND_INTERWAVE is not set
# CONFIG_SND_INTERWAVE_STB is not set
# CONFIG_SND_OPTI92X_AD1848 is not set
# CONFIG_SND_OPTI92X_CS4231 is not set
# CONFIG_SND_OPTI93X is not set
# CONFIG_SND_SB8 is not set
# CONFIG_SND_SB16 is not set
# CONFIG_SND_SBAWE is not set
# CONFIG_SND_WAVEFRONT is not set
# CONFIG_SND_CMI8330 is not set
# CONFIG_SND_OPL3SA2 is not set
# CONFIG_SND_SGALAXY is not set

#
# PCI devices
#
# CONFIG_SND_ALI5451 is not set
# CONFIG_SND_CS46XX is not set
# CONFIG_SND_CS4281 is not set
# CONFIG_SND_EMU10K1 is not set
# CONFIG_SND_KORG1212 is not set
# CONFIG_SND_NM256 is not set
# CONFIG_SND_RME32 is not set
# CONFIG_SND_RME96 is not set
# CONFIG_SND_RME9652 is not set
# CONFIG_SND_HDSP is not set
# CONFIG_SND_TRIDENT is not set
# CONFIG_SND_YMFPCI is not set
# CONFIG_SND_ALS4000 is not set
# CONFIG_SND_CMIPCI is not set
CONFIG_SND_ENS1370=m
CONFIG_SND_ENS1371=m
# CONFIG_SND_ES1938 is not set
# CONFIG_SND_ES1968 is not set
# CONFIG_SND_MAESTRO3 is not set
# CONFIG_SND_FM801 is not set
# CONFIG_SND_ICE1712 is not set
CONFIG_SND_INTEL8X0=m
# CONFIG_SND_SONICVIBES is not set
# CONFIG_SND_VIA82XX is not set

#
# ALSA USB devices
#
# CONFIG_SND_USB_AUDIO is not set

#
# Open Sound System
#
CONFIG_SOUND_PRIME=m
# CONFIG_SOUND_BT878 is not set
# CONFIG_SOUND_CMPCI is not set
CONFIG_SOUND_EMU10K1=m
CONFIG_MIDI_EMU10K1=y
# CONFIG_SOUND_FUSION is not set
# CONFIG_SOUND_CS4281 is not set
CONFIG_SOUND_ES1370=m
CONFIG_SOUND_ES1371=m
# CONFIG_SOUND_ESSSOLO1 is not set
# CONFIG_SOUND_MAESTRO is not set
# CONFIG_SOUND_MAESTRO3 is not set
CONFIG_SOUND_ICH=m
# CONFIG_SOUND_RME96XX is not set
# CONFIG_SOUND_SONICVIBES is not set
# CONFIG_SOUND_TRIDENT is not set
# CONFIG_SOUND_MSNDCLAS is not set
# CONFIG_SOUND_MSNDPIN is not set
# CONFIG_SOUND_VIA82CXXX is not set
CONFIG_SOUND_OSS=m
CONFIG_SOUND_TRACEINIT=y
CONFIG_SOUND_DMAP=y
# CONFIG_SOUND_AD1816 is not set
# CONFIG_SOUND_SGALAXY is not set
# CONFIG_SOUND_ADLIB is not set
# CONFIG_SOUND_ACI_MIXER is not set
# CONFIG_SOUND_CS4232 is not set
# CONFIG_SOUND_SSCAPE is not set
# CONFIG_SOUND_GUS is not set
CONFIG_SOUND_VMIDI=m
# CONFIG_SOUND_TRIX is not set
# CONFIG_SOUND_MSS is not set
CONFIG_SOUND_MPU401=m
# CONFIG_SOUND_NM256 is not set
# CONFIG_SOUND_MAD16 is not set
# CONFIG_SOUND_PAS is not set
# CONFIG_SOUND_PSS is not set
CONFIG_SOUND_SB=m
CONFIG_SOUND_AWE32_SYNTH=m
# CONFIG_SOUND_WAVEFRONT is not set
# CONFIG_SOUND_MAUI is not set
CONFIG_SOUND_YM3812=m
CONFIG_SOUND_OPL3SA1=m
CONFIG_SOUND_OPL3SA2=m
# CONFIG_SOUND_YMFPCI is not set
# CONFIG_SOUND_UART6850 is not set
# CONFIG_SOUND_AEDSP16 is not set

#
# USB support
#
CONFIG_USB=m
CONFIG_USB_DEBUG=y

#
# Miscellaneous USB options
#
CONFIG_USB_DEVICEFS=y
CONFIG_USB_BANDWIDTH=y
# CONFIG_USB_DYNAMIC_MINORS is not set

#
# USB Host Controller Drivers
#
CONFIG_USB_EHCI_HCD=m
CONFIG_USB_OHCI_HCD=m
CONFIG_USB_UHCI_HCD=m

#
# USB Device Class drivers
#
# CONFIG_USB_AUDIO is not set
# CONFIG_USB_BLUETOOTH_TTY is not set
# CONFIG_USB_MIDI is not set
# CONFIG_USB_ACM is not set
# CONFIG_USB_PRINTER is not set
CONFIG_USB_STORAGE=m
# CONFIG_USB_STORAGE_DEBUG is not set
# CONFIG_USB_STORAGE_DATAFAB is not set
# CONFIG_USB_STORAGE_FREECOM is not set
# CONFIG_USB_STORAGE_ISD200 is not set
# CONFIG_USB_STORAGE_DPCM is not set
# CONFIG_USB_STORAGE_HP8200e is not set
# CONFIG_USB_STORAGE_SDDR09 is not set
# CONFIG_USB_STORAGE_SDDR55 is not set
# CONFIG_USB_STORAGE_JUMPSHOT is not set

#
# USB Human Interface Devices (HID)
#
# CONFIG_USB_HID is not set

#
# USB HID Boot Protocol drivers
#
# CONFIG_USB_KBD is not set
# CONFIG_USB_MOUSE is not set
# CONFIG_USB_AIPTEK is not set
# CONFIG_USB_WACOM is not set
# CONFIG_USB_KBTAB is not set
# CONFIG_USB_POWERMATE is not set
# CONFIG_USB_XPAD is not set

#
# USB Imaging devices
#
# CONFIG_USB_MDC800 is not set
# CONFIG_USB_SCANNER is not set
# CONFIG_USB_MICROTEK is not set
# CONFIG_USB_HPUSBSCSI is not set

#
# USB Multimedia devices
#
# CONFIG_USB_DABUSB is not set

#
# Video4Linux support is needed for USB Multimedia device support
#

#
# USB Network adaptors
#
# CONFIG_USB_CATC is not set
# CONFIG_USB_CDCETHER is not set
# CONFIG_USB_KAWETH is not set
# CONFIG_USB_PEGASUS is not set
# CONFIG_USB_RTL8150 is not set
# CONFIG_USB_USBNET is not set

#
# USB port drivers
#
# CONFIG_USB_USS720 is not set

#
# USB Serial Converter support
#
# CONFIG_USB_SERIAL is not set

#
# USB Miscellaneous drivers
#
# CONFIG_USB_TIGL is not set
# CONFIG_USB_AUERSWALD is not set
# CONFIG_USB_RIO500 is not set
# CONFIG_USB_BRLVGER is not set
# CONFIG_USB_LCD is not set
# CONFIG_USB_TEST is not set

#
# Bluetooth support
#
# CONFIG_BT is not set

#
# Profiling support
#
# CONFIG_PROFILING is not set

#
# Kernel hacking
#
CONFIG_DEBUG_KERNEL=y
CONFIG_DEBUG_STACKOVERFLOW=y
CONFIG_DEBUG_SLAB=y
# CONFIG_X86_REMOTE_DEBUG is not set
CONFIG_DEBUG_IOVIRT=y
CONFIG_MAGIC_SYSRQ=y
CONFIG_DEBUG_SPINLOCK=y
CONFIG_SPINLINE=y
CONFIG_KALLSYMS=y
CONFIG_DEBUG_SPINLOCK_SLEEP=y
CONFIG_FRAME_POINTER=y
CONFIG_X86_EXTRA_IRQS=y
CONFIG_X86_FIND_SMP_CONFIG=y
CONFIG_X86_MPPARSE=y

#
# Security options
#
# CONFIG_SECURITY is not set

#
# Cryptographic options
#
CONFIG_CRYPTO=y
CONFIG_CRYPTO_HMAC=y
CONFIG_CRYPTO_NULL=m
CONFIG_CRYPTO_MD4=m
CONFIG_CRYPTO_MD5=m
CONFIG_CRYPTO_SHA1=m
CONFIG_CRYPTO_SHA256=m
CONFIG_CRYPTO_SHA512=m
CONFIG_CRYPTO_DES=m
CONFIG_CRYPTO_BLOWFISH=m
CONFIG_CRYPTO_TWOFISH=m
CONFIG_CRYPTO_SERPENT=m
CONFIG_CRYPTO_AES=m
CONFIG_CRYPTO_TEST=m

#
# Library routines
#
CONFIG_CRC32=y
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=m
CONFIG_X86_BIOS_REBOOT=y

--------------080705040606050800070003--

