Return-Path: <linux-kernel-owner+willy=40w.ods.org-S281185AbUKBDga@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S281185AbUKBDga (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Nov 2004 22:36:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264579AbUKAW6p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Nov 2004 17:58:45 -0500
Received: from outmx002.isp.belgacom.be ([195.238.3.52]:26777 "EHLO
	outmx002.isp.belgacom.be") by vger.kernel.org with ESMTP
	id S283403AbUKAVga (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Nov 2004 16:36:30 -0500
Date: Mon, 1 Nov 2004 22:36:22 +0100
From: Vincent Thomasset <vincent.thomasset@skynet.be>
To: linux-kernel@vger.kernel.org
Subject: [2.6.9] BUG - include/linux/dcache.h (modprobe -r floppy)
Message-ID: <20041101223622.2f3080d9@klamath>
X-Mailer: Sylpheed-Claws 0.9.12b (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I got this the first time i try to 'modprobe -r floppy' (then it says
it's busy).

I don't know if tainted kernels (nvidia) are supported but i thought
this may not be related.

I didn't post my kernel config since it was more than 1000 lines, it's
available at http://users.skynet.be/fa309820/linux-config

I'm not subscribed to the list.

Hope it'll help, good luck and thanks.

--------------

kernel BUG at include/linux/dcache.h:276!
invalid operand: 0000 [#1]
PREEMPT 
Modules linked in: rd floppy usblp via_rhine ipt_MASQUERADE iptable_nat
iptable_filter ip_tables nvidia pppoatm CPU:    0
EIP:    0060:[sysfs_remove_dir+293/320]    Tainted: P   VLI
EFLAGS: 00010246   (2.6.9) 
EIP is at sysfs_remove_dir+0x125/0x140
eax: 00000000   ebx: d3d7a078   ecx: d4a69260   edx: c13127e0
esi: d1c4c0fc   edi: c1302978   ebp: 00000000   esp: c4cd1ec0
ds: 007b   es: 007b   ss: 0068
Process modprobe (pid: 1914, threadinfo=c4cd0000 task=c2acfaa0)
Stack: c13287c0 c1302978 d3d7a078 c13028a0 c1302978 00000000 c01bf213
d3d7a078        d3d7a078 d3d7a078 c01bf243 d3d7a078 d3d7a028 c01eb56a
d3d7a078 d3d7a028        c01ef818 d3d7a028 c13028a0 d4a70ffc c01f0683
c13028a0 c13028a0 c13028a0 Call Trace:
 [kobject_del+35/64] kobject_del+0x23/0x40
 [kobject_unregister+19/48] kobject_unregister+0x13/0x30
 [elv_unregister_queue+26/64] elv_unregister_queue+0x1a/0x40
 [blk_unregister_queue+56/96] blk_unregister_queue+0x38/0x60
 [unlink_gendisk+19/64] unlink_gendisk+0x13/0x40
 [del_gendisk+100/240] del_gendisk+0x64/0xf0
 [pg0+342570769/1069835264] cleanup_module+0x101/0x110 [floppy]
 [try_stop_module+40/48] try_stop_module+0x28/0x30
 [sys_delete_module+334/384] sys_delete_module+0x14e/0x180
 [do_munmap+326/400] do_munmap+0x146/0x190
 [sysenter_past_esp+82/113] sysenter_past_esp+0x52/0x71
Code: 04 24 e8 af ca fe ff 89 1c 24 e8 07 3d fe ff ff 45 14 e9 2d ff ff
ff 8b 43 4c 89 04 24 e8 44 cd 03 00 eb d4 e8 4d 58 13 00 eb ba <0f> 0b
14 01 55 76 2c c0 e9 ee fe ff ff 83 c4 08 5b 5e 5f 5d c3 
