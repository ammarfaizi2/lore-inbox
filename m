Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262629AbVEARtm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262629AbVEARtm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 May 2005 13:49:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262630AbVEARt2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 May 2005 13:49:28 -0400
Received: from smtp-100-sunday.noc.nerim.net ([62.4.17.100]:12819 "EHLO
	mallaury.noc.nerim.net") by vger.kernel.org with ESMTP
	id S262629AbVEARtM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 May 2005 13:49:12 -0400
Date: Sun, 1 May 2005 19:50:05 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
       LM Sensors <sensors@Stimpy.netroedge.com>,
       Corey Minyard <minyard@acm.org>
Subject: [PATCH 2.4] I2C updates for 2.4.31-pre1 (2/3)
Message-Id: <20050501195005.41c99f62.khali@linux-fr.org>
In-Reply-To: <20050501185236.2f76a5ba.khali@linux-fr.org>
References: <20050501185236.2f76a5ba.khali@linux-fr.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix I2C_FUNC_* defines in i2c.h. These defines lack surrounding
parentheses, which might cause unexpected results where used. These were
originally fixed by Corey Minyard in Linux 2.6.

http://marc.theaimsgroup.com/?l=linux-kernel&m=110928784629301
http://linux.bkbits.net:8080/linux-2.5/diffs/include/linux/i2c.h@1.48

--- linux-2.4.30-rc1/include/linux/i2c.h.orig	2005-03-19 13:17:40.000000000 +0100
+++ linux-2.4.30-rc1/include/linux/i2c.h	2005-03-19 13:22:52.000000000 +0100
@@ -390,23 +390,23 @@
 #define I2C_FUNC_SMBUS_READ_I2C_BLOCK	0x04000000 /* New I2C-like block */
 #define I2C_FUNC_SMBUS_WRITE_I2C_BLOCK	0x08000000 /* transfer */
 
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
-
-#define I2C_FUNC_SMBUS_EMUL I2C_FUNC_SMBUS_QUICK | \
-                            I2C_FUNC_SMBUS_BYTE | \
-                            I2C_FUNC_SMBUS_BYTE_DATA | \
-                            I2C_FUNC_SMBUS_WORD_DATA | \
-                            I2C_FUNC_SMBUS_PROC_CALL | \
-                            I2C_FUNC_SMBUS_WRITE_BLOCK_DATA
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
+
+#define I2C_FUNC_SMBUS_EMUL (I2C_FUNC_SMBUS_QUICK | \
+                             I2C_FUNC_SMBUS_BYTE | \
+                             I2C_FUNC_SMBUS_BYTE_DATA | \
+                             I2C_FUNC_SMBUS_WORD_DATA | \
+                             I2C_FUNC_SMBUS_PROC_CALL | \
+                             I2C_FUNC_SMBUS_WRITE_BLOCK_DATA)
 
 /* 
  * Data for SMBus Messages 


-- 
Jean Delvare
