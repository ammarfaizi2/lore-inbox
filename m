Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274963AbTHACuk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 22:50:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274964AbTHACuj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 22:50:39 -0400
Received: from user-10cm126.cable.mindspring.com ([64.203.4.70]:12039 "HELO
	cia.zemos.net") by vger.kernel.org with SMTP id S274963AbTHACui
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 22:50:38 -0400
Date: Thu, 31 Jul 2003 19:51:37 -0700 (PDT)
From: Gorik Van Steenberge <gvs@cia.zemos.net>
To: linux-kernel@vger.kernel.org
Subject: 2.6.0-test2 usb-storage problem
Message-ID: <Pine.LNX.4.50L0.0307311948100.2728-100000@cia.zemos.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Hello,

I'm running 2.6.0-test2, this happened right after doing rmmod usb-storage.
If any further info is needed, please send me a mail back.

[root@aeolus:/proc/scsi]# ls
device_info  scsi  usb-storage  usb-storage
[root@aeolus:/proc/scsi]# ll
Segmentation fault
Aug  1 04:42:30 aeolus kernel: drivers/usb/core/usb.c: deregistering driver usb-storage
Aug  1 04:42:36 aeolus kernel: Unable to handle kernel paging request at virtual address d099f800
Aug  1 04:42:36 aeolus kernel:  printing eip:
Aug  1 04:42:36 aeolus kernel: c0179d4c
Aug  1 04:42:36 aeolus kernel: *pde = 012f6067
Aug  1 04:42:36 aeolus kernel: *pte = 00000000
Aug  1 04:42:36 aeolus kernel: Oops: 0000 [#1]
Aug  1 04:42:36 aeolus kernel: CPU:    0
Aug  1 04:42:36 aeolus kernel: EIP:    0060:[<c0179d4c>]    Not tainted
Aug  1 04:42:36 aeolus kernel: EFLAGS: 00010202
Aug  1 04:42:36 aeolus kernel: EIP is at proc_get_inode+0xac/0x140
Aug  1 04:42:36 aeolus kernel: eax: c6b98000   ebx: c712d0d0   ecx: 00000000   edx: d099f800
Aug  1 04:42:36 aeolus kernel: esi: cf633bc0   edi: 00000001   ebp: c76fc2c0   esp: c6b99e24
Aug  1 04:42:36 aeolus kernel: ds: 007b   es: 007b   ss: 0068
Aug  1 04:42:36 aeolus kernel: Process ls (pid: 463, threadinfo=c6b98000 task=c7
77b980)
Aug  1 04:42:36 aeolus kernel: Stack: c712d0d0 00001244 00000000 0000000b c76fc347 cf633c13 c017c932 cffeae00
Aug  1 04:42:36 aeolus kernel:        00001244 cf633bc0 cf633bc0 ffffffea 00000000 fffffff4 c712dbb8 c712db50
Aug  1 04:42:36 aeolus kernel:        c76fc2c0 c015bb5c c712db50 c76fc2c0 c6b99f38 00000000 c6b99f38 cfff0f00
Aug  1 04:42:36 aeolus kernel: Call Trace:
Aug  1 04:42:36 aeolus kernel:  [<c017c932>] proc_lookup+0x112/0x120
Aug  1 04:42:36 aeolus kernel:  [<c015bb5c>] real_lookup+0xcc/0xf0
Aug  1 04:42:36 aeolus kernel:  [<c015bde6>] do_lookup+0x96/0xb0
Aug  1 04:42:36 aeolus kernel:  [<c015c29d>] link_path_walk+0x49d/0x8e0
Aug  1 04:42:36 aeolus kernel:  [<c015b9d5>] path_release+0x15/0x40
Aug  1 04:42:36 aeolus kernel:  [<c015cbb9>] __user_walk+0x49/0x60
Aug  1 04:42:36 aeolus kernel:  [<c0157c1c>] vfs_lstat+0x1c/0x60
Aug  1 04:42:36 aeolus kernel:  [<c01582db>] sys_lstat64+0x1b/0x40
Aug  1 04:42:36 aeolus kernel:  [<c0109177>] syscall_call+0x7/0xb
Aug  1 04:42:36 aeolus kernel:
Aug  1 04:42:36 aeolus kernel: Code: 83 3a 02 74 4a ff 82 c0 00 00 00 b8 00 e0 ff ff 21 e0 ff 48
Aug  1 04:42:36 aeolus kernel:  <6>note: ls[463] exited with preempt_count 2
Aug  1 04:43:23 aeolus kernel: SysRq : Emergency Sync
Aug  1 04:43:23 aeolus kernel: Emergency Sync complete

After this happened, I did rmmod sd_mod and then scsi_mod:

Aug  1 04:44:55 aeolus kernel: remove_proc_entry: /proc/scsi busy, count=1


Cheers,

Gorik

