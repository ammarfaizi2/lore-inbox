Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030260AbWIFXyB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030260AbWIFXyB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 19:54:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030261AbWIFXyA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 19:54:00 -0400
Received: from ug-out-1314.google.com ([66.249.92.172]:13746 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1030260AbWIFXx5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 19:53:57 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=hbx0MnnPg6e2Dozm629Z6ljISyx5gRlFnFUXHV4a0qkpEm4vPkVOYLCOjJcGWDKb1QuQAlH+vhiMbv7MUHSbVzLUOXM8xSN7MZC+dATdsf6EcYvdjyfHLy+SzXGRG5OoLkTrMSBJEpQIOTaJOtESbOFOB/0J60ygOFarq57itfk=
Message-ID: <6b4e42d10609061653p608a2947g1943b3d752855dfe@mail.gmail.com>
Date: Wed, 6 Sep 2006 16:53:55 -0700
From: "Om Narasimhan" <om.turyx@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: what is the expected behaviour under extreme high load.
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I am running a stress test on my SunFire 4600 (8x2core, 64G) using the
mem_test available from
http://carpanta.dc.fi.udc.es/~quintela/memtest. I am using SuSE
enterprise 9 SP3.

I am wondering what is the expected behaviour of a machine under
extreme VM stress.
When I stress the system to the limits, it practically becomes
unresponsive. It runs for almost half an hour and then it crashes
because of a CPU lockup.

Any pointers from where I can start debugging this issue?

>From top,
load average: 190.70, 132.45, 60.43
# cat /proc/sys/vm/overcommit_memory
0

The final crashing message on the ser. console is,

Active:14191667 inactive:1947580 dirty:0 writeback:0 unstable:0
free:6484 slab:5724 mapped:16141523 pagetables:169329
Node 7 DMA free:0kB min:0kB low:0kB high:0kB active:0kB inactive:0kB
present:0kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 8191 8191
Node 7 Normal free:1732kB min:2048kB low:4096kB high:6144kB
active:7994996kB inactive:24532kB present:8388604kB
pages_scanned:5761247 all_unreclaimable? yes
lowmem_reserve[]: 0 0 0
Node 7 HighMem free:0kB min:128kB low:256kB high:384kB active:0kB
inactive:0kB present:0kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0
Node 6 DMA free:0kB min:0kB low:0kB high:0kB active:0kB inactive:0kB
present:0kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 8191 8191
Node 6 Normal free:1956kB min:2048kB low:4096kB high:6144kB
active:1159424kB inactive:7001172kB present:8388604kB
pages_scanned:13111204 all_unreclaimable? yes
lowmem_reserve[]: 0 0 0
Node 6 HighMem free:0kB min:128kB low:256kB high:384kB active:0kB
inactive:0kB present:0kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0
Node 5 DMA free:0kB min:0kB low:0kB high:0kB active:0kB inactive:0kB
present:0kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 8191 8191
Node 5 Normal free:1988kB min:2048kB low:4096kB high:6144kB
active:6999360kB inactive:1172952kB present:8388604kB
pages_scanned:53653526 all_unreclaimable? no
lowmem_reserve[]: 0 0 0
Node 5 HighMem free:0kB min:128kB low:256kB high:384kB active:0kB
inactive:0kB present:0kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0
Node 4 DMA free:0kB min:0kB low:0kB high:0kB active:0kB inactive:0kB
present:0kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 8191 8191
Node 4 Normal free:2032kB min:2048kB low:4096kB high:6144kB
active:8122000kB inactive:35028kB present:8388604kB
pages_scanned:24604282 all_unreclaimable? yes
lowmem_reserve[]: 0 0 0
Node 4 HighMem free:0kB min:128kB low:256kB high:384kB active:0kB
inactive:0kB present:0kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0
Node 3 DMA free:0kB min:0kB low:0kB high:0kB active:0kB inactive:0kB
present:0kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 8191 8191
Node 3 Normal free:2044kB min:2048kB low:4096kB high:6144kB
active:8125544kB inactive:7352kB present:8388604kB
pages_scanned:7673160 all_unreclaimable? yes
lowmem_reserve[]: 0 0 0
Node 3 HighMem free:0kB min:128kB low:256kB high:384kB active:0kB
inactive:0kB present:0kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0
Node 2 DMA free:0kB min:0kB low:0kB high:0kB active:0kB inactive:0kB
present:0kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 8191 8191
Node 2 Normal free:1968kB min:2048kB low:4096kB high:6144kB
active:8156208kB inactive:12440kB present:8388604kB
pages_scanned:7651429 all_unreclaimable? yes
lowmem_reserve[]: 0 0 0
Node 2 HighMem free:0kB min:128kB low:256kB high:384kB active:0kB
inactive:0kB present:0kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0
Node 1 DMA free:0kB min:0kB low:0kB high:0kB active:0kB inactive:0kB
present:0kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 8191 8191
Node 1 Normal free:2036kB min:2048kB low:4096kB high:6144kB
active:8154368kB inactive:3316kB present:8388604kB
pages_scanned:4589167 all_unreclaimable? yes
lowmem_reserve[]: 0 0 0
Node 1 HighMem free:0kB min:128kB low:256kB high:384kB active:0kB
inactive:0kB present:0kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0
Node 0 DMA free:10264kB min:4kB low:8kB high:12kB active:0kB
inactive:0kB present:16384kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 8175 8175
Node 0 Normal free:1916kB min:2040kB low:4080kB high:6120kB
active:7587780kB inactive:4kB present:8372220kB pages_scanned:4402368
all_unreclaimable? yes
lowmem_reserve[]: 0 0 0
Node 0 HighMem free:0kB min:128kB low:256kB high:384kB active:0kB
inactive:0kB present:0kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0
Node 7 DMA: empty
Node 7 Normal: 17*4kB 10*8kB 1*16kB 1*32kB 0*64kB 2*128kB 1*256kB
0*512kB 1*1024kB 0*2048kB 0*4096kB = 1732kB
Node 7 HighMem: empty
Node 6 DMA: empty
Node 6 Normal: 1*4kB 16*8kB 8*16kB 1*32kB 0*64kB 1*128kB 2*256kB
0*512kB 1*1024kB 0*2048kB 0*4096kB = 1956kB
Node 6 HighMem: empty
Node 5 DMA: empty
Node 5 Normal: 5*4kB 16*8kB 23*16kB 0*32kB 1*64kB 1*128kB 1*256kB
0*512kB 1*1024kB 0*2048kB 0*4096kB = 1988kB
Node 5 HighMem: empty
Node 4 DMA: empty
Node 4 Normal: 0*4kB 16*8kB 13*16kB 5*32kB 2*64kB 1*128kB 1*256kB
0*512kB 1*1024kB 0*2048kB 0*4096kB = 2032kB
Node 4 HighMem: empty
Node 3 DMA: empty
Node 3 Normal: 75*4kB 12*8kB 3*16kB 4*32kB 1*64kB 1*128kB 1*256kB
0*512kB 1*1024kB 0*2048kB 0*4096kB = 2044kB
Node 3 HighMem: empty
Node 2 DMA: empty
Node 2 Normal: 0*4kB 0*8kB 1*16kB 9*32kB 0*64kB 1*128kB 0*256kB
1*512kB 1*1024kB 0*2048kB 0*4096kB = 1968kB
Node 2 HighMem: empty
Node 1 DMA: empty
Node 1 Normal: 81*4kB 16*8kB 3*16kB 2*32kB 1*64kB 1*128kB 1*256kB
0*512kB 1*1024kB 0*2048kB 0*4096kB = 2036kB
Node 1 HighMem: empty
Node 0 DMA: 0*4kB 1*8kB 1*16kB 2*32kB 3*64kB 2*128kB 0*256kB 1*512kB
1*1024kB 0*2048kB 2*4096kB = 10264kB
Node 0 Normal: 1*4kB 1*8kB 1*16kB 1*32kB 1*64kB 0*128kB 3*256kB
0*512kB 1*1024kB 0*2048kB 0*4096kB = 1916kB
Node 0 HighMem: empty
Swap cache: add 274845, delete 274813, find 322/1666, race 1+1
Free swap:            0kB
16777208 pages of RAM
430115 reserved pages
69705619 pages shared
32 pages swap cached
Out of Memory: Killed process 12726 (mtest).
NMI Watchdog detected LOCKUP on CPU14, registers:
CPU 14
Pid: 12756, comm: mtest Tainted: G   U   (2.6.5-7.244-smp-dbg )
RIP: 0010:[<ffffffff80180342>] <ffffffff80180342>{.text.lock.vmscan+18}
RSP: 0000:0000010dfbd31a38  EFLAGS: 00000082
RAX: 0000010603945a10 RBX: 0000000000000000 RCX: 0000010601cb7128
RDX: 0000010dfbd31b48 RSI: 0000010600004408 RDI: 0000000000000000
RBP: 0000010600004380 R08: 0000000000000001 R09: 0000000000000001
R10: 0000000000000064 R11: 0000000000000080 R12: 0000010600004380
R13: 0000010600004400 R14: 0000010dfbd31b48 R15: 0000010dfbd31b28
FS:  0000002a95894b00(0000) GS:ffffffff80610c80(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: 0000002ae2f57010 CR3: 00000001fff2d000 CR4: 00000000000006e0
Process mtest (pid: 12756, threadinfo 0000010dfbd30000, task 0000010dfede0280)
Stack: 0000000000000000 0000000100000000 0000010dfbd31c08 0000008000000246
       0000000000000246 0000000000000246 0000010dfede0280 0000000000000286
       0000010975a5ad30 ffffffff805353e0
Call Trace:<ffffffff8017f5c2>{shrink_zone+226}
<ffffffff8017fed8>{try_to_free_pages+280}
       <ffffffff80140cb0>{autoremove_wake_function+0}
<ffffffff80174a0f>{__alloc_pages+559}
       <ffffffff80185393>{handle_mm_fault+2323}
<ffffffff80123e80>{do_page_fault+0}
       <ffffffff80124054>{do_page_fault+468} <ffffffff8013be17>{thread_return+0}
       <ffffffff80111465>{error_exit+0}

Code: 80 bd 80 00 00 00 00 7e f5 e9 29 df ff ff f3 90 80 bd 80 00
console shuts up ...
