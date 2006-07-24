Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751093AbWGXJkW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751093AbWGXJkW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jul 2006 05:40:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751111AbWGXJkW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jul 2006 05:40:22 -0400
Received: from ev1s-67-15-60-3.ev1servers.net ([67.15.60.3]:28084 "EHLO
	mail.aftek.com") by vger.kernel.org with ESMTP id S1751093AbWGXJkV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jul 2006 05:40:21 -0400
X-Antivirus-MYDOMAIN-Mail-From: abum@aftek.com via plain.ev1servers.net
X-Antivirus-MYDOMAIN: 1.22-st-qms (Clear:RC:0(203.129.230.146):SA:0(?/?):. Processed in 4.904767 secs Process 5802)
From: "Abu M. Muttalib" <abum@aftek.com>
To: "Chase Venters" <chase.venters@clientec.com>
Cc: "Robin Holt" <holt@sgi.com>, "Alan Cox" <alan@lxorguk.ukuu.org.uk>,
       <nickpiggin@yahoo.com.au>, "Robert Hancock" <hancockr@shaw.ca>,
       <kernelnewbies@nl.linux.org>, <linux-newbie@vger.kernel.org>,
       <linux-kernel@vger.kernel.org>, "linux-mm" <linux-mm@kvack.org>
Subject: RE: Commenting out out_of_memory() function in __alloc_pages()
Date: Mon, 24 Jul 2006 15:14:39 +0530
Message-ID: <BKEKJNIHLJDCFGDBOHGMGEPDDDAA.abum@aftek.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
In-Reply-To: <Pine.LNX.4.64.0607111025320.19812@turbotaz.ourhouse>
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4927.1200
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

In the same context I want to know whether kernel 2.6.13 broken?

I got oom, and as per the documentation and code of out_of_memory, all the
processes, which share the same memory address as the process chosen to be
killed, i.e. threads, will be killed. But in my case its not the case
always.

At times the process chosen, "Angelia", is killed will all its threads but
at other times, only some of the threads get killed and the print from oom
killer (function out_of_memory) comes repeatedly but no process is killed.
Why its so?

Anticipation and regards,
Abu.

----------------------------------------------------------------------------
----------------------------------------------------------------
oom-killer: gfp_mask=0x201d0, order=0
Mem-info:
DMA per-cpu:
cpu 0 hot: low 2, high 6, batch 1 used:2
cpu 0 cold: low 0, high 2, batch 1 used:1
Normal per-cpu: empty
HighMem per-cpu: empty
Free pages:         712kB (0kB HighMem)
Active:1359 inactive:122 dirty:0 writeback:0 unstable:0 free:178 slab:469
mapped:1244 pagetables:452
DMA free:712kB min:512kB low:640kB high:768kB active:5436kB inactive:488kB
present:16384kB pages_scanned:5261 all_unreclaimable? no
lowmem_reserve[]: 0 0 0
Normal free:0kB min:0kB low:0kB high:0kB active:0kB inactive:0kB present:0kB
pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0
HighMem free:0kB min:128kB low:160kB high:192kB active:0kB inactive:0kB
present:0kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0
DMA: 48*4kB 7*8kB 1*16kB 0*32kB 1*64kB 1*128kB 1*256kB 0*512kB 0*1024kB =
712kB
Normal: empty
HighMem: empty
Swap cache: add 0, delete 0, find 0/0, race 0+0
Free swap  = 0kB
Total swap = 0kB
Free swap:            0kB
4096 pages of RAM
285 free pages
631 reserved pages
469 slab pages
950 pages shared
0 pages swap cached
Out of Memory: Killed process 1137 (Angelia).
oom-killer: gfp_mask=0x201d2, order=0
Mem-info:
DMA per-cpu:
cpu 0 hot: low 2, high 6, batch 1 used:2
cpu 0 cold: low 0, high 2, batch 1 used:1
Normal per-cpu: empty
HighMem per-cpu: empty
Free pages:         712kB (0kB HighMem)
Active:1308 inactive:173 dirty:0 writeback:0 unstable:0 free:178 slab:469
mapped:1244 pagetables:452
DMA free:712kB min:512kB low:640kB high:768kB active:5232kB inactive:692kB
present:16384kB pages_scanned:7971 all_unreclaimable? yes
lowmem_reserve[]: 0 0 0
Normal free:0kB min:0kB low:0kB high:0kB active:0kB inactive:0kB present:0kB
pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0
HighMem free:0kB min:128kB low:160kB high:192kB active:0kB inactive:0kB
present:0kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0
DMA: 48*4kB 7*8kB 1*16kB 0*32kB 1*64kB 1*128kB 1*256kB 0*512kB 0*1024kB =
712kB
Normal: empty
HighMem: empty
Swap cache: add 0, delete 0, find 0/0, race 0+0
Free swap  = 0kB
Total swap = 0kB
Free swap:            0kB
4096 pages of RAM
285 free pages
631 reserved pages
469 slab pages
950 pages shared
0 pages swap cached
oom-killer: gfp_mask=0x201d2, order=0
Mem-info:
DMA per-cpu:
cpu 0 hot: low 2, high 6, batch 1 used:2
cpu 0 cold: low 0, high 2, batch 1 used:1
Normal per-cpu: empty
HighMem per-cpu: empty
Free pages:         712kB (0kB HighMem)
Active:1308 inactive:173 dirty:0 writeback:0 unstable:0 free:178 slab:469
mapped:1244 pagetables:452
DMA free:712kB min:512kB low:640kB high:768kB active:5232kB inactive:692kB
present:16384kB pages_scanned:7971 all_unreclaimable? yes
lowmem_reserve[]: 0 0 0
Normal free:0kB min:0kB low:0kB high:0kB active:0kB inactive:0kB present:0kB
pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0
HighMem free:0kB min:128kB low:160kB high:192kB active:0kB inactive:0kB
present:0kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0
DMA: 48*4kB 7*8kB 1*16kB 0*32kB 1*64kB 1*128kB 1*256kB 0*512kB 0*1024kB =
712kB
Normal: empty
HighMem: empty
Swap cache: add 0, delete 0, find 0/0, race 0+0
Free swap  = 0kB
Total swap = 0kB
Free swap:            0kB
4096 pages of RAM
285 free pages
631 reserved pages
469 slab pages
950 pages shared
0 pages swap cached
oom-killer: gfp_mask=0x201d2, order=0
Mem-info:
DMA per-cpu:
cpu 0 hot: low 2, high 6, batch 1 used:2
cpu 0 cold: low 0, high 2, batch 1 used:0
Normal per-cpu: empty
HighMem per-cpu: empty
Free pages:         512kB (0kB HighMem)
Active:1314 inactive:232 dirty:0 writeback:0 unstable:0 free:128 slab:470
mapped:1250 pagetables:452
DMA free:512kB min:512kB low:640kB high:768kB active:5256kB inactive:928kB
present:16384kB pages_scanned:7971 all_unreclaimable? yes
lowmem_reserve[]: 0 0 0
Normal free:0kB min:0kB low:0kB high:0kB active:0kB inactive:0kB present:0kB
pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0
HighMem free:0kB min:128kB low:160kB high:192kB active:0kB inactive:0kB
present:0kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0
DMA: 0*4kB 6*8kB 1*16kB 0*32kB 1*64kB 1*128kB 1*256kB 0*512kB 0*1024kB =
512kB
Normal: empty
HighMem: empty
Swap cache: add 0, delete 0, find 0/0, race 0+0
Free swap  = 0kB
Total swap = 0kB
Free swap:            0kB
4096 pages of RAM
234 free pages
631 reserved pages
470 slab pages
989 pages shared
0 pages swap cached
oom-killer: gfp_mask=0x201d2, order=0
Mem-info:
DMA per-cpu:
cpu 0 hot: low 2, high 6, batch 1 used:2
cpu 0 cold: low 0, high 2, batch 1 used:0
Normal per-cpu: empty
HighMem per-cpu: empty
Free pages:         512kB (0kB HighMem)
Active:1314 inactive:232 dirty:0 writeback:0 unstable:0 free:128 slab:470
mapped:1250 pagetables:452
DMA free:512kB min:512kB low:640kB high:768kB active:5256kB inactive:928kB
present:16384kB pages_scanned:7971 all_unreclaimable? yes
lowmem_reserve[]: 0 0 0
Normal free:0kB min:0kB low:0kB high:0kB active:0kB inactive:0kB present:0kB
pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0
HighMem free:0kB min:128kB low:160kB high:192kB active:0kB inactive:0kB
present:0kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0
DMA: 0*4kB 6*8kB 1*16kB 0*32kB 1*64kB 1*128kB 1*256kB 0*512kB 0*1024kB =
512kB
Normal: empty
HighMem: empty
Swap cache: add 0, delete 0, find 0/0, race 0+0
Free swap  = 0kB
Total swap = 0kB
Free swap:            0kB
4096 pages of RAM
234 free pages
631 reserved pages
470 slab pages
989 pages shared
0 pages swap cached
oom-killer: gfp_mask=0x201d2, order=0
Mem-info:
DMA per-cpu:
cpu 0 hot: low 2, high 6, batch 1 used:2
cpu 0 cold: low 0, high 2, batch 1 used:0
Normal per-cpu: empty
HighMem per-cpu: empty
Free pages:         512kB (0kB HighMem)
Active:1314 inactive:232 dirty:0 writeback:0 unstable:0 free:128 slab:470
mapped:1250 pagetables:452
DMA free:512kB min:512kB low:640kB high:768kB active:5256kB inactive:928kB
present:16384kB pages_scanned:7971 all_unreclaimable? yes
lowmem_reserve[]: 0 0 0
Normal free:0kB min:0kB low:0kB high:0kB active:0kB inactive:0kB present:0kB
pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0
HighMem free:0kB min:128kB low:160kB high:192kB active:0kB inactive:0kB
present:0kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0
DMA: 0*4kB 6*8kB 1*16kB 0*32kB 1*64kB 1*128kB 1*256kB 0*512kB 0*1024kB =
512kB
Normal: empty
HighMem: empty
Swap cache: add 0, delete 0, find 0/0, race 0+0
Free swap  = 0kB
Total swap = 0kB
Free swap:            0kB
4096 pages of RAM
234 free pages
631 reserved pages
470 slab pages
989 pages shared
0 pages swap cached
oom-killer: gfp_mask=0x201d2, order=0
Mem-info:
DMA per-cpu:
cpu 0 hot: low 2, high 6, batch 1 used:2
cpu 0 cold: low 0, high 2, batch 1 used:0
Normal per-cpu: empty
HighMem per-cpu: empty
Free pages:         512kB (0kB HighMem)
Active:1314 inactive:232 dirty:0 writeback:0 unstable:0 free:128 slab:470
mapped:1250 pagetables:452
DMA free:512kB min:512kB low:640kB high:768kB active:5256kB inactive:928kB
present:16384kB pages_scanned:7971 all_unreclaimable? yes
lowmem_reserve[]: 0 0 0
Normal free:0kB min:0kB low:0kB high:0kB active:0kB inactive:0kB present:0kB
pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0
HighMem free:0kB min:128kB low:160kB high:192kB active:0kB inactive:0kB
present:0kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0
DMA: 0*4kB 6*8kB 1*16kB 0*32kB 1*64kB 1*128kB 1*256kB 0*512kB 0*1024kB =
512kB
Normal: empty
HighMem: empty
Swap cache: add 0, delete 0, find 0/0, race 0+0
Free swap  = 0kB
Total swap = 0kB
Free swap:            0kB
4096 pages of RAM
234 free pages
631 reserved pages
470 slab pages
989 pages shared
0 pages swap cached
oom-killer: gfp_mask=0x201d2, order=0
Mem-info:
DMA per-cpu:
cpu 0 hot: low 2, high 6, batch 1 used:2
cpu 0 cold: low 0, high 2, batch 1 used:0
Normal per-cpu: empty
HighMem per-cpu: empty
Free pages:         512kB (0kB HighMem)
Active:1314 inactive:232 dirty:0 writeback:0 unstable:0 free:128 slab:470
mapped:1250 pagetables:452
DMA free:512kB min:512kB low:640kB high:768kB active:5256kB inactive:928kB
present:16384kB pages_scanned:7971 all_unreclaimable? yes
lowmem_reserve[]: 0 0 0
Normal free:0kB min:0kB low:0kB high:0kB active:0kB inactive:0kB present:0kB
pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0
HighMem free:0kB min:128kB low:160kB high:192kB active:0kB inactive:0kB
present:0kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0
DMA: 0*4kB 6*8kB 1*16kB 0*32kB 1*64kB 1*128kB 1*256kB 0*512kB 0*1024kB =
512kB
Normal: empty
HighMem: empty
Swap cache: add 0, delete 0, find 0/0, race 0+0
Free swap  = 0kB
Total swap = 0kB
Free swap:            0kB
4096 pages of RAM
234 free pages
631 reserved pages
470 slab pages
989 pages shared
0 pages swap cached
oom-killer: gfp_mask=0x201d2, order=0
Mem-info:
DMA per-cpu:
cpu 0 hot: low 2, high 6, batch 1 used:2
cpu 0 cold: low 0, high 2, batch 1 used:0
Normal per-cpu: empty
HighMem per-cpu: empty
Free pages:         512kB (0kB HighMem)
Active:1347 inactive:203 dirty:0 writeback:0 unstable:0 free:128 slab:470
mapped:1250 pagetables:452
DMA free:512kB min:512kB low:640kB high:768kB active:5388kB inactive:812kB
present:16384kB pages_scanned:8037 all_unreclaimable? yes
lowmem_reserve[]: 0 0 0
Normal free:0kB min:0kB low:0kB high:0kB active:0kB inactive:0kB present:0kB
pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0
HighMem free:0kB min:128kB low:160kB high:192kB active:0kB inactive:0kB
present:0kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0
DMA: 0*4kB 6*8kB 1*16kB 0*32kB 1*64kB 1*128kB 1*256kB 0*512kB 0*1024kB =
512kB
Normal: empty
HighMem: empty
Swap cache: add 0, delete 0, find 0/0, race 0+0
Free swap  = 0kB
Total swap = 0kB
Free swap:            0kB
4096 pages of RAM
234 free pages
631 reserved pages
470 slab pages
985 pages shared
0 pages swap cached
oom-killer: gfp_mask=0x201d2, order=0
Mem-info:
DMA per-cpu:
cpu 0 hot: low 2, high 6, batch 1 used:2
cpu 0 cold: low 0, high 2, batch 1 used:0
Normal per-cpu: empty
HighMem per-cpu: empty
Free pages:         512kB (0kB HighMem)
Active:1347 inactive:203 dirty:0 writeback:0 unstable:0 free:128 slab:470
mapped:1250 pagetables:452
DMA free:512kB min:512kB low:640kB high:768kB active:5388kB inactive:812kB
present:16384kB pages_scanned:8037 all_unreclaimable? yes
lowmem_reserve[]: 0 0 0
Normal free:0kB min:0kB low:0kB high:0kB active:0kB inactive:0kB present:0kB
pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0
HighMem free:0kB min:128kB low:160kB high:192kB active:0kB inactive:0kB
present:0kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0
DMA: 0*4kB 6*8kB 1*16kB 0*32kB 1*64kB 1*128kB 1*256kB 0*512kB 0*1024kB =
512kB
Normal: empty
HighMem: empty
Swap cache: add 0, delete 0, find 0/0, race 0+0
Free swap  = 0kB
Total swap = 0kB
Free swap:            0kB
4096 pages of RAM
234 free pages
631 reserved pages
470 slab pages
985 pages shared
0 pages swap cached
----------------------------------------------------------------------------
----------------------------------------------------------------

