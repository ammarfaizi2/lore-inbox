Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263201AbSJGUvs>; Mon, 7 Oct 2002 16:51:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263195AbSJGUuY>; Mon, 7 Oct 2002 16:50:24 -0400
Received: from mail000.mail.bellsouth.net ([205.152.58.20]:60953 "EHLO
	imf00bis.bellsouth.net") by vger.kernel.org with ESMTP
	id <S263196AbSJGUuG>; Mon, 7 Oct 2002 16:50:06 -0400
Date: Mon, 7 Oct 2002 16:55:28 -0400 (EDT)
From: Burton Windle <bwindle@fint.org>
X-X-Sender: bwindle@morpheus
To: linux-kernel@vger.kernel.org
Subject: [2.5.41] Oops on reboot in device_remove_file
Message-ID: <Pine.LNX.4.43.0210071653490.6732-100000@morpheus>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.5.41, after "Rebooting..." is printed, I get this oops:

 printing eip:
c015b1a2
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0060:[<c015b1a2>]    Not tainted
EFLAGS: 00010246
EIP is at driverfs_remove_file+0x22/0x80
eax: 00000001   ebx: 5a5a5a5a   ecx: 5a5a5ab6   edx: 00000001
esi: 5a5a5ab6   edi: c9fd98ec   ebp: 00000001   esp: c991be18
esi: 5a5a5ab6   edi: c9fd98ec   ebp: 00000001   esp: c991be18
Process reboot (pid: 300, threadinfo=c991a000 task=c13d32a0)
Stack: c026f636 00000077 c9fd984c 00000000 c9fd9800 c01b4f12 c9fd98ec c026f441
       c9fd984c c9fd984c c0159bf2 c9fd984c c02b635c c9fd9800 c9fd9800 00000001
       c015a0e3 c9fd9800 c03c18f4 c01e4a2e c9fd9800 c03c18f4 00000000 c01e2115
Call Trace:
 [<c01b4f12>] device_remove_file+0x22/0x30
 [<c0159bf2>] driverfs_remove_partitions+0x72/0x94
 [<c015a0e3>] del_gendisk+0xb/0x3c
 [<c01e4a2e>] idedisk_cleanup+0x5e/0x70
 [<c01e2115>] ide_notify_reboot+0x8d/0xb8
 [<c011aa2a>] notifier_call_chain+0x1e/0x38
 [<c011aebe>] sys_reboot+0xce/0x2a0
 [<c012196d>] do_no_page+0x219/0x288
 [<c01283b3>] kmem_cache_free+0x19b/0x244
 [<c01283b3>] kmem_cache_free+0x19b/0x244
 [<c0147a79>] dput+0x19/0x184
 [<c0136456>] __fput+0xba/0xdc
 [<c013639b>] fput+0x13/0x14
 [<c0134c95>] filp_close+0x99/0xa4
 [<c0134cf8>] sys_close+0x58/0x80
 [<c0106f6b>] syscall_call+0x7/0xb

Code: ff 4b 5c 0f 88 af 01 00 00 83 c4 08 8b 44 24 14 50 8b 47 04

--
Burton Windle                           burton@fint.org
Linux: the "grim reaper of innocent orphaned children."
          from /usr/src/linux-2.4.18/init/main.c:461


