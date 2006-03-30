Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751453AbWC3CPv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751453AbWC3CPv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Mar 2006 21:15:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751448AbWC3CPb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Mar 2006 21:15:31 -0500
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:23502 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1751447AbWC3CP0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Mar 2006 21:15:26 -0500
Date: Thu, 30 Mar 2006 11:15:18 +0900
From: Yasunori Goto <y-goto@jp.fujitsu.com>
To: Andrew Morton <akpm@osdl.org>
Subject: [Patch:005/011] Configureable NODES_SHIFT (for powerpc)
Cc: Linux Kernel ML <linux-kernel@vger.kernel.org>
In-Reply-To: <20060330105135.DC9F.Y-GOTO@jp.fujitsu.com>
References: <20060330105135.DC9F.Y-GOTO@jp.fujitsu.com>
X-Mailer-Plugin: BkASPil for Becky!2 Ver.2.063
Message-Id: <20060330110708.DCAD.Y-GOTO@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.24.02 [ja]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is for powerpc.

Signed-off-by: Yasunori Goto <y-goto@jp.fujitsu.com>

 include/asm-powerpc/numnodes.h |    9 ---------
 arch/powerpc/Kconfig           |    5 +++++
 2 files changed, 5 insertions(+), 9 deletions(-)

Index: pxm_ver4/arch/powerpc/Kconfig
===================================================================
--- pxm_ver4.orig/arch/powerpc/Kconfig	2006-03-29 20:14:38.355448607 +0900
+++ pxm_ver4/arch/powerpc/Kconfig	2006-03-29 20:33:19.268520813 +0900
@@ -649,6 +649,11 @@ config NUMA
 	depends on PPC64
 	default y if SMP && PPC_PSERIES
 
+config NODES_SHIFT
+	int
+	default "4"
+	depens on NEED_MULTIPLE_NODES
+
 config ARCH_SELECT_MEMORY_MODEL
 	def_bool y
 	depends on PPC64
Index: pxm_ver4/include/asm-powerpc/numnodes.h
===================================================================
--- pxm_ver4.orig/include/asm-powerpc/numnodes.h	2006-03-29 20:14:38.355448607 +0900
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
@@ -1,9 +0,0 @@
-#ifndef _ASM_POWERPC_MAX_NUMNODES_H
-#define _ASM_POWERPC_MAX_NUMNODES_H
-#ifdef __KERNEL__
-
-/* Max 16 Nodes */
-#define NODES_SHIFT	4
-
-#endif /* __KERNEL__ */
-#endif /* _ASM_POWERPC_MAX_NUMNODES_H */

-- 
Yasunori Goto 


