Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263106AbVCDVXq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263106AbVCDVXq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 16:23:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263169AbVCDVOD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 16:14:03 -0500
Received: from mail.kroah.org ([69.55.234.183]:60577 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263149AbVCDUy0 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 15:54:26 -0500
Cc: minyard@acm.org
Subject: [PATCH] I2C: minor I2C cleanups
In-Reply-To: <11099685971397@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 4 Mar 2005 12:36:37 -0800
Message-Id: <110996859785@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2110, 2005/03/02 15:03:00-08:00, minyard@acm.org

[PATCH] I2C: minor I2C cleanups

This is one in a series of patches for adding a non-blocking interface
to the I2C driver for supporting the IPMI SMBus driver.  This patch is a
simply some minor cleanups and is in addition to the patch by Mickey
Stein (http://marc.theaimsgroup.com/?l=linux-kernel&m=110919738708916&w=2).

Clean up some general I2C things.  Fix some grammar and put ()
around all the #defines that are compound to avoid nasty
side-effects.

Signed-off-by: Corey Minyard <minyard@acm.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>


 include/linux/i2c.h |   50 +++++++++++++++++++++++++-------------------------
 1 files changed, 25 insertions(+), 25 deletions(-)


diff -Nru a/include/linux/i2c.h b/include/linux/i2c.h
--- a/include/linux/i2c.h	2005-03-04 12:23:20 -08:00
+++ b/include/linux/i2c.h	2005-03-04 12:23:20 -08:00
@@ -187,7 +187,7 @@
 	char name[32];				/* textual description 	*/
 	unsigned int id;
 
-	/* If an adapter algorithm can't to I2C-level access, set master_xfer
+	/* If an adapter algorithm can't do I2C-level access, set master_xfer
 	   to NULL. If an adapter algorithm can do SMBus access, set 
 	   smbus_xfer. If set to NULL, the SMBus protocol is simulated
 	   using common I2C messages */
@@ -420,22 +420,22 @@
 #define I2C_FUNC_SMBUS_READ_BLOCK_DATA_PEC  0x40000000 /* SMBus 2.0 */
 #define I2C_FUNC_SMBUS_WRITE_BLOCK_DATA_PEC 0x80000000 /* SMBus 2.0 */
 
-#define I2C_FUNC_SMBUS_BYTE I2C_FUNC_SMBUS_READ_BYTE | \
-                            I2C_FUNC_SMBUS_WRITE_BYTE
-#define I2C_FUNC_SMBUS_BYTE_DATA I2C_FUNC_SMBUS_READ_BYTE_DATA | \
-                                 I2C_FUNC_SMBUS_WRITE_BYTE_DATA
-#define I2C_FUNC_SMBUS_WORD_DATA I2C_FUNC_SMBUS_READ_WORD_DATA | \
-                                 I2C_FUNC_SMBUS_WRITE_WORD_DATA
-#define I2C_FUNC_SMBUS_BLOCK_DATA I2C_FUNC_SMBUS_READ_BLOCK_DATA | \
-                                  I2C_FUNC_SMBUS_WRITE_BLOCK_DATA
-#define I2C_FUNC_SMBUS_I2C_BLOCK I2C_FUNC_SMBUS_READ_I2C_BLOCK | \
-                                  I2C_FUNC_SMBUS_WRITE_I2C_BLOCK
-#define I2C_FUNC_SMBUS_I2C_BLOCK_2 I2C_FUNC_SMBUS_READ_I2C_BLOCK_2 | \
-                                   I2C_FUNC_SMBUS_WRITE_I2C_BLOCK_2
-#define I2C_FUNC_SMBUS_BLOCK_DATA_PEC I2C_FUNC_SMBUS_READ_BLOCK_DATA_PEC | \
-                                      I2C_FUNC_SMBUS_WRITE_BLOCK_DATA_PEC
-#define I2C_FUNC_SMBUS_WORD_DATA_PEC  I2C_FUNC_SMBUS_READ_WORD_DATA_PEC | \
-                                      I2C_FUNC_SMBUS_WRITE_WORD_DATA_PEC
+#define I2C_FUNC_SMBUS_BYTE (I2C_FUNC_SMBUS_READ_BYTE | \
+                             I2C_FUNC_SMBUS_WRITE_BYTE)
+#define I2C_FUNC_SMBUS_BYTE_DATA (I2C_FUNC_SMBUS_READ_BYTE_DATA | \
+                                  I2C_FUNC_SMBUS_WRITE_BYTE_DATA)
+#define I2C_FUNC_SMBUS_WORD_DATA (I2C_FUNC_SMBUS_READ_WORD_DATA | \
+                                  I2C_FUNC_SMBUS_WRITE_WORD_DATA)
+#define I2C_FUNC_SMBUS_BLOCK_DATA (I2C_FUNC_SMBUS_READ_BLOCK_DATA | \
+                                   I2C_FUNC_SMBUS_WRITE_BLOCK_DATA)
+#define I2C_FUNC_SMBUS_I2C_BLOCK (I2C_FUNC_SMBUS_READ_I2C_BLOCK | \
+                                  I2C_FUNC_SMBUS_WRITE_I2C_BLOCK)
+#define I2C_FUNC_SMBUS_I2C_BLOCK_2 (I2C_FUNC_SMBUS_READ_I2C_BLOCK_2 | \
+                                    I2C_FUNC_SMBUS_WRITE_I2C_BLOCK_2)
+#define I2C_FUNC_SMBUS_BLOCK_DATA_PEC (I2C_FUNC_SMBUS_READ_BLOCK_DATA_PEC | \
+                                       I2C_FUNC_SMBUS_WRITE_BLOCK_DATA_PEC)
+#define I2C_FUNC_SMBUS_WORD_DATA_PEC  (I2C_FUNC_SMBUS_READ_WORD_DATA_PEC | \
+                                       I2C_FUNC_SMBUS_WRITE_WORD_DATA_PEC)
 
 #define I2C_FUNC_SMBUS_READ_BYTE_PEC		I2C_FUNC_SMBUS_READ_BYTE_DATA
 #define I2C_FUNC_SMBUS_WRITE_BYTE_PEC		I2C_FUNC_SMBUS_WRITE_BYTE_DATA
