Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751444AbWC3CP3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751444AbWC3CP3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Mar 2006 21:15:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751448AbWC3CP3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Mar 2006 21:15:29 -0500
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:18130 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1751444AbWC3CP0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Mar 2006 21:15:26 -0500
Date: Thu, 30 Mar 2006 11:15:03 +0900
From: Yasunori Goto <y-goto@jp.fujitsu.com>
To: Andrew Morton <akpm@osdl.org>
Subject: [Patch:004/011] Configureable NODES_SHIFT (for x86-64)
Cc: Linux Kernel ML <linux-kernel@vger.kernel.org>
In-Reply-To: <20060330105135.DC9F.Y-GOTO@jp.fujitsu.com>
References: <20060330105135.DC9F.Y-GOTO@jp.fujitsu.com>
X-Mailer-Plugin: BkASPil for Becky!2 Ver.2.063
Message-Id: <20060330110601.DCA9.Y-GOTO@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.24.02 [ja]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is for x86-64.

Signed-off-by: Yasunori Goto <y-goto@jp.fujitsu.com>

 include/asm-x86_64/numnodes.h |   12 ------------
 arch/x86_64/Kconfig           |    5 +++++
 include/asm-x86_64/numa.h     |    1 -
 3 files changed, 5 insertions(+), 13 deletions(-)

Index: pxm_ver4/arch/x86_64/Kconfig
===================================================================
--- pxm_ver4.orig/arch/x86_64/Kconfig	2006-03-29 20:46:08.596636389 +0900
+++ pxm_ver4/arch/x86_64/Kconfig	2006-03-29 20:50:37.943312777 +0900
@@ -283,6 +283,11 @@ config K8_NUMA
 	 Northbridge of Opteron. It is recommended to use X86_64_ACPI_NUMA
 	 instead, which also takes priority if both are compiled in.   
 
+config NODES_SHIFT
+	int
+	default "6"
+	depends on NEED_MULTIPLE_NODES
+
 # Dummy CONFIG option to select ACPI_NUMA from drivers/acpi/Kconfig.
 
 config X86_64_ACPI_NUMA
Index: pxm_ver4/include/asm-x86_64/numnodes.h
===================================================================
--- pxm_ver4.orig/include/asm-x86_64/numnodes.h	2006-03-29 20:46:08.597612951 +0900
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
@@ -1,12 +0,0 @@
-#ifndef _ASM_X8664_NUMNODES_H
-#define _ASM_X8664_NUMNODES_H 1
-
-#include <linux/config.h>
-
-#ifdef CONFIG_NUMA
-#define NODES_SHIFT	6
-#else
-#define NODES_SHIFT	0
-#endif
-
-#endif
Index: pxm_ver4/include/asm-x86_64/numa.h
===================================================================
--- pxm_ver4.orig/include/asm-x86_64/numa.h	2006-03-29 21:11:59.431578329 +0900
+++ pxm_ver4/include/asm-x86_64/numa.h	2006-03-29 21:12:21.884703054 +0900
@@ -2,7 +2,6 @@
 #define _ASM_X8664_NUMA_H 1
 
 #include <linux/nodemask.h>
-#include <asm/numnodes.h>
 
 struct bootnode {
 	u64 start,end; 

-- 
Yasunori Goto 


