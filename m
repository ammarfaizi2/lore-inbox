Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262957AbUKRU5b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262957AbUKRU5b (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 15:57:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261164AbUKRU4H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 15:56:07 -0500
Received: from amsfep20-int.chello.nl ([213.46.243.18]:12879 "EHLO
	amsfep20-int.chello.nl") by vger.kernel.org with ESMTP
	id S262957AbUKRUtk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 15:49:40 -0500
Date: Thu, 18 Nov 2004 21:49:27 +0100
Message-Id: <200411182049.iAIKnRYj007063@anakin.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Greg Ungerer <gerg@snapgear.com>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 522] M68k: Add 3 missing syscalls
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

M68k: Add 3 missing syscalls (up to 2.6.10-rc1)

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

--- linux-2.6.10-rc1/arch/m68k/kernel/entry.S	2004-10-24 22:21:53.000000000 +0200
+++ linux-m68k-2.6.10-rc1/arch/m68k/kernel/entry.S	2004-10-30 13:43:12.000000000 +0200
@@ -706,4 +706,7 @@ sys_call_table:
 	.long sys_mq_getsetattr
 	.long sys_waitid
 	.long sys_ni_syscall	/* for sys_vserver */
+	.long sys_add_key
+	.long sys_request_key	/* 280 */
+	.long sys_keyctl
 
--- linux-2.6.10-rc1/include/asm-m68k/unistd.h	2004-10-24 22:21:53.000000000 +0200
+++ linux-m68k-2.6.10-rc1/include/asm-m68k/unistd.h	2004-10-30 13:43:35.000000000 +0200
@@ -281,8 +281,11 @@
 #define __NR_mq_getsetattr	276
 #define __NR_waitid		277
 #define __NR_vserver		278
+#define __NR_add_key		279
+#define __NR_request_key	280
+#define __NR_keyctl		281
 
-#define NR_syscalls		279
+#define NR_syscalls		282
 
 /* user-visible error numbers are in the range -1 - -124: see
    <asm-m68k/errno.h> */

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
