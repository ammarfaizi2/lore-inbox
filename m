Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271090AbTHLUYo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Aug 2003 16:24:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271094AbTHLUYo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Aug 2003 16:24:44 -0400
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:47433 "EHLO
	pd5mo3so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S271090AbTHLUYl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Aug 2003 16:24:41 -0400
Date: Tue, 12 Aug 2003 13:23:49 -0700
From: Ken Savage <kens1835@shaw.ca>
Subject: Re: High CPU load with kswapd and heavy disk I/O
In-reply-to: <3F3943B9.7080700@vgertech.com>
To: linux-kernel@vger.kernel.org
Message-id: <200308121323.49081.kens1835@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 7BIT
Content-disposition: inline
User-Agent: KMail/1.5
References: <200308121136.11979.kens1835@shaw.ca>
 <3F3943B9.7080700@vgertech.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue August 12 2003 12:44, Nuno Silva wrote:

> Can you send before, during and after:
> cat /proc/meminfo
> cat /proc/slabinfo

Can't send "during" because the system is completely locked up
and unresponsive.  There is no warning as to when it's about to
bomb out on kswapd, so I can't provide anything resembling a
"just before".  OTOH, "after", I can since it just happened now! ;)

AFTER:
-----------

        total:    used:    free:  shared: buffers:  cached:
Mem:  3710840832 2703040512 1007800320        0 427081728 522944512
Swap: 2147467264 57257984 2090209280
MemTotal:      3623868 kB
MemFree:        984180 kB
MemShared:           0 kB
Buffers:        417072 kB
Cached:         470384 kB
SwapCached:      40304 kB
Active:         509216 kB
Inactive:      1973064 kB
HighTotal:     2752448 kB
HighFree:       978908 kB
LowTotal:       871420 kB
LowFree:          5272 kB
SwapTotal:     2097136 kB
SwapFree:      2041220 kB

slabinfo - version: 1.1 (SMP)
kmem_cache            80     80    244    5    5    1 :  252  126
ip_conntrack         211    270    384   27   27    1 :  124   62
tcp_tw_bucket         19     90    128    3    3    1 :  252  126
tcp_bind_bucket       54    224     32    2    2    1 :  252  126
tcp_open_request      59     59     64    1    1    1 :  252  126
inet_peer_cache        4     59     64    1    1    1 :  252  126
ip_fib_hash           10    224     32    2    2    1 :  252  126
ip_dst_cache          12    120    192    6    6    1 :  252  126
arp_cache              6     60    128    2    2    1 :  252  126
blkdev_requests      384    390    128   13   13    1 :  252  126
nfs_write_data         0      0    384    0    0    1 :  124   62
nfs_read_data          0      0    384    0    0    1 :  124   62
nfs_page               0      0    128    0    0    1 :  252  126
journal_head           0      0     48    0    0    1 :  252  126
revoke_table           0      0     12    0    0    1 :  252  126
revoke_record          0      0     32    0    0    1 :  252  126
dnotify cache          0      0     20    0    0    1 :  252  126
file lock cache        1     42     92    1    1    1 :  252  126
fasync cache           0      0     16    0    0    1 :  252  126
uid_cache              2    112     32    1    1    1 :  252  126
skbuff_head_cache    328    640    192   32   32    1 :  252  126
sock                 154    180    832   20   20    2 :  124   62
sigqueue              29     29    132    1    1    1 :  252  126
cdev_cache            12    177     64    3    3    1 :  252  126
bdev_cache             5     59     64    1    1    1 :  252  126
mnt_cache             14    118     64    2    2    1 :  252  126
inode_cache        33897 106547    512 15221 15221    1 :  124   62
dentry_cache       12195  12300    128  410  410    1 :  252  126
filp                2751   2790    128   93   93    1 :  252  126
names_cache            3      3   4096    3    3    1 :   60   30
buffer_head       223778 513540    128 17117 17118    1 :  252  126
mm_struct            180    180    192    9    9    1 :  252  126
vm_area_struct      2638   3030    128  101  101    1 :  252  126
fs_cache              76    236     64    4    4    1 :  252  126
files_cache           76    135    448   15   15    1 :  124   62
signal_act            90    117   1344   39   39    1 :   60   30
size-131072(DMA)       0      0 131072    0    0   32 :    0    0
size-131072            0      0 131072    0    0   32 :    0    0
size-65536(DMA)        0      0  65536    0    0   16 :    0    0
size-65536             0      0  65536    0    0   16 :    0    0
size-32768(DMA)        0      0  32768    0    0    8 :    0    0
size-32768             3      3  32768    3    3    8 :    0    0
size-16384(DMA)        0      0  16384    0    0    4 :    0    0
size-16384            12     12  16384   12   12    4 :    0    0
size-8192(DMA)         0      0   8192    0    0    2 :    0    0
size-8192              2      2   8192    2    2    2 :    0    0
size-4096(DMA)         0      0   4096    0    0    1 :   60   30
size-4096            182    182   4096  182  182    1 :   60   30
size-2048(DMA)         0      0   2048    0    0    1 :   60   30
size-2048            108    108   2048   54   54    1 :   60   30
size-1024(DMA)         0      0   1024    0    0    1 :  124   62
size-1024            172    172   1024   43   43    1 :  124   62
size-512(DMA)          0      0    512    0    0    1 :  124   62
size-512             360    360    512   45   45    1 :  124   62
size-256(DMA)          0      0    256    0    0    1 :  252  126
size-256             165    165    256   11   11    1 :  252  126
size-128(DMA)          0      0    128    0    0    1 :  252  126
size-128             570    570    128   19   19    1 :  252  126
size-64(DMA)           0      0     64    0    0    1 :  252  126
size-64              722   1534     64   26   26    1 :  252  126
size-32(DMA)           0      0     64    0    0    1 :  252  126
size-32            11868  12390     64  210  210    1 :  252  126


