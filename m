Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264514AbUEaCc2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264514AbUEaCc2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 May 2004 22:32:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264515AbUEaCc2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 May 2004 22:32:28 -0400
Received: from web90002.mail.scd.yahoo.com ([66.218.94.60]:52356 "HELO
	web90002.mail.scd.yahoo.com") by vger.kernel.org with SMTP
	id S264514AbUEaCcZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 May 2004 22:32:25 -0400
Message-ID: <20040531023225.93772.qmail@web90002.mail.scd.yahoo.com>
Date: Sun, 30 May 2004 19:32:25 -0700 (PDT)
From: Phy Prabab <phyprabab@yahoo.com>
Subject: Ooops w/2.6.7-rc2 & XFS
To: linux-xfs@oss.sgi.com
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Ran into this problem today.  The machine in question
is a dual Xeon 2.4GHz w/a 1.5T 3Ware sata volume
carved out  vi LVM2 and formated with XFS:

nfsd: non-standard errno: -990
Filesystem "dm-1": XFS internal error
xfs_btree_check_sblock at line 342 of file
fs/xfs/xfs_btree.c.  Caller 0xc025c414
 [<c0240098>] xfs_btree_check_sblock+0x65/0xed
 [<c025c414>] xfs_inobt_lookup+0x19f/0x3cf
 [<c025c414>] xfs_inobt_lookup+0x19f/0x3cf
 [<c0259832>] xfs_dialloc+0x316/0xb74
 [<c027ef70>] xfs_vget+0xcf/0xe8
 [<c016f836>] iput+0x3c/0x76
 [<c026c8e2>] xlog_grant_log_space+0x260/0x408
 [<c0261736>] xfs_ialloc+0x7a/0x4bd
 [<c027c595>] xfs_dir_ialloc+0x9b/0x323
 [<c027923b>] xfs_trans_reserve+0x8b/0x1f9
 [<c0283988>] xfs_mkdir+0x2d9/0x77d
 [<c021d664>] xfs_acl_vhasacl_default+0x3b/0x49
 [<c028ecdb>] linvfs_mknod+0x44c/0x451
 [<c037cec9>] tcp_transmit_skb+0x40b/0x693
 [<c011864d>] __wake_up_common+0x3f/0x5e
 [<c028ed17>] linvfs_mkdir+0x2a/0x2e
 [<c0164eaf>] vfs_mkdir+0x9f/0x118
 [<c01e7b3f>] nfsd_create+0x443/0x48a
 [<c01eed79>] nfsd3_proc_mkdir+0xd3/0x11b
 [<c01e32a4>] nfsd_dispatch+0x15e/0x20e
 [<c03a9d7d>] svc_process+0x406/0x61d
 [<c01e2f97>] nfsd+0x1ed/0x39c
 [<c01e2daa>] nfsd+0x0/0x39c
 [<c01022b5>] kernel_thread_helper+0x5/0xb


I unmounted and repaired which allowed the unit to run
for another couple of hours only to get hosed again
with the above trace.

Any suggestions?

Thank you for your time.
Phy


	
		
__________________________________
Do you Yahoo!?
Friends.  Fun.  Try the all-new Yahoo! Messenger.
http://messenger.yahoo.com/ 
