Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263182AbTCYSEZ>; Tue, 25 Mar 2003 13:04:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263183AbTCYSEY>; Tue, 25 Mar 2003 13:04:24 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:37637 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S263182AbTCYSEV>; Tue, 25 Mar 2003 13:04:21 -0500
Date: Tue, 25 Mar 2003 19:15:31 +0100
From: Jan Kara <jack@ucw.cz>
To: Andrew Morton <akpm@diego.com>
Cc: linux-kernel@vger.kernel.org
Subject: Co noveho s ext3 ve 2.5.66 ? (fwd)
Message-ID: <20030325181531.GB16507@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi,

  seems there are still some problems in ext3 in 2.5.66 (see the oops).
The machine is dual athlon with SMP kernel, oops occured while doing
'make install' after compilation of wine.

								Honza


Assertion failure in journal_stop() at fs/jbd/transaction.c:1334: "transaction->t_updates > 0"
------------[ cut here ]------------
kernel BUG at fs/jbd/transaction.c:1334!
invalid operand: 0000 [#1]
CPU:    1
EIP:    0060:[<c01a8399>]    Not tainted
EFLAGS: 00010286
EIP is at journal_stop+0x1d9/0x1f0
eax: 00000062   ebx: 00000000   ecx: d302c0c0   edx: c03ee740
esi: dfdaae40   edi: 00000000   ebp: dcfdfc40   esp: d35f9b40
ds: 007b   es: 007b   ss: 0068
Process ginstall (pid: 6175, threadinfo=d35f8000 task=d302c0c0)
Stack: c039e860 c03880c1 c039c64f 00000536 c039c664 dfc1a200 c019b32f 00000000
       dfc1a400 d8978948 dfc1a400 c019fe84 dcfdfc40 dfc1a294 dcfdfc40 dcfdfc40
       dcfdfc40 c019b3c5 c0387763 dcfdfc40 00000007 d8978948 dfc1a400 c0179555
Call Trace:
 [<c019b32f>] ext3_mark_inode_dirty+0x4f/0x60
 [<c019fe84>] __ext3_journal_stop+0x24/0x50
 [<c019b3c5>] ext3_dirty_inode+0x85/0xf0
 [<c0179555>] __mark_inode_dirty+0x115/0x120
 [<c01946d7>] ext3_new_block+0xd7/0x880
 [<c0158d73>] wake_up_buffer+0x13/0x40
 [<c0197697>] ext3_alloc_block+0x37/0x40
 [<c0197a2a>] ext3_alloc_branch+0x4a/0x2a0
 [<c019784b>] ext3_get_branch+0x6b/0xf0
 [<c0197fe0>] ext3_get_block_handle+0x190/0x390
 [<c015cac6>] alloc_buffer_head+0x46/0x70
 [<c0159eac>] create_buffers+0x5c/0xa0
 [<c0198234>] ext3_get_block+0x54/0xa0
 [<c015afe2>] __block_prepare_write+0x1d2/0x440
 [<c01ae353>] __jbd_kmalloc+0x23/0x70
 [<c01a69bb>] start_this_handle+0x9b/0x1e0
 [<c01a6b2b>] new_handle+0x2b/0x60
 [<c015ba54>] block_prepare_write+0x34/0x50
 [<c01981e0>] ext3_get_block+0x0/0xa0
 [<c01988e4>] ext3_prepare_write+0xb4/0x220
 [<c01981e0>] ext3_get_block+0x0/0xa0
 [<c013c82a>] generic_file_aio_write_nolock+0x35a/0xa00
 [<c0172e17>] update_atime+0x87/0xe0
 [<c013b730>] __generic_file_aio_read+0x1b0/0x1f0
 [<c013cfe2>] generic_file_aio_write+0x72/0x90
 [<c0195cf4>] ext3_file_write+0x44/0xe0
 [<c015788b>] do_sync_write+0x8b/0xc0
 [<c0157985>] vfs_write+0xc5/0x1c0
 [<c0157b1e>] sys_write+0x3e/0x60
 [<c010adeb>] syscall_call+0x7/0xb

Code: 0f 0b 36 05 4f c6 39 c0 e9 39 fe ff ff 8d 76 00 8d bc 27 00
