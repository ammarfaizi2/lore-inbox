Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261160AbVALLpx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261160AbVALLpx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 06:45:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261154AbVALLpx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 06:45:53 -0500
Received: from aun.it.uu.se ([130.238.12.36]:25286 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S261160AbVALLps (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 06:45:48 -0500
From: Mikael Pettersson <mikpe@user.it.uu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16869.3554.217069.82614@alkaid.it.uu.se>
Date: Wed, 12 Jan 2005 12:45:38 +0100
To: akpm@osdl.org
CC: linux-kernel@vger.kernel.org
Subject: [PATCH][2.6.10-mm3] perfctr syscall numbers in x86-64 ia32-emulation
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

2.6.10-mm3 reverted the perfctr syscall numbers in x86-64's
ia32-emulation to an older definition when sys_perfctr_info()
still existed. This patch fixes that.

Signed-off-by: Mikael Petterson <mikpe@csd.uu.se>

--- linux-2.6.10-mm3/include/asm-x86_64/ia32_unistd.h.~1~	2005-01-11 23:35:17.000000000 +0100
+++ linux-2.6.10-mm3/include/asm-x86_64/ia32_unistd.h	2005-01-12 00:33:25.000000000 +0100
@@ -295,10 +295,10 @@
 #define __NR_ia32_request_key	287
 #define __NR_ia32_keyctl		288
 #define __NR_ia32_vperfctr_open		289
-#define __NR_ia32_vperfctr_control	(__NR_ia32_perfctr_info+1)
-#define __NR_ia32_vperfctr_unlink	(__NR_ia32_perfctr_info+2)
-#define __NR_ia32_vperfctr_iresume	(__NR_ia32_perfctr_info+3)
-#define __NR_ia32_vperfctr_read		(__NR_ia32_perfctr_info+4)
+#define __NR_ia32_vperfctr_control	(__NR_ia32_vperfctr_open+1)
+#define __NR_ia32_vperfctr_unlink	(__NR_ia32_vperfctr_open+2)
+#define __NR_ia32_vperfctr_iresume	(__NR_ia32_vperfctr_open+3)
+#define __NR_ia32_vperfctr_read		(__NR_ia32_vperfctr_open+4)
 
 #define IA32_NR_syscalls 294	/* must be > than biggest syscall! */
 
