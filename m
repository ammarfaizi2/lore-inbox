Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261723AbTIYSZH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Sep 2003 14:25:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261718AbTIYSYW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Sep 2003 14:24:22 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:8413 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261683AbTIYRzp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Sep 2003 13:55:45 -0400
Date: Thu, 25 Sep 2003 08:49:50 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
cc: Andrew Morton <akpm@digeo.com>
Subject: ext3 panic on test4 running dbench
Message-ID: <20610000.1064504990@flay>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

maybe this is fixed already ... but:

Sep 24 02:26:14 elm3b67 kernel: invalid operand: 0000 [#1]
Sep 24 02:26:14 elm3b67 kernel: CPU:    11
Sep 24 02:26:14 elm3b67 kernel: EIP:    0060:[_end+404081921/1069412752]    Not tainted
Sep 24 02:26:14 elm3b67 kernel: EFLAGS: 00010206
Sep 24 02:26:14 elm3b67 kernel: EIP is at 0xd857bb71
Sep 24 02:26:14 elm3b67 kernel: eax: 00038815   ebx: 00000002   ecx: cbe4ab20   edx: 00000011
Sep 24 02:26:14 elm3b67 kernel: esi: 00000000   edi: d82c6690   ebp: d4ecd1b0   esp: d857bb80
Sep 24 02:26:14 elm3b67 kernel: ds: 007b   es: 007b   ss: 0068
Sep 24 02:26:14 elm3b67 kernel: Process dbench (pid: 20747, threadinfo=d857a000 task=d4015900)
Sep 24 02:26:14 elm3b67 kernel: Stack: cf768ea4 00000000 d82c6690 d857bc1c d8841400 d5f0a180 00000000 00000000 
Sep 24 02:26:14 elm3b67 kernel:        00818006 d8841400 00000000 d5489310 cf768ea4 c017f65f cc218280 c01892b9 
Sep 24 02:26:14 elm3b67 kernel:        cf768ea4 d82c6690 00000000 00000000 d4ecd1b0 00000000 d4ecd1b0 cf768ea4 
Sep 24 02:26:14 elm3b67 kernel: Call Trace:
Sep 24 02:26:14 elm3b67 kernel:  [ext3_get_inode_loc+87/572] ext3_get_inode_loc+0x57/0x23c
Sep 24 02:26:14 elm3b67 kernel:  [journal_get_write_access+33/52] journal_get_write_access+0x21/0x34
Sep 24 02:26:14 elm3b67 kernel:  [ext3_reserve_inode_write+52/152] ext3_reserve_inode_write+0x34/0x98
Sep 24 02:26:14 elm3b67 kernel:  [ext3_mark_inode_dirty+26/52] ext3_mark_inode_dirty+0x1a/0x34
Sep 24 02:26:14 elm3b67 kernel:  [ext3_splice_branch+209/388] ext3_splice_branch+0xd1/0x184
Sep 24 02:26:14 elm3b67 kernel:  [ext3_get_block_handle+479/640] ext3_get_block_handle+0x1df/0x280
Sep 24 02:26:14 elm3b67 kernel:  [ext3_get_block+96/104] ext3_get_block+0x60/0x68
Sep 24 02:26:14 elm3b67 kernel:  [__block_prepare_write+300/972] __block_prepare_write+0x12c/0x3cc
Sep 24 02:26:14 elm3b67 kernel:  [block_prepare_write+33/56] block_prepare_write+0x21/0x38
Sep 24 02:26:14 elm3b67 kernel:  [ext3_get_block+0/104] ext3_get_block+0x0/0x68
Sep 24 02:26:14 elm3b67 kernel:  [ext3_prepare_write+69/216] ext3_prepare_write+0x45/0xd8
Sep 24 02:26:14 elm3b67 kernel:  [ext3_get_block+0/104] ext3_get_block+0x0/0x68
Sep 24 02:26:14 elm3b67 kernel:  [generic_file_aio_write_nolock+1693/2608] generic_file_aio_write_nolock+0x69d/0xa30
Sep 24 02:26:14 elm3b67 kernel:  [generic_file_aio_write+103/128] generic_file_aio_write+0x67/0x80
Sep 24 02:26:14 elm3b67 kernel:  [ext3_file_write+43/183] ext3_file_write+0x2b/0xb7
Sep 24 02:26:14 elm3b67 kernel:  [do_sync_write+129/176] do_sync_write+0x81/0xb0
Sep 24 02:26:14 elm3b67 kernel:  [sys_fstat64+37/48] sys_fstat64+0x25/0x30
Sep 24 02:26:14 elm3b67 kernel:  [vfs_write+160/208] vfs_write+0xa0/0xd0
Sep 24 02:26:14 elm3b67 kernel:  [sys_pwrite64+64/92] sys_pwrite64+0x40/0x5c
Sep 24 02:26:14 elm3b67 kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Sep 24 02:26:14 elm3b67 kernel: 
Sep 24 02:26:14 elm3b67 kernel: Code: ff ff ff 71 bb 57 d8 60 00 00 00 06 02 01 00 a4 8e 76 cf 00 


