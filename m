Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751461AbWC3CQz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751461AbWC3CQz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Mar 2006 21:16:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751452AbWC3CQX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Mar 2006 21:16:23 -0500
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:60366 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1751451AbWC3CQS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Mar 2006 21:16:18 -0500
Date: Thu, 30 Mar 2006 11:16:09 +0900
From: Yasunori Goto <y-goto@jp.fujitsu.com>
To: Andrew Morton <akpm@osdl.org>
Subject: [Patch:010/011] Configureable NODES_SHIFT (for mips)
Cc: Linux Kernel ML <linux-kernel@vger.kernel.org>
In-Reply-To: <20060330105135.DC9F.Y-GOTO@jp.fujitsu.com>
References: <20060330105135.DC9F.Y-GOTO@jp.fujitsu.com>
X-Mailer-Plugin: BkASPil for Becky!2 Ver.2.063
Message-Id: <20060330111246.DCB7.Y-GOTO@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.24.02 [ja]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is for mips.

Signed-off-by: Yasunori Goto <y-goto@jp.fujitsu.com>

 include/asm-mips/numnodes.h |    7 -------
 arch/mips/Kconfig           |    5 +++++
 2 files changed, 5 insertions(+), 7 deletions(-)

Index: pxm_ver4/arch/mips/Kconfig
===================================================================
--- pxm_ver4.orig/arch/mips/Kconfig	2006-03-29 20:12:35.968731356 +0900
+++ pxm_ver4/arch/mips/Kconfig	2006-03-29 20:36:20.998987337 +0900
@@ -1587,6 +1587,11 @@ config ARCH_FLATMEM_ENABLE
 	def_bool y
 	depends on !NUMA
 
+config NODES_SHIFT
+	int
+	default "6"
+	depends on NEED_MULTIPLE_NODES
+
 source "mm/Kconfig"
 
 config SMP
Index: pxm_ver4/include/asm-mips/numnodes.h
===================================================================
--- pxm_ver4.orig/include/asm-mips/numnodes.h	2006-03-29 20:12:35.968731356 +0900
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
@@ -1,7 +0,0 @@
-#ifndef _ASM_MAX_NUMNODES_H
-#define _ASM_MAX_NUMNODES_H
-
-/* Max 128 Nodes */
-#define NODES_SHIFT	6
-
-#endif /* _ASM_MAX_NUMNODES_H */

-- 
Yasunori Goto 


