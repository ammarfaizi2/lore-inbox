Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261306AbULAAXR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261306AbULAAXR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 19:23:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261180AbULAAT0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 19:19:26 -0500
Received: from mail.kroah.org ([69.55.234.183]:49892 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261281AbULAAOY convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 19:14:24 -0500
Subject: Re: [PATCH] I2C fixes for 2.6.10-rc2
In-Reply-To: <11018600193699@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Tue, 30 Nov 2004 16:13:39 -0800
Message-Id: <11018600193088@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2223.2.4, 2004/11/24 14:25:23-08:00, johnpol@2ka.mipt.ru

[PATCH] drivers/w1/dscore: fix the inline mess

Remove unneded inlines.

Signed-off-by: Adrian Bunk <bunk@stusta.de>
Signed-off-by: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/w1/dscore.c |   40 ++++++++++++++++++++--------------------
 drivers/w1/dscore.h |   34 +++++++++++++++++-----------------
 2 files changed, 37 insertions(+), 37 deletions(-)


diff -Nru a/drivers/w1/dscore.c b/drivers/w1/dscore.c
--- a/drivers/w1/dscore.c	2004-11-30 16:01:10 -08:00
+++ b/drivers/w1/dscore.c	2004-11-30 16:01:10 -08:00
@@ -35,26 +35,26 @@
 int ds_probe(struct usb_interface *, const struct usb_device_id *);
 void ds_disconnect(struct usb_interface *);
 
-inline int ds_touch_bit(struct ds_device *, u8, u8 *);
-inline int ds_read_byte(struct ds_device *, u8 *);
-inline int ds_read_bit(struct ds_device *, u8 *);
-inline int ds_write_byte(struct ds_device *, u8);
-inline int ds_write_bit(struct ds_device *, u8);
-inline int ds_start_pulse(struct ds_device *, int);
-inline int ds_set_speed(struct ds_device *, int);
-inline int ds_reset(struct ds_device *, struct ds_status *);
-inline int ds_detect(struct ds_device *, struct ds_status *);
-inline int ds_stop_pulse(struct ds_device *, int);
-inline int ds_send_data(struct ds_device *, unsigned char *, int);
-inline int ds_recv_data(struct ds_device *, unsigned char *, int);
-inline int ds_recv_status(struct ds_device *, struct ds_status *);
-inline struct ds_device * ds_get_device(void);
-inline void ds_put_device(struct ds_device *);
+int ds_touch_bit(struct ds_device *, u8, u8 *);
+int ds_read_byte(struct ds_device *, u8 *);
+int ds_read_bit(struct ds_device *, u8 *);
+int ds_write_byte(struct ds_device *, u8);
+int ds_write_bit(struct ds_device *, u8);
+int ds_start_pulse(struct ds_device *, int);
+int ds_set_speed(struct ds_device *, int);
+int ds_reset(struct ds_device *, struct ds_status *);
+int ds_detect(struct ds_device *, struct ds_status *);
+int ds_stop_pulse(struct ds_device *, int);
+int ds_send_data(struct ds_device *, unsigned char *, int);
+int ds_recv_data(struct ds_device *, unsigned char *, int);
+int ds_recv_status(struct ds_device *, struct ds_status *);
+struct ds_device * ds_get_device(void);
+void ds_put_device(struct ds_device *);
 
 static inline void ds_dump_status(unsigned char *, unsigned char *, int);
-static inline int ds_send_control(struct ds_device *, u16, u16);
-static inline int ds_send_control_mode(struct ds_device *, u16, u16);
-static inline int ds_send_control_cmd(struct ds_device *, u16, u16);
+static int ds_send_control(struct ds_device *, u16, u16);
+static int ds_send_control_mode(struct ds_device *, u16, u16);
+static int ds_send_control_cmd(struct ds_device *, u16, u16);
 
 
 static struct usb_driver ds_driver = {
@@ -503,7 +503,7 @@
 	return 0;
 }
 
-inline int ds_read_block(struct ds_device *dev, u8 *buf, int len)
+int ds_read_block(struct ds_device *dev, u8 *buf, int len)
 {
 	struct ds_status st;
 	int err;
@@ -529,7 +529,7 @@
 	return err;
 }
 
-inline int ds_write_block(struct ds_device *dev, u8 *buf, int len)
+int ds_write_block(struct ds_device *dev, u8 *buf, int len)
 {
 	int err;
 	struct ds_status st;
diff -Nru a/drivers/w1/dscore.h b/drivers/w1/dscore.h
--- a/drivers/w1/dscore.h	2004-11-30 16:01:10 -08:00
+++ b/drivers/w1/dscore.h	2004-11-30 16:01:10 -08:00
@@ -151,23 +151,23 @@
 
 };
 
-inline int ds_touch_bit(struct ds_device *, u8, u8 *);
-inline int ds_read_byte(struct ds_device *, u8 *);
-inline int ds_read_bit(struct ds_device *, u8 *);
-inline int ds_write_byte(struct ds_device *, u8);
-inline int ds_write_bit(struct ds_device *, u8);
-inline int ds_start_pulse(struct ds_device *, int);
-inline int ds_set_speed(struct ds_device *, int);
-inline int ds_reset(struct ds_device *, struct ds_status *);
-inline int ds_detect(struct ds_device *, struct ds_status *);
-inline int ds_stop_pulse(struct ds_device *, int);
-inline int ds_send_data(struct ds_device *, unsigned char *, int);
-inline int ds_recv_data(struct ds_device *, unsigned char *, int);
-inline int ds_recv_status(struct ds_device *, struct ds_status *);
-inline struct ds_device * ds_get_device(void);
-inline void ds_put_device(struct ds_device *);
-inline int ds_write_block(struct ds_device *, u8 *, int);
-inline int ds_read_block(struct ds_device *, u8 *, int);
+int ds_touch_bit(struct ds_device *, u8, u8 *);
+int ds_read_byte(struct ds_device *, u8 *);
+int ds_read_bit(struct ds_device *, u8 *);
+int ds_write_byte(struct ds_device *, u8);
+int ds_write_bit(struct ds_device *, u8);
+int ds_start_pulse(struct ds_device *, int);
+int ds_set_speed(struct ds_device *, int);
+int ds_reset(struct ds_device *, struct ds_status *);
+int ds_detect(struct ds_device *, struct ds_status *);
+int ds_stop_pulse(struct ds_device *, int);
+int ds_send_data(struct ds_device *, unsigned char *, int);
+int ds_recv_data(struct ds_device *, unsigned char *, int);
+int ds_recv_status(struct ds_device *, struct ds_status *);
+struct ds_device * ds_get_device(void);
+void ds_put_device(struct ds_device *);
+int ds_write_block(struct ds_device *, u8 *, int);
+int ds_read_block(struct ds_device *, u8 *, int);
 
 #endif /* __DSCORE_H */
 

