Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278476AbRJVKee>; Mon, 22 Oct 2001 06:34:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278489AbRJVKeZ>; Mon, 22 Oct 2001 06:34:25 -0400
Received: from nick.dcs.qmul.ac.uk ([138.37.88.61]:4579 "EHLO
	nick.dcs.qmul.ac.uk") by vger.kernel.org with ESMTP
	id <S278476AbRJVKeN>; Mon, 22 Oct 2001 06:34:13 -0400
Date: Mon, 22 Oct 2001 11:34:47 +0100 (BST)
From: Matt Bernstein <matt@theBachChoir.org.uk>
To: <linux-kernel@vger.kernel.org>
Subject: oops (BUG() in slab.c:1419) in 2.4.9-ac18
Message-ID: <Pine.LNX.4.33.0110221129270.9856-100000@nick.dcs.qmul.ac.uk>
X-URL: http://www.theBachChoir.org.uk/
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This on our twin Pentium II server (built with egcs-1.1.2). The machine
was partly responding, but ssh and the console were both pretty dead.
Alt-SysRq-S tried to work but never finished. All ext2 filesystems,
hanging off an ICP Vortex (gdth.o) card. The fsck was not pretty.

We still haven't ruled out hardware problems, but could this be a Linux
bug? Any more information on request..

Matt

kernel BUG at slab.c:1419!
invalid operand: 0000
CPU:    0
EIP:    0010:[kmem_cache_reap+541/1492]    Not tainted
EFLAGS: 00010086
eax: 0000001b   ebx: ead1d000   ecx: c022e3a4   edx: 001e564b
esi: ead1de0c   edi: 00002108   ebp: c221b0c0   esp: f7ee1f80
ds: 0018   es: 0018   ss: 0018
Process kswapd (pid: 5, stackpage=f7ee1000)
Stack: c0201ca9 0000058b 00000080 000000c0 f7ee0335 0008e000 00020400 00020400
       000000c0 0002ad1d c221b0e4 00000001 f7eec00c f7eec000 00000008 00000000
       00000000 00000000 c0138eb8 000000c0 f7ee0000 c02026d1 c0138f27 000000c0
Call Trace: [do_try_to_free_pages+72/80] [kswapd+103/204] [kernel_thread+35/48]

Code: 0f 0b 83 c4 08 89 74 24 10 8b 4d 18 01 4c 24 10 b8 71 f0 2c


