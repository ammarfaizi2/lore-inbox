Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261963AbVDKWSW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261963AbVDKWSW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Apr 2005 18:18:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261959AbVDKWQn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Apr 2005 18:16:43 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:32274 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261963AbVDKWP0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Apr 2005 18:15:26 -0400
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Andrew Morton <akpm@osdl.org>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] Fix floppy disk dependencies
X-Patch-Ref: 01-fixes/03-blk_dev_fd-depends
Message-Id: <E1DL7Bg-0003C9-Vj@raistlin.arm.linux.org.uk>
Date: Mon, 11 Apr 2005 23:15:20 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Both the RiscPC and (optionally) EBSA285 have floppy disk
support.  Allow this option to be selected on these ARM
platforms again.

Signed-off-by: Russell King <rmk@arm.linux.org.uk>

diff -up -x BitKeeper -x ChangeSet -x SCCS -x _xlk -x '*.orig' -x '*.rej' -r orig/drivers/block/Kconfig linux/drivers/block/Kconfig
--- orig/drivers/block/Kconfig	Mon Apr  4 22:53:23 2005
+++ linux/drivers/block/Kconfig	Mon Apr  4 23:42:07 2005
@@ -6,7 +6,7 @@ menu "Block devices"
 
 config BLK_DEV_FD
 	tristate "Normal floppy disk support"
-	depends on (!ARCH_S390 && !M68K && !IA64 && !UML) || Q40 || (SUN3X && BROKEN)
+	depends on (!ARCH_S390 && !M68K && !IA64 && !UML) || Q40 || (SUN3X && BROKEN) || ARCH_RPC || ARCH_EBSA285
 	---help---
 	  If you want to use the floppy disk drive(s) of your PC under Linux,
 	  say Y. Information about this driver, especially important for IBM

