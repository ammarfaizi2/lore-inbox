Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263070AbVCDWMK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263070AbVCDWMK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 17:12:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263044AbVCDWKl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 17:10:41 -0500
Received: from mail.kroah.org ([69.55.234.183]:1954 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263157AbVCDUya convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 15:54:30 -0500
Cc: mhoffman@lightlink.com
Subject: [PATCH] I2C: i2c-dev namespace cleanup
In-Reply-To: <11099685943850@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 4 Mar 2005 12:36:34 -0800
Message-Id: <1109968594850@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2090, 2005/03/02 12:04:12-08:00, mhoffman@lightlink.com

[PATCH] I2C: i2c-dev namespace cleanup

This patch is namespace cleanup for the i2c-dev module.  Please apply.

Signed-off-by Mark M. Hoffman <mhoffman@lightlink.com>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/i2c/i2c-dev.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)


diff -Nru a/drivers/i2c/i2c-dev.c b/drivers/i2c/i2c-dev.c
--- a/drivers/i2c/i2c-dev.c	2005-03-04 12:25:37 -08:00
+++ b/drivers/i2c/i2c-dev.c	2005-03-04 12:25:37 -08:00
@@ -55,7 +55,7 @@
 static struct i2c_dev *i2c_dev_array[I2C_MINORS];
 static DEFINE_SPINLOCK(i2c_dev_array_lock);
 
-struct i2c_dev *i2c_dev_get_by_minor(unsigned index)
+static struct i2c_dev *i2c_dev_get_by_minor(unsigned index)
 {
 	struct i2c_dev *i2c_dev;
 
@@ -65,7 +65,7 @@
 	return i2c_dev;
 }
 
-struct i2c_dev *i2c_dev_get_by_adapter(struct i2c_adapter *adap)
+static struct i2c_dev *i2c_dev_get_by_adapter(struct i2c_adapter *adap)
 {
 	struct i2c_dev *i2c_dev = NULL;
 
@@ -173,8 +173,8 @@
 	return ret;
 }
 
-int i2cdev_ioctl (struct inode *inode, struct file *file, unsigned int cmd, 
-                  unsigned long arg)
+static int i2cdev_ioctl(struct inode *inode, struct file *file,
+		unsigned int cmd, unsigned long arg)
 {
 	struct i2c_client *client = (struct i2c_client *)file->private_data;
 	struct i2c_rdwr_ioctl_data rdwr_arg;

