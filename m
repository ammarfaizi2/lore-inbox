Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750798AbWCIGPs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750798AbWCIGPs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 01:15:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750806AbWCIGPs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 01:15:48 -0500
Received: from pilet.ens-lyon.fr ([140.77.167.16]:65481 "EHLO
	pilet.ens-lyon.fr") by vger.kernel.org with ESMTP id S1750798AbWCIGPr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 01:15:47 -0500
Date: Thu, 9 Mar 2006 07:15:35 +0100
From: Benoit Boissinot <benoit.boissinot@ens-lyon.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.16-rc5-mm3
Message-ID: <20060309061535.GC19403@ens-lyon.fr>
References: <20060307021929.754329c9.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060307021929.754329c9.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 07, 2006 at 02:19:29AM -0800, Andrew Morton wrote:
> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.16-rc5/2.6.16-rc5-mm3/
> 
> - A relatively small number of changes, although we're up to 9MB of diff
>   in the various git trees.
> 

I just encountered a memleak, this is a laptop and i use swsusp (I am not
sure if it is related but since the memleak involves task_struct).

Let me know if you need any other informations, i'll see if it is
reproducable in the next days.

regards.

Benoit

procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
 0  0      0  35176  25148  69532    6    4    42    72   44   332 12  2 83  3

             total       used       free     shared    buffers     cached
Mem:        515256     479648      35608          0      24860      69504
-/+ buffers/cache:     385284     129972
Swap:       979956          0     979956

slabinfo - version: 2.1
# name            <active_objs> <num_objs> <objsize> <objperslab> <pagesperslab> : tunables <limit> <batchcount> <sharedfactor> : slabdata <active_slabs> <num_slabs> <sharedavail> : shrinker stat <nr requested> <nr freed>
ip_conntrack_expect      0      0     92   42    1 : tunables  120   60    0 : slabdata      0      0      0
ip_conntrack          19     38    208   19    1 : tunables  120   60    0 : slabdata      2      2      0
ip_fib_alias          10    113     32  113    1 : tunables  120   60    0 : slabdata      1      1      0
ip_fib_hash           10    113     32  113    1 : tunables  120   60    0 : slabdata      1      1      0
uhci_urb_priv          0      0     28  127    1 : tunables  120   60    0 : slabdata      0      0      0
UNIX                  40     40    384   10    1 : tunables   54   27    0 : slabdata      4      4      0
tcp_bind_bucket        6    203     16  203    1 : tunables  120   60    0 : slabdata      1      1      0
inet_peer_cache        0      0     64   59    1 : tunables  120   60    0 : slabdata      0      0      0
secpath_cache          0      0    128   30    1 : tunables  120   60    0 : slabdata      0      0      0
xfrm_dst_cache         0      0    288   13    1 : tunables   54   27    0 : slabdata      0      0      0
ip_dst_cache          65     75    256   15    1 : tunables  120   60    0 : slabdata      5      5      0
arp_cache              2     30    128   30    1 : tunables  120   60    0 : slabdata      1      1      0
RAW                    2      9    448    9    1 : tunables   54   27    0 : slabdata      1      1      0
UDP                    1      9    448    9    1 : tunables   54   27    0 : slabdata      1      1      0
tw_sock_TCP            0      0     96   40    1 : tunables  120   60    0 : slabdata      0      0      0
request_sock_TCP       0      0     64   59    1 : tunables  120   60    0 : slabdata      0      0      0
TCP                    6     21   1056    7    2 : tunables   24   12    0 : slabdata      3      3      0
flow_cache             0      0     96   40    1 : tunables  120   60    0 : slabdata      0      0      0
cfq_ioc_pool          35    100     76   50    1 : tunables  120   60    0 : slabdata      2      2      0
cfq_pool              36     78    100   39    1 : tunables  120   60    0 : slabdata      2      2      0
crq_pool              59    168     44   84    1 : tunables  120   60    0 : slabdata      2      2      0
deadline_drq           0      0     48   78    1 : tunables  120   60    0 : slabdata      0      0      0
as_arq                 0      0     60   63    1 : tunables  120   60    0 : slabdata      0      0      0
mqueue_inode_cache      1      7    544    7    1 : tunables   54   27    0 : slabdata      1      1      0
isofs_inode_cache      0      0    384   10    1 : tunables   54   27    0 : slabdata      0      0      0
ext2_inode_cache       0      0    484    8    1 : tunables   54   27    0 : slabdata      0      0      0
ext2_xattr             0      0     44   84    1 : tunables  120   60    0 : slabdata      0      0      0 : shrinker stat       0       0
journal_handle         0      0     20  169    1 : tunables  120   60    0 : slabdata      0      0      0
journal_head           0      0     52   72    1 : tunables  120   60    0 : slabdata      0      0      0
revoke_table           2    254     12  254    1 : tunables  120   60    0 : slabdata      1      1      0
revoke_record          0      0     16  203    1 : tunables  120   60    0 : slabdata      0      0      0
ext3_inode_cache       2      7    524    7    1 : tunables   54   27    0 : slabdata      1      1      0
ext3_xattr             0      0     44   84    1 : tunables  120   60    0 : slabdata      0      0      0 : shrinker stat       0       0
reiser_inode_cache   4509   4536    432    9    1 : tunables   54   27    0 : slabdata    504    504      0
dnotify_cache          0      0     20  169    1 : tunables  120   60    0 : slabdata      0      0      0
eventpoll_pwq          0      0     36  101    1 : tunables  120   60    0 : slabdata      0      0      0
eventpoll_epi          0      0     96   40    1 : tunables  120   60    0 : slabdata      0      0      0
inotify_event_cache      0      0     28  127    1 : tunables  120   60    0 : slabdata      0      0      0
inotify_watch_cache      1    101     36  101    1 : tunables  120   60    0 : slabdata      1      1      0
kioctx                 0      0    160   24    1 : tunables  120   60    0 : slabdata      0      0      0
kiocb                  0      0    128   30    1 : tunables  120   60    0 : slabdata      0      0      0
fasync_cache           1    203     16  203    1 : tunables  120   60    0 : slabdata      1      1      0
shmem_inode_cache    814    819    448    9    1 : tunables   54   27    0 : slabdata     91     91      0
swapped_entry          0      0     12  254    1 : tunables  120   60    0 : slabdata      0      0      0
posix_timers_cache      0      0     96   40    1 : tunables  120   60    0 : slabdata      0      0      0
uid_cache              2     59     64   59    1 : tunables  120   60    0 : slabdata      1      1      0
sgpool-128            32     32   2048    2    1 : tunables   24   12    0 : slabdata     16     16      0
sgpool-64             32     32   1024    4    1 : tunables   54   27    0 : slabdata      8      8      0
sgpool-32             32     32    512    8    1 : tunables   54   27    0 : slabdata      4      4      0
sgpool-16             32     45    256   15    1 : tunables  120   60    0 : slabdata      3      3      0
sgpool-8              32     60    128   30    1 : tunables  120   60    0 : slabdata      2      2      0
scsi_io_context        0      0    104   37    1 : tunables  120   60    0 : slabdata      0      0      0
blkdev_ioc            35    127     28  127    1 : tunables  120   60    0 : slabdata      1      1      0
blkdev_queue          27     28    904    4    1 : tunables   54   27    0 : slabdata      7      7      0
blkdev_requests       46     46    168   23    1 : tunables  120   60    0 : slabdata      2      2      0
biovec-(256)           7      8   3072    2    2 : tunables   24   12    0 : slabdata      4      4      0
biovec-128             7     10   1536    5    2 : tunables   24   12    0 : slabdata      2      2      0
biovec-64              7     10    768    5    1 : tunables   54   27    0 : slabdata      2      2      0
biovec-16              7     20    192   20    1 : tunables  120   60    0 : slabdata      1      1      0
biovec-4               7     59     64   59    1 : tunables  120   60    0 : slabdata      1      1      0
biovec-1              54    203     16  203    1 : tunables  120   60    0 : slabdata      1      1      0
bio                  303    354     64   59    1 : tunables  120   60    0 : slabdata      6      6      0
sock_inode_cache      90     90    416    9    1 : tunables   54   27    0 : slabdata     10     10      0
skbuff_fclone_cache      0      0    352   11    1 : tunables   54   27    0 : slabdata      0      0      0
skbuff_head_cache    128    240    192   20    1 : tunables  120   60    0 : slabdata     12     12      0
file_lock_cache       18     42     92   42    1 : tunables  120   60    0 : slabdata      1      1      0
acpi_operand         741    828     40   92    1 : tunables  120   60    0 : slabdata      9      9      0
acpi_parse_ext         0      0     44   84    1 : tunables  120   60    0 : slabdata      0      0      0
acpi_parse             0      0     28  127    1 : tunables  120   60    0 : slabdata      0      0      0
acpi_state             0      0     48   78    1 : tunables  120   60    0 : slabdata      0      0      0
proc_inode_cache     245    300    372   10    1 : tunables   54   27    0 : slabdata     30     30      0
sigqueue               4     27    144   27    1 : tunables  120   60    0 : slabdata      1      1      0
radix_tree_node     3012   3276    276   14    1 : tunables   54   27    0 : slabdata    234    234      0
bdev_cache             7     14    512    7    1 : tunables   54   27    0 : slabdata      2      2      0
sysfs_dir_cache     4727   4784     40   92    1 : tunables  120   60    0 : slabdata     52     52      0
mnt_cache             22     30    128   30    1 : tunables  120   60    0 : slabdata      1      1      0
inode_cache         1239   1287    356   11    1 : tunables   54   27    0 : slabdata    117    117      0 : shrinker stat 2043264 2047000
dentry_cache       10770  10770    128   30    1 : tunables  120   60    0 : slabdata    359    359      0 : shrinker stat 4719104 2255900
filp                 740    900    192   20    1 : tunables  120   60    0 : slabdata     45     45      0
names_cache            5      5   4096    1    1 : tunables   24   12    0 : slabdata      5      5      0
idr_layer_cache       92    116    136   29    1 : tunables  120   60    0 : slabdata      4      4      0
buffer_head         6006   6006     48   78    1 : tunables  120   60    0 : slabdata     77     77      0
mm_struct             63     63    448    9    1 : tunables   54   27    0 : slabdata      7      7      0
vm_area_struct      1448   1496     88   44    1 : tunables  120   60    0 : slabdata     34     34      0
fs_cache              83    113     32  113    1 : tunables  120   60    0 : slabdata      1      1      0
files_cache           84    120    192   20    1 : tunables  120   60    0 : slabdata      6      6      0
signal_cache          84     90    384   10    1 : tunables   54   27    0 : slabdata      9      9      0
sighand_cache         57     57   1344    3    1 : tunables   24   12    0 : slabdata     19     19      0
task_struct        60291  60291   1344    3    1 : tunables   24   12    0 : slabdata  20097  20097      0
anon_vma             750   1356      8  339    1 : tunables  120   60    0 : slabdata      4      4      0
pgd                   41     41   4096    1    1 : tunables   24   12    0 : slabdata     41     41      0
size-131072(DMA)       0      0 131072    1   32 : tunables    8    4    0 : slabdata      0      0      0
size-131072            0      0 131072    1   32 : tunables    8    4    0 : slabdata      0      0      0
size-65536(DMA)        0      0  65536    1   16 : tunables    8    4    0 : slabdata      0      0      0
size-65536             4      4  65536    1   16 : tunables    8    4    0 : slabdata      4      4      0
size-32768(DMA)        0      0  32768    1    8 : tunables    8    4    0 : slabdata      0      0      0
size-32768             1      1  32768    1    8 : tunables    8    4    0 : slabdata      1      1      0
size-16384(DMA)        0      0  16384    1    4 : tunables    8    4    0 : slabdata      0      0      0
size-16384            25     25  16384    1    4 : tunables    8    4    0 : slabdata     25     25      0
size-8192(DMA)         0      0   8192    1    2 : tunables    8    4    0 : slabdata      0      0      0
size-8192              6      6   8192    1    2 : tunables    8    4    0 : slabdata      6      6      0
size-4096(DMA)         0      0   4096    1    1 : tunables   24   12    0 : slabdata      0      0      0
size-4096          60463  60476   4096    1    1 : tunables   24   12    0 : slabdata  60463  60476      0
size-2048(DMA)         0      0   2048    2    1 : tunables   24   12    0 : slabdata      0      0      0
size-2048             47     48   2048    2    1 : tunables   24   12    0 : slabdata     24     24      0
size-1024(DMA)         0      0   1024    4    1 : tunables   54   27    0 : slabdata      0      0      0
size-1024            180    180   1024    4    1 : tunables   54   27    0 : slabdata     45     45      0
size-512(DMA)          0      0    512    8    1 : tunables   54   27    0 : slabdata      0      0      0
size-512             262    272    512    8    1 : tunables   54   27    0 : slabdata     34     34      0
size-256(DMA)          0      0    256   15    1 : tunables  120   60    0 : slabdata      0      0      0
size-256              71     75    256   15    1 : tunables  120   60    0 : slabdata      5      5      0
size-192(DMA)          0      0    192   20    1 : tunables  120   60    0 : slabdata      0      0      0
size-192             840    840    192   20    1 : tunables  120   60    0 : slabdata     42     42      0
size-128(DMA)          0      0    128   30    1 : tunables  120   60    0 : slabdata      0      0      0
size-128             932   1080    128   30    1 : tunables  120   60    0 : slabdata     36     36      0
size-64(DMA)           0      0     64   59    1 : tunables  120   60    0 : slabdata      0      0      0
size-32(DMA)           0      0     32  113    1 : tunables  120   60    0 : slabdata      0      0      0
size-64             1389   1711     64   59    1 : tunables  120   60    0 : slabdata     29     29      0
size-32            63413  64636     32  113    1 : tunables  120   60    0 : slabdata    572    572      0
kmem_cache           119    120    128   30    1 : tunables  120   60    0 : slabdata      4      4      0

MemTotal:       515256 kB
MemFree:         39436 kB
Buffers:         21080 kB
Cached:          69492 kB
SwapCached:          0 kB
Active:          80392 kB
Inactive:        48388 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:       515256 kB
LowFree:         39436 kB
SwapTotal:      979956 kB
SwapFree:       979956 kB
Dirty:              16 kB
Writeback:           0 kB
Mapped:          59824 kB
Slab:           333300 kB
CommitLimit:   1237584 kB
Committed_AS:   106788 kB
PageTables:        572 kB
VmallocTotal:   515800 kB
VmallocUsed:     26684 kB
VmallocChunk:   487124 kB


ps aux:

USER       PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
root         1  0.0  0.0   1484   332 ?        Ss   Mar07   0:01 init [3]  
root         2  0.0  0.0      0     0 ?        SN   Mar07   0:00 [ksoftirqd/0]
root         3  0.0  0.0      0     0 ?        S    Mar07   0:00 [watchdog/0]
root         4  0.0  0.0      0     0 ?        S<   Mar07   0:01 [events/0]
root         5  0.0  0.0      0     0 ?        S<   Mar07   0:00 [khelper]
root         6  0.0  0.0      0     0 ?        S<   Mar07   0:00 [kthread]
root         8  0.0  0.0      0     0 ?        S<   Mar07   0:00 [kblockd/0]
root         9  0.0  0.0      0     0 ?        S<   Mar07   0:00 [kacpid]
root       114  0.0  0.0      0     0 ?        S<   Mar07   0:00 [kseriod]
root       152  0.0  0.0      0     0 ?        S    Mar07   0:05 [kswapd0]
root       153  0.0  0.0      0     0 ?        SN   Mar07   0:00 [kprefetchd]
root       154  0.0  0.0      0     0 ?        S<   Mar07   0:00 [aio/0]
root       822  0.0  0.0      0     0 ?        S<   Mar07   0:00 [reiserfs/0]
root      1021  0.0  0.0   1692   348 ?        S<s  Mar07   0:00 /sbin/udevd --daemon
root      2268  0.0  0.0      0     0 ?        S<   Mar07   0:00 [kpsmoused]
root      2274  0.0  0.0      0     0 ?        S<   Mar07   0:13 [ipw2200/0]
root      2431  0.0  0.0      0     0 ?        S<   Mar07   0:00 [khubd]
root      2734  0.0  0.0      0     0 ?        S<   Mar07   0:00 [kjournald]
root      3283  0.0  0.0   1824   464 ?        Ss   Mar07   0:00 /usr/sbin/syslog-ng
root      3356  0.0  0.0   1596   276 ?        Ss   Mar07   0:00 /usr/sbin/acpid -c /etc/acpi/events
root      6696  0.0  0.0   3420   260 ?        Ss   Mar07   0:00 /usr/sbin/sshd
root      6766  0.0  0.0   1720   228 ?        Ss   Mar07   0:00 /usr/sbin/cron
root      6919  0.0  0.2   2280  1108 tty2     Ss   Mar07   0:00 /bin/login --      
root      6920  0.0  0.0   1516    84 tty3     Ss+  Mar07   0:00 /sbin/agetty 38400 tty3 linux
root      6921  0.0  0.0   1516    84 tty4     Ss+  Mar07   0:00 /sbin/agetty 38400 tty4 linux
root      6940  0.0  0.0   1512    80 tty5     Ss+  Mar07   0:00 /sbin/agetty 38400 tty5 linux
root      6943  0.0  0.0   1512    80 tty6     Ss+  Mar07   0:00 /sbin/agetty 38400 tty6 linux
tonfa     7292  0.0  0.0   3036   488 ?        Ss   Mar07   0:00 ssh-agent
root      5142  0.0  0.0   1940   128 ?        Ss   Mar07   0:00 rsync --daemon
root     10474  0.0  0.0      0     0 ?        S    Mar08   0:01 [pdflush]
root     18538  0.0  0.0      0     0 ?        S    03:32   0:00 [pdflush]
root     14408  0.0  0.2   2280  1108 tty1     Ss   06:40   0:00 /bin/login --     
root     14470  0.0  0.4   3256  2208 tty1     S    06:40   0:00 -bash
root     15495  0.0  0.1   3192   852 ?        Ss   06:42   0:00 /sbin/wpa_supplicant -Dwext -c/etc/wpa_supplicant.conf -W -P/var/run/wpa_supplicant-wlan.pid -B -iwlan
root     15506  0.0  0.0   1928   404 ?        Ss   06:42   0:00 /bin/wpa_cli -a/sbin/wpa_cli.action -iwlan -P/var/run/wpa_cli-wlan.pid -B
tonfa    15867  0.0  0.4   3776  2284 tty2     S    06:42   0:00 -bash
root     16137  0.0  0.1   3536   844 ?        Ss   06:42   0:00 /usr/bin/xdm
root     16140  0.4  1.7  13996  9132 tty7     Ss+  06:42   0:02 /usr/bin/X vt7 -nolisten tcp -auth /etc/X11/xdm/authdir/authfiles/A:0-08C0Mi
root     16141  0.0  0.4   4168  2224 ?        S    06:42   0:00 -:0         
tonfa    16150  0.0  0.3   3328  1664 tty2     S+   06:42   0:00 ssh arakou.residence.ens
tonfa    16151  0.0  0.3   3484  1780 tty2     S+   06:42   0:00 ssh -T XXX
tonfa    16167  0.0  0.2   2632  1220 ?        S    06:44   0:00 /bin/bash /home/tonfa/.xsession
tonfa    16249  0.0  0.2   6276  1240 ?        S    06:44   0:00 urxvtd
tonfa    16250  0.0  0.2   2896  1164 ?        S    06:44   0:00 /bin/sh /home/tonfa/bin/wmii
tonfa    16253  0.0  0.2   2796  1312 ?        S    06:44   0:00 wmiiwm -a unix /tmp/ns.tonfa.:0/wmii
tonfa    16276  0.3  0.2   3024  1228 ?        S    06:44   0:01 /bin/sh /home/tonfa/local/etc/wmii-3/status
tonfa    16323  0.0  0.0   2492   500 ?        S    06:44   0:00 wmiir read /event
tonfa    16324  0.0  0.1   3028   580 ?        S    06:44   0:00 /bin/sh /home/tonfa/local/etc/wmii-3/wmiirc
tonfa    19037  0.0  0.2   3148  1352 ?        S    06:45   0:00 /bin/bash /usr/libexec/mozilla-launcher
tonfa    19062  3.1  7.9 103516 41204 ?        Sl   06:45   0:09 /usr/lib/mozilla-firefox/firefox-bin
tonfa    19090  0.0  0.4   3840  2252 ?        S    06:45   0:00 /usr/libexec/gconfd-2 10
tonfa    21210  0.0  0.0   1720   512 ?        S    06:50   0:00 sleep 1
root     21211  0.0  0.1   2228   880 tty1     R+   06:50   0:00 ps aux

-- 
powered by bash/screen/(urxvt/fvwm|linux-console)/gentoo/gnu/linux OS
