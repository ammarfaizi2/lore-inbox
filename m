Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262814AbUDAKUy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 05:20:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262826AbUDAKUy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 05:20:54 -0500
Received: from lindsey.linux-systeme.com ([62.241.33.80]:32776 "EHLO
	mx00.linux-systeme.com") by vger.kernel.org with ESMTP
	id S262814AbUDAKUt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 05:20:49 -0500
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
Organization: Working Overloaded Linux Kernel
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.5-rc3-aa1
Date: Thu, 1 Apr 2004 12:21:21 +0200
User-Agent: KMail/1.6.1
Cc: Bongani Hlope <bonganilinux@mweb.co.za>, Andrea Arcangeli <andrea@suse.de>
References: <20040331030921.GA2143@dualathlon.random> <20040331211620.19a8f725@bongani> <200404011157.33051@WOLK>
In-Reply-To: <200404011157.33051@WOLK>
X-Operating-System: Linux 2.6.4-wolk2.3 i686 GNU/Linux
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200404011221.21476@WOLK>
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 01 April 2004 11:57, Marc-Christian Petersen wrote:

Hi again,

> > I'm running 2.6.5-rc2-aa4, when I woke-up in the morning almost all of my
> > memory was gone, but my swap was never touched. I managed to get only the
> > output of SysRq-M before it hard-locked. For some reason it doesn't swap.
> > I'll try to reproduce.

> hmm, I am running 2.6.5-rc3-aa1 stuff ontop of 2.6.5-rc3-mm3. It works very
> well. What is the value of /proc/sys/vm/swappiness?

I really manage it to forget something again and again ;(

SysRq : Show Memory
Mem-info:
DMA per-cpu:
cpu 0 hot: low 2, high 6, batch 1
cpu 0 cold: low 0, high 2, batch 1
Normal per-cpu:
cpu 0 hot: low 32, high 96, batch 16
cpu 0 cold: low 0, high 32, batch 16
HighMem per-cpu:
cpu 0 hot: low 14, high 42, batch 7
cpu 0 cold: low 0, high 14, batch 7

Free pages: 14380kB (252kB HighMem)
Active:149756 inactive:45587 dirty:47 writeback:0 unstable:0 free:3595
DMA free:2280kB min:16kB low:32kB high:48kB active:1316kB inactive:5876kB 
present:16384kB
protections[]: 8 476 540
Normal free:11848kB min:936kB low:1872kB high:2808kB active:494812kB 
inactive:155796kB present:901120kB
protections[]: 0 468 532
HighMem free:252kB min:128kB low:256kB high:384kB active:102896kB 
inactive:20676kB present:130992kB
protections[]: 0 0 64
DMA: 28*4kB 1*8kB 15*16kB 2*32kB 1*64kB 0*128kB 1*256kB 1*512kB 1*1024kB 
0*2048kB 0*4096kB = 2280kB
Normal: 2222*4kB 110*8kB 0*16kB 3*32kB 1*64kB 1*128kB 1*256kB 1*512kB 1*1024kB 
0*2048kB 0*4096kB = 11848kB
HighMem: 1*4kB 1*8kB 1*16kB 1*32kB 1*64kB 1*128kB 0*256kB 0*512kB 0*1024kB 
0*2048kB 0*4096kB = 252kB
Swap cache: add 281, delete 281, find 28/28, race 0+0
Free swap: 986944kB
262124 pages of RAM
32748 pages of HIGHMEM
2864 reserved pages
159610 pages shared
0 pages swap cached



cat /proc/meminfo 
MemTotal:      1037272 kB
MemFree:         12096 kB
Buffers:         29640 kB
Cached:         512264 kB
SwapCached:          0 kB
Active:         600180 kB
Inactive:       183568 kB
HighTotal:      130992 kB
HighFree:          616 kB
LowTotal:       906280 kB
LowFree:         11480 kB
SwapTotal:      987956 kB
SwapFree:       986944 kB
Dirty:             740 kB
Writeback:           0 kB
Mapped:         328296 kB
Slab:           226804 kB
Committed_AS:   446724 kB
PageTables:       4104 kB
VmallocTotal:   106488 kB
VmallocUsed:     23068 kB
VmallocChunk:    83260 kB
HugePages_Total:     0
HugePages_Free:      0
Hugepagesize:     4096 kB


uptime
 12:12:41 up 16:24,  6 users,  load average: 1.03, 1.07, 1.36


cat /proc/sys/vm/swappiness 
48

ciao, Marc
