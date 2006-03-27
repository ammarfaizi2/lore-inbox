Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750861AbWC0UbI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750861AbWC0UbI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Mar 2006 15:31:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750879AbWC0UbI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Mar 2006 15:31:08 -0500
Received: from uproxy.gmail.com ([66.249.92.200]:19563 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750861AbWC0UbG convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Mar 2006 15:31:06 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=KFYZtt0sXG79dtUyZcrd7f7UQ/cNKBFmq40YhHgFeQPEbHQaVGvllwYM416GAK8XoFbFtIl/wkSL8gjs+Sn+YhPSFwE6kRN7ej7nhcsNu9F/z4SgyanPjKqTccpGhPXWcqseS6WBI+E8lFGnPQaryo0KxZnb+6lqYDE/jUrUnlA=
Message-ID: <2cf1ee820603271231l69187925j3150098097c7ca15@mail.gmail.com>
Date: Mon, 27 Mar 2006 23:31:04 +0300
From: "emin ak" <eminak71@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: 2.6.16-rt10 crash on ppc
In-Reply-To: <2cf1ee820603270656w6697778ai83935217ea5ab3a5@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <2cf1ee820603270656w6697778ai83935217ea5ab3a5@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear all,
Today I have tried Ingo Molnar's patch-2.6.16-rt10 on a ppc (PQ3 MPC8540ADS)
For testing purpose I have enabled packet routing  and send ethernet
packets over the system with a network test equipment. under light
load  on ethernet, the system is working fine, but under heavy load,
firstly console freezes, then the message below prints on the console
again and again. The system without patch is working fine on light or
heavy loads. What can be the problem, is there a bug  or am i doing
something wrong?
Thanks alot..
here is the console output
--------------------------console output-----
softirq-net-rx/: page allocation failure. order:0, mode:0x20
Call Trace:
[C04E3DB0] [C000A60C] show_stack+0x50/0x188 (unreliable)
[C04E3DE0] [C004C3EC] __alloc_pages+0x1c8/0x2a4
[C04E3E30] [C0063C90] cache_alloc_refill+0x35c/0x57c
[C04E3E80] [C0063FA4] __kmalloc+0xf4/0xfc
[C04E3EB0] [C012D460] __alloc_skb+0x58/0x118
[C04E3ED0] [C011AF20] gfar_new_skb+0x40/0xd4
[C04E3EF0] [C011D320] gfar_clean_rx_ring+0x25c/0x634
[C04E3F30] [C011D72C] gfar_poll+0x34/0x140
[C04E3F50] [C013364C] net_rx_action+0x94/0x188
[C04E3F80] [C0026730] ksoftirqd+0x104/0x1b4
[C04E3FC0] [C003779C] kthread+0xf8/0x100
[C04E3FF0] [C0004DB8] kernel_thread+0x44/0x60
Mem-info:
DMA per-cpu:
cpu 0 hot: high 90, batch 15 used:0
cpu 0 cold: high 30, batch 7 used:0
DMA32 per-cpu: empty
Normal per-cpu: empty
HighMem per-cpu: empty
Free pages:         768kB (0kB HighMem)
Active:1650 inactive:2036 dirty:0 writeback:0 unstable:0 free:192
slab:60106 mapped:764 pagetables:29
DMA free:768kB min:2048kB low:2560kB high:3072kB active:6600kB
inactive:8144kB present:262144kB pages_scanned:0 all_unreclaimab
le? no
lowmem_reserve[]: 0 0 0 0
DMA32 free:0kB min:0kB low:0kB high:0kB active:0kB inactive:0kB
present:0kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0 0
Normal free:0kB min:0kB low:0kB high:0kB active:0kB inactive:0kB
present:0kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0 0
HighMem free:0kB min:128kB low:128kB high:128kB active:0kB
inactive:0kB present:0kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0 0
DMA: 0*4kB 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 1*256kB 1*512kB 0*1024kB
0*2048kB 0*4096kB = 768kB
DMA32: empty
Normal: empty
HighMem: empty
Swap cache: add 0, delete 0, find 0/0, race 0+0
Free swap  = 0kB
Total swap = 0kB
Free swap:            0kB
65536 pages of RAM
0 pages of HIGHMEM
662 free pages
1180 reserved pages
1249 pages shared
0 pages swap cached
printk: 2159030 messages suppressed.
-------and continues..
