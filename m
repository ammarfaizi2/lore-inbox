Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262381AbUKKVFf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262381AbUKKVFf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Nov 2004 16:05:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262382AbUKKVFe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Nov 2004 16:05:34 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:15808 "EHLO
	MTVMIME01.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S262381AbUKKVFa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Nov 2004 16:05:30 -0500
Date: Thu, 11 Nov 2004 21:05:11 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] WTF is VLI?
Message-ID: <Pine.LNX.4.44.0411112103060.3167-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

What is this "VLI" that 2.6.9 started putting after the taint string
in i386 oopses?  Vick Library Index?  Vineyard Leadership Institute?
Shall we just remove it?

Signed-off-by: Hugh Dickins <hugh@veritas.com>

--- 2.6.10-rc1-bk20/arch/i386/kernel/traps.c	2004-11-10 14:05:34.000000000 +0000
+++ linux/arch/i386/kernel/traps.c	2004-11-11 20:53:06.725490224 +0000
@@ -215,7 +215,7 @@ void show_registers(struct pt_regs *regs
 		ss = regs->xss & 0xffff;
 	}
 	print_modules();
-	printk("CPU:    %d\nEIP:    %04x:[<%08lx>]    %s VLI\nEFLAGS: %08lx"
+	printk("CPU:    %d\nEIP:    %04x:[<%08lx>]    %s\nEFLAGS: %08lx"
 			"   (%s) \n",
 		smp_processor_id(), 0xffff & regs->xcs, regs->eip,
 		print_tainted(), regs->eflags, system_utsname.release);

