Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267924AbUHKEUi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267924AbUHKEUi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 00:20:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267927AbUHKEUh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 00:20:37 -0400
Received: from os.inf.tu-dresden.de ([141.76.48.99]:24744 "EHLO
	os.inf.tu-dresden.de") by vger.kernel.org with ESMTP
	id S267924AbUHKEUS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 00:20:18 -0400
Date: Tue, 10 Aug 2004 21:18:49 -0700
From: "Udo A. Steinberg" <us15@os.inf.tu-dresden.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       viro@parcelfarce.linux.theplanet.co.uk
Subject: Re: Possible dcache BUG
Message-ID: <20040810211849.0d556af4@laptop.delusion.de>
In-Reply-To: <Pine.LNX.4.58.0408102044220.1839@ppc970.osdl.org>
References: <Pine.LNX.4.44.0408020911300.10100-100000@franklin.wrl.org>
	<20040808113930.24ae0273.akpm@osdl.org>
	<200408100012.08945.gene.heskett@verizon.net>
	<200408102342.12792.gene.heskett@verizon.net>
	<Pine.LNX.4.58.0408102044220.1839@ppc970.osdl.org>
X-GPG-Key: 1024D/233B9D29 (wwwkeys.pgp.net)
X-GPG-Fingerprint: CE1F 5FDD 3C01 BE51 2106 292E 9E14 735D 233B 9D29
X-Mailer: X-Mailer 5.0 Gold
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Tue__10_Aug_2004_21_18_49_-0700_uQ55l9a9zXB9wqZ4"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Tue__10_Aug_2004_21_18_49_-0700_uQ55l9a9zXB9wqZ4
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

On Tue, 10 Aug 2004 20:46:33 -0700 (PDT) Linus Torvalds (LT) wrote:

I'm currently using 2.6.8-rc4 and I'm seeing the same problem. Each day the
machine just gets slower and swappier, even though I'm always running the same
workload. Rebooting helps a lot. The machine has very little memory (128MB).

LT> As Andrew already requested, the only way for us to figure out what is 
LT> wrong is to get output from you on where the memory has gone. Notably, the 
LT> output of "/proc/meminfo" and "/proc/slabinfo". "ps axm" helps too.

See below.

-Udo.


MemTotal:       125124 kB
MemFree:          1404 kB
Buffers:         19060 kB
Cached:          40484 kB
SwapCached:      33336 kB
Active:          70176 kB
Inactive:        41892 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:       125124 kB
LowFree:          1404 kB
SwapTotal:      506512 kB
SwapFree:       455536 kB
Dirty:               4 kB
Writeback:           0 kB
Mapped:          65312 kB
Slab:             9068 kB
Committed_AS:    99576 kB
PageTables:        704 kB
VmallocTotal:   909268 kB
VmallocUsed:      8936 kB
VmallocChunk:   900312 kB

slabinfo - version: 2.0
# name            <active_objs> <num_objs> <objsize> <objperslab> <pagesperslab> : tunables <batchcount> <limit> <sharedfactor> : slabdata <active_slabs> <num_slabs> <sharedavail>
rpc_buffers            8      8   2048    2    1 : tunables   24   12    0 : slabdata      4      4      0
rpc_tasks              8     25    160   25    1 : tunables  120   60    0 : slabdata      1      1      0
rpc_inode_cache        0      0    416    9    1 : tunables   54   27    0 : slabdata      0      0      0
xfrm6_tunnel_spi       0      0     64   61    1 : tunables  120   60    0 : slabdata      0      0      0
fib6_nodes             5    119     32  119    1 : tunables  120   60    0 : slabdata      1      1      0
ip6_dst_cache          5     18    224   18    1 : tunables  120   60    0 : slabdata      1      1      0
ndisc_cache            1     25    160   25    1 : tunables  120   60    0 : slabdata      1      1      0
raw6_sock              0      0    640    6    1 : tunables   54   27    0 : slabdata      0      0      0
udp6_sock              0      0    608    6    1 : tunables   54   27    0 : slabdata      0      0      0
tcp6_sock              6      7   1120    7    2 : tunables   24   12    0 : slabdata      1      1      0
unix_sock             42     50    384   10    1 : tunables   54   27    0 : slabdata      5      5      0
ip_conntrack           4     25    160   25    1 : tunables  120   60    0 : slabdata      1      1      0
tcp_tw_bucket          2     31    128   31    1 : tunables  120   60    0 : slabdata      1      1      0
tcp_bind_bucket       10    226     16  226    1 : tunables  120   60    0 : slabdata      1      1      0
tcp_open_request       0      0     96   41    1 : tunables  120   60    0 : slabdata      0      0      0
inet_peer_cache        0      0     64   61    1 : tunables  120   60    0 : slabdata      0      0      0
secpath_cache          0      0    128   31    1 : tunables  120   60    0 : slabdata      0      0      0
xfrm_dst_cache         0      0    256   15    1 : tunables  120   60    0 : slabdata      0      0      0
ip_fib_hash            9    226     16  226    1 : tunables  120   60    0 : slabdata      1      1      0
ip_dst_cache          10     30    256   15    1 : tunables  120   60    0 : slabdata      2      2      0
arp_cache              1     31    128   31    1 : tunables  120   60    0 : slabdata      1      1      0
raw4_sock              0      0    480    8    1 : tunables   54   27    0 : slabdata      0      0      0
udp_sock               1      7    512    7    1 : tunables   54   27    0 : slabdata      1      1      0
tcp_sock              11     16   1024    4    1 : tunables   54   27    0 : slabdata      4      4      0
flow_cache             0      0     96   41    1 : tunables  120   60    0 : slabdata      0      0      0
uhci_urb_priv          0      0     44   88    1 : tunables  120   60    0 : slabdata      0      0      0
ntfs_big_inode_cache      0      0    448    9    1 : tunables   54   27    0 : slabdata      0      0      0
ntfs_inode_cache       0      0    160   25    1 : tunables  120   60    0 : slabdata      0      0      0
ntfs_name_cache        0      0    512    8    1 : tunables   54   27    0 : slabdata      0      0      0
ntfs_attr_ctx_cache      0      0     32  119    1 : tunables  120   60    0 : slabdata      0      0      0
ntfs_index_ctx_cache      0      0     64   61    1 : tunables  120   60    0 : slabdata      0      0      0
smb_request            0      0    256   15    1 : tunables  120   60    0 : slabdata      0      0      0
smb_inode_cache        0      0    320   12    1 : tunables   54   27    0 : slabdata      0      0      0
nfs_write_data        36     36    448    9    1 : tunables   54   27    0 : slabdata      4      4      0
nfs_read_data         32     36    416    9    1 : tunables   54   27    0 : slabdata      4      4      0
nfs_inode_cache        0      0    544    7    1 : tunables   54   27    0 : slabdata      0      0      0
nfs_page               0      0     96   41    1 : tunables  120   60    0 : slabdata      0      0      0
isofs_inode_cache      0      0    320   12    1 : tunables   54   27    0 : slabdata      0      0      0
fat_inode_cache        0      0    352   11    1 : tunables   54   27    0 : slabdata      0      0      0
ext2_inode_cache       0      0    416    9    1 : tunables   54   27    0 : slabdata      0      0      0
ext2_xattr             0      0     44   88    1 : tunables  120   60    0 : slabdata      0      0      0
journal_handle        16    135     28  135    1 : tunables  120   60    0 : slabdata      1      1      0
journal_head          46    162     48   81    1 : tunables  120   60    0 : slabdata      2      2      0
revoke_table          12    290     12  290    1 : tunables  120   60    0 : slabdata      1      1      0
revoke_record          0      0     16  226    1 : tunables  120   60    0 : slabdata      0      0      0
ext3_inode_cache     844   1359    448    9    1 : tunables   54   27    0 : slabdata    151    151      0
ext3_xattr             0      0     44   88    1 : tunables  120   60    0 : slabdata      0      0      0
eventpoll_pwq          0      0     36  107    1 : tunables  120   60    0 : slabdata      0      0      0
eventpoll_epi          0      0     96   41    1 : tunables  120   60    0 : slabdata      0      0      0
kioctx                 0      0    160   25    1 : tunables  120   60    0 : slabdata      0      0      0
kiocb                  0      0     96   41    1 : tunables  120   60    0 : slabdata      0      0      0
dnotify_cache          0      0     20  185    1 : tunables  120   60    0 : slabdata      0      0      0
file_lock_cache        1     43     92   43    1 : tunables  120   60    0 : slabdata      1      1      0
fasync_cache           2    226     16  226    1 : tunables  120   60    0 : slabdata      1      1      0
shmem_inode_cache      8     10    384   10    1 : tunables   54   27    0 : slabdata      1      1      0
posix_timers_cache      0      0     96   41    1 : tunables  120   60    0 : slabdata      0      0      0
uid_cache              2    119     32  119    1 : tunables  120   60    0 : slabdata      1      1      0
cfq_pool              64    119     32  119    1 : tunables  120   60    0 : slabdata      1      1      0
crq_pool               0      0     36  107    1 : tunables  120   60    0 : slabdata      0      0      0
deadline_drq           0      0     48   81    1 : tunables  120   60    0 : slabdata      0      0      0
as_arq                 4     65     60   65    1 : tunables  120   60    0 : slabdata      1      1      0
blkdev_ioc            43    185     20  185    1 : tunables  120   60    0 : slabdata      1      1      0
blkdev_queue           9      9    448    9    1 : tunables   54   27    0 : slabdata      1      1      0
blkdev_requests        4     26    152   26    1 : tunables  120   60    0 : slabdata      1      1      0
biovec-(256)          60     60   3072    2    2 : tunables   24   12    0 : slabdata     30     30      0
biovec-128           121    125   1536    5    2 : tunables   24   12    0 : slabdata     25     25      0
biovec-64            242    245    768    5    1 : tunables   54   27    0 : slabdata     49     49      0
biovec-16            242    260    192   20    1 : tunables  120   60    0 : slabdata     13     13      0
biovec-4             242    244     64   61    1 : tunables  120   60    0 : slabdata      4      4      0
biovec-1             242    452     16  226    1 : tunables  120   60    0 : slabdata      2      2      0
bio                  259    366     64   61    1 : tunables  120   60    0 : slabdata      6      6      0
sock_inode_cache      65     77    352   11    1 : tunables   54   27    0 : slabdata      7      7      0
skbuff_head_cache    520    580    192   20    1 : tunables  120   60    0 : slabdata     29     29      0
sock                   4     12    320   12    1 : tunables   54   27    0 : slabdata      1      1      0
proc_inode_cache     360    360    320   12    1 : tunables   54   27    0 : slabdata     30     30      0
sigqueue              16     27    148   27    1 : tunables  120   60    0 : slabdata      1      1      0
radix_tree_node     1934   2044    276   14    1 : tunables   54   27    0 : slabdata    146    146      0
bdev_cache            10     18    416    9    1 : tunables   54   27    0 : slabdata      2      2      0
mnt_cache             23     41     96   41    1 : tunables  120   60    0 : slabdata      1      1      0
inode_cache         1069   1078    288   14    1 : tunables   54   27    0 : slabdata     77     77      0
dentry_cache        2432   4368    140   28    1 : tunables  120   60    0 : slabdata    156    156      0
filp                 800    800    160   25    1 : tunables  120   60    0 : slabdata     32     32      0
names_cache            8      8   4096    1    1 : tunables   24   12    0 : slabdata      8      8      0
idr_layer_cache       84     87    136   29    1 : tunables  120   60    0 : slabdata      3      3      0
buffer_head        33719  36126     48   81    1 : tunables  120   60    0 : slabdata    446    446      0
mm_struct             56     56    512    7    1 : tunables   54   27    0 : slabdata      8      8      0
vm_area_struct      1619   1692     84   47    1 : tunables  120   60    0 : slabdata     36     36      0
fs_cache              59    119     32  119    1 : tunables  120   60    0 : slabdata      1      1      0
files_cache           54     54    416    9    1 : tunables   54   27    0 : slabdata      6      6      0
signal_cache          95    123     96   41    1 : tunables  120   60    0 : slabdata      3      3      0
sighand_cache         63     63   1312    3    1 : tunables   24   12    0 : slabdata     21     21      0
task_struct           82     85   1424    5    2 : tunables   24   12    0 : slabdata     17     17      0
anon_vma             762    814      8  407    1 : tunables  120   60    0 : slabdata      2      2      0
pgd                   46     46   4096    1    1 : tunables   24   12    0 : slabdata     46     46      0
size-131072(DMA)       0      0 131072    1   32 : tunables    8    4    0 : slabdata      0      0      0
size-131072            0      0 131072    1   32 : tunables    8    4    0 : slabdata      0      0      0
size-65536(DMA)        0      0  65536    1   16 : tunables    8    4    0 : slabdata      0      0      0
size-65536             0      0  65536    1   16 : tunables    8    4    0 : slabdata      0      0      0
size-32768(DMA)        0      0  32768    1    8 : tunables    8    4    0 : slabdata      0      0      0
size-32768            28     28  32768    1    8 : tunables    8    4    0 : slabdata     28     28      0
size-16384(DMA)        0      0  16384    1    4 : tunables    8    4    0 : slabdata      0      0      0
size-16384             3      3  16384    1    4 : tunables    8    4    0 : slabdata      3      3      0
size-8192(DMA)         0      0   8192    1    2 : tunables    8    4    0 : slabdata      0      0      0
size-8192             84     84   8192    1    2 : tunables    8    4    0 : slabdata     84     84      0
size-4096(DMA)         0      0   4096    1    1 : tunables   24   12    0 : slabdata      0      0      0
size-4096             53     53   4096    1    1 : tunables   24   12    0 : slabdata     53     53      0
size-2048(DMA)         0      0   2048    2    1 : tunables   24   12    0 : slabdata      0      0      0
size-2048            118    118   2048    2    1 : tunables   24   12    0 : slabdata     59     59      0
size-1024(DMA)         0      0   1024    4    1 : tunables   54   27    0 : slabdata      0      0      0
size-1024            184    184   1024    4    1 : tunables   54   27    0 : slabdata     46     46      0
size-512(DMA)          0      0    512    8    1 : tunables   54   27    0 : slabdata      0      0      0
size-512             383    568    512    8    1 : tunables   54   27    0 : slabdata     71     71      0
size-256(DMA)          0      0    256   15    1 : tunables  120   60    0 : slabdata      0      0      0
size-256             252    480    256   15    1 : tunables  120   60    0 : slabdata     32     32      0
size-192(DMA)          0      0    192   20    1 : tunables  120   60    0 : slabdata      0      0      0
size-192             200    200    192   20    1 : tunables  120   60    0 : slabdata     10     10      0
size-128(DMA)          0      0    128   31    1 : tunables  120   60    0 : slabdata      0      0      0
size-128             335    372    128   31    1 : tunables  120   60    0 : slabdata     12     12      0
size-96(DMA)           0      0     96   41    1 : tunables  120   60    0 : slabdata      0      0      0
size-96             1655   1681     96   41    1 : tunables  120   60    0 : slabdata     41     41      0
size-64(DMA)           0      0     64   61    1 : tunables  120   60    0 : slabdata      0      0      0
size-64             1782   2013     64   61    1 : tunables  120   60    0 : slabdata     33     33      0
size-32(DMA)           0      0     32  119    1 : tunables  120   60    0 : slabdata      0      0      0
size-32             2677   2737     32  119    1 : tunables  120   60    0 : slabdata     23     23      0
kmem_cache           124    124    128   31    1 : tunables  120   60    0 : slabdata      4      4      0

  PID TTY      STAT   TIME COMMAND
    1 ?        -      0:01 init [4]             
    - -        S      0:01 -
    2 ?        -      0:00 [ksoftirqd/0]
    - -        SN     0:00 -
    3 ?        -      0:00 [events/0]
    - -        S<     0:00 -
    4 ?        -      0:00 [khelper]
    - -        S<     0:00 -
    5 ?        -      0:04 [kacpid]
    - -        S<     0:04 -
   22 ?        -      0:00 [kblockd/0]
    - -        S<     0:00 -
   23 ?        -      0:00 [khubd]
    - -        S      0:00 -
   37 ?        -      0:00 [pdflush]
    - -        S      0:00 -
   40 ?        -      0:00 [aio/0]
    - -        S<     0:00 -
   39 ?        -      0:02 [kswapd0]
    - -        S      0:02 -
  142 ?        -      0:00 [pccardd]
    - -        S      0:00 -
  144 ?        -      0:00 [pccardd]
    - -        S      0:00 -
  152 ?        -      0:00 [kseriod]
    - -        S      0:00 -
  171 ?        -      0:00 [kjournald]
    - -        S      0:00 -
  330 ?        -      0:00 [kjournald]
    - -        S      0:00 -
  331 ?        -      0:24 [loop0]
    - -        S<     0:24 -
  332 ?        -      0:00 [kjournald]
    - -        S      0:00 -
  333 ?        -      0:00 [kjournald]
    - -        S      0:00 -
  334 ?        -      0:00 [kjournald]
    - -        S      0:00 -
  335 ?        -      0:00 [kjournald]
    - -        S      0:00 -
  497 ?        -      0:00 /usr/sbin/syslogd -m 0
    - -        Ss     0:00 -
  511 ?        -      0:00 /usr/sbin/klogd -c 3 -x
    - -        Ss     0:00 -
  514 ?        -      0:00 /sbin/cardmgr
    - -        Ss     0:00 -
  857 ?        -      0:00 /sbin/rpc.portmap
    - -        Ss     0:00 -
  898 ?        -      0:00 /usr/sbin/inetd
    - -        Ss     0:00 -
  904 ?        -      0:00 /usr/local/sbin/sshd
    - -        Ss     0:00 -
  914 ?        -      0:00 /usr/sbin/crond -l10
    - -        S      0:00 -
  917 ?        -      0:00 /usr/sbin/acpid
    - -        Ss     0:00 -
  930 ?        -      0:00 /usr/sbin/gpm -m /dev/mouse -t ps2
    - -        Ss     0:00 -
  933 ?        -      0:00 /usr/sbin/smartd
    - -        S      0:00 -
  950 tty2     -      0:00 /sbin/agetty 38400 tty2 linux
    - -        Ss+    0:00 -
  951 tty3     -      0:00 /sbin/agetty 38400 tty3 linux
    - -        Ss+    0:00 -
  952 tty4     -      0:00 /sbin/agetty 38400 tty4 linux
    - -        Ss+    0:00 -
  953 tty5     -      0:00 /sbin/agetty 38400 tty5 linux
    - -        Ss+    0:00 -
  954 tty6     -      0:00 /sbin/agetty 38400 tty6 linux
    - -        Ss+    0:00 -
  955 tty7     -      0:00 /sbin/agetty 38400 tty7 linux
    - -        Ss+    0:00 -
  956 tty8     -      0:00 /sbin/agetty 38400 tty8 linux
    - -        Ss+    0:00 -
  957 tty9     -      0:00 /sbin/agetty 38400 tty9 linux
    - -        Ss+    0:00 -
  958 tty10    -      0:00 /sbin/agetty 38400 tty10 linux
    - -        Ss+    0:00 -
  959 ?        -      0:00 /usr/X11R6/bin/xdm -nodaemon
    - -        Ss     0:00 -
 1081 ?        -     19:54 /usr/X11R6/bin/X -auth /usr/X11R6/lib/X11/xdm/authdir/authfiles/A:0-yl5ncw
    - -        S     19:54 -
 1082 ?        -      0:00 -:0                         
    - -        S      0:00 -
 1181 ?        -      0:00 [eth1]
    - -        S      0:00 -
 1244 ?        -      0:00 /sbin/dhcpcd -d eth1
    - -        Ss     0:00 -
 1251 ?        -      0:01 blackbox
    - -        S      0:01 -
 1280 ?        -      6:18 /home/uas/bin/wmbatteries
    - -        S      6:18 -
 1282 ?        -      0:02 /home/uas/bin/wmcpuload -a -n -lc rgb:ff/ff/33
    - -        S      0:02 -
 1284 ?        -      2:24 /home/uas/bin/wmnetload -n eth1
    - -        S      2:24 -
 1286 ?        -      0:01 /home/uas/bin/wmmemload -am -b -c -lc rgb:ff/80/30
    - -        S      0:01 -
 1288 ?        -      0:12 /home/uas/bin/wmtime -lc rgb:33/33/ff
    - -        S      0:12 -
 1292 ?        -      0:00 /home/uas/bin/root-tail -f -g 350x10+5-10 -fn -schumacher-clean-medium-r-*-*-10-*-*-*-*-*-*-* -color rgb:cc/cc/ff /var/log/messages rgb:88/88/ff /var/log/syslog rgb:ff/88/ff /var/log/maillog
    - -        Ss     0:00 -
 1328 ?        -      0:00 licq
    - -        Ss     0:00 -
 1331 ?        -      0:00 licq
    - -        S      0:00 -
 1332 ?        -      0:06 licq
    - -        S      0:06 -
 1333 ?        -      0:00 licq
    - -        S      0:00 -
 1334 ?        -      0:00 licq
    - -        S      0:00 -
 1335 ?        -      0:04 licq
    - -        S      0:04 -
 1484 ?        -      0:00 /home/uas/bin/aterm -geometry 80x25
    - -        Ss     0:00 -
 1485 pts/1    -      0:00 -bash
    - -        Rs     0:00 -
 1508 tty1     -      0:00 /sbin/agetty 38400 tty1 linux
    - -        Ss+    0:00 -
 4232 ?        -      0:03 xmms
    - -        Ss     0:03 -
 4233 ?        -      0:00 xmms
    - -        S      0:00 -
 4234 ?        -      0:00 xmms
    - -        S      0:00 -
 4235 ?        -      0:00 xmms
    - -        S      0:00 -
 4265 ?        -      0:00 /bin/sh /usr/local/bin/firefox
    - -        Ss     0:00 -
 4277 ?        -      0:00 /bin/sh /usr/local/firefox/run-mozilla.sh /usr/local/firefox/firefox-bin
    - -        S      0:00 -
 4282 ?        -      0:30 /usr/local/firefox/firefox-bin
    - -        S      0:30 -
 4283 ?        -      0:00 /usr/local/firefox/firefox-bin
    - -        S      0:00 -
 4284 ?        -      0:00 /usr/local/firefox/firefox-bin
    - -        S      0:00 -
 4285 ?        -      0:00 /usr/local/firefox/firefox-bin
    - -        S      0:00 -
 4307 ?        -      0:00 [netstat] <defunct>
    - -        Z      0:00 -
 4335 ?        -      0:00 [pdflush]
    - -        S      0:00 -
 4386 ?        -      0:00 xmms
    - -        S      0:00 -
 4387 ?        -      0:00 xmms
    - -        S      0:00 -
 4441 ?        -      0:03 sylpheed
    - -        Ss     0:03 -
 4447 ?        -      0:00 /home/uas/bin/aterm -geometry 80x25
    - -        Ss     0:00 -
 4448 pts/2    -      0:00 -bash
    - -        Ss+    0:00 -
 4474 ?        -      0:00 /home/uas/bin/aterm -geometry 80x25
    - -        Ss     0:00 -
 4475 pts/0    -      0:00 -bash
    - -        Ss+    0:00 -
 4489 pts/1    -      0:00 ps axm
    - -        R+     0:00 -

--Signature=_Tue__10_Aug_2004_21_18_49_-0700_uQ55l9a9zXB9wqZ4
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFBGZ4tnhRzXSM7nSkRAmnUAJwIyoiDxdrWztHlTtpmhLuNviGV4ACeLiFX
5buZbQ68hNOndMTLgh/rElo=
=zmHw
-----END PGP SIGNATURE-----

--Signature=_Tue__10_Aug_2004_21_18_49_-0700_uQ55l9a9zXB9wqZ4--
