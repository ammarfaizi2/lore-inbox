Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266136AbUITIQA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266136AbUITIQA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Sep 2004 04:16:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262085AbUITIP7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Sep 2004 04:15:59 -0400
Received: from mail.cobolt.net ([213.180.160.231]:40658 "EHLO
	mustang.cobolt.net") by vger.kernel.org with ESMTP id S266143AbUITIGh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Sep 2004 04:06:37 -0400
Date: Mon, 20 Sep 2004 10:04:27 +0200
From: Stefan Hornburg (Racke) <kernel@linuxia.de>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Kernel BUG at mm/prio_tree.c:538
Message-Id: <20040920100427.40dde54a.kernel@linuxia.de>
Organization: LinuXia Systems
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Virus-Scanned-By: AMaViS-ng with CLAMD on mustang.cobolt.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

on one of my machines the kernel is oopsing every so often with
the following message:

Sep 19 18:59:19 www2 kernel: ------------[ cut here ]------------
Sep 19 18:59:19 www2 kernel: kernel BUG at mm/prio_tree.c:538!
Sep 19 18:59:19 www2 kernel: invalid operand: 0000 [#1]
Sep 19 18:59:19 www2 kernel: SMP 
Sep 19 18:59:19 www2 kernel: Modules linked in: dm_mod
Sep 19 18:59:19 www2 kernel: CPU:    0
Sep 19 18:59:19 www2 kernel: EIP:    0060:[vma_prio_tree_add+21/160]    Not tainted
Sep 19 18:59:19 www2 kernel: EFLAGS: 00010206   (2.6.8.1) 
Sep 19 18:59:19 www2 kernel: EIP is at vma_prio_tree_add+0x15/0xa0
Sep 19 18:59:19 www2 kernel: eax: d8e2b5b8   ebx: d5298f90   ecx: 00000000   edx: 0000000a
Sep 19 18:59:19 www2 kernel: esi: d8e2b5b8   edi: 00000000   ebp: 0fa9b000   esp: d8e91ef0
Sep 19 18:59:19 www2 kernel: ds: 007b   es: 007b   ss: 0068
Sep 19 18:59:19 www2 kernel: Process cfserver (pid: 1317, threadinfo=d8e91000 task=d7fb4650)
Sep 19 18:59:20 www2 kernel: Stack: d5298fb8 d5298f90 00000000 c0135b19 d5298f90 d8e2b5b8 d6004bf4 d6fa68ac 
Sep 19 18:59:20 www2 kernel:        c013ed0f d5298f90 ded2be58 d6fa68ac d6fa6900 d5298f90 0fa9b000 bd7fed90 
Sep 19 18:59:20 www2 kernel:        00000000 00000000 def6a780 ded2be58 ded2be38 00000000 df84e300 c013fdf4 
Sep 19 18:59:20 www2 kernel: Call Trace:
Sep 19 18:59:20 www2 kernel:  [vma_prio_tree_insert+37/44] vma_prio_tree_insert+0x25/0x2c
Sep 19 18:59:20 www2 kernel:  [vma_adjust+363/808] vma_adjust+0x16b/0x328
Sep 19 18:59:20 www2 kernel:  [split_vma+252/264] split_vma+0xfc/0x108
Sep 19 18:59:20 www2 kernel:  [do_munmap+126/280] do_munmap+0x7e/0x118
Sep 19 18:59:20 www2 kernel:  [sys_munmap+56/88] sys_munmap+0x38/0x58
Sep 19 18:59:20 www2 kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Sep 19 18:59:20 www2 kernel: Code: 0f 0b 1a 02 9f 51 35 c0 8b 43 04 8b 7b 08 29 c7 89 f8 c1 e8 

This happens with 2.6.8.1 as well as with earlier kernels. 
This is a Quad-Xeon-Box from Dell (SMP kernel).
I've no idea what is causing these failures and didn't found anything useful
by searching. Therefore I would be grateful for any help.

With regards

	Racke

-- 
LinuXia Systems => http://www.linuxia.de/
Expert Interchange Consulting and System Administration
ICDEVGROUP => http://www.icdevgroup.org/
Interchange Development Team

