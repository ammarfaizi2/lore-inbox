Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262777AbTJJJlr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Oct 2003 05:41:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262781AbTJJJlr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Oct 2003 05:41:47 -0400
Received: from mail-6.tiscali.it ([195.130.225.152]:23791 "EHLO
	mail-6.tiscali.it") by vger.kernel.org with ESMTP id S262777AbTJJJlo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Oct 2003 05:41:44 -0400
From: Lorenzo Allegrucci <l.allegrucci@tiscali.it>
Organization: -ENOENT
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [OOPS] 2.6.0-test7
Date: Fri, 10 Oct 2003 11:41:03 +0000
User-Agent: KMail/1.5.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200310101141.03064.l.allegrucci@tiscali.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Multiple oops, machine is a Athlon uniprocessor.
100% reproducible.  Need more info? My .config?
(sorry >80 cols)

Oct 10 11:25:01 odyssey kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000034
Oct 10 11:25:01 odyssey kernel:  printing eip:
Oct 10 11:25:01 odyssey kernel: c0177d79
Oct 10 11:25:01 odyssey kernel: *pde = 00000000
Oct 10 11:25:01 odyssey kernel: Oops: 0000 [#1]
Oct 10 11:25:01 odyssey kernel: CPU:    0
Oct 10 11:25:01 odyssey kernel: EIP:    0060:[proc_pid_stat+489/1072]    Not tainted
Oct 10 11:25:01 odyssey kernel: EFLAGS: 00010212
Oct 10 11:25:01 odyssey kernel: EIP is at proc_pid_stat+0x1e9/0x430
Oct 10 11:25:01 odyssey kernel: eax: 00000000   ebx: 00000000   ecx: 00055fef   edx: d8412040
Oct 10 11:25:01 odyssey kernel: esi: 0000000a   edi: daf7eb00   ebp: da665f44   esp: da665e3c
Oct 10 11:25:01 odyssey kernel: ds: 007b   es: 007b   ss: 0068
Oct 10 11:25:01 odyssey kernel: Process killall (pid: 19781, threadinfo=da664000 task=d672ac80)
Oct 10 11:25:01 odyssey kernel: Stack: d8412040 0000002b d5656c40 3f867aed 1fdc23c8 c036efa0 c036efa0 c036efa0
Oct 10 11:25:01 odyssey kernel:        da665e8c c01761c3 d4cde3c0 d5656c50 0000000d c0354a27 00000004 d8412040
Oct 10 11:25:01 odyssey kernel:        ffffffea fffffff4 d5656e38 d5656dd0 da665eb0 c01576d4 d5656dd0 da665eb4
Oct 10 11:25:01 odyssey kernel: Call Trace:
Oct 10 11:25:01 odyssey kernel:  [proc_pident_lookup+243/544] proc_pident_lookup+0xf3/0x220
Oct 10 11:25:01 odyssey kernel:  [real_lookup+212/256] real_lookup+0xd4/0x100
Oct 10 11:25:01 odyssey kernel:  [rb_insert_color+224/256] rb_insert_color+0xe0/0x100
Oct 10 11:25:01 odyssey kernel:  [buffered_rmqueue+177/320] buffered_rmqueue+0xb1/0x140
Oct 10 11:25:01 odyssey kernel:  [do_exit+374/816] do_exit+0x176/0x330
Oct 10 11:25:01 odyssey kernel:  [proc_info_read+83/352] proc_info_read+0x53/0x160
Oct 10 11:25:01 odyssey kernel:  [old_mmap+305/384] old_mmap+0x131/0x180
Oct 10 11:25:01 odyssey kernel:  [vfs_read+160/288] vfs_read+0xa0/0x120
Oct 10 11:25:01 odyssey kernel:  [sys_read+63/96] sys_read+0x3f/0x60
Oct 10 11:25:01 odyssey kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Oct 10 11:25:01 odyssey kernel:
Oct 10 11:25:01 odyssey kernel: Code: 8b 58 34 8b 70 2c 8b 42 40 89 84 24 ac 00 00 00 8b 82 60 01
Oct 10 11:25:01 odyssey kernel:  <1>Unable to handle kernel NULL pointer dereference at virtual address 00000034
Oct 10 11:25:01 odyssey kernel:  printing eip:
Oct 10 11:25:01 odyssey kernel: c0177d79
Oct 10 11:25:01 odyssey kernel: *pde = 00000000
Oct 10 11:25:01 odyssey kernel: Oops: 0000 [#2]
Oct 10 11:25:01 odyssey kernel: CPU:    0
Oct 10 11:25:01 odyssey kernel: EIP:    0060:[proc_pid_stat+489/1072]    Not tainted
Oct 10 11:25:01 odyssey kernel: EFLAGS: 00010212
Oct 10 11:25:01 odyssey kernel: EIP is at proc_pid_stat+0x1e9/0x430
Oct 10 11:25:01 odyssey kernel: eax: 00000000   ebx: 00000000   ecx: 00055fef   edx: d8412040
Oct 10 11:25:01 odyssey kernel: esi: 0000000a   edi: daf7eb00   ebp: d49b7f44   esp: d49b7e3c
Oct 10 11:25:01 odyssey kernel: ds: 007b   es: 007b   ss: 0068
Oct 10 11:25:01 odyssey kernel: Process killall (pid: 19919, threadinfo=d49b6000 task=da152640)
Oct 10 11:25:01 odyssey kernel: Stack: d8412040 0000002b dbb8d900 db84c200 401c6000 00000001 00000001 401c6000
Oct 10 11:25:01 odyssey kernel:        da152640 0000024b 00000100 00000203 00000000 00000246 00000000 00000000
Oct 10 11:25:01 odyssey kernel:        00000203 c036d474 00000000 d4cde430 00001000 d4cde3c0 d49b7eb0 d49b7eb4 
Oct 10 11:25:01 odyssey kernel: Call Trace:
Oct 10 11:25:01 odyssey kernel:  [rb_insert_color+224/256] rb_insert_color+0xe0/0x100
Oct 10 11:25:01 odyssey kernel:  [buffered_rmqueue+177/320] buffered_rmqueue+0xb1/0x140
Oct 10 11:25:01 odyssey kernel:  [do_exit+374/816] do_exit+0x176/0x330
Oct 10 11:25:01 odyssey kernel:  [proc_info_read+83/352] proc_info_read+0x53/0x160
Oct 10 11:25:01 odyssey kernel:  [old_mmap+305/384] old_mmap+0x131/0x180
Oct 10 11:25:01 odyssey kernel:  [vfs_read+160/288] vfs_read+0xa0/0x120
Oct 10 11:25:01 odyssey kernel:  [sys_read+63/96] sys_read+0x3f/0x60
Oct 10 11:25:01 odyssey kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Oct 10 11:25:01 odyssey kernel:
Oct 10 11:25:01 odyssey kernel: Code: 8b 58 34 8b 70 2c 8b 42 40 89 84 24 ac 00 00 00 8b 82 60 01
Oct 10 11:25:01 odyssey kernel:  <1>Unable to handle kernel NULL pointer dereference at virtual address 00000034
Oct 10 11:25:01 odyssey kernel:  printing eip:
Oct 10 11:25:01 odyssey kernel: c0177d79
Oct 10 11:25:01 odyssey kernel: *pde = 00000000
Oct 10 11:25:01 odyssey kernel: Oops: 0000 [#3]
Oct 10 11:25:01 odyssey kernel: CPU:    0
Oct 10 11:25:01 odyssey kernel: EIP:    0060:[proc_pid_stat+489/1072]    Not tainted
Oct 10 11:25:01 odyssey kernel: EFLAGS: 00010212
Oct 10 11:25:01 odyssey kernel: EIP is at proc_pid_stat+0x1e9/0x430
Oct 10 11:25:01 odyssey kernel: eax: 00000000   ebx: 00000000   ecx: 00055fef   edx: d8412040
Oct 10 11:25:01 odyssey kernel: esi: 0000000a   edi: daf7eb00   ebp: dbf05f44   esp: dbf05e3c
Oct 10 11:25:01 odyssey kernel: ds: 007b   es: 007b   ss: 0068
Oct 10 11:25:01 odyssey kernel: Process killall (pid: 20033, threadinfo=dbf04000 task=dbbeec80)
Oct 10 11:25:01 odyssey kernel: Stack: d8412040 0000002b d7283940 d9039600 401c6000 00000001 00000001 401c6000
Oct 10 11:25:01 odyssey kernel:        dbbeec80 0000024b 00000100 00000203 00000000 00000246 00000000 00000000 
Oct 10 11:25:01 odyssey kernel:        00000203 c036d474 00000000 d4cde430 00001000 d4cde3c0 dbf05eb0 dbf05eb4
Oct 10 11:25:01 odyssey kernel: Call Trace:
Oct 10 11:25:01 odyssey kernel:  [rb_insert_color+224/256] rb_insert_color+0xe0/0x100
Oct 10 11:25:01 odyssey kernel:  [buffered_rmqueue+177/320] buffered_rmqueue+0xb1/0x140
Oct 10 11:25:01 odyssey kernel:  [do_exit+374/816] do_exit+0x176/0x330
Oct 10 11:25:01 odyssey kernel:  [proc_info_read+83/352] proc_info_read+0x53/0x160
Oct 10 11:25:01 odyssey kernel:  [old_mmap+305/384] old_mmap+0x131/0x180
Oct 10 11:25:01 odyssey kernel:  [vfs_read+160/288] vfs_read+0xa0/0x120
Oct 10 11:25:01 odyssey kernel:  [sys_read+63/96] sys_read+0x3f/0x60
Oct 10 11:25:01 odyssey kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Oct 10 11:25:01 odyssey kernel:
Oct 10 11:25:01 odyssey kernel: Code: 8b 58 34 8b 70 2c 8b 42 40 89 84 24 ac 00 00 00 8b 82 60 01 



