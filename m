Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269216AbUJQQRa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269216AbUJQQRa (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Oct 2004 12:17:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269210AbUJQQPk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Oct 2004 12:15:40 -0400
Received: from vsmtp4alice-fr.tin.it ([212.216.176.150]:24965 "EHLO
	vsmtp4.tin.it") by vger.kernel.org with ESMTP id S269187AbUJQQKD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Oct 2004 12:10:03 -0400
Subject: [PATCH 8/8] replacing/fixing printk with pr_debug/pr_info in
	include/asm-i386 - smpboot_hooks.h
From: Daniele Pizzoni <auouo@tin.it>
To: kernel-janitors <kernel-janitors@lists.osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>
Content-Type: text/plain
Message-Id: <1098032701.3023.134.camel@pdp11.tsho.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sun, 17 Oct 2004 19:11:42 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Replace custom macro Dprintk with pr_debug from kernel.h.

Signed-off-by: Daniele Pizzoni <auouo@tin.it>

Index: linux-2.6.9-rc4/include/asm-i386/mach-default/smpboot_hooks.h
===================================================================
--- linux-2.6.9-rc4.orig/include/asm-i386/mach-default/smpboot_hooks.h	2004-08-14 07:36:44.000000000 +0200
+++ linux-2.6.9-rc4/include/asm-i386/mach-default/smpboot_hooks.h	2004-10-17 17:01:24.044525072 +0200
@@ -10,11 +10,11 @@ static inline void smpboot_setup_warm_re
 {
 	CMOS_WRITE(0xa, 0xf);
 	local_flush_tlb();
-	Dprintk("1.\n");
+	pr_debug("1.\n");
 	*((volatile unsigned short *) TRAMPOLINE_HIGH) = start_eip >> 4;
-	Dprintk("2.\n");
+	pr_debug("2.\n");
 	*((volatile unsigned short *) TRAMPOLINE_LOW) = start_eip & 0xf;
-	Dprintk("3.\n");
+	pr_debug("3.\n");
 }
 
 static inline void smpboot_restore_warm_reset_vector(void)


