Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265484AbTBPBEs>; Sat, 15 Feb 2003 20:04:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265513AbTBPBEs>; Sat, 15 Feb 2003 20:04:48 -0500
Received: from virtisp1.zianet.com ([216.234.192.105]:52493 "HELO
	mesatop.zianet.com") by vger.kernel.org with SMTP
	id <S265484AbTBPBEr>; Sat, 15 Feb 2003 20:04:47 -0500
Subject: [PATCH] 2.5.61 fix erroneous spellings of error.
From: Steven Cole <elenstev@mesatop.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2-5mdk 
Date: 15 Feb 2003 18:06:26 -0700
Message-Id: <1045357587.5611.35.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes several erors and one erorr.

Diffed against the 2.5 tree as of cset 1.1027.

Steven

diff -ur linux-2.5.61-1.1027-orig/drivers/pci/pci.c linux-2.5.61-1.1027/drivers/pci/pci.c
--- linux-2.5.61-1.1027-orig/drivers/pci/pci.c	Thu Jan 16 19:21:48 2003
+++ linux-2.5.61-1.1027/drivers/pci/pci.c	Sat Feb 15 17:39:25 2003
@@ -592,7 +592,7 @@
  * function.  Originally copied from drivers/net/acenic.c.
  * Copyright 1998-2001 by Jes Sorensen, <jes@trained-monkey.org>.
  *
- * RETURNS: An appropriate -ERRNO error value on eror, or zero for success.
+ * RETURNS: An appropriate -ERRNO error value on error, or zero for success.
  */
 static int
 pci_generic_prep_mwi(struct pci_dev *dev)
@@ -634,7 +634,7 @@
  * and then calls @pcibios_set_mwi to do the needed arch specific
  * operations or a generic mwi-prep function.
  *
- * RETURNS: An appriopriate -ERRNO error value on eror, or zero for success.
+ * RETURNS: An appropriate -ERRNO error value on error, or zero for success.
  */
 int
 pci_set_mwi(struct pci_dev *dev)
diff -ur linux-2.5.61-1.1027-orig/drivers/s390/block/dasd_eckd.c linux-2.5.61-1.1027/drivers/s390/block/dasd_eckd.c
--- linux-2.5.61-1.1027-orig/drivers/s390/block/dasd_eckd.c	Thu Jan 16 19:21:34 2003
+++ linux-2.5.61-1.1027/drivers/s390/block/dasd_eckd.c	Sat Feb 15 17:40:16 2003
@@ -1195,7 +1195,7 @@
 	rc = dasd_sleep_on_immediatly(cqr);
 
 	if (rc == -EIO) {
-		/* Request got an eror or has been timed out. */
+		/* Request got an error or has been timed out. */
 		dasd_eckd_release(bdev, no, args);
 	}
 	dasd_kfree_request(cqr, cqr->device);
@@ -1238,7 +1238,7 @@
 	rc = dasd_sleep_on_immediatly(cqr);
 
 	if (rc == -EIO) {
-		/* Request got an eror or has been timed out. */
+		/* Request got an error or has been timed out. */
 		dasd_eckd_release(bdev, no, args);
 	}
 	dasd_kfree_request(cqr, cqr->device);
diff -ur linux-2.5.61-1.1027-orig/include/asm-ia64/sn/ioerror.h linux-2.5.61-1.1027/include/asm-ia64/sn/ioerror.h
--- linux-2.5.61-1.1027-orig/include/asm-ia64/sn/ioerror.h	Thu Jan 16 19:21:49 2003
+++ linux-2.5.61-1.1027/include/asm-ia64/sn/ioerror.h	Sat Feb 15 17:40:41 2003
@@ -108,7 +108,7 @@
  *        we have a single structure, and the appropriate fields get filled in
  *        at each layer.
  *      - This provides a way to dump all error related information in any layer
- *        of erorr handling (debugging aid).
+ *        of error handling (debugging aid).
  *
  * A second possibility is to allow each layer to define its own error
  * data structure, and fill in the proper fields. This has the advantage

