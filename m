Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265961AbUGEIdO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265961AbUGEIdO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jul 2004 04:33:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265963AbUGEIdO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jul 2004 04:33:14 -0400
Received: from atropo.wseurope.com ([195.110.122.67]:1769 "EHLO
	atropo.wseurope.com") by vger.kernel.org with ESMTP id S265961AbUGEIdM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jul 2004 04:33:12 -0400
From: Fabio Coatti <cova@ferrara.linux.it>
Organization: FerraraLUG
To: linux-kernel@vger.kernel.org
Subject: XFS problem 2.6.7 vanilla
Date: Mon, 5 Jul 2004 10:33:10 +0200
User-Agent: KMail/1.6.2
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200407051033.10994.cova@ferrara.linux.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We are getting some error trace from xfs. I suppose that this can be due to a 
faulty HD sector, but it sound strange to me that a HD error can trigger an 
internal FS failure. We have tried several times to fix this error with XFS 
repair without succes, so I suppose a hw error, but is the aspected behaviour 
to get an internal FS error?
(2.6.7 vanilla)

Filesystem "hde2": corrupt inode 25375199 ((a)extents = 2034).  Unmount and 
run xfs_repair.
0x0: 49 4e 41 ed 01 02 00 03 00 00 07 f2 00 00 07 f2
Filesystem "hde2": XFS internal error xfs_iformat_extents(1) at line 678 of 
file fs/xfs/xfs_inode.c.  Caller 0xc029b5be
 [<c029bbb7>] xfs_iformat_extents+0x287/0x310
 [<c029b5be>] xfs_iformat+0x4ee/0x610
 [<c029b5be>] xfs_iformat+0x4ee/0x610
 [<c029b5be>] xfs_iformat+0x4ee/0x610
 [<c029c040>] xfs_xlate_dinode_core+0x160/0x810
 [<c029c99d>] xfs_iread+0x21d/0x270
 [<c0299c96>] xfs_iget_core+0xb6/0x4c0
 [<c029a1b9>] xfs_iget+0x119/0x150
 [<c02b6824>] xfs_dir_lookup_int+0xb4/0x130
 [<c02bc0e0>] xfs_lookup+0x50/0x90
 [<c02c82c7>] linvfs_lookup+0x67/0xa0
 [<c0151d2b>] real_lookup+0xcb/0xf0
 [<c0151f96>] do_lookup+0x96/0xb0
 [<c01523cf>] link_path_walk+0x41f/0x800
 [<c02f502e>] copy_to_user+0x3e/0x50
 [<c01529cf>] path_lookup+0x6f/0x150
 [<c0152c79>] __user_walk+0x49/0x80
 [<c014e4dc>] vfs_lstat+0x1c/0x60
 [<c014ebeb>] sys_lstat64+0x1b/0x40
 [<c0145810>] sys_close+0x50/0x60
 [<c0103efb>] syscall_call+0x7/0xb


-- 
Fabio "Cova" Coatti    http://members.ferrara.linux.it/cova     
Ferrara Linux Users Group           http://ferrara.linux.it
GnuPG fp:9765 A5B6 6843 17BC A646  BE8C FA56 373A 5374 C703
Old SysOps never die... they simply forget their password.

