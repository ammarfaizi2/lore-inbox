Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261864AbUB1O4c (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Feb 2004 09:56:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261869AbUB1O4c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Feb 2004 09:56:32 -0500
Received: from village.ehouse.ru ([193.111.92.18]:26131 "EHLO mail.ehouse.ru")
	by vger.kernel.org with ESMTP id S261864AbUB1O4R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Feb 2004 09:56:17 -0500
From: "Sergey S. Kostyliov" <rathamahata@php4.ru>
Reply-To: "Sergey S. Kostyliov" <rathamahata@php4.ru>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.1 IO lockup on SMP systems
Date: Sat, 28 Feb 2004 17:56:08 +0300
User-Agent: KMail/1.6
Cc: linux-kernel@vger.kernel.org, gluk@php4.ru, anton@megashop.ru,
       mfedyk@matchmail.com
References: <200401311940.28078.rathamahata@php4.ru> <200402261730.51874.rathamahata@php4.ru> <20040226120310.037a6702.akpm@osdl.org>
In-Reply-To: <20040226120310.037a6702.akpm@osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200402281756.08260.rathamahata@php4.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 26 February 2004 23:03, Andrew Morton wrote:
<cut>
> OK, thanks.  Is there any possibility that you can run without iptables for
> a while, see if that fixes it?

I recompiled 2.6.3 without iptables support, unfortunately it doesn't
solve the problem, machine still hangs.

1) sysrq-M:

SysRq : Show Memory
Mem-info:
DMA per-cpu:
cpu 0 hot: low 2, high 6, batch 1
cpu 0 cold: low 0, high 2, batch 1
cpu 1 hot: low 2, high 6, batch 1
cpu 1 cold: low 0, high 2, batch 1
Normal per-cpu:
cpu 0 hot: low 32, high 96, batch 16
cpu 0 cold: low 0, high 32, batch 16
cpu 1 hot: low 32, high 96, batch 16
cpu 1 cold: low 0, high 32, batch 16
HighMem per-cpu:
cpu 0 hot: low 32, high 96, batch 16
cpu 0 cold: low 0, high 32, batch 16
cpu 1 hot: low 32, high 96, batch 16
cpu 1 cold: low 0, high 32, batch 16

Free pages:        3276kB (512kB HighMem)
Active:820 inactive:195 dirty:0 writeback:0 unstable:0 free:819
DMA free:1348kB min:16kB low:32kB high:48kB active:316kB inactive:0kB
Normal free:1416kB min:936kB low:1872kB high:2808kB active:1388kB inactive:348kB
HighMem free:512kB min:512kB low:1024kB high:1536kB active:1604kB inactive:404kB
DMA: 75*4kB 69*8kB 21*16kB 3*32kB 1*64kB 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 1348kB
Normal: 98*4kB 20*8kB 0*16kB 1*32kB 1*64kB 0*128kB 1*256kB 1*512kB 0*1024kB 0*2048kB 0*4096kB = 1416kB
HighMem: 0*4kB 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 2*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 512kB
Swap cache: add 342862, delete 342774, find 15349/23980, race 14+29
Free swap:       2473044kB
524288 pages of RAM
294912 pages of HIGHMEM
5814 reserved pages
899 pages shared
89 pages swap cached

2) /proc/meminfo before a lockup
Sat Feb 28 06:42:33 MSK 2004
MemTotal:      2073896 kB
MemFree:          3452 kB
Buffers:          2240 kB
Cached:          29648 kB
SwapCached:      21084 kB
Active:         627896 kB
Inactive:        17340 kB
HighTotal:     1179648 kB
HighFree:          576 kB
LowTotal:       894248 kB
LowFree:          2876 kB
SwapTotal:     3583968 kB
SwapFree:      3095996 kB
Dirty:               0 kB
Writeback:       14104 kB
Mapped:         625540 kB
Slab:            19044 kB
Committed_AS:  1767368 kB
PageTables:       4316 kB
VmallocTotal:   114680 kB
VmallocUsed:      7448 kB
VmallocChunk:   107232 kB

-- 
                   Best regards,
                   Sergey S. Kostyliov <rathamahata@php4.ru>
                   Public PGP key: http://sysadminday.org.ru/rathamahata.asc
