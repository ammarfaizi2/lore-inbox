Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261962AbVCEF0X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261962AbVCEF0X (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Mar 2005 00:26:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263303AbVCDXH6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 18:07:58 -0500
Received: from mail.kroah.org ([69.55.234.183]:36514 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263182AbVCDUyy convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 15:54:54 -0500
Cc: johnpol@2ka.mipt.ru
Subject: [PATCH] w1: dscore cleanups. 2/2
In-Reply-To: <110996878287@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 4 Mar 2005 12:39:42 -0800
Message-Id: <11099687822751@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2081, 2005/03/02 16:58:36-08:00, johnpol@2ka.mipt.ru

[PATCH] w1: dscore cleanups. 2/2

Trivial cleanups, mostly static/non static, removed unneded exports.

Signed-off-by: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/w1/dscore.c |   24 ++++++++++++++----------
 1 files changed, 14 insertions(+), 10 deletions(-)


diff -Nru a/drivers/w1/dscore.c b/drivers/w1/dscore.c
--- a/drivers/w1/dscore.c	2005-03-04 12:38:18 -08:00
+++ b/drivers/w1/dscore.c	2005-03-04 12:38:18 -08:00
@@ -148,7 +148,7 @@
 	return count;
 }
 
-int ds_recv_status(struct ds_device *dev, struct ds_status *st)
+static int ds_recv_status(struct ds_device *dev, struct ds_status *st)
 {
 	unsigned char buf[64];
 	int count, err = 0, i;
@@ -206,7 +206,7 @@
 	return err;
 }
 
-int ds_recv_data(struct ds_device *dev, unsigned char *buf, int size)
+static int ds_recv_data(struct ds_device *dev, unsigned char *buf, int size)
 {
 	int count, err;
 	struct ds_status st;
@@ -234,7 +234,7 @@
 	return count;
 }
 
-int ds_send_data(struct ds_device *dev, unsigned char *buf, int len)
+static int ds_send_data(struct ds_device *dev, unsigned char *buf, int len)
 {
 	int count, err;
 	
@@ -774,15 +774,19 @@
 EXPORT_SYMBOL(ds_write_byte);
 EXPORT_SYMBOL(ds_write_bit);
 EXPORT_SYMBOL(ds_write_block);
+EXPORT_SYMBOL(ds_reset);
+EXPORT_SYMBOL(ds_get_device);
+EXPORT_SYMBOL(ds_put_device);
+
+/*
+ * This functions can be used for EEPROM programming, 
+ * when driver will be included into mainline this will 
+ * require uncommenting.
+ */
+#if 0
 EXPORT_SYMBOL(ds_start_pulse);
 EXPORT_SYMBOL(ds_set_speed);
-EXPORT_SYMBOL(ds_reset);
 EXPORT_SYMBOL(ds_detect);
 EXPORT_SYMBOL(ds_stop_pulse);
-EXPORT_SYMBOL(ds_send_data);
-EXPORT_SYMBOL(ds_recv_data);
-EXPORT_SYMBOL(ds_recv_status);
 EXPORT_SYMBOL(ds_search);
-EXPORT_SYMBOL(ds_get_device);
-EXPORT_SYMBOL(ds_put_device);
-
+#endif

