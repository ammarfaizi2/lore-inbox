Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262703AbTE2UEO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 May 2003 16:04:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262706AbTE2UEN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 May 2003 16:04:13 -0400
Received: from kknd.mweb.co.za ([196.2.45.79]:54213 "EHLO kknd.mweb.co.za")
	by vger.kernel.org with ESMTP id S262703AbTE2UD6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 May 2003 16:03:58 -0400
Date: Thu, 29 May 2003 22:16:22 +0200
From: Bongani Hlope <bonganilinux@mweb.co.za>
To: akpm@digeo.com
Cc: linux-kernel@vger.kernel.org
Subject: 2.5.70-mm1 Strangeness
Message-Id: <20030529221622.542a6df5.bonganilinux@mweb.co.za>
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i586-mandrake-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1"; boundary="=.1bR8I+KRNXk0qa"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=.1bR8I+KRNXk0qa
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Andrew

I'm experiencing a strange behaviour with 2.5.70-mm1 on my work PC, 
Pentium IV 1.6GHZ with 512MB memory. Let me know if you need any more input.

After login in to KDE /proc/meminfo

MemTotal:       514864 kB
MemFree:         16308 kB
Buffers:         10780 kB
Cached:          86268 kB
SwapCached:          0 kB
Active:         122096 kB
Inactive:        31680 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:       514864 kB
LowFree:         16308 kB
SwapTotal:      409208 kB
SwapFree:       409208 kB
Dirty:            4604 kB
Writeback:           0 kB
Mapped:          93668 kB
Slab:           340540 kB
Committed_AS:    83492 kB
PageTables:       1148 kB
VmallocTotal:   516024 kB
VmallocUsed:     33644 kB
VmallocChunk:   482272 kB

Too much memory has gone to Slab. cat /proc/slabinfo follows bellow.

After a while the kernel hangs, and after rebooting my /var/log/messages 
has this as the last output:

May 29 15:10:06 bongani1 last message repeated 689 times
May 29 15:10:06 bongani1 kernel: e:0x20
May 29 15:10:06 bongani1 kernel: lisa: page allocation failure. order:0, mode:0x20

I was running a couple of applications Mozilla-mail, KDE, Some Java Application Server ...
When I load the a application, some memory is freed from the Slabs. The PC was just 
sitting there both times running those applications and both times I returned and found it
 hanging.

cat /proc/slabinfo looks like this

