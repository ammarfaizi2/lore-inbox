Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277598AbRJ3TcR>; Tue, 30 Oct 2001 14:32:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277653AbRJ3TcH>; Tue, 30 Oct 2001 14:32:07 -0500
Received: from jalon.able.es ([212.97.163.2]:13778 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S277598AbRJ3Tbu>;
	Tue, 30 Oct 2001 14:31:50 -0500
Date: Tue, 30 Oct 2001 19:29:19 +0100
From: "J . A . Magallon" <jamagallon@able.es>
To: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: funny free output with all mem for buffers
Message-ID: <20011030192919.A2436@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 1.2.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

When making several images of Linux install disks with dd
(dd if=/dev/cdrom of=linux.img) I dared to check the mem/cache state:

             total       used       free     shared    buffers     cached
Mem:        513168     510104       3064        992     349720 4294707520
-/+ buffers/cache: -4294547136 4295060304
Swap:       345356          0     345356

See the <0 value ? Strange accounting...
Kernel is 2.4.13-ac5, 512Mb of ram.

If it is worthy, here are the outputs of /proc/meminfo and slabinfo

        total:    used:    free:  shared: buffers:  cached:
Mem:  525484032 522346496  3137536  1015808 395116544 18446744073370112000
Swap: 353644544        0 353644544
MemTotal:       513168 kB
MemFree:          3064 kB
MemShared:         992 kB
Buffers:        385856 kB
Cached:       4294635812 kB
SwapCached:          0 kB
Active:         324320 kB
Inact_dirty:    114476 kB
Inact_clean:      1432 kB
Inact_target:   104856 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:       513168 kB
LowFree:          3064 kB
SwapTotal:      345356 kB
SwapFree:       345356 kB

slabinfo - version: 1.1 (SMP)
kmem_cache            64     64    244    4    4    1 :  252  126
tcp_tw_bucket          1     40     96    1    1    1 :  252  126
tcp_bind_bucket      130    226     32    2    2    1 :  252  126
tcp_open_request       0      0     64    0    0    1 :  252  126
inet_peer_cache        2    118     64    2    2    1 :  252  126
ip_fib_hash           10    226     32    2    2    1 :  252  126
ip_dst_cache          11     72    160    3    3    1 :  252  126
arp_cache              2     30    128    1    1    1 :  252  126
blkdev_requests     9216   9240     96  231  231    1 :  252  126
journal_head        3933   7800     48   53  100    1 :  252  126
revoke_table           1    253     12    1    1    1 :  252  126
revoke_record          0      0     32    0    0    1 :  252  126
dnotify cache          0      0     20    0    0    1 :  252  126
file lock cache       84    126     92    3    3    1 :  252  126
fasync cache           1    202     16    1    1    1 :  252  126
uid_cache              2    113     32    1    1    1 :  252  126
skbuff_head_cache    353    696    160   29   29    1 :  252  126
sock                 271    333    832   37   37    2 :  124   62
sigqueue             116    116    132    4    4    1 :  252  126
kiobuf                 0      0   8768    0    0    4 :    0    0
cdev_cache           270    295     64    5    5    1 :  252  126
bdev_cache             7    118     64    2    2    1 :  252  126
mnt_cache             15    118     64    2    2    1 :  252  126
inode_cache         1129   1674    448  186  186    1 :  124   62
dentry_cache         888   3480    128  116  116    1 :  252  126
filp                1693   1720     96   43   43    1 :  252  126
names_cache            3      3   4096    3    3    1 :   60   30
buffer_head       212644 215920     96 5395 5398    1 :  252  126
mm_struct            144    144    160    6    6    1 :  252  126
vm_area_struct      2706   2773     64   46   47    1 :  252  126
fs_cache             236    236     64    4    4    1 :  252  126
files_cache          108    108    416   12   12    1 :  124   62
signal_act            96     96   1312   32   32    1 :   60   30
size-131072(DMA)       0      0 131072    0    0   32 :    0    0
size-131072            0      0 131072    0    0   32 :    0    0
size-65536(DMA)        0      0  65536    0    0   16 :    0    0
size-65536             0      0  65536    0    0   16 :    0    0
size-32768(DMA)        0      0  32768    0    0    8 :    0    0
size-32768             1      1  32768    1    1    8 :    0    0
size-16384(DMA)        0      0  16384    0    0    4 :    0    0
size-16384             7      8  16384    7    8    4 :    0    0
size-8192(DMA)         0      0   8192    0    0    2 :    0    0
size-8192              4      6   8192    4    6    2 :    0    0
size-4096(DMA)         0      0   4096    0    0    1 :   60   30
size-4096             51     51   4096   51   51    1 :   60   30
size-2048(DMA)         0      0   2048    0    0    1 :   60   30
size-2048             36     44   2048   20   22    1 :   60   30
size-1024(DMA)         0      0   1024    0    0    1 :  124   62
size-1024            168    168   1024   42   42    1 :  124   62
size-512(DMA)          0      0    512    0    0    1 :  124   62
size-512             680    680    512   85   85    1 :  124   62
size-256(DMA)          0      0    256    0    0    1 :  252  126
size-256             450    450    256   30   30    1 :  252  126
size-128(DMA)          0      0    128    0    0    1 :  252  126
size-128             923    930    128   31   31    1 :  252  126
size-64(DMA)           0      0     64    0    0    1 :  252  126
size-64              566    767     64   13   13    1 :  252  126
size-32(DMA)           0      0     32    0    0    1 :  252  126
size-32             1058   2599     32   23   23    1 :  252  126


-- 
J.A. Magallon                           #  Let the source be with you...        
mailto:jamagallon@able.es
Mandrake Linux release 8.2 (Cooker) for i586
Linux werewolf 2.4.13-ac5-beo #1 SMP Tue Oct 30 00:10:00 CET 2001 i686