@@ -444,14 +444,14 @@
 #define I2C_FUNC_SMBUS_BYTE_PEC			I2C_FUNC_SMBUS_BYTE_DATA
 #define I2C_FUNC_SMBUS_BYTE_DATA_PEC		I2C_FUNC_SMBUS_WORD_DATA
 
-#define I2C_FUNC_SMBUS_EMUL I2C_FUNC_SMBUS_QUICK | \
-                            I2C_FUNC_SMBUS_BYTE | \
-                            I2C_FUNC_SMBUS_BYTE_DATA | \
-                            I2C_FUNC_SMBUS_WORD_DATA | \
-                            I2C_FUNC_SMBUS_PROC_CALL | \
-                            I2C_FUNC_SMBUS_WRITE_BLOCK_DATA | \
-                            I2C_FUNC_SMBUS_WRITE_BLOCK_DATA_PEC | \
-                            I2C_FUNC_SMBUS_I2C_BLOCK
+#define I2C_FUNC_SMBUS_EMUL (I2C_FUNC_SMBUS_QUICK | \
+                             I2C_FUNC_SMBUS_BYTE | \
+                             I2C_FUNC_SMBUS_BYTE_DATA | \
+                             I2C_FUNC_SMBUS_WORD_DATA | \
+                             I2C_FUNC_SMBUS_PROC_CALL | \
+                             I2C_FUNC_SMBUS_WRITE_BLOCK_DATA | \
+                             I2C_FUNC_SMBUS_WRITE_BLOCK_DATA_PEC | \
+                             I2C_FUNC_SMBUS_I2C_BLOCK)
 
 /* 
  * Data for SMBus Messages 

