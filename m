Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262721AbUKLXrs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262721AbUKLXrs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Nov 2004 18:47:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262713AbUKLXqw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Nov 2004 18:46:52 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.106]:1021 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262683AbUKLX0v convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Nov 2004 18:26:51 -0500
Subject: Re: [PATCH] I2C fixes for 2.6.10-rc1
In-Reply-To: <11003020053782@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 12 Nov 2004 15:26:45 -0800
Message-Id: <11003020051927@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2095, 2004/11/12 13:20:15-08:00, khali@linux-fr.org

[PATCH] I2C: Missing newlines in debug messages

As discussed on IRC, this simple patch fixes broken debug messages
missing their trailing newlines. I just applied something similar to
CVS, and will prepare patches for 2.4 as well.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/i2c/i2c-core.c          |    2 +-
 drivers/i2c/i2c-dev.c           |    2 +-
 drivers/i2c/i2c-sensor-detect.c |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)


diff -Nru a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
--- a/drivers/i2c/i2c-core.c	2004-11-12 15:22:38 -08:00
+++ b/drivers/i2c/i2c-core.c	2004-11-12 15:22:38 -08:00
@@ -760,7 +760,7 @@
 			if (addr == address_data->normal_i2c[i]) {
 				found = 1;
 				dev_dbg(&adapter->dev, "found normal i2c entry for adapter %d, "
-					"addr %02x", adap_id,addr);
+					"addr %02x\n", adap_id, addr);
 			}
 		}
 
diff -Nru a/drivers/i2c/i2c-dev.c b/drivers/i2c/i2c-dev.c
--- a/drivers/i2c/i2c-dev.c	2004-11-12 15:22:38 -08:00
+++ b/drivers/i2c/i2c-dev.c	2004-11-12 15:22:38 -08:00
@@ -539,7 +539,7 @@
 out_unreg_chrdev:
 	unregister_chrdev(I2C_MAJOR, "i2c");
 out:
-	printk(KERN_ERR "%s: Driver Initialisation failed", __FILE__);
+	printk(KERN_ERR "%s: Driver Initialisation failed\n", __FILE__);
 	return res;
 }
 
diff -Nru a/drivers/i2c/i2c-sensor-detect.c b/drivers/i2c/i2c-sensor-detect.c
--- a/drivers/i2c/i2c-sensor-detect.c	2004-11-12 15:22:38 -08:00
+++ b/drivers/i2c/i2c-sensor-detect.c	2004-11-12 15:22:38 -08:00
@@ -115,7 +115,7 @@
 			for (i = 0; !found && (normal_i2c[i] != I2C_CLIENT_END); i += 1) {
 				if (addr == normal_i2c[i]) {
 					found = 1;
-					dev_dbg(&adapter->dev, "found normal i2c entry for adapter %d, addr %02x", adapter_id, addr);
+					dev_dbg(&adapter->dev, "found normal i2c entry for adapter %d, addr %02x\n", adapter_id, addr);
 				}
 			}
 		}

