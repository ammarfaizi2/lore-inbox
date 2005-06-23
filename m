Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262263AbVFWJRK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262263AbVFWJRK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 05:17:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262627AbVFWJOD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 05:14:03 -0400
Received: from mx2.elte.hu ([157.181.151.9]:40374 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S262261AbVFWJJs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 05:09:48 -0400
Date: Thu, 23 Jun 2005 11:09:36 +0200
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>
Subject: DEBUG_PAGEALLOC & SMP?
Message-ID: <20050623090936.GA28112@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


is this a known problem? I'm getting an oom-kill and a stuck boot with 
SMP & PAGEALLOC enabled. The UP kernel boots fine.

	Ingo

Calling initcall 0xc04a38a3: ahd_linux_init+0x0/0x19()
Calling initcall 0xc04a38bc: init_sd+0x0/0x53()
oom-killer: gfp_mask=0xd1
DMA per-cpu:
cpu 0 hot: low 2, high 6, batch 1
cpu 0 cold: low 0, high 2, batch 1
cpu 1 hot: low 2, high 6, batch 1
cpu 1 cold: low 0, high 2, batch 1
cpu 2 hot: low 2, high 6, batch 1
cpu 2 cold: low 0, high 2, batch 1
cpu 3 hot: low 2, high 6, batch 1
cpu 3 cold: low 0, high 2, batch 1
Normal per-cpu:
cpu 0 hot: low 62, high 186, batch 31
cpu 0 cold: low 0, high 62, batch 31
cpu 1 hot: low 62, high 186, batch 31
cpu 1 cold: low 0, high 62, batch 31
cpu 2 hot: low 62, high 186, batch 31
cpu 2 cold: low 0, high 62, batch 31
cpu 3 hot: low 62, high 186, batch 31
cpu 3 cold: low 0, high 62, batch 31
HighMem per-cpu: empty

Free pages:      864488kB (0kB HighMem)
Active:0 inactive:0 dirty:0 writeback:0 unstable:0 free:216122 slab:4011 mapped:0 pagetables:0
DMA free:0kB min:68kB low:84kB high:100kB active:0kB inactive:0kB present:16384kB pages_scanned:0 all_unreclaimable? yes
lowmem_reserve[]: 0 880 880
Normal free:864488kB min:3756kB low:4692kB high:5632kB active:0kB inactive:0kB present:901120kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0
HighMem free:0kB min:128kB low:160kB high:192kB active:0kB inactive:0kB present:0kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0
DMA: 0*4kB 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 0kB
Normal: 16*4kB 5*8kB 2*16kB 1*32kB 1*64kB 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 211*4096kB = 864488kB
HighMem: empty
Swap cache: add 0, delete 0, find 0/0, race 0+0
Free swap  = 0kB
Total swap = 0kB
oom-killer: gfp_mask=0xd1
DMA per-cpu:
[...]
