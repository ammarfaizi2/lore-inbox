Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964794AbWDCK7s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964794AbWDCK7s (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Apr 2006 06:59:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964797AbWDCK7r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Apr 2006 06:59:47 -0400
Received: from mail01.hansenet.de ([213.191.73.61]:13549 "EHLO
	webmail.hansenet.de") by vger.kernel.org with ESMTP id S964794AbWDCK7r
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Apr 2006 06:59:47 -0400
Message-ID: <4431001C.5080905@e-dict.net>
Date: Mon, 03 Apr 2006 12:59:40 +0200
From: Ingo Freund <Ingo.Freund@e-dict.net>
Reply-To: linux-kernel-news@e-dict.net
Organization: e-dict GmbH & Co. KG
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: de-DE, de, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: out of memory
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

on our database machine with 4 GB RAM and 2 XEON CPUs I got the
following kernel messages.
There are 2 GB RAM declared as shared memory for database usage.
Can anybody explain to me what happened and -may be- why?


Apr  2 10:55:09 widbrz01 kernel: oom-killer: gfp_mask=0xd0, order=0
Apr  2 10:55:09 widbrz01 kernel: Mem-info:
Apr  2 10:55:09 widbrz01 kernel: DMA per-cpu:
Apr  2 10:55:09 widbrz01 kernel: cpu 0 hot: low 2, high 6, batch 1 used:2
Apr  2 10:55:09 widbrz01 kernel: cpu 0 cold: low 0, high 2, batch 1 used:1
Apr  2 10:55:09 widbrz01 kernel: cpu 1 hot: low 2, high 6, batch 1 used:2
Apr  2 10:55:09 widbrz01 kernel: cpu 1 cold: low 0, high 2, batch 1 used:1
Apr  2 10:55:09 widbrz01 kernel: cpu 2 hot: low 2, high 6, batch 1 used:2
Apr  2 10:55:09 widbrz01 kernel: cpu 2 cold: low 0, high 2, batch 1 used:1
Apr  2 10:55:09 widbrz01 kernel: cpu 3 hot: low 2, high 6, batch 1 used:2
Apr  2 10:55:09 widbrz01 kernel: cpu 3 cold: low 0, high 2, batch 1 used:1
Apr  2 10:55:09 widbrz01 kernel: Normal per-cpu:
Apr  2 10:55:09 widbrz01 kernel: cpu 0 hot: low 62, high 186, batch 31 used:174
Apr  2 10:56:10 widbrz01 kernel: cpu 0 cold: low 0, high 62, batch 31 used:52
Apr  2 10:56:10 widbrz01 kernel: cpu 1 hot: low 62, high 186, batch 31 used:86
Apr  2 10:56:10 dbm kernel: cpu 1 cold: low 0, high 62, batch 31 used:47
Apr  2 10:56:10 dbm kernel: cpu 2 hot: low 62, high 186, batch 31 used:107
Apr  2 10:56:10 dbm kernel: cpu 2 cold: low 0, high 62, batch 31 used:31
Apr  2 10:56:10 dbm kernel: cpu 3 hot: low 62, high 186, batch 31 used:71
Apr  2 10:56:10 dbm kernel: cpu 3 cold: low 0, high 62, batch 31 used:39
Apr  2 10:56:10 dbm kernel: HighMem per-cpu:
Apr  2 10:56:10 dbm kernel: cpu 0 hot: low 62, high 186, batch 31 used:124
Apr  2 10:56:10 dbm kernel: cpu 0 cold: low 0, high 62, batch 31 used:46
Apr  2 10:56:10 dbm kernel: cpu 1 hot: low 62, high 186, batch 31 used:93
Apr  2 10:56:10 dbm kernel: cpu 1 cold: low 0, high 62, batch 31 used:47
Apr  2 10:56:10 dbm kernel: cpu 2 hot: low 62, high 186, batch 31 used:160
Apr  2 10:56:10 dbm kernel: cpu 2 cold: low 0, high 62, batch 31 used:50
Apr  2 10:56:10 dbm kernel: cpu 3 hot: low 62, high 186, batch 31 used:87
Apr  2 10:56:10 dbm kernel: cpu 3 cold: low 0, high 62, batch 31 used:31
Apr  2 10:56:10 dbm kernel: Free pages:        7608kB (868kB HighMem)
Apr  2 10:56:10 dbm kernel: Active:401296 inactive:416067 dirty:76506 writeback:14 unstable:0 free:1902 slab:8550 mapped:399275
pagetables:20137
Apr  2 10:56:10 dbm kernel: DMA free:3572kB min:68kB low:84kB high:100kB active:0kB inactive:0kB present:16384kB pages_scanned:4
all_unreclaimable? yes
Apr  2 10:56:10 dbm kernel: lowmem_reserve[]: 0 880 6128
Apr  2 10:56:10 dbm kernel: Normal free:3168kB min:3756kB low:4692kB high:5632kB active:700kB inactive:548kB present:901120kB
pages_scanned:1488 all_unreclaimable? yes
Apr  2 10:56:10 dbm kernel: lowmem_reserve[]: 0 0 41984
Apr  2 10:56:10 dbm kernel: HighMem free:868kB min:512kB low:640kB high:768kB active:1604484kB inactive:1663720kB present:5373952kB
pages_scanned:0 all_unreclaimable? no
Apr  2 10:56:10 dbm kernel: lowmem_reserve[]: 0 0 0
Apr  2 10:56:10 dbm kernel: DMA: 1*4kB 0*8kB 1*16kB 1*32kB 1*64kB 1*128kB 1*256kB 0*512kB 1*1024kB 1*2048kB 0*4096kB = 3572kB
Apr  2 10:56:10 dbm kernel: Normal: 88*4kB 4*8kB 0*16kB 1*32kB 1*64kB 1*128kB 0*256kB 1*512kB 0*1024kB 1*2048kB 0*4096kB = 3168kB
Apr  2 10:56:10 dbm kernel: HighMem: 5*4kB 4*8kB 3*16kB 2*32kB 3*64kB 2*128kB 1*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 868kB
Apr  2 10:56:10 dbm kernel: Swap cache: add 1, delete 1, find 0/0, race 0+0
Apr  2 10:56:10 dbm kernel: Free swap  = 4209004kB
Apr  2 10:56:10 dbm kernel: Total swap = 4209008kB
Apr  2 10:56:10 dbm kernel: Free swap:       4209004kB
Apr  2 10:56:10 dbm kernel: klogd 1.4.1, ---------- state change ----------
Apr  2 10:56:11 dbm kernel: Inspecting /boot/System.map-2.6.13.2
Apr  2 10:56:11 dbm kernel: Loaded 28714 symbols from /boot/System.map-2.6.13.2.
Apr  2 10:56:11 dbm kernel: Symbols match kernel version 2.6.13.
Apr  2 10:56:11 dbm kernel: No module symbols loaded - kernel modules not enabled.
Apr  2 10:56:11 dbm kernel: 1572864 pages of RAM
Apr  2 10:56:11 dbm kernel: 1343488 pages of HIGHMEM
Apr  2 10:56:11 dbm kernel: 538120 reserved pages
Apr  2 10:56:11 dbm kernel: 10551624 pages shared
Apr  2 10:56:11 dbm kernel: 0 pages swap cached
Apr  2 10:56:11 dbm kernel: 63038 pages dirty
Apr  2 10:56:11 dbm kernel: 14 pages writeback
Apr  2 10:56:11 dbm kernel: 399275 pages mapped
Apr  2 10:56:11 dbm kernel: 8538 pages slab
Apr  2 10:56:11 dbm kernel: 20137 pages pagetables
Apr  2 10:56:11 dbm kernel: Out of Memory: Killed process 18250 (db:SBWI).


Thanks,
Ingo.
