Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751442AbWC3CQJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751442AbWC3CQJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Mar 2006 21:16:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751447AbWC3CPy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Mar 2006 21:15:54 -0500
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:35278 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1751442AbWC3CPp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Mar 2006 21:15:45 -0500
Date: Thu, 30 Mar 2006 11:15:30 +0900
From: Yasunori Goto <y-goto@jp.fujitsu.com>
To: Andrew Morton <akpm@osdl.org>
Subject: [Patch:006/011] Configureable NODES_SHIFT (for alpha)
Cc: Linux Kernel ML <linux-kernel@vger.kernel.org>
In-Reply-To: <20060330105135.DC9F.Y-GOTO@jp.fujitsu.com>
References: <20060330105135.DC9F.Y-GOTO@jp.fujitsu.com>
X-Mailer-Plugin: BkASPil for Becky!2 Ver.2.063
Message-Id: <20060330110808.DCAF.Y-GOTO@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.24.02 [ja]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is for alpha.

Signed-off-by: Yasunori Goto <y-goto@jp.fujitsu.com>

 include/asm-alpha/numnodes.h |    7 -------
 arch/alpha/Kconfig           |    5 +++++
 2 files changed, 5 insertions(+), 7 deletions(-)

Index: pxm_ver4/arch/alpha/Kconfig
===================================================================
--- pxm_ver4.orig/arch/alpha/Kconfig	2006-03-29 16:43:16.406385211 +0900
+++ pxm_ver4/arch/alpha/Kconfig	2006-03-29 20:02:16.541004569 +0900
@@ -549,6 +549,11 @@ config NUMA
 	  Access).  This option is for configuring high-end multiprocessor
 	  server machines.  If in doubt, say N.
 
+config NODES_SHIFT
+	int
+	default "7"
+	depends on NEED_MULTIPLE_NODES
+
 # LARGE_VMALLOC is racy, if you *really* need it then fix it first
 config ALPHA_LARGE_VMALLOC
 	bool
Index: pxm_ver4/include/asm-alpha/numnodes.h
===================================================================
--- pxm_ver4.orig/include/asm-alpha/numnodes.h	2006-03-29 16:43:16.406385211 +0900
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
@@ -1,7 +0,0 @@
-#ifndef _ASM_MAX_NUMNODES_H
-#define _ASM_MAX_NUMNODES_H
-
-/* Max 128 Nodes - Marvel */
-#define NODES_SHIFT	7
-
-#endif /* _ASM_MAX_NUMNODES_H */

-- 
Yasunori Goto 


