Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262680AbTHZRgI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Aug 2003 13:36:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262398AbTHZRdw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Aug 2003 13:33:52 -0400
Received: from mail4.bluewin.ch ([195.186.4.74]:1254 "EHLO mail4.bluewin.ch")
	by vger.kernel.org with ESMTP id S262246AbTHZRdj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Aug 2003 13:33:39 -0400
Date: Tue, 26 Aug 2003 19:33:37 +0200
From: Roger Luethi <rl@hellgate.ch>
To: linux-kernel@vger.kernel.org
Subject: [2.6] kernel BUG at arch/i386/mm/highmem.c:14!
Message-ID: <20030826173337.GA3993@k3.hellgate.ch>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Operating-System: Linux 2.6.0-test4 on i686
X-GPG-Fingerprint: 92 F4 DC 20 57 46 7B 95  24 4E 9E E7 5A 54 DC 1B
X-GPG: 1024/80E744BD wwwkeys.ch.pgp.net
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This BUG immediately followed my turning off DMA on hda (with a mounted
partition and dirty buffers). Register and stack info are available upon
request (screenshot). 2.6.0-test4.

Roger

kernel BUG at arch/i386/mm/highmem.c:14!
invalid operand: 0000 [#1]
CPU:    0
EIP:    0060:[<c011bc36>]   Not tainted
EFLAGS: 00010206
EIP is at kunmap+0x16/0x30
[...]
Process pdflush [...]

 [<c0158f69>] __blk_queue_bounce+0x1e9/0x230
 [<c0158fe7>] blk_queue_bounce+0x37/0x60
 [<c022be20>] __make_request+0x50/0x670
 [<c023ccb0>] task_mulout_intr+0x0/0x290
 [<c022c584>] generic_make_request+0x144/0x1e0
 [<c0176fec>] bio_alloc+0xcc/0x1a0
 [<c022c65d>] submit_bio+0x3d/0x70
 [<c01c80e0>] reiserfs_write_full_page+0x210/0x350
 [<c01c8265>] reiserfs_writepage+0x25/0x40
 [<c019ed3f>] mpage_writepages+0x38f/0x4d0
 [<c01c8240>] reiserfs_writepage+0x0/0x40
 [<c014e375>] do_writepages+0x35/0x40
 [<c019c644>] __sync_single_inode+0x194/0x470
 [<c010a10c>] common_interrupt+0x18/0x20
 [<c019cce1>] sync_sb_inodes+0x1d1/0x3d0
 [<c019d041>] writeback_inodes+0x161/0x420
 [<c014d0a9>] get_page_state+0x19/0x20
 [<c014e1bc>] wb_kupdate+0xdc/0x160
 [<c014eb0c>] __pdflush+0x21c/0x5f0
 [<c014eee0>] pdflush+0x0/0x20
 [<c014eef1>] pdflush+0x11/0x20
 [<c014e0e0>] wb_kupdate+0x0/0x160
 [<c0107259>] kernel_thread_helper+0x5/0xc
