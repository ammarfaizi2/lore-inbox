Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751288AbWC3CTc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751288AbWC3CTc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Mar 2006 21:19:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751450AbWC3CTb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Mar 2006 21:19:31 -0500
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:24718 "EHLO
	fgwmail7.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1751288AbWC3CTa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Mar 2006 21:19:30 -0500
Date: Thu, 30 Mar 2006 11:16:16 +0900
From: Yasunori Goto <y-goto@jp.fujitsu.com>
To: Andrew Morton <akpm@osdl.org>
Subject: [Patch:011/011] Configureable NODES_SHIFT (for sh)
Cc: Linux Kernel ML <linux-kernel@vger.kernel.org>
In-Reply-To: <20060330105135.DC9F.Y-GOTO@jp.fujitsu.com>
References: <20060330105135.DC9F.Y-GOTO@jp.fujitsu.com>
X-Mailer-Plugin: BkASPil for Becky!2 Ver.2.063
Message-Id: <20060330111338.DCB9.Y-GOTO@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.24.02 [ja]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is for sh.

Signed-off-by: Yasunori Goto <y-goto@jp.fujitsu.com>

 include/asm-sh/numnodes.h |    7 -------
 arch/sh/Kconfig           |    5 +++++
 2 files changed, 5 insertions(+), 7 deletions(-)

Index: pxm_ver4/arch/sh/Kconfig
===================================================================
--- pxm_ver4.orig/arch/sh/Kconfig	2006-03-29 20:12:33.810528258 +0900
+++ pxm_ver4/arch/sh/Kconfig	2006-03-29 20:38:51.580040180 +0900
@@ -527,6 +527,11 @@ config CPU_HAS_SR_RB
 	  See <file:Documentation/sh/register-banks.txt> for further
 	  information on SR.RB and register banking in the kernel in general.
 
+config NODES_SHIFT
+	int
+	default "1"
+	depends on NEED_MULTIPLE_NODES
+
 endmenu
 
 menu "Boot options"
Index: pxm_ver4/include/asm-sh/numnodes.h
===================================================================
--- pxm_ver4.orig/include/asm-sh/numnodes.h	2006-03-29 20:12:33.810528258 +0900
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
@@ -1,7 +0,0 @@
-#ifndef _ASM_MAX_NUMNODES_H
-#define _ASM_MAX_NUMNODES_H
-
-/* Max 2 Nodes */
-#define NODES_SHIFT	1
-
-#endif /* _ASM_MAX_NUMNODES_H */

-- 
Yasunori Goto 


