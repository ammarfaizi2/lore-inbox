Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261375AbSLaK0Q>; Tue, 31 Dec 2002 05:26:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261376AbSLaK0P>; Tue, 31 Dec 2002 05:26:15 -0500
Received: from wiprom2mx1.wipro.com ([203.197.164.41]:56256 "EHLO
	wiprom2mx1.wipro.com") by vger.kernel.org with ESMTP
	id <S261375AbSLaK0P> convert rfc822-to-8bit; Tue, 31 Dec 2002 05:26:15 -0500
x-mimeole: Produced By Microsoft Exchange V6.0.5762.3
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: 5.53 mm2 oops during LMbench.
Date: Tue, 31 Dec 2002 16:04:24 +0530
Message-ID: <94F20261551DC141B6B559DC491086720445DD@blr-m3-msg.wipro.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: 5.53 mm2 oops during LMbench.
Thread-Index: AcKwuC9isuQkX45yS4C23SDtdRp5/g==
From: "Aniruddha M Marathe" <aniruddha.marathe@wipro.com>
To: "Andrew Morton" <akpm@digeo.com>
Cc: <linux-kernel@vger.kernel.org>, "Larry McVoy" <lm@bitmover.com>
X-OriginalArrivalTime: 31 Dec 2002 10:34:25.0084 (UTC) FILETIME=[30505FC0:01C2B0B8]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oops came when Lmbench was calculating memory load latency. 

Couldn't capture the entire call trace. Here is the last screen.

3ef4c>] shrink_list+0x3c/0x660
 [<c0109cea>] apic_timer_interrupt+0x1a/0x20
 [<c013dfca>] __pagevec_release+0x1a/0x30
 [<c013f7a8>] shrink_cache+0x238/0x460
 [<c01401b3>] shrink_zone+0x83/0xb0
 [<c0140250>] shrink_caches+0x70/0xa0
 [<c0140309>] try_to_free_pages+0x89/0xc0
 [<c01382a7>] __alloc_pages+0x1f7/0x2c0
 [<c013839a>] __get_free_pages+0x2a/0x70
 [<c013b6e1>] cache_grow+0x141/0x380
 [<c013ba51>] __cache_alloc_refill+0x131/0x440
 [<c013bda4>] cache_alloc_refill+0x44/0x60
 [<c013c316>] kmem_cache_alloc+0x56/0x100
 [<c01485b5>] pgtable_add_rmap+0x55/0x80
 [<c01416a1>] pte_alloc_map+0xe1/0x180
 [<c0148f61>] pte_chain_alloc+0x41/0x60
 [<c0141ca6>] copy_page_range+0x466/0x6c0
 [<c011ce4d>] mm_init+0xdd/0x120
 [<c011d37b>] copy_mm+0x3ab/0x4b0
 [<c011df55>] copy_process+0x5c5/0xbd0
 [<c011e5e7>] do_fork+0x87/0x140
 [<c01076c9>] sys_fork+0x19/0x30
 [<c0109323>] syscall_call+0x7/0xb
