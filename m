Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267329AbSLKVrD>; Wed, 11 Dec 2002 16:47:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267335AbSLKVrD>; Wed, 11 Dec 2002 16:47:03 -0500
Received: from inetgw.eenterprises.com ([212.27.173.62]:43275 "EHLO
	inetgw.eenterprises.com") by vger.kernel.org with ESMTP
	id <S267329AbSLKVq6>; Wed, 11 Dec 2002 16:46:58 -0500
Message-ID: <E8EE16A19D69D611B40000D0B73EBB250F06C6@exchange.intern.eproduction.ch>
From: =?iso-8859-1?Q?=22R=FCegg=2C_Peter_H=2E=22?= 
	<peter.ruegg@eenterprises.com>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Cc: "'Martin J. Bligh'" <mbligh@aracnet.com>
Subject: AW: Complete freeze with 2.4.20 on 4-proc IBM xSeries 350
Date: Wed, 11 Dec 2002 22:55:04 +0100
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11. December 2002, Martin J. Bligh wrote:
>> I'm experiencing serious problems with Kernel 2.4.20 on a 
>> IBM xSeries 350 machine, having 4 700 MHz processors and 
>> 4 GB RAM (same on another machine with the same configuration,
>> but only 3 GB RAM). The machine just completely freezes 
>> after some time, ranging from 20 minutes to 3 hours. It
>> is running IBM DB/2 with quite some load, the base system 
>> is RedHat 7.2 with all the updates applied. There is no 
>> oops or other fault, just a plain freeze.
> 
> Can you watch /proc/meminfo and see how low "lowfree" gets?
> If it gets low (eg below 50Mb), dump /proc/slabinfo as well.

Thanks for your input! However, that doesn't seem to be the
problem. When the machine crashed this time, there still was
829MB of LowFree memory available. See the two files a few
seconds before the freeze below.

Any other thoughts, anyone?

Thanks in advance!


Peter H. Ruegg
Systems-/Networkadministrator RHCE eEnterprises Technology

--8<------------------------------------------------------------------------
-
main(){char*s="O_>>^PQAHBbPQAHBbPOOH^^PAAHBJPAAHBbPA_H>BB";int
i,j,k=1,l,m,n;
for(j=0;j<7;j++)for(l=0;m=l-6+j,i=m/6,n=j*6+i,k=1<<m%6,l<41-j;l++)
putchar(l<6-j?' ':l==40-j?'\n':k&&s[n]&k?'*':' ');}


        total:    used:    free:  shared: buffers:  cached:
Mem:  3901415424 1651003392 2250412032        0  3432448 1415294976
Swap: 2147467264        0 2147467264
MemTotal:      3809976 kB
MemFree:       2197668 kB
MemShared:           0 kB
Buffers:          3352 kB
Cached:        1382124 kB
SwapCached:          0 kB
Active:          81164 kB
Inactive:      1486032 kB
HighTotal:     2940900 kB
HighFree:      1368624 kB
LowTotal:       869076 kB
LowFree:        829044 kB
SwapTotal:     2097136 kB
SwapFree:      2097136 kB
--------------------------------
slabinfo - version: 1.1 (SMP)
kmem_cache            80     80    244    5    5    1 :  252  126
tcp_tw_bucket         30     30    128    1    1    1 :  252  126
tcp_bind_bucket      339    339     32    3    3    1 :  252  126
tcp_open_request     120    120     96    3    3    1 :  252  126
inet_peer_cache      118    118     64    2    2    1 :  252  126
ip_fib_hash          452    452     32    4    4    1 :  252  126
ip_dst_cache         144    144    160    6    6    1 :  252  126
arp_cache            120    120    128    4    4    1 :  252  126
blkdev_requests     1160   1160     96   29   29    1 :  252  126
nfs_write_data         0      0    352    0    0    1 :  124   62
nfs_read_data          0      0    352    0    0    1 :  124   62
nfs_page               0      0     96    0    0    1 :  252  126
journal_head           0      0     48    0    0    1 :  252  126
revoke_table           0      0     12    0    0    1 :  252  126
revoke_record          0      0     32    0    0    1 :  252  126
dnotify_cache          0      0     20    0    0    1 :  252  126
file_lock_cache      240    240     96    6    6    1 :  252  126
fasync_cache           0      0     16    0    0    1 :  252  126
uid_cache            452    452     32    4    4    1 :  252  126
skbuff_head_cache    822   1200    160   49   50    1 :  252  126
sock                 272    272    928   68   68    1 :  124   62
sigqueue             628    754    132   23   26    1 :  252  126
kiobuf                 0      0     64    0    0    1 :  252  126
cdev_cache           354    354     64    6    6    1 :  252  126
bdev_cache           236    236     64    4    4    1 :  252  126
mnt_cache            236    236     64    4    4    1 :  252  126
inode_cache         4032   4032    480  504  504    1 :  124   62
dentry_cache        5280   5280    128  176  176    1 :  252  126
dquot                  0      0    128    0    0    1 :  252  126
filp                1530   1530    128   51   51    1 :  252  126
names_cache           12     12   4096   12   12    1 :   60   30
buffer_head        42114  42240     96 1056 1056    1 :  252  126
mm_struct            336    336    160   14   14    1 :  252  126
vm_area_struct      6142   6520     96  163  163    1 :  252  126
fs_cache             413    413     64    7    7    1 :  252  126
files_cache          306    306    416   34   34    1 :  124   62
signal_act           258    258   1312   86   86    1 :   60   30
size-131072(DMA)       0      0 131072    0    0   32 :    0    0
size-131072            0      0 131072    0    0   32 :    0    0
size-65536(DMA)        0      0  65536    0    0   16 :    0    0
size-65536             0      0  65536    0    0   16 :    0    0
size-32768(DMA)        0      0  32768    0    0    8 :    0    0
size-32768             0      0  32768    0    0    8 :    0    0
size-16384(DMA)        0      0  16384    0    0    4 :    0    0
size-16384             5      5  16384    5    5    4 :    0    0
size-8192(DMA)         0      0   8192    0    0    2 :    0    0
size-8192              4      5   8192    4    5    2 :    0    0
size-4096(DMA)         0      0   4096    0    0    1 :   60   30
size-4096             37     37   4096   37   37    1 :   60   30
size-2048(DMA)         0      0   2048    0    0    1 :   60   30
size-2048            162    222   2048   81  111    1 :   60   30
size-1024(DMA)         0      0   1024    0    0    1 :  124   62
size-1024            404    404   1024  101  101    1 :  124   62
size-512(DMA)          0      0    512    0    0    1 :  124   62
size-512             554    616    512   76   77    1 :  124   62
size-256(DMA)          0      0    256    0    0    1 :  252  126
size-256             534    660    256   37   44    1 :  252  126
size-128(DMA)          0      0    128    0    0    1 :  252  126
size-128             870    870    128   29   29    1 :  252  126
size-64(DMA)           0      0     64    0    0    1 :  252  126
size-64              708    708     64   12   12    1 :  252  126
size-32(DMA)           0      0     32    0    0    1 :  252  126
size-32             1443   1695     32   15   15    1 :  252  126
