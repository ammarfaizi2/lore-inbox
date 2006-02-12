Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932078AbWBLLvh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932078AbWBLLvh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Feb 2006 06:51:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932385AbWBLLvh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Feb 2006 06:51:37 -0500
Received: from lucidpixels.com ([66.45.37.187]:6846 "EHLO lucidpixels.com")
	by vger.kernel.org with ESMTP id S932078AbWBLLvg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Feb 2006 06:51:36 -0500
Date: Sun, 12 Feb 2006 06:51:20 -0500 (EST)
From: Justin Piszcz <jpiszcz@lucidpixels.com>
X-X-Sender: jpiszcz@p34
To: linux-kernel@vger.kernel.org
Subject: Kernel Crash Debugging Help - From Sysrq output.
Message-ID: <Pine.LNX.4.64.0602120647030.19529@p34>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a dual CPU 3.06GHZ box that keeps freezing after 5-7 days, via 
SYSRQ I get the following information under a RHEL AS3/2.4 kernel.

Any idea what could be wrong?  Nothing useful shows up in dmesg or the 
kernel logs.

wait_on_irq, CPU 1:
irq:  0 [ 0 0 ]
bh:   1 [ 1 0 ]
Stack dumps:
CPU 0: <unknown>
CPU 1:c6a43f14 c029ec93 00000001 00000000 ffffffff 00000001 c6a43f44
c010a622
        c029eca8 00000000 f6fcc000 00000001 c6a43f60 c01b39bf f6fcc568
f6fcc168
        c02f1324 c6a43f6c c6a42594 c6a43f7c c011fc8f f6fcc000 f6fcc130
c02f1324
Call Trace:    [<c010a622>] [<c01b39bf>] [<c011fc8f>] [<c0128b97>]
[<c0128a50>]
   [<c0105000>] [<c01073f6>] [<c0128a50>]

SysRq : Show Regs

Pid: 2, comm:              keventd
EIP: 0010:[<c010a625>] CPU: 1 EFLAGS: 00000286    Not tainted
EAX: 00000000 EBX: 00000000 ECX: 00000000 EDX: 00000000
ESI: bc011900 EDI: 00000001 EBP: c6a43f44 DS: 0018 ES: 0018
CR0: 8005003b CR2: 08727604 CR3: 36f8f2e0 CR4: 000006f0
Call Trace:    [<c01b39bf>] [<c011fc8f>] [<c0128b97>] [<c0128a50>]
[<c0105000>]
   [<c01073f6>] [<c0128a50>]

SysRq : Show Memory
Mem-info:
Free pages:      4975396kB (4495236kB HighMem)
Zone:DMA freepages: 13248kB min:  4224kB low:  4352kB high:  4480
kBZone:Normal freepages:466912kB min:  5116kB low: 18176kB high: 25216
kBZone:HighMem freepages:4495236kB min:  1020kB low: 83960kB high:125940
kB( Active: 85802/106289, inactive_laundry: 5363, inactive_clean: 0,
free: 12438
49 )
6*4kB 3*8kB 5*16kB 2*32kB 6*64kB 3*128kB 2*256kB 1*512kB 1*1024kB
5*2048kB = 132
48kB)
0*4kB 14*8kB 1*16kB 1*32kB 1*64kB 0*128kB 1*256kB 1*512kB 1*1024kB
227*2048kB =
466912kB)
307*4kB 205*8kB 81*16kB 32*32kB 13*64kB 2*128kB 25*256kB 17*512kB
5*1024kB 2182*
2048kB = 4495236kB)
Swap cache: add 0, delete 0, find 0/0, race 0+0
Free swap:       2097112kB
1572863 pages of RAM
1277945 pages of HIGHMEM
89384 reserved pages
185929 pages shared
0 pages swap cached

