Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262223AbUCGQg3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Mar 2004 11:36:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262219AbUCGQg3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Mar 2004 11:36:29 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:30455 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S262223AbUCGQg2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Mar 2004 11:36:28 -0500
Date: Sun, 7 Mar 2004 17:36:21 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Andrew Morton <akpm@osdl.org>, robert@schwebel.de
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] small fix for the "AMD Elan is a different subarch" patch
Message-ID: <20040307163621.GQ22479@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It seems the part of the patch below got lost somewhere.

Please apply
Adrian

--- linux-2.6.4-rc1-mm2/arch/i386/Kconfig.old	2004-03-07 17:13:46.000000000 +0100
+++ linux-2.6.4-rc1-mm2/arch/i386/Kconfig	2004-03-07 17:16:05.000000000 +0100
@@ -269,9 +269,6 @@
 	  use of some extended instructions, and passes appropriate optimization
 	  flags to GCC.
 
-config MELAN
-	bool "Elan"
-
 config MCRUSOE
 	bool "Crusoe"
 	help
--- linux-2.6.4-rc1-mm2/include/asm-i386/module.h.old	2004-03-07 17:16:41.000000000 +0100
+++ linux-2.6.4-rc1-mm2/include/asm-i386/module.h	2004-03-07 17:17:09.000000000 +0100
@@ -36,7 +36,7 @@
 #define MODULE_PROC_FAMILY "K7 "
 #elif defined CONFIG_MK8
 #define MODULE_PROC_FAMILY "K8 "
-#elif defined CONFIG_MELAN
+#elif defined CONFIG_X86_ELAN
 #define MODULE_PROC_FAMILY "ELAN "
 #elif defined CONFIG_MCRUSOE
 #define MODULE_PROC_FAMILY "CRUSOE "
