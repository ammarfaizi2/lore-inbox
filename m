Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262874AbUKTMm3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262874AbUKTMm3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Nov 2004 07:42:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262833AbUKTMm2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Nov 2004 07:42:28 -0500
Received: from smtp-106-saturday.noc.nerim.net ([62.4.17.106]:49676 "EHLO
	mallaury.noc.nerim.net") by vger.kernel.org with ESMTP
	id S262874AbUKTMmG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Nov 2004 07:42:06 -0500
Date: Sat, 20 Nov 2004 13:42:03 +0100
From: Jean Delvare <khali@linux-fr.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.4] I2C updates for 2.4.28 (5/5)
Message-Id: <20041120134203.0af28c59.khali@linux-fr.org>
In-Reply-To: <20041120125423.42527051.khali@linux-fr.org>
References: <20041120125423.42527051.khali@linux-fr.org>
X-Mailer: Sylpheed version 1.0.0beta3 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Original report and discussion:
http://archives.andrew.net.au/lm-sensors/msg28295.html

Bottom line:
Some debug messages in the i2c-core lack their trailing newline, which
breaks the logs.

Signed-off-by: Jean Delvare <khali@linux-fr.org>

diff -ruN linux-2.4.28-rc2/drivers/i2c.orig/i2c-core.c linux-2.4.28-rc2/drivers/i2c/i2c-core.c
--- linux-2.4.28-rc2/drivers/i2c.orig/i2c-core.c	2004-11-09 22:02:16.000000000 +0100
+++ linux-2.4.28-rc2/drivers/i2c/i2c-core.c	2004-11-09 22:04:41.000000000 +0100
@@ -901,7 +901,7 @@
 			if (addr == address_data->normal_i2c[i]) {
 				found = 1;
 				DEB2(printk(KERN_DEBUG "i2c-core.o: found normal i2c entry for adapter %d, "
-				            "addr %02x", adap_id,addr));
+				            "addr %02x\n", adap_id, addr));
 			}
 		}
 
diff -ruN linux-2.4.28-rc2/drivers/i2c.orig/i2c-proc.c linux-2.4.28-rc2/drivers/i2c/i2c-proc.c
--- linux-2.4.28-rc2/drivers/i2c.orig/i2c-proc.c	2004-11-09 22:02:09.000000000 +0100
+++ linux-2.4.28-rc2/drivers/i2c/i2c-proc.c	2004-11-09 22:03:59.000000000 +0100
@@ -762,7 +762,7 @@
 #ifdef DEBUG
 					printk
 					    (KERN_DEBUG "i2c-proc.o: found normal isa_range entry for adapter %d, "
-					     "addr %04x", adapter_id, addr);
+					     "addr %04x\n", adapter_id, addr);
 #endif
 					found = 1;
 				}
@@ -776,7 +776,7 @@
 #ifdef DEBUG
 					printk
 					    (KERN_DEBUG "i2c-proc.o: found normal i2c entry for adapter %d, "
-					     "addr %02x", adapter_id, addr);
+					     "addr %02x\n", adapter_id, addr);
 #endif
 				}
 			}

-- 
Jean Delvare
http://khali.linux-fr.org/
