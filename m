Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261593AbSL2UOn>; Sun, 29 Dec 2002 15:14:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261599AbSL2UOn>; Sun, 29 Dec 2002 15:14:43 -0500
Received: from dsl-67-48-44-237.telocity.com ([67.48.44.237]:10541 "EHLO
	lnuxlab.ath.cx") by vger.kernel.org with ESMTP id <S261593AbSL2UOm>;
	Sun, 29 Dec 2002 15:14:42 -0500
Date: Sun, 29 Dec 2002 15:41:36 -0500
To: linux-kernel@vger.kernel.org
Subject: 2.5.53-mm3: bad: scheduling while atomic!
Message-ID: <20021229204136.GA24616@lnuxlab.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
From: khromy@lnuxlab.ath.cx (khromy)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Running 2.5.53-mm3, I got the following:

bad: scheduling while atomic!
Call Trace:
 [<c0114381>] do_schedule+0x3d/0x2c8
 [<c011d9b0>] schedule_timeout+0x80/0xa0
 [<c011d924>] process_timeout+0x0/0xc
 [<c0115315>] io_schedule_timeout+0x11/0x1c
 [<c01de5de>] blk_congestion_wait+0x8a/0xa0
 [<c0115a54>] autoremove_wake_function+0x0/0x38
 [<c0115a54>] autoremove_wake_function+0x0/0x38
 [<c012fbb4>] try_to_free_pages+0x3c/0xbc
 [<c012a33c>] __alloc_pages+0x1b4/0x260
 [<c012a410>] __get_free_pages+0x28/0x64
 [<c012c7e6>] cache_grow+0xb6/0x20c
 [<c012c9cf>] __cache_alloc_refill+0x93/0x220
 [<c012cb96>] cache_alloc_refill+0x3a/0x58
 [<c012cf1d>] kmem_cache_alloc+0x45/0xc8
 [<c0136460>] pte_chain_alloc+0x38/0x68
 [<c0130eea>] copy_page_range+0x2be/0x3f0
 [<c0115f8b>] copy_mm+0x283/0x348
 [<c0116a4f>] copy_process+0x61b/0xb24
 [<c0116fd6>] do_fork+0x7e/0x134
 [<c0107478>] sys_fork+0x18/0x2c
 [<c01089af>] syscall_call+0x7/0xb

dpkg: page allocation failure. order:0, mode:0x20
dpkg: page allocation failure. order:0, mode:0x20
xmms: page allocation failure. order:5, mode:0x20
xmms: page allocation failure. order:4, mode:0x20
xmms: page allocation failure. order:3, mode:0x20

-- 
L1:	khromy		;khromy(at)lnuxlab.ath.cx
