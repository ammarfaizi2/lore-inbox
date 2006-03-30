Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751447AbWC3CQ4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751447AbWC3CQ4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Mar 2006 21:16:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751454AbWC3CQ0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Mar 2006 21:16:26 -0500
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:57294 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1751448AbWC3CQQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Mar 2006 21:16:16 -0500
Date: Thu, 30 Mar 2006 11:16:01 +0900
From: Yasunori Goto <y-goto@jp.fujitsu.com>
To: Andrew Morton <akpm@osdl.org>
Subject: [Patch:009/011] Configureable NODES_SHIFT (for m32r)
Cc: Linux Kernel ML <linux-kernel@vger.kernel.org>
In-Reply-To: <20060330105135.DC9F.Y-GOTO@jp.fujitsu.com>
References: <20060330105135.DC9F.Y-GOTO@jp.fujitsu.com>
X-Mailer-Plugin: BkASPil for Becky!2 Ver.2.063
Message-Id: <20060330111050.DCB5.Y-GOTO@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.24.02 [ja]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is to m32r.

Signed-off-by: Yasunori Goto <y-goto@jp.fujitsu.com>

 include/asm-m32r/numnodes.h |   15 ---------------
 arch/m32r/Kconfig           |    5 +++++
 2 files changed, 5 insertions(+), 15 deletions(-)

Index: pxm_ver4/arch/m32r/Kconfig
===================================================================
--- pxm_ver4.orig/arch/m32r/Kconfig	2006-03-29 16:43:15.437635223 +0900
+++ pxm_ver4/arch/m32r/Kconfig	2006-03-29 20:07:58.554672254 +0900
@@ -285,6 +285,11 @@ config NUMA
 	depends on SMP && BROKEN
 	default n
 
+config NODES_SHIFT
+	int
+	default "1"
+	depends on NEED_MULTIPLE_NODES
+
 # turning this on wastes a bunch of space.
 # Summit needs it only when NUMA is on
 config BOOT_IOREMAP
Index: pxm_ver4/include/asm-m32r/numnodes.h
===================================================================
--- pxm_ver4.orig/include/asm-m32r/numnodes.h	2006-03-29 16:43:15.437635223 +0900
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
@@ -1,15 +0,0 @@
-#ifndef _ASM_NUMNODES_H_
-#define _ASM_NUMNODES_H_
-
-#include <linux/config.h>
-
-#ifdef CONFIG_DISCONTIGMEM
-
-#if defined(CONFIG_CHIP_M32700)
-#define	NODES_SHIFT	1	/* Max 2 Nodes */
-#endif	/* CONFIG_CHIP_M32700 */
-
-#endif	/* CONFIG_DISCONTIGMEM */
-
-#endif	/* _ASM_NUMNODES_H_ */
-

-- 
Yasunori Goto 


