Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261492AbSKTQAX>; Wed, 20 Nov 2002 11:00:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261550AbSKTQAW>; Wed, 20 Nov 2002 11:00:22 -0500
Received: from air-2.osdl.org ([65.172.181.6]:36521 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S261492AbSKTQAV>;
	Wed, 20 Nov 2002 11:00:21 -0500
Subject: Call trace at mm/page-writeback.c in 2.5.47
From: Mark Haverkamp <markh@osdl.org>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: 
Message-Id: <1037808468.6367.41.camel@markh1.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.0 
Date: 20 Nov 2002 08:07:48 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

While running a memory stress workload test on a 16 processor numa
system, I received a number of call traces like the following:

buffer layer error at mm/page-writeback.c:559
Pass this trace through ksymoops for reporting
Call Trace:
 [<c013f1fb>] __set_page_dirty_buffers+0x3b/0x150
 [<c012d746>] zap_pte_range+0x1d6/0x2c0
 [<c0183401>] do_get_write_access+0x4a1/0x4d0
 [<c012d89c>] zap_pmd_range+0x6c/0x80
 [<c012d8f0>] unmap_page_range+0x40/0x60
 [<c012da0f>] zap_page_range+0xff/0x180
 [<c012e76a>] vmtruncate_list+0x5a/0x80
 [<c012e835>] vmtruncate+0xa5/0x150
 [<c015b456>] inode_setattr+0x56/0x120
 [<c0179087>] ext3_setattr+0x167/0x1d0
 [<c015b696>] notify_change+0x106/0x1d9
 [<c01433a8>] do_truncate+0x58/0x80
 [<c01213d0>] tasklet_hi_action+0x80/0xd0
 [<c01210cb>] do_softirq+0x5b/0xc0
 [<c0143916>] sys_ftruncate64+0x106/0x120
 [<c0108d73>] syscall_call+0x7/0xb

The system did not crash and continues to run.  If someone wants to look
into this and needs more information, let me know.

Thanks,
Mark. 

-- 
Mark Haverkamp <markh@osdl.org>

