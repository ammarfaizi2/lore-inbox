Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267090AbTBUDUI>; Thu, 20 Feb 2003 22:20:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267094AbTBUDUI>; Thu, 20 Feb 2003 22:20:08 -0500
Received: from wsip68-15-8-100.sd.sd.cox.net ([68.15.8.100]:50564 "EHLO
	gnuppy.monkey.org") by vger.kernel.org with ESMTP
	id <S267090AbTBUDUH>; Thu, 20 Feb 2003 22:20:07 -0500
Date: Thu, 20 Feb 2003 19:30:13 -0800
To: linux-kernel@vger.kernel.org
Cc: "Bill Huey (Hui)" <billh@gnuppy.monkey.org>
Subject: ext3/VFS double freeing warning
Message-ID: <20030221033013.GA10354@gnuppy.monkey.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.3i
From: Bill Huey (Hui) <billh@gnuppy.monkey.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Hey, I got this:

-------------------------------------------

VFS: brelse: Trying to free free buffer
buffer layer error at fs/buffer.c:1170
Call Trace:
 [<c01503e5>] __brelse+0x35/0x40
 [<c018ce9d>] ext3_htree_fill_tree+0x15d/0x290
 [<c01861c2>] ext3_dx_readdir+0x92/0x1d0
 [<c015ff20>] filldir64+0x0/0x120
 [<c0185dbd>] ext3_readdir+0x4bd/0x4f0
 [<c015ff20>] filldir64+0x0/0x120
 [<c0140366>] handle_mm_fault+0x76/0xb0
 [<c01193ec>] do_page_fault+0x23c/0x45e
 [<c015fbdc>] vfs_readdir+0x7c/0x80
 [<c015ff20>] filldir64+0x0/0x120
 [<c01600da>] sys_getdents64+0x9a/0xe0
 [<c015ff20>] filldir64+0x0/0x120
 [<c01413ad>] sys_brk+0xfd/0x130
 [<c01095cf>] syscall_call+0x7/0xb

-------------------------------------------

bill

