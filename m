Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263679AbUACTyE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jan 2004 14:54:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263772AbUACTyE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jan 2004 14:54:04 -0500
Received: from citrine.spiritone.com ([216.99.193.133]:9143 "EHLO
	citrine.spiritone.com") by vger.kernel.org with ESMTP
	id S263679AbUACTxz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jan 2004 14:53:55 -0500
Date: Sat, 03 Jan 2004 11:53:46 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Jens Axboe <axboe@suse.de>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Long pauses (IO?) whilst ripping DVDs
Message-ID: <37670000.1073159626@[10.10.2.4]>
In-Reply-To: <20040103122614.GW5523@suse.de>
References: <2950000.1073111086@[10.10.2.4]> <20040103122614.GW5523@suse.de>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OK, here's a capture of data from when the system is being a little bit
slow to respond, though nothing as bad as I'd managed to recreate earlier.
There's a vmstat 5, mixed with a grab of some fields from /proc/meminfo,
and the dentry_cache from slabinfo (every 5 seconds).

M.

 3  0  0      0   3516 217260  93480    0    0   384   139 1017  9551 96  4  0
MemTotal:       513060 kB
MemFree:          3068 kB
Buffers:        217644 kB
Cached:          93616 kB
Active:         363024 kB
Inactive:       121000 kB
Dirty:            1256 kB
Slab:            20628 kB
dentry_cache        6969  13848    160   24    1 : tunables  240  120    0 : slabdata    577    577      0
 5  0  0      0   3516 216776  93956    0    0   487   142 1010  9285 96  4  0
MemTotal:       513060 kB
MemFree:          3132 kB
Buffers:        217160 kB
Cached:          94068 kB
Active:         361808 kB
Inactive:       122188 kB
Dirty:            1852 kB
Slab:            20588 kB
dentry_cache        6969  13848    160   24    1 : tunables  240  120    0 : slabdata    577    577      0
 6  0  0      0   3132 217912  93320    0    0   384    88 1012 10023 95  5  0
MemTotal:       513060 kB
MemFree:          3580 kB
Buffers:        217404 kB
Cached:          93312 kB
Active:         367352 kB
Inactive:       116136 kB
Dirty:            2480 kB
Slab:            20572 kB
dentry_cache        6969  13848    160   24    1 : tunables  240  120    0 : slabdata    577    577      0
 4  0  0      0   3580 217388  93420    0    0   384   146 1008  9426 97  3  0
MemTotal:       513060 kB
MemFree:          3132 kB
Buffers:        217772 kB
Cached:          93540 kB
Active:         366492 kB
Inactive:       117592 kB
Dirty:            3104 kB
Slab:            20508 kB
dentry_cache        6969  13848    160   24    1 : tunables  240  120    0 : slabdata    577    577      0
   procs                      memory      swap          io     system      cpu
 r  b  w   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id
 6  0  0      0   3068 217712  93684    0    0   384   263 1044  9347 96  4  0
MemTotal:       513060 kB
MemFree:          3452 kB
Buffers:        216740 kB
Cached:          94224 kB
Active:         364408 kB
Inactive:       119300 kB
Dirty:            3764 kB
Slab:            20472 kB
dentry_cache        7087  13848    160   24    1 : tunables  240  120    0 : slabdata    577    577      0
 3  0  0      0   3388 216740  94224    0    0   384   140 1008  9362 96  4  0
 7  0  0      0   3132 216672  94732    0    0   385   180 1035 10069 95  5  0
MemTotal:       513060 kB
MemFree:          3132 kB
Buffers:        216672 kB
Cached:          94740 kB
Active:         370508 kB
Inactive:       113648 kB
Dirty:             120 kB
Slab:            20432 kB
dentry_cache        7039  13848    160   24    1 : tunables  240  120    0 : slabdata    577    577      0
 7  0  0      0   3516 215996  94992    0    0   410   114 1047  9273 97  3  0
MemTotal:       513060 kB
MemFree:          3516 kB
Buffers:        215996 kB
Cached:          95000 kB
Active:         368980 kB
Inactive:       114760 kB
Dirty:             712 kB
Slab:            20416 kB
dentry_cache        7039  13848    160   24    1 : tunables  240  120    0 : slabdata    577    577      0
 5  0  0      0   3004 216720  94808    0    0   384   109 1047  8724 97  3  0
MemTotal:       513060 kB
MemFree:          3004 kB
Buffers:        216720 kB
Cached:          94812 kB
Active:         367984 kB
Inactive:       116328 kB
Dirty:            1280 kB
Slab:            20388 kB
dentry_cache        6991  13848    160   24    1 : tunables  240  120    0 : slabdata    577    577      0
 4  1  0      0   3580 215780  95168    0    0   385   141 1064  9814 95  5  0
MemTotal:       513060 kB
MemFree:          3580 kB
Buffers:        215780 kB
Cached:          95180 kB
Active:         373840 kB
Inactive:       109896 kB
Dirty:            1848 kB
Slab:            20344 kB
dentry_cache        6991  13848    160   24    1 : tunables  240  120    0 : slabdata    577    577      0
 3  0  0      0   3580 215240  95612    0    0   384   162 1088  9067 96  4  0
MemTotal:       513060 kB
MemFree:          3580 kB
Buffers:        215240 kB
Cached:          95640 kB
Active:         372108 kB
Inactive:       111524 kB
Dirty:            2396 kB
Slab:            20332 kB
dentry_cache        6981  13848    160   24    1 : tunables  240  120    0 : slabdata    577    577      0
 6  0  0      0   3132 215536  95956    0    0   384   142 1092  9009 96  4  0
MemTotal:       513060 kB
MemFree:          3132 kB
Buffers:        215536 kB
Cached:          95964 kB
Active:         371216 kB
Inactive:       113040 kB
Dirty:            2888 kB
Slab:            20328 kB
 4  1  0      0   3180 215376  96120    0    0   385   134 1120  8516 96  4  0
 7  0  0      0   3892 214932  95792    0    0   307   122 1133  9362 95  5  0
dentry_cache        7045  13848    160   24    1 : tunables  240  120    0 : slabdata    577    577      0
 3  0  0      0   3252 215608  95836    0    0   384   157 1090  9001 96  4  0
MemTotal:       513060 kB
MemFree:          3132 kB
Buffers:        215248 kB
Cached:          96364 kB
Active:         373324 kB
Inactive:       111048 kB
Dirty:            1372 kB
Slab:            20160 kB
dentry_cache        6986  13848    160   24    1 : tunables  240  120    0 : slabdata    577    577      0
 4  0  0      0   3132 215248  96364    0    0   486   121 1013  9666 96  4  0
MemTotal:       513060 kB
MemFree:          3580 kB
Buffers:        214292 kB
Cached:          96856 kB
Active:         371812 kB
Inactive:       112104 kB
Dirty:            1988 kB
Slab:            20132 kB
dentry_cache        6973  13824    160   24    1 : tunables  240  120    0 : slabdata    576    576      0
 4  0  0      0   3516 214292  96868    0    0   385   142 1016  9716 96  4  0
 5  0  0      0   3132 214212  97448    0    0   384    97 1012  9989 95  5  0
MemTotal:       513060 kB
MemFree:          3132 kB
Buffers:        214212 kB
Cached:          97448 kB
Active:         378272 kB
Inactive:       106156 kB
Dirty:            2596 kB
Slab:            20136 kB
dentry_cache        6973  13824    160   24    1 : tunables  240  120    0 : slabdata    576    576      0
 7  0  0      0   3516 213268  98032    0    0   384   122 1053  9592 96  4  0
MemTotal:       513060 kB
MemFree:          3068 kB
Buffers:        213652 kB
Cached:          98136 kB
Active:         376808 kB
Inactive:       107752 kB
Dirty:            3264 kB
Slab:            20084 kB
dentry_cache        6925  13824    160   24    1 : tunables  240  120    0 : slabdata    576    576      0
 4  0  0      0   3068 213220  98620    0    0   384   229 1011  9324 96  4  0
MemTotal:       513060 kB
MemFree:          3196 kB
Buffers:        213064 kB
Cached:          98668 kB
Active:         375136 kB
Inactive:       109364 kB
Dirty:             272 kB
Slab:            20056 kB
dentry_cache        6877  13824    160   24    1 : tunables  240  120    0 : slabdata    576    576      0
 5  0  0      0   2940 214224  97712    0    0   487    75 1015 10150 96  4  0
MemTotal:       513060 kB
MemFree:          3580 kB
Buffers:        213572 kB
Cached:          97676 kB
Active:         380592 kB
Inactive:       103428 kB
Dirty:             856 kB
Slab:            20048 kB
dentry_cache        6877  13824    160   24    1 : tunables  240  120    0 : slabdata    576    576      0
 5  0  0      0   4284 212984  97660    0    0   358   141 1011  9356 96  4  0
MemTotal:       513060 kB
MemFree:          3452 kB
Buffers:        213752 kB
Cached:          97768 kB
Active:         379736 kB
Inactive:       104556 kB
Dirty:            1516 kB
Slab:            20004 kB
dentry_cache        6829  13800    160   24    1 : tunables  240  120    0 : slabdata    575    575      0
 5  0  0      0   3132 213588  98224    0    0   486   133 1025  9466 97  3  0
MemTotal:       513060 kB
MemFree:          3004 kB
Buffers:        213596 kB
Cached:          98344 kB
Active:         378700 kB
Inactive:       106016 kB
Dirty:            2160 kB
Slab:            19972 kB
dentry_cache        6781  13800    160   24    1 : tunables  240  120    0 : slabdata    575    575      0
 3  0  0      0   3452 212884  98568    0    0   385   111 1034  9482 96  4  0
 5  1  0      0   3196 212700  99124    0    0   384   139 1011 10499 96  4  0
MemTotal:       513060 kB
MemFree:          3132 kB
Buffers:        212700 kB
Cached:          99124 kB
Active:         383052 kB
Inactive:       101552 kB
Dirty:            3236 kB
Slab:            19976 kB
dentry_cache        6733  13800    160   24    1 : tunables  240  120    0 : slabdata    575    575      0
   procs                      memory      swap          io     system      cpu
 r  b  w   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id
 4  0  0      0   3580 211712  99664    0    0   384   271 1057  9218 96  4  0
MemTotal:       513060 kB
MemFree:          3580 kB
Buffers:        211712 kB
Cached:          99676 kB
Active:         381532 kB
Inactive:       102636 kB
Dirty:             180 kB
Slab:            19904 kB
dentry_cache        6721  13800    160   24    1 : tunables  240  120    0 : slabdata    575    575      0
 5  0  0      0   3060 211684 100180    0    0   386   149 1010  9284 97  3  0
MemTotal:       513060 kB
MemFree:          3060 kB
Buffers:        211688 kB
Cached:         100180 kB
Active:         380560 kB
Inactive:       104176 kB
Dirty:             844 kB
Slab:            19912 kB
dentry_cache        6835  13800    160   24    1 : tunables  240  120    0 : slabdata    575    575      0
 4  0  0      0   3636 211812  99488    0    0   389   142 1009  9396 96  4  0
MemTotal:       513060 kB
MemFree:          3636 kB
Buffers:        211812 kB
Cached:          99504 kB
Active:         383504 kB
Inactive:       100596 kB
Dirty:            1452 kB
Slab:            19912 kB
dentry_cache        6835  13800    160   24    1 : tunables  240  120    0 : slabdata    575    575      0
 5  0  0      0   3812 211472  99664    0    0   307   117 1179  9565 95  5  0
MemTotal:       513060 kB
MemFree:          3812 kB
Buffers:        211472 kB
Cached:          99684 kB
Active:         385308 kB
Inactive:        98632 kB
Dirty:            1980 kB
Slab:            19976 kB
dentry_cache        6787  13800    160   24    1 : tunables  240  120    0 : slabdata    575    575      0
 4  0  0      0   3396 212056  99884    0    0   461   118 1036  9283 96  4  0

