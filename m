Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261343AbVCTXKe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261343AbVCTXKe (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Mar 2005 18:10:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261334AbVCTXIV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Mar 2005 18:08:21 -0500
Received: from ns3.dataphone.se ([212.37.0.170]:36563 "EHLO
	mail-slave.dataphone.se") by vger.kernel.org with ESMTP
	id S261342AbVCTXG1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Mar 2005 18:06:27 -0500
From: Magnus Damm <damm@opensource.se>
To: linux-kernel@vger.kernel.org
Cc: Magnus Damm <damm@opensource.se>
Message-Id: <20050320223835.25305.25668.76404@clementine.local>
In-Reply-To: <20050320223814.25305.52695.65404@clementine.local>
References: <20050320223814.25305.52695.65404@clementine.local>
Subject: [PATCH 4/5] autoparam: ide workarounds
Date: Mon, 21 Mar 2005 00:06:27 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch contains quick fixes that prevents KBUILD_MODNAME conflicts.

Signed-off-by: Magnus Damm <damm@opensource.se>

diff -urN linux-2.6.12-rc1/drivers/ide/ide-disk.c linux-2.6.12-rc1-autoparam/drivers/ide/ide-disk.c
--- linux-2.6.12-rc1/drivers/ide/ide-disk.c	2005-03-20 18:20:16.000000000 +0100
+++ linux-2.6.12-rc1-autoparam/drivers/ide/ide-disk.c	2005-03-20 22:19:34.917938632 +0100
@@ -1179,6 +1179,8 @@
 	return ide_register_driver(&idedisk_driver);
 }
 
+#undef ide_disk
+
 module_init(idedisk_init);
 module_exit(idedisk_exit);
 MODULE_LICENSE("GPL");
diff -urN linux-2.6.12-rc1/drivers/ide/ide-floppy.c linux-2.6.12-rc1-autoparam/drivers/ide/ide-floppy.c
--- linux-2.6.12-rc1/drivers/ide/ide-floppy.c	2005-03-20 18:20:16.000000000 +0100
+++ linux-2.6.12-rc1-autoparam/drivers/ide/ide-floppy.c	2005-03-20 22:19:34.920938176 +0100
@@ -2117,6 +2117,8 @@
 	return 0;
 }
 
+#undef ide_floppy
+
 module_init(idefloppy_init);
 module_exit(idefloppy_exit);
 MODULE_LICENSE("GPL");
diff -urN linux-2.6.12-rc1/drivers/ide/ide-tape.c linux-2.6.12-rc1-autoparam/drivers/ide/ide-tape.c
--- linux-2.6.12-rc1/drivers/ide/ide-tape.c	2005-03-20 18:20:16.000000000 +0100
+++ linux-2.6.12-rc1-autoparam/drivers/ide/ide-tape.c	2005-03-20 22:19:34.944934528 +0100
@@ -4818,6 +4818,8 @@
 	return 0;
 }
 
+#undef ide_tape
+
 module_init(idetape_init);
 module_exit(idetape_exit);
 MODULE_ALIAS_CHARDEV_MAJOR(IDETAPE_MAJOR);
diff -urN linux-2.6.12-rc1/drivers/scsi/ide-scsi.c linux-2.6.12-rc1-autoparam/drivers/scsi/ide-scsi.c
--- linux-2.6.12-rc1/drivers/scsi/ide-scsi.c	2005-03-20 18:20:17.000000000 +0100
+++ linux-2.6.12-rc1-autoparam/drivers/scsi/ide-scsi.c	2005-03-20 22:19:34.946934224 +0100
@@ -1097,6 +1097,8 @@
 	ide_unregister_driver(&idescsi_driver);
 }
 
+#undef ide_scsi
+
 module_init(init_idescsi_module);
 module_exit(exit_idescsi_module);
 MODULE_LICENSE("GPL");
