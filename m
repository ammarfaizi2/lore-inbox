Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751291AbWC3COo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751291AbWC3COo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Mar 2006 21:14:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751442AbWC3COo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Mar 2006 21:14:44 -0500
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:55434 "EHLO
	fgwmail7.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1751291AbWC3COn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Mar 2006 21:14:43 -0500
Date: Thu, 30 Mar 2006 11:14:09 +0900
From: Yasunori Goto <y-goto@jp.fujitsu.com>
To: Andrew Morton <akpm@osdl.org>
Subject: [Patch:001/011] Configureable NODES_SHIFT (Generic part)
Cc: Linux Kernel ML <linux-kernel@vger.kernel.org>
In-Reply-To: <20060330105135.DC9F.Y-GOTO@jp.fujitsu.com>
References: <20060330105135.DC9F.Y-GOTO@jp.fujitsu.com>
X-Mailer-Plugin: BkASPil for Becky!2 Ver.2.063
Message-Id: <20060330110304.DCA1.Y-GOTO@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.24.02 [ja]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is generic part.
include/asm-xxx/numnodes.h becomes not necessary.

Signed-off-by: Yasunori Goto <y-goto@jp.fujitsu.com>

 include/linux/numa.h |    8 +++-----
 1 files changed, 3 insertions(+), 5 deletions(-)

Index: pxm_ver4/include/linux/numa.h
===================================================================
--- pxm_ver4.orig/include/linux/numa.h	2005-10-28 12:03:06.000000000 +0900
+++ pxm_ver4/include/linux/numa.h	2006-03-29 19:03:55.705109954 +0900
@@ -3,11 +3,9 @@
 
 #include <linux/config.h>
 
-#ifndef CONFIG_FLATMEM
-#include <asm/numnodes.h>
-#endif
-
-#ifndef NODES_SHIFT
+#ifdef CONFIG_NODES_SHIFT
+#define NODES_SHIFT     CONFIG_NODES_SHIFT
+#else
 #define NODES_SHIFT     0
 #endif
 

-- 
Yasunori Goto 


