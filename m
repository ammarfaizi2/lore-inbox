Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262605AbVAPVLD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262605AbVAPVLD (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jan 2005 16:11:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262606AbVAPVLD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jan 2005 16:11:03 -0500
Received: from asmtp01.eresmas.com ([62.81.235.141]:56193 "EHLO
	asmtp01.eresmas.com") by vger.kernel.org with ESMTP id S262605AbVAPVKP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jan 2005 16:10:15 -0500
From: "man_josewanadoo.es" <man_jose@wanadoo.es>
To: linux-kernel@vger.kernel.org
Subject: Kernel bug: mm/rmap.c:483
Date: Sun, 16 Jan 2005 22:12:21 +0100
X-MAILER: ARB/3.0
Content-Type: text/plain; charset=iso-8859-1
Message-Id: <E1CqHh7-0000uQ-93@mb05.in.mad.eresmas.com>
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My name is José María García Pérez (Spain). My system is an: AMD Athlon 800 (this is not an Athlon-XP). I was trying Gentoo for the first time (I'm a newbie). The kernel 2.6.9-r1 makes a similar bug. Then I try to upgrade to kernel-2.6.10-r4. The error persist. It appears when I try to "emerge" with Gentoo. 



What is next is with the kernel-2.6.10-r4



Would you post me to say if the bug is closed or if is my system who is broken?



See you

José María



------------[ cut here ]------------

kernel BUG at mm/rmap.c:483!

invalid operand: 0000 [#1]

Modules linked in:

CPU:    0

EIP:    0060:[<c0143ed9>]    Not tainted VLI

EFLAGS: 00010296   (2.6.10-gentoo-r4)

EIP is at page_remove_rmap+0x29/0x40

eax: fffffff0   ebx: 00000000   ecx: c1215000   edx: c1215000

esi: d0aa8058   edi: c1215000   ebp: 00001000   esp: d1924d64

ds: 007b   es: 007b   ss: 0068

Process doexe (pid: 9678, threadinfo=d1924000 task=d01b9520)

Stack: c013ddf8 c1215000 d1924d84 c0131c10 00000080 10a80067 40416000 cff63404

       40017000 00000000 c013df67 c04ddb68 cff63400 40016000 00001000 00000000

       c04ddb68 40016000 cff63404 40017000 00000000 c013dfdb c04ddb68 cff63400

Call Trace:

 [<c013ddf8>] zap_pte_range+0x128/0x240

 [<c0131c10>] file_read_actor+0x0/0xe0

 [<c013df67>] zap_pmd_range+0x57/0x80

 [<c013dfdb>] unmap_page_range+0x4b/0x80

 [<c013e10d>] unmap_vmas+0xfd/0x1b0

 [<c0142308>] exit_mmap+0x78/0x140

 [<c0112aec>] mmput+0x2c/0x80

 [<c0156e89>] exec_mmap+0x79/0xf0

 [<c015702a>] flush_old_exec+0xca/0x650

 [<c0156e00>] kernel_read+0x50/0x60

 [<c0174bcb>] load_elf_binary+0x33b/0xc80

 [<c013545e>] buffered_rmqueue+0xbe/0x150

 [<c01356ba>] __alloc_pages+0x1ca/0x360

 [<c01ecbc2>] copy_from_user+0x42/0x80

 [<c0156928>] copy_strings+0x188/0x200

 [<c013df67>] zap_pmd_range+0x57/0x80

 [<c013dfdb>] unmap_page_range+0x4b/0x80

 [<c013e10d>] unmap_vmas+0xfd/0x1b0

 [<c0142308>] exit_mmap+0x78/0x140

 [<c0112aec>] mmput+0x2c/0x80

 [<c0156e89>] exec_mmap+0x79/0xf0

 [<c015702a>] flush_old_exec+0xca/0x650

 [<c0156e00>] kernel_read+0x50/0x60

 [<c0174bcb>] load_elf_binary+0x33b/0xc80

 [<c013545e>] buffered_rmqueue+0xbe/0x150

 [<c01356ba>] __alloc_pages+0x1ca/0x360

 [<c01ecbc2>] copy_from_user+0x42/0x80

 [<c0156928>] copy_strings+0x188/0x200

 [<c01577cd>] search_binary_handler+0x5d/0x1b0

 [<c0157aa0>] do_execve+0x180/0x200

 [<c0101c02>] sys_execve+0x42/0xa0

 [<c0102fcf>] syscall_call+0x7/0xb

Code: 26 00 8b 54 24 04 8b 02 f6 c4 08 75 28 83 42 08 ff 0f 98 c0 84 c0 74 11 8b 42 08 40 78 0d 9c 58 fa ff 0d 70 a1 4e c0 50 9d 90 c3 <0f> 0b e3 01 f8 35 3c c0 eb e9 0f 0b e0 01 f8 35 3c c0 eb ce 8d



