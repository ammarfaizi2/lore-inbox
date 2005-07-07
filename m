Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261290AbVGGL25@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261290AbVGGL25 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Jul 2005 07:28:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261298AbVGGL1k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Jul 2005 07:27:40 -0400
Received: from coderock.org ([193.77.147.115]:26250 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S261300AbVGGL1D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Jul 2005 07:27:03 -0400
Message-Id: <20050707112637.593334000@homer>
References: <20050707112551.331553000@homer>
Date: Thu, 07 Jul 2005 13:25:56 +0200
From: domen@coderock.org
To: linux-kernel@vger.kernel.org
Cc: damm@opensource.se, domen@coderock.org
Subject: [patch 5/5] autoparam: ide workarounds
Content-Disposition: inline; filename=autoparam_5-ide_workaround
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Magnus Damm <damm@opensource.se>


This patch contains quick fixes that prevents KBUILD_MODNAME conflicts.

Signed-off-by: Magnus Damm <damm@opensource.se>
Signed-off-by: Domen Puncer <domen@coderock.org>

 drivers/ide/ide-disk.c   |    2 ++
 drivers/ide/ide-floppy.c |    2 ++
 drivers/ide/ide-tape.c   |    2 ++
 drivers/scsi/ide-scsi.c  |    2 ++
 4 files changed, 8 insertions(+)

Index: a/drivers/ide/ide-disk.c
===================================================================
--- a.orig/drivers/ide/ide-disk.c
+++ a/drivers/ide/ide-disk.c
@@ -1273,6 +1273,8 @@ static int idedisk_init (void)
 	return driver_register(&idedisk_driver.gen_driver);
 }
 
+#undef ide_disk
+
 module_init(idedisk_init);
 module_exit(idedisk_exit);
 MODULE_LICENSE("GPL");
Index: a/drivers/ide/ide-floppy.c
===================================================================
--- a.orig/drivers/ide/ide-floppy.c
+++ a/drivers/ide/ide-floppy.c
@@ -2204,6 +2204,8 @@ static int idefloppy_init (void)
 	return driver_register(&idefloppy_driver.gen_driver);
 }
 
+#undef ide_floppy
+
 module_init(idefloppy_init);
 module_exit(idefloppy_exit);
 MODULE_LICENSE("GPL");
Index: a/drivers/ide/ide-tape.c
===================================================================
--- a.orig/drivers/ide/ide-tape.c
+++ a/drivers/ide/ide-tape.c
@@ -4919,6 +4919,8 @@ static int idetape_init (void)
 	return driver_register(&idetape_driver.gen_driver);
 }
 
+#undef ide_tape
+
 module_init(idetape_init);
 module_exit(idetape_exit);
 MODULE_ALIAS_CHARDEV_MAJOR(IDETAPE_MAJOR);
Index: a/drivers/scsi/ide-scsi.c
===================================================================
--- a.orig/drivers/scsi/ide-scsi.c
+++ a/drivers/scsi/ide-scsi.c
@@ -1186,6 +1186,8 @@ static void __exit exit_idescsi_module(v
 	driver_unregister(&idescsi_driver.gen_driver);
 }
 
+#undef ide_scsi
+
 module_init(init_idescsi_module);
 module_exit(exit_idescsi_module);
 MODULE_LICENSE("GPL");

--
