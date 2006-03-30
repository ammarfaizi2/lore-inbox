Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751456AbWC3CQW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751456AbWC3CQW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Mar 2006 21:16:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751452AbWC3CQL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Mar 2006 21:16:11 -0500
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:43986 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1751448AbWC3CQC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Mar 2006 21:16:02 -0500
Date: Thu, 30 Mar 2006 11:15:44 +0900
From: Yasunori Goto <y-goto@jp.fujitsu.com>
To: Andrew Morton <akpm@osdl.org>
Subject: [Patch:007/011] Configureable NODES_SHIFT (for parisc)
Cc: Linux Kernel ML <linux-kernel@vger.kernel.org>
In-Reply-To: <20060330105135.DC9F.Y-GOTO@jp.fujitsu.com>
References: <20060330105135.DC9F.Y-GOTO@jp.fujitsu.com>
X-Mailer-Plugin: BkASPil for Becky!2 Ver.2.063
Message-Id: <20060330110906.DCB1.Y-GOTO@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.24.02 [ja]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is for parisc.


Signed-off-by: Yasunori Goto <y-goto@jp.fujitsu.com>

 include/asm-parisc/numnodes.h |    7 -------
 arch/parisc/Kconfig           |    5 +++++
 2 files changed, 5 insertions(+), 7 deletions(-)

Index: pxm_ver4/arch/parisc/Kconfig
===================================================================
--- pxm_ver4.orig/arch/parisc/Kconfig	2006-03-29 20:13:18.144512090 +0900
+++ pxm_ver4/arch/parisc/Kconfig	2006-03-29 20:34:27.982387159 +0900
@@ -177,6 +177,11 @@ config ARCH_DISCONTIGMEM_DEFAULT
 	def_bool y
 	depends on ARCH_DISCONTIGMEM_ENABLE
 
+config NODES_SHIFT
+	int
+	default "3"
+	depens on NEED_MULTIPLE_NODES
+
 source "kernel/Kconfig.hz"
 source "mm/Kconfig"
 
Index: pxm_ver4/include/asm-parisc/numnodes.h
===================================================================
--- pxm_ver4.orig/include/asm-parisc/numnodes.h	2006-03-29 20:13:18.144512090 +0900
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
@@ -1,7 +0,0 @@
-#ifndef _ASM_MAX_NUMNODES_H
-#define _ASM_MAX_NUMNODES_H
-
-/* Max 8 Nodes */
-#define NODES_SHIFT	3
-
-#endif /* _ASM_MAX_NUMNODES_H */

-- 
Yasunori Goto 


