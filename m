Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132913AbRDEOwt>; Thu, 5 Apr 2001 10:52:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132917AbRDEOwf>; Thu, 5 Apr 2001 10:52:35 -0400
Received: from mx3out.umbc.edu ([130.85.253.53]:63698 "EHLO mx3out.umbc.edu")
	by vger.kernel.org with ESMTP id <S132913AbRDEOw1>;
	Thu, 5 Apr 2001 10:52:27 -0400
Date: Thu, 5 Apr 2001 10:51:45 -0400
From: John Jasen <jjasen1@umbc.edu>
X-X-Sender: <jjasen1@irix2.gl.umbc.edu>
To: <linux-kernel@vger.kernel.org>
Subject: kernel bug in 2.4.2-ac28, patched with 6.1.8 aic drivers
Message-ID: <Pine.SGI.4.31L.02.0104051048001.2606646-100000@irix2.gl.umbc.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


got this on booting up 2.4.2-ac28:
Apr  5 09:36:37 grim kernel: kernel BUG at slab.c:1244!
Apr  5 09:36:37 grim kernel: invalid operand: 0000
Apr  5 09:36:37 grim kernel: CPU:    0
Apr  5 09:36:37 grim kernel: EIP:    0010:[kmalloc+303/472]
Apr  5 09:36:37 grim kernel: EFLAGS: 00010086
Apr  5 09:36:37 grim kernel: eax: 0000001b   ebx: c1447768   ecx: c02900a0   edx: 000016ea
Apr  5 09:36:37 grim kernel: esi: cea5a000   edi: cea5a9aa   ebp: 00012800   esp: cf27de30
Apr  5 09:36:37 grim kernel: ds: 0018   es: 0018   ss: 0018
Apr  5 09:36:37 grim kernel: Process mingetty (pid: 672, stackpage=cf27d000)
Apr  5 09:36:37 grim kernel: Stack: c023a56b 000004dc c02ffae0 00000403 00000403 00000000 cea5a000 00001000
Apr  5 09:36:37 grim kernel:        00000015 00000246 c01b1dfe 00000c3c 00000007 c02ffae0 00000403 c01b2a6a
Apr  5 09:36:37 grim kernel:        00000000 00000000 cf011a30 cff0de74 00000001 cf27dee8 c0291080 cf27c000
Apr  5 09:36:37 grim kernel: Call Trace: [alloc_tty_struct+14/40] [init_dev+138/1088] [tty_open+475/944] [cached_l
ookup+16/84] [get_chrfops+106/232] [permission+43/48] [chrdev_open+64/76]
Apr  5 09:36:37 grim kernel:        [dentry_open+198/336] [filp_open+82/92] [sys_open+56/180] [system_call+51/56]
Apr  5 09:36:37 grim kernel:
Apr  5 09:36:37 grim kernel: Code: 0f 0b 83 c4 08 8b 6b 10 f7 c5 00 04 00
00 74 53 b8 a5 c2 0f

Console was half dead -- got the login prompt, but a whole lot of nothing
afterwards, but I was able to SysRQ-sync and reboot into another kernel.

This problem does not appear in 2.4.3-ac3, FWIW.

--
-- John E. Jasen (jjasen1@umbc.edu)
-- In theory, theory and practise are the same. In practise, they aren't.

