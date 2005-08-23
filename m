Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932449AbVHWVpK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932449AbVHWVpK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Aug 2005 17:45:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932450AbVHWVpJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Aug 2005 17:45:09 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:21686 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S932449AbVHWVpE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Aug 2005 17:45:04 -0400
To: torvalds@osdl.org
Subject: [PATCH] (40/43) Kconfig fix (non-modular SCSI drivers)
Cc: linux-kernel@vger.kernel.org
Message-Id: <E1E7gcp-0007FV-HR@parcelfarce.linux.theplanet.co.uk>
From: Al Viro <viro@www.linux.org.uk>
Date: Tue, 23 Aug 2005 22:48:07 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

non-modular scsi drivers depend on built-in scsi

Signed-off-by: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
----
diff -urN RC13-rc6-git13-oss-pci/drivers/scsi/Kconfig RC13-rc6-git13-scsi-modular/drivers/scsi/Kconfig
--- RC13-rc6-git13-oss-pci/drivers/scsi/Kconfig	2005-08-10 10:37:50.000000000 -0400
+++ RC13-rc6-git13-scsi-modular/drivers/scsi/Kconfig	2005-08-21 13:17:42.000000000 -0400
@@ -1696,7 +1696,7 @@
 
 config MAC_SCSI
 	bool "Macintosh NCR5380 SCSI"
-	depends on MAC && SCSI
+	depends on MAC && SCSI=y
 	help
 	  This is the NCR 5380 SCSI controller included on most of the 68030
 	  based Macintoshes.  If you have one of these say Y and read the
@@ -1717,7 +1717,7 @@
 
 config MVME147_SCSI
 	bool "WD33C93 SCSI driver for MVME147"
-	depends on MVME147 && SCSI
+	depends on MVME147 && SCSI=y
 	help
 	  Support for the on-board SCSI controller on the Motorola MVME147
 	  single-board computer.
@@ -1758,7 +1758,7 @@
 
 config SUN3X_ESP
 	bool "Sun3x ESP SCSI"
-	depends on SUN3X && SCSI
+	depends on SUN3X && SCSI=y
 	help
 	  The ESP was an on-board SCSI controller used on Sun 3/80
 	  machines.  Say Y here to compile in support for it.
