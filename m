Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269603AbUICWeW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269603AbUICWeW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 18:34:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269980AbUICWeW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 18:34:22 -0400
Received: from aun.it.uu.se ([130.238.12.36]:62937 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S269603AbUICWd4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 18:33:56 -0400
Date: Sat, 4 Sep 2004 00:33:34 +0200 (MEST)
Message-Id: <200409032233.i83MXY8S018787@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: akpm@osdl.org
Subject: [PATCH][2.6.9-rc1-mm3] repair x86_64' IA32_NR_syscalls #define
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The waitid/perfctr system call numbers shuffle in 2.6.9-rc1-mm3
broke x86_64' IA32_NR_syscalls #define: it was decremented by
one when it should have remained unchanged.

This patch restores its correct value.

/Mikael

--- linux-2.6.9-rc1-mm3/include/asm-x86_64/ia32_unistd.h.~1~	2004-09-03 23:06:33.000000000 +0200
+++ linux-2.6.9-rc1-mm3/include/asm-x86_64/ia32_unistd.h	2004-09-04 00:11:36.827628168 +0200
@@ -297,6 +297,6 @@
 #define __NR_ia32_vperfctr_iresume	(__NR_ia32_perfctr_info+4)
 #define __NR_ia32_vperfctr_read		(__NR_ia32_perfctr_info+5)
 
-#define IA32_NR_syscalls 290	/* must be > than biggest syscall! */
+#define IA32_NR_syscalls 291	/* must be > than biggest syscall! */
 
 #endif /* _ASM_X86_64_IA32_UNISTD_H_ */
