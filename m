Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261296AbSKBRIv>; Sat, 2 Nov 2002 12:08:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261298AbSKBRIv>; Sat, 2 Nov 2002 12:08:51 -0500
Received: from rwcrmhc51.attbi.com ([204.127.198.38]:9949 "EHLO
	rwcrmhc51.attbi.com") by vger.kernel.org with ESMTP
	id <S261296AbSKBRIu>; Sat, 2 Nov 2002 12:08:50 -0500
From: jordan.breeding@attbi.com
To: linux-kernel@vger.kernel.org
Subject: VFS error in dmesg with ext3 htree
Date: Sat, 02 Nov 2002 17:15:10 +0000
X-Mailer: AT&T Message Center Version 1 (Aug 12 2002)
Message-Id: <20021102171511.OFNK14374.rwcrmhc51.attbi.com@rwcrwbc70>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is a message I keep getting in my dmesg 
when I mount my ext3 filesystems with htree 
activated on 2.5.45-bk.

VFS: brelse: Trying to free free buffer
buffer layer error at fs/buffer.c:1166
Pass this trace through ksymoops for reporting
Call Trace:
 [<c0155db6>] __brelse+0x36/0x40
 [<c0155fd7>] bh_lru_install+0xc7/0x100
 [<c0156075>] __find_get_block+0x65/0x70
 [<c01560af>] __getblk+0x2f/0x70
 [<c015611f>] __bread+0x2f/0x80
 [<c0194223>] ext3_get_inode_loc+0xf3/0x190
 [<c0194e61>] ext3_reserve_inode_write+0x31/0xe0
 [<c01927c5>] commit_write_fn+0x25/0x90
 [<c0194f3b>] ext3_mark_inode_dirty+0x2b/0x60
 [<c0192419>] walk_page_buffers+0x69/0x70
 [<c0192966>] ext3_commit_write+0x136/0x270
 [<c01927a0>] commit_write_fn+0x0/0x90
 [<c013c68d>] generic_file_write_nolock+0x34d/
0x9f0
 [<c044f0ca>] sys_recvfrom+0xda/0x120
 [<c011d1d3>] schedule+0x1a3/0x340
 [<c01449a3>] __get_free_pages+0x33/0x40
 [<c013cedc>] generic_file_writev+0x5c/0x80
 [<c0153325>] do_readv_writev+0x175/0x290
 [<c0152c10>] do_sync_write+0x0/0xc0
 [<c0153575>] sys_writev+0x95/0xa0
 [<c0109413>] syscall_call+0x7/0xb

Anybody know how to fix this?  Thanks.

Jordan
