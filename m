Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261213AbVAWJ43@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261213AbVAWJ43 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Jan 2005 04:56:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261268AbVAWJ43
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Jan 2005 04:56:29 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:19331 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261213AbVAWJ4T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Jan 2005 04:56:19 -0500
Date: Sun, 23 Jan 2005 10:56:08 +0100
From: Jens Axboe <axboe@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: alexn@dsv.su.se, kas@fi.muni.cz, linux-kernel@vger.kernel.org
Subject: Re: Memory leak in 2.6.11-rc1?
Message-ID: <20050123095608.GD16648@suse.de>
References: <20050121161959.GO3922@fi.muni.cz> <1106360639.15804.1.camel@boxen> <20050123091154.GC16648@suse.de> <20050123011918.295db8e8.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="0ntfKIWw70PvrIHh"
Content-Disposition: inline
In-Reply-To: <20050123011918.295db8e8.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--0ntfKIWw70PvrIHh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Jan 23 2005, Andrew Morton wrote:
> Jens Axboe <axboe@suse.de> wrote:
> >
> >  This is after 2 days of uptime, the box is basically unusable.
> 
> hm, no indication where it all went.

Nope, that's the annoying part.

> Does the machine still page properly?  Can you do a couple of monster
> usemems or fillmems to page everything out, then take another look at
> meminfo and the sysrq-M output?

It seems so, yes. But I'm still stuck with all of my ram gone after a
600MB fillmem, half of it is just in swap.

Attaching meminfo and sysrq-m after fillmem.

-- 
Jens Axboe


--0ntfKIWw70PvrIHh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=meminfo

MemTotal:      1022372 kB
MemFree:        383824 kB
Buffers:           908 kB
Cached:          29468 kB
SwapCached:      49912 kB
Active:         122232 kB
Inactive:        64228 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:      1022372 kB
LowFree:        383824 kB
SwapTotal:     1116476 kB
SwapFree:       437884 kB
Dirty:              44 kB
Writeback:           0 kB
Mapped:         130812 kB
Slab:            21948 kB
CommitLimit:   1627660 kB
Committed_AS:  1130368 kB
PageTables:       7884 kB
VmallocTotal: 34359738367 kB
VmallocUsed:      1152 kB
VmallocChunk: 34359737171 kB
HugePages_Total:     0
HugePages_Free:      0
Hugepagesize:     2048 kB

--0ntfKIWw70PvrIHh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=sysrq-m

SysRq : Show Memory
Mem-info:
DMA per-cpu:
cpu 0 hot: low 2, high 6, batch 1
cpu 0 cold: low 0, high 2, batch 1
Normal per-cpu:
cpu 0 hot: low 32, high 96, batch 16
cpu 0 cold: low 0, high 32, batch 16
HighMem per-cpu: empty

Free pages:      379280kB (0kB HighMem)
Active:31304 inactive:16430 dirty:80 writeback:0 unstable:0 free:94820 slab:5486 mapped:33169 pagetables:1987
DMA free:8632kB min:60kB low:72kB high:88kB active:120kB inactive:2076kB present:16384kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 1007 1007
Normal free:370648kB min:4028kB low:5032kB high:6040kB active:125096kB inactive:63644kB present:1031360kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0
HighMem free:0kB min:128kB low:160kB high:192kB active:0kB inactive:0kB present:0kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0
DMA: 414*4kB 220*8kB 54*16kB 10*32kB 1*64kB 1*128kB 1*256kB 1*512kB 1*1024kB 1*2048kB 0*4096kB = 8632kB
Normal: 36308*4kB 17473*8kB 4136*16kB 456*32kB 16*64kB 2*128kB 0*256kB 1*512kB 1*1024kB 1*2048kB 0*4096kB = 370648kB
HighMem: empty
Swap cache: add 301052, delete 288547, find 27582/38199, race 0+0
Free swap  = 437948kB
Total swap = 1116476kB
Free swap:       437948kB
261936 pages of RAM
6456 reserved pages
18505 pages shared
12505 pages swap cached

--0ntfKIWw70PvrIHh--
