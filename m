Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265785AbUBFTQf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Feb 2004 14:16:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265802AbUBFTPV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Feb 2004 14:15:21 -0500
Received: from devil.servak.biz ([209.124.81.2]:8428 "EHLO devil.servak.biz")
	by vger.kernel.org with ESMTP id S265785AbUBFTMH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Feb 2004 14:12:07 -0500
Subject: 2.6.2-mm1 - errors during boot
From: Torrey Hoffman <thoffman@arnor.net>
To: Linux-Kernel List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1076094927.6331.5.camel@moria.arnor.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Fri, 06 Feb 2004 11:15:27 -0800
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - devil.servak.biz
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - arnor.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I didn't have these with 2.6.2-rc3-mm1.

(snipped from dmesg log:)
...
found reiserfs format "3.6" with standard journal
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[00508d0000f42af5]
Badness in kobject_get at lib/kobject.c:431
Call Trace:
 [<c02078dc>] kobject_get+0x3c/0x50
 [<c0272fd1>] get_device+0x11/0x20
 [<c0273c68>] bus_for_each_dev+0x78/0xd0
 [<fc876185>] nodemgr_node_probe+0x45/0x100 [ieee1394]
 [<fc876030>] nodemgr_probe_ne_cb+0x0/0x90 [ieee1394]
 [<fc87654b>] nodemgr_host_thread+0x14b/0x180 [ieee1394]
 [<fc876400>] nodemgr_host_thread+0x0/0x180 [ieee1394]
 [<c010b285>] kernel_thread_helper+0x5/0x10
 
Unable to handle kernel paging request at virtual address 57e58955
 printing eip:
57e58955
*pde = 00000000
Oops: 0000 [#1]
PREEMPT SMP
CPU:    0
EIP:    0060:[<57e58955>]    Not tainted VLI
EFLAGS: 00010206
EIP is at 0x57e58955
eax: fc87f5a8   ebx: fc87f5a8   ecx: fc87f584   edx: 57e58955
esi: fc875af0   edi: 00000000   ebp: f7265f6c   esp: f7265f58
ds: 007b   es: 007b   ss: 0068
Process knodemgrd_0 (pid: 28, threadinfo=f7264000 task=f7267780)
Stack: c0207974 fc874940 fc87f584 fc87f58c fc87f4e0 f7265f90 c0273c7a
fc87f52c
       00000000 f7350244 f7265fa4 f735023c f7265fa4 f7c46398 f7265fc8
fc876185
       fc876030 f7fa8000 00000001 f7c46398 f7350200 0000ffff f7265fb8
00000004
Call Trace:
 [<c0207974>] kobject_cleanup+0x84/0x90
 [<fc874940>] nodemgr_bus_match+0x0/0xb0 [ieee1394]
 [<c0273c7a>] bus_for_each_dev+0x8a/0xd0
 [<fc876185>] nodemgr_node_probe+0x45/0x100 [ieee1394]
 [<fc876030>] nodemgr_probe_ne_cb+0x0/0x90 [ieee1394]
 [<fc87654b>] nodemgr_host_thread+0x14b/0x180 [ieee1394]
 [<fc876400>] nodemgr_host_thread+0x0/0x180 [ieee1394]
 [<c010b285>] kernel_thread_helper+0x5/0x10
 
Code:  Bad EIP value.
 Reiserfs journal params: device md1, size 8192, journal first block 18,
max trans len 1024, max batch 900, max commit age 30, max trans age 30
...

-- 
Torrey Hoffman <thoffman@arnor.net>