slabinfo - version: 2.0 (statistics)
# name            active_objs num_objs objsize objperslab pagesperslab
#! tunables       batchcount limit sharedfactor
#! slabdata       active_slabs num_slabs sharedavail
#! globalstat     listallocs maxobjs grown reaped error maxfreeable freelimit
#! cpustat N      allochit allocmiss freehit freemiss
unix_sock            125    128   4096    1    1
! tunables            24   12    0
! slabdata           125    128      0
! globalstat         193    133   165   37    0    0   25
! cpustat   0       2699    186   2760      0
ip_mrt_cache           0      0     88   43    1
! tunables            32   16    0
! slabdata             0      0      0
! globalstat           0      0     0    0    0    0   75
tcp_tw_bucket          2     29    132   29    1
! tunables            32   16    0
! slabdata             1      1      0
! globalstat          48     18     2    1    0    0   61
! cpustat   0          3      3      4      0
tcp_bind_bucket       11    123     28  123    1
! tunables            32   16    0
! slabdata             1      1      0
! globalstat          80     27     1    0    0    0  155
! cpustat   0         10      5      4      0
tcp_open_request       0      0     96   40    1
! tunables            32   16    0
! slabdata             0      0      0
! globalstat          48     16     3    3    0    0   72
! cpustat   0          3      3      6      0
inet_peer_cache        6     71     52   71    1
! tunables            32   16    0
! slabdata             1      1      0
! globalstat          80     21     1    0    0    0  103
! cpustat   0          1      5      0      0
secpath4_cache         0      0    136   28    1
! tunables            32   16    0
! slabdata             0      0      0
! globalstat           0      0     0    0    0    0   60
xfrm_dst_cache         0      0   4096    1    1
! tunables            24   12    0
! slabdata             0      0      0
! globalstat           0      0     0    0    0    0   25
ip_fib_hash           10    123     28  123    1
! tunables            32   16    0
! slabdata             1      1      0
! globalstat          32     25     1    0    0    0  155
! cpustat   0         17      2      9      0
ip_dst_cache       19470  19470   4096    1    1
! tunables            24   12    0
! slabdata         19470  19470      0
! globalstat       69869  32578 69655  220    0   25   25
! cpustat   0        288  69681  46319   4181
arp_cache            211    459    140   27    1
! tunables            32   16    0
! slabdata            17     17      0
! globalstat         544    513    19    0    0    0   59
! cpustat   0        475     41    295     10
raw4_sock              0      0   4096    1    1
! tunables            24   12    0
! slabdata             0      0      0
! globalstat           0      0     0    0    0    0   25
udp_sock              10     10   4096    1    1
! tunables            24   12    0
! slabdata            10     10      0
! globalstat          15     12    13    3    0    0   25
! cpustat   0         18     15     23      0
tcp_sock              15     15   4096    1    1
! tunables            24   12    0
! slabdata            15     15      0
! globalstat          50     18    41   26    0    0   25
! cpustat   0       1899     50   1934      0
flow_cache             0      0    104   36    1
! tunables            32   16    0
! slabdata             0      0      0
! globalstat           0      0     0    0    0    0   68
uhci_urb_priv          0      0     72   53    1
! tunables            32   16    0
! slabdata             0      0      0
! globalstat           0      0     0    0    0    0   85
udf_inode_cache        0      0   4096    1    1
! tunables            24   12    0
! slabdata             0      0      0
! globalstat           0      0     0    0    0    0   25
smb_request            0      0   4096    1    1
! tunables            24   12    0
! slabdata             0      0      0
! globalstat           0      0     0    0    0    0   25
smb_inode_cache        0      0   4096    1    1
! tunables            24   12    0
! slabdata             0      0      0
! globalstat           0      0     0    0    0    0   25
devfsd_event           0      0     32  112    1
! tunables            32   16    0
! slabdata             0      0      0
! globalstat         270    128     4    3    0    0  144
! cpustat   0        608     17    615     10
isofs_inode_cache      0      0   4096    1    1
! tunables            24   12    0
! slabdata             0      0      0
! globalstat           0      0     0    0    0    0   25
fat_inode_cache        0      0   4096    1    1
! tunables            24   12    0
! slabdata             0      0      0
! globalstat           0      0     0    0    0    0   25
ext2_inode_cache       0      0   4096    1    1
! tunables            24   12    0
! slabdata             0      0      0
! globalstat           7      7     7    7    0    0   25
! cpustat   0          0      7      7      0
ext2_xattr             0      0     56   66    1
! tunables            32   16    0
! slabdata             0      0      0
! globalstat           0      0     0    0    0    0   98
journal_handle         9     90     40   90    1
! tunables            32   16    0
! slabdata             1      1      0
! globalstat         144     16     5    4    0    0  122
! cpustat   0      33806      9  33815      0
journal_head        1240   1647     60   61    1
! tunables            32   16    0
! slabdata            27     27      0
! globalstat       10764   1756    31    0    0    1   93
! cpustat   0      11463    679  10348    578
revoke_table           2    144     24  144    1
! tunables            32   16    0
! slabdata             1      1      0
! globalstat          16     16     1    0    0    0  176
! cpustat   0          1      1      0      0
revoke_record          0      0     28  123    1
! tunables            32   16    0
! slabdata             0      0      0
! globalstat         224     89     5    5    0    0  155
! cpustat   0        177     14    184      7
ext3_inode_cache   26178  26179   4096    1    1
! tunables            24   12    0
! slabdata         26178  26179      0
! globalstat       29765  27105 29416   21    0   25   25
! cpustat   0       1218  29457   4199    298
ext3_xattr             0      0     56   66    1
! tunables            32   16    0
! slabdata             0      0      0
! globalstat           0      0     0    0    0    0   98
dquot                  0      0    116   33    1
! tunables            32   16    0
! slabdata             0      0      0
! globalstat           0      0     0    0    0    0   65
eventpoll_pwq          0      0     48   77    1
! tunables            32   16    0
! slabdata             0      0      0
! globalstat           0      0     0    0    0    0  109
eventpoll_epi          0      0     84   45    1
! tunables            32   16    0
! slabdata             0      0      0
! globalstat           0      0     0    0    0    0   77
async_poll             0      0     44   84    1
! tunables            32   16    0
! slabdata             0      0      0
! globalstat           0      0     0    0    0    0  116
kioctx                 0      0   4096    1    1
! tunables            24   12    0
! slabdata             0      0      0
! globalstat           0      0     0    0    0    0   25
kiocb                  0      0   4096    1    1
! tunables            24   12    0
! slabdata             0      0      0
! globalstat           0      0     0    0    0    0   25
dnotify_cache         44    224     32  112    1
! tunables            32   16    0
! slabdata             2      2      0
! globalstat         352    218     2    0    0    0  144
! cpustat   0        330     22    298     16
file_lock_cache       12     36    104   36    1
! tunables            32   16    0
! slabdata             1      1      0
! globalstat         208     31     1    0    0    0   68
! cpustat   0       2066     13   2067      0
fasync_cache           1    123     28  123    1
! tunables            32   16    0
! slabdata             1      1      0
! globalstat          64     16     4    3    0    0  155
! cpustat   0          0      4      3      0
shmem_inode_cache      2      2   4096    1    1
! tunables            24   12    0
! slabdata             2      2      0
! globalstat          10      4     8    6    0    0   25
! cpustat   0         12      9     19      0
idr_layer_cache        0      0   4096    1    1
! tunables            24   12    0
! slabdata             0      0      0
! globalstat           0      0     0    0    0    0   25
posix_timers_cache      0      0     88   43    1
! tunables            32   16    0
! slabdata             0      0      0
! globalstat           0      0     0    0    0    0   75
uid_cache              5     99     36   99    1
! tunables            32   16    0
! slabdata             1      1      0
! globalstat          32     20     1    0    0    0  131
! cpustat   0          3      2      0      0
cfq_pool              64     84     44   84    1
! tunables            32   16    0
! slabdata             1      1      0
! globalstat          64     64     1    0    0    0  116
! cpustat   0         60      4      0      0
crq_pool               0      0     48   77    1
! tunables            32   16    0
! slabdata             0      0      0
! globalstat           0      0     0    0    0    0  109
as_arq                39     53     72   53    1
! tunables            32   16    0
! slabdata             1      1      0
! globalstat         984    159     6    3    0    1   85
! cpustat   0      17326     65  17327     44
deadline_drq           0      0     60   61    1
! tunables            32   16    0
! slabdata             0      0      0
! globalstat           0      0     0    0    0    0   93
blkdev_requests       26     26   4096    1    1
! tunables            24   12    0
! slabdata            26     26      0
! globalstat         881    157   547  131    0   25   25
! cpustat   0      16804    587  17307     64
biovec-BIO_MAX_PAGES    256    256   4096    1    1
! tunables            24   12    0
! slabdata           256    256      0
! globalstat         438    306   370   91    0   25   25
! cpustat   0        116    380    236      4
biovec-128           256    256   4096    1    1
! tunables            24   12    0
! slabdata           256    256      0
! globalstat         365    276   325   69    0    0   25
! cpustat   0        200    333    277      0
biovec-64            256    256   4096    1    1
! tunables            24   12    0
! slabdata           256    256      0
! globalstat         397    285   365  109    0   12   25
! cpustat   0        437    371    549      3
biovec-16            258    260   4096    1    1
! tunables            24   12    0
! slabdata           258    260      0
! globalstat         336    267   311   51    0    0   25
! cpustat   0       1118    317   1179      0
biovec-4             256    305     60   61    1
! tunables            32   16    0
! slabdata             5      5      0
! globalstat         420    275     5    0    0    0   93
! cpustat   0       1339     27   1110      0
biovec-1             274    432     24  144    1
! tunables            32   16    0
! slabdata             3      3      0
! globalstat        9310    864    31    3    0    1  176
! cpustat   0      23648    585  23431    546
bio                  274    392     68   56    1
! tunables            32   16    0
! slabdata             7      7      0
! globalstat        9998    856   105    4    0    1   88
! cpustat   0      29127    672  28954    589
sock_inode_cache     160    160   4096    1    1
! tunables            24   12    0
! slabdata           160    160      0
! globalstat         168    160   165    5    0    0   25
! cpustat   0       3803    168   3817      0
skbuff_head_cache    626    651   4096    1    1
! tunables            24   12    0
! slabdata           626    651      0
! globalstat        8141    874  5173   97    0   25   25
! cpustat   0     223010   5476 227246    626
sock                   3      3   4096    1    1
! tunables            24   12    0
! slabdata             3      3      0
! globalstat           4      4     4    1    0    0   25
! cpustat   0         10      4     11      0
proc_inode_cache     230    230   4096    1    1
! tunables            24   12    0
! slabdata           230    230      0
! globalstat         370    230   369   61    0   25   25
! cpustat   0      10687    370  10821      9
sigqueue              17     42   4096    1    1
! tunables            24   12    0
! slabdata            17     42      0
! globalstat         213    209   213    4    0   25   25
! cpustat   0      11150    213  11347     16
radix_tree_node     2271   2271   4096    1    1
! tunables            24   12    0
! slabdata          2271   2271      0
! globalstat        2757   2271  2510   20    0   25   25
! cpustat   0        626   2537    854     38
bdev_cache             6     40     96   40    1
! tunables            32   16    0
! slabdata             1      1      0
! globalstat         224    192     5    0    0    0   72
! cpustat   0        198     16    198     10
mnt_cache             18     53     72   53    1
! tunables            32   16    0
! slabdata             1      1      0
! globalstat          32     29     1    0    0    0   85
! cpustat   0         24      2      8      0
inode_cache         2953   2953   4096    1    1
! tunables            24   12    0
! slabdata          2953   2953      0
! globalstat        4237   4137  4197   34    0   25   25
! cpustat   0       1158   4203   2303    105
dentry_cache       25891  25891   4096    1    1
! tunables            24   12    0
! slabdata         25891  25891      0
! globalstat       95071  33059 82069   10    0   26   25
! cpustat   0      38623  83540  90513   5765
filp                1341   1392    132   29    1
! tunables            32   16    0
! slabdata            48     48      0
! globalstat        3821   1437    53    1    0    1   61
! cpustat   0      50750    249  49504    155
names_cache            8      8   4096    1    1
! tunables            24   12    0
! slabdata             8      8      0
! globalstat           9      8     8    0    0    0   25
! cpustat   0     293086      9 293095      0
buffer_head         6327   6588     60   61    1
! tunables            32   16    0
! slabdata           108    108      0
! globalstat       14121   6620   111    1    0    1   93
! cpustat   0      13983    904   8112    467
mm_struct             59     59   4096    1    1
! tunables            24   12    0
! slabdata            59     59      0
! globalstat          95     64    84   25    0    0   25
! cpustat   0       3451     90   3483      0
vm_area_struct      3454   3600     76   50    1
! tunables            32   16    0
! slabdata            72     72      0
! globalstat       35887   3716    92    0    0    1   82
! cpustat   0     108028   2312 104871   2027
fs_cache              72     84     44   84    1
! tunables            32   16    0
! slabdata             1      1      0
! globalstat         224     72     1    0    0    0  116
! cpustat   0       1985     14   1942      0
files_cache           57     57   4096    1    1
! tunables            24   12    0
! slabdata            57     57      0
! globalstat          80     62    75   18    0    0   25
! cpustat   0       1920     79   1942      0
signal_cache          84    132     56   66    1
! tunables            32   16    0
! slabdata             2      2      0
! globalstat         239     84     2    0    0    0   98
! cpustat   0       2004     16   1951      0
sighand_cache         63     63   4096    1    1
! tunables            24   12    0
! slabdata            63     63      0
! globalstat          89     69    81   18    0    0   25
! cpustat   0       1919     85   1941      0
task_struct           71     71   4084    1    1
! tunables            24   12    0
! slabdata            71     71      0
! globalstat          98     77    88   17    0    0   25
! cpustat   0       1927     93   1949      0
pte_chain          14194  14280    128   30    1
! tunables            32   16    0
! slabdata           476    476      0
! globalstat       45675  14446   815    2    0    2   62
! cpustat   0      51527   2975  38358   1957
pgd                   59     59   4096    1    1
! tunables            24   12    0
! slabdata            59     59      0
! globalstat         100     64    83   24    0    0   25
! cpustat   0       3452     89   3483      0
size-131072(DMA)       0      0 131072    1   32
! tunables             8    4    0
! slabdata             0      0      0
! globalstat           0      0     0    0    0    0    9
size-131072            0      0 131072    1   32
! tunables             8    4    0
! slabdata             0      0      0
! globalstat           0      0     0    0    0    0    9
size-65536(DMA)        0      0  65536    1   16
! tunables             8    4    0
! slabdata             0      0      0
! globalstat           0      0     0    0    0    0    9
size-65536             1      1  65536    1   16
! tunables             8    4    0
! slabdata             1      1      0
! globalstat           1      1     1    0    0    0    9
! cpustat   0          0      1      0      0
size-32768(DMA)        0      0  32768    1    8
! tunables             8    4    0
! slabdata             0      0      0
! globalstat           0      0     0    0    0    0    9
size-32768             1      1  32768    1    8
! tunables             8    4    0
! slabdata             1      1      0
! globalstat           2      2     2    1    0    0    9
! cpustat   0          1      2      2      0
size-16384(DMA)        0      0  16384    1    4
! tunables             8    4    0
! slabdata             0      0      0
! globalstat           0      0     0    0    0    0    9
size-16384             0      0  16384    1    4
! tunables             8    4    0
! slabdata             0      0      0
! globalstat          19      6    17   17    0    0    9
! cpustat   0        725     19    744      0
size-8192(DMA)         0      0   8192    1    2
! tunables             8    4    0
! slabdata             0      0      0
! globalstat           0      0     0    0    0    0    9
size-8192             11     13   8192    1    2
! tunables             8    4    0
! slabdata            11     13      0
! globalstat          36     13    29   16    0    0    9
! cpustat   0        268     35    292      0
size-4096(DMA)         0      0   4096    1    1
! tunables            24   12    0
! slabdata             0      0      0
! globalstat           0      0     0    0    0    0   25
size-4096             60     60   4096    1    1
! tunables            24   12    0
! slabdata            60     60      0
! globalstat         297    132   248   94    0   25   25
! cpustat   0       6288    255   6474     17
size-2048(DMA)         0      0   4096    1    1
! tunables            24   12    0
! slabdata             0      0      0
! globalstat           0      0     0    0    0    0   25
size-2048             81     81   4096    1    1
! tunables            24   12    0
! slabdata            81     81      0
! globalstat         103     82    96   15    0    0   25
! cpustat   0       1112    103   1138      0
size-1024(DMA)         0      0   4096    1    1
! tunables            24   12    0
! slabdata             0      0      0
! globalstat           0      0     0    0    0    0   25
size-1024             76     76   4096    1    1
! tunables            24   12    0
! slabdata            76     76      0
! globalstat          93     88    88   12    0   12   25
! cpustat   0      11184     91  11217      1
size-512(DMA)          0      0   4096    1    1
! tunables            24   12    0
! slabdata             0      0      0
! globalstat           0      0     0    0    0    0   25
size-512             641    654   4096    1    1
! tunables            24   12    0
! slabdata           641    654      0
! globalstat        7999    846  5007   92    0   25   25
! cpustat   0     136047   5307 140123    613
size-256(DMA)          0      0   4096    1    1
! tunables            24   12    0
! slabdata             0      0      0
! globalstat           0      0     0    0    0    0   25
size-256             252    252   4096    1    1
! tunables            24   12    0
! slabdata           252    252      0
! globalstat         255    252   254    2    0    0   25
! cpustat   0      40315    255  40320      0
size-128(DMA)          0      0    140   27    1
! tunables            32   16    0
! slabdata             0      0      0
! globalstat           0      0     0    0    0    0   59
size-128           82705  94716    140   27    1
! tunables            32   16    0
! slabdata          3508   3508      0
! globalstat      195853  94797  3511    0    0    0   59
! cpustat   0     193572  13350 117172   7061
size-64(DMA)           0      0     76   50    1
! tunables            32   16    0
! slabdata             0      0      0
! globalstat           0      0     0    0    0    0   82
size-64              248    250     76   50    1
! tunables            32   16    0
! slabdata             5      5      0
! globalstat         279    248     5    0    0    0   82
! cpustat   0       4089     30   3893      0
size-32(DMA)           0      0     44   84    1
! tunables            32   16    0
! slabdata             0      0      0
! globalstat           0      0     0    0    0    0  116
size-32             1324   1344     44   84    1
! tunables            32   16    0
! slabdata            16     16      0
! globalstat        1516   1324    16    0    0    0  116
! cpustat   0      53594    131  52405     12
kmem_cache           112    120    160   24    1
! tunables            32   16    0
! slabdata             5      5      0
! globalstat         112    112     5    0    0    0   56
! cpustat   0         70     33      0      0


--=.1bR8I+KRNXk0qa
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE+1mqf+pvEqv8+FEMRAg+uAJ0VQ6+eLz9K+rtdDfyw/+oHaDV9RACdGCau
VDvEIFF2npqH3ojqOMESi4I=
=QQc9
-----END PGP SIGNATURE-----

--=.1bR8I+KRNXk0qa--
