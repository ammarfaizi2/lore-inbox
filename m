Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316619AbSFUO5C>; Fri, 21 Jun 2002 10:57:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316632AbSFUO5B>; Fri, 21 Jun 2002 10:57:01 -0400
Received: from mail16.speakeasy.net ([216.254.0.216]:19917 "EHLO
	mail.speakeasy.net") by vger.kernel.org with ESMTP
	id <S316619AbSFUO46>; Fri, 21 Jun 2002 10:56:58 -0400
Subject: Re: strange swap usage with ac branch of 2.4.19-pre9/10
From: Ed Sweetman <safemode@speakeasy.net>
To: linux-kernel@vger.kernel.org
In-Reply-To: <20020618103046.7D7BA152D7@oscar.casa.dyndns.org>
References: <1024377359.7801.38.camel@psuedomode> 
	<20020618103046.7D7BA152D7@oscar.casa.dyndns.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.7 
Date: 21 Jun 2002 10:56:59 -0400
Message-Id: <1024671419.21535.23.camel@psuedomode>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I see a growing dentry_cache,  but why call it a cache when free shows it as being buffer?
This is related to my previous posts about this. Does anyone know what's going on here? 


             total       used       free     shared    buffers     cached
Mem:           629        622          7          0         30         65
-/+ buffers/cache:        525        103
Swap:         1040         70        970


slabinfo - version: 1.1
kmem_cache            60     68    112    2    2    1
uhci_urb_priv          3     62     60    1    1    1
tcp_tw_bucket          0     60    128    0    2    1
tcp_bind_bucket       24    112     32    1    1    1
tcp_open_request       0     59     64    0    1    1
inet_peer_cache        0      0     64    0    0    1
ip_fib_hash            9    112     32    1    1    1
ip_dst_cache          73    120    192    4    6    1
arp_cache              2     30    128    1    1    1
blkdev_requests     6144   6150    128  205  205    1
devfsd_event           0      0     20    0    0    1
journal_head         884   3696     48   22   48    1
revoke_table          10    250     12    1    1    1
revoke_record          0    112     32    0    1    1
dnotify_cache          0      0     20    0    0    1
file_lock_cache       11     42     92    1    1    1
fasync_cache           2    202     16    1    1    1
uid_cache              4    112     32    1    1    1
skbuff_head_cache    160    200    192   10   10    1
sock                 271    279    832   31   31    2
sigqueue               0     29    132    0    1    1
kiobuf                 0      0     64    0    0    1
cdev_cache            32    295     64    4    5    1
bdev_cache            13     59     64    1    1    1
mnt_cache             21     59     64    1    1    1
inode_cache        35683  55398    512 7914 7914    1
dentry_cache       36016  70500    128 2350 2350    1
filp                2494   2520    128   84   84    1
names_cache            0      3   4096    0    3    1
buffer_head        24531  47190    128 1531 1573    1
mm_struct             83    100    192    5    5    1
vm_area_struct      4688   4770    128  157  159    1
fs_cache              82    118     64    2    2    1
files_cache           82     90    448   10   10    1
signal_act            96    102   1344   33   34    1
size-131072(DMA)       0      0 131072    0    0   32
size-131072            0      0 131072    0    0   32
size-65536(DMA)        0      0  65536    0    0   16
size-65536             1      1  65536    1    1   16
size-32768(DMA)        0      0  32768    0    0    8
size-32768             2      2  32768    2    2    8
size-16384(DMA)        0      0  16384    0    0    4
size-16384             6      8  16384    6    8    4
size-8192(DMA)         0      0   8192    0    0    2
size-8192              6      7   8192    6    7    2
size-4096(DMA)         0      0   4096    0    0    1
size-4096             52     61   4096   52   61    1
size-2048(DMA)         0      0   2048    0    0    1
size-2048             51     74   2048   26   37    1
size-1024(DMA)         0      0   1024    0    0    1
size-1024             89     96   1024   23   24    1
size-512(DMA)          0      0    512    0    0    1
size-512              59     64    512    8    8    1
size-256(DMA)          0      0    256    0    0    1
size-256             145    165    256   10   11    1
size-128(DMA)          4     30    128    1    1    1
size-128            2329   2460    128   79   82    1
size-64(DMA)           0      0     64    0    0    1
size-64             1662   3422     64   39   58    1
size-32(DMA)           4     59     64    1    1    1
size-32             6906  12862     64  160  218    1


        total:    used:    free:  shared: buffers:  cached:
Mem:  660455424 652906496  7548928        0 31686656 97972224
Swap: 1091526656 74035200 1017491456
MemTotal:       644976 kB
MemFree:          7372 kB
MemShared:           0 kB
Buffers:         30944 kB
Cached:          68284 kB
SwapCached:      27392 kB
Active:         145192 kB
Inact_dirty:     84108 kB
Inact_clean:     22196 kB
Inact_target:    50296 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:       644976 kB
LowFree:          7372 kB
SwapTotal:     1065944 kB
SwapFree:       993644 kB
Committed_AS:   339068 kB

