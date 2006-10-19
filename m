Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946604AbWJSWjU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946604AbWJSWjU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 18:39:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946602AbWJSWjU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 18:39:20 -0400
Received: from e32.co.us.ibm.com ([32.97.110.150]:31932 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1946604AbWJSWjS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 18:39:18 -0400
Subject: 2.6.19-rc2-mm1 warning in invalidate_inode_pages2_range()
From: Badari Pulavarty <pbadari@us.ibm.com>
To: Zach Brown <zach.brown@oracle.com>, ext4 <linux-ext4@vger.kernel.org>,
       akpm@osdl.org
Cc: lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Thu, 19 Oct 2006 15:39:06 -0700
Message-Id: <1161297546.26843.33.camel@dyn9047017100.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Zach,

While running IO tests I get following messages on 2.6.19-rc2-mm1

BUG: warning at mm/truncate.c:400/invalidate_inode_pages2_range()

Call Trace:
 [<ffffffff8020b481>] show_trace+0x41/0x70
 [<ffffffff8020b4c2>] dump_stack+0x12/0x20
 [<ffffffff80257f17>] invalidate_inode_pages2_range+0x297/0x2e0
 [<ffffffff8024fcb5>] generic_file_direct_IO+0xf5/0x130
 [<ffffffff8024fd64>] generic_file_direct_write+0x74/0x140
 [<ffffffff802507cc>] __generic_file_aio_write_nolock+0x36c/0x4b0
 [<ffffffff80250977>] generic_file_aio_write+0x67/0xd0
 [<ffffffff8808f6d3>] :ext4dev:ext4_file_write+0x23/0xc0
DWARF2 unwinder stuck at ext4_file_write+0x23/0xc0 [ext4dev]
Leftover inexact backtrace:
 [<ffffffff8027379f>] do_sync_write+0xcf/0x120
 [<ffffffff802772b7>] cp_new_stat+0xe7/0x100
 [<ffffffff8023db90>] autoremove_wake_function+0x0/0x30
 [<ffffffff804805bf>] __mutex_lock_slowpath+0x1df/0x1f0
 [<ffffffff8027408d>] vfs_write+0xbd/0x180
 [<ffffffff802747b3>] sys_write+0x53/0x90
 [<ffffffff80209c1e>] system_call+0x7e/0x83


FYI.

Thaks
Badari

