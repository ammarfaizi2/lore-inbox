Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261787AbUKUTBj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261787AbUKUTBj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Nov 2004 14:01:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261789AbUKUTBj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Nov 2004 14:01:39 -0500
Received: from host-3.tebibyte16-2.demon.nl ([82.161.9.107]:45573 "EHLO
	doc.tebibyte.org") by vger.kernel.org with ESMTP id S261787AbUKUTBe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Nov 2004 14:01:34 -0500
Message-ID: <41A0E60C.605@tebibyte.org>
Date: Sun, 21 Nov 2004 20:01:32 +0100
From: Chris Ross <chris@tebibyte.org>
Organization: At home (Eindhoven, The Netherlands)
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: pt-br, pt
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: marcelo.tosatti@cyclades.com, andrea@novell.com,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       piggin@cyberone.com.au, riel@redhat.com,
       mmokrejs@ribosome.natur.cuni.cz, tglx@linutronix.de
Subject: Re: [PATCH] fix spurious OOM kills
References: <20041111112922.GA15948@logos.cnet>	<4193E056.6070100@tebibyte.org>	<4194EA45.90800@tebibyte.org>	<20041113233740.GA4121@x30.random>	<20041114094417.GC29267@logos.cnet>	<20041114170339.GB13733@dualathlon.random>	<20041114202155.GB2764@logos.cnet>	<419A2B3A.80702@tebibyte.org>	<419B14F9.7080204@tebibyte.org> <20041117012346.5bfdf7bc.akpm@osdl.org>
In-Reply-To: <20041117012346.5bfdf7bc.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Andrew Morton escreveu:
> Please ignore the previous patch and try the below.

I still get OOM kills with this (well one, anyway). It does seem harder 
to trigger though.

Regards,
Chris R.


Nov 20 03:24:46 sleepy cpu 0 hot: low 4, high 12, batch 2
Nov 20 03:24:46 sleepy cpu 0 cold: low 0, high 4, batch 2
Nov 20 03:24:46 sleepy HighMem per-cpu: empty
Nov 20 03:24:46 sleepy
Nov 20 03:24:46 sleepy Free pages:        1012kB (0kB HighMem)
Nov 20 03:24:46 sleepy Active:6290 inactive:6215 dirty:0 writeback:0 
unstable:0 free:253 slab:1324 mapped:1 pagetables:56
Nov 20 03:24:46 sleepy DMA free:252kB min:252kB low:312kB high:376kB 
active:5700
kB inactive:5540kB present:16384kB pages_scanned:15950 
all_unreclaimable? yes
Nov 20 03:24:46 sleepy protections[]: 0 0 0
Nov 20 03:24:46 sleepy Normal free:760kB min:764kB low:952kB high:1144kB 
active:19460kB inactive:19320kB present:49144kB pages_scanned:40497 
all_unreclaimabl
e? yes
Nov 20 03:24:46 sleepy protections[]: 0 0 0
Nov 20 03:24:46 sleepy HighMem free:0kB min:128kB low:160kB high:192kB 
active:0kB inactive:0kB present:0kB pages_scanned:0 all_unreclaimable? no
Nov 20 03:24:46 sleepy protections[]: 0 0 0
Nov 20 03:24:46 sleepy DMA: 3*4kB 4*8kB 3*16kB 1*32kB 2*64kB 0*128kB 
0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 252kB
Nov 20 03:24:46 sleepy Normal: 10*4kB 2*8kB 4*16kB 4*32kB 2*64kB 3*128kB 
0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 760kB
Nov 20 03:24:46 sleepy HighMem: empty
Nov 20 03:24:46 sleepy Swap cache: add 4076265, delete 4076262, find 
482017/1245636, race 1+9
Nov 20 03:24:46 sleepy Out of Memory: Killed process 6841 (sshd).
Nov 20 03:24:46 sleepy sshd: page allocation failure. order:0, mode:0x1d2
Nov 20 03:24:46 sleepy [<c010395b>] dump_stack+0x16/0x18
Nov 20 03:24:46 sleepy [<c0144859>] __alloc_pages+0x2fe/0x31a
Nov 20 03:24:46 sleepy [<c0146f2f>] do_page_cache_readahead+0x101/0x18d
Nov 20 03:24:46 sleepy [<c01407c4>] filemap_nopage+0x163/0x337
Nov 20 03:24:46 sleepy [<c015215d>] do_no_page+0x10f/0x534
Nov 20 03:24:46 sleepy [<c0152799>] handle_mm_fault+0xe2/0x261
Nov 20 03:24:46 sleepy [<c0114030>] do_page_fault+0x216/0x5d2
Nov 20 03:24:46 sleepy [<c01034ef>] error_code+0x2b/0x30
Nov 20 03:24:46 sleepy sshd: page allocation failure. order:0, mode:0xd2
Nov 20 03:24:46 sleepy [<c010395b>] dump_stack+0x16/0x18
Nov 20 03:24:46 sleepy [<c0144859>] __alloc_pages+0x2fe/0x31a
Nov 20 03:24:46 sleepy [<c015a3d6>] read_swap_cache_async+0x33/0xa5
Nov 20 03:24:46 sleepy [<c0151813>] swapin_readahead+0x3c/0x81
Nov 20 03:24:46 sleepy [<c0151920>] do_swap_page+0xc8/0x4c6
Nov 20 03:24:46 sleepy [<c01527c1>] handle_mm_fault+0x10a/0x261
Nov 20 03:24:46 sleepy [<c0114030>] do_page_fault+0x216/0x5d2
Nov 20 03:24:46 sleepy [<c01034ef>] error_code+0x2b/0x30
Nov 20 03:24:46 sleepy sshd: page allocation failure. order:0, mode:0xd2
Nov 20 03:24:46 sleepy [<c010395b>] dump_stack+0x16/0x18
Nov 20 03:24:46 sleepy [<c0144859>] __alloc_pages+0x2fe/0x31a
