Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272557AbTG1BHa (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jul 2003 21:07:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272554AbTG1ADm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jul 2003 20:03:42 -0400
Received: from zeus.kernel.org ([204.152.189.113]:31477 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S272737AbTG0W6p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jul 2003 18:58:45 -0400
Date: Sun, 27 Jul 2003 21:15:47 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200307272015.h6RKFl9f029725@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: PATCH: switch escaped 8859-1 symbols inthe kernel to ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(Otherwise this plays hell with logging on non old US systems)
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.6.0-test2/drivers/usb/serial/visor.c linux-2.6.0-test2-ac1/drivers/usb/serial/visor.c
--- linux-2.6.0-test2/drivers/usb/serial/visor.c	2003-07-27 19:56:28.000000000 +0100
+++ linux-2.6.0-test2-ac1/drivers/usb/serial/visor.c	2003-07-27 20:32:35.000000000 +0100
@@ -169,7 +169,7 @@
  */
 #define DRIVER_VERSION "v2.1"
 #define DRIVER_AUTHOR "Greg Kroah-Hartman <greg@kroah.com>"
-#define DRIVER_DESC "USB HandSpring Visor, Palm m50x, Sony Clié driver"
+#define DRIVER_DESC "USB HandSpring Visor, Palm m50x, Sony Clie driver"
 
 /* function prototypes for a handspring visor */
 static int  visor_open		(struct usb_serial_port *port, struct file *filp);
@@ -275,7 +275,7 @@
 /* All of the device info needed for the Handspring Visor, and Palm 4.0 devices */
 static struct usb_serial_device_type handspring_device = {
 	.owner =		THIS_MODULE,
-	.name =			"Handspring Visor / Treo / Palm 4.0 / Clié 4.x",
+	.name =			"Handspring Visor / Treo / Palm 4.0 / Clie 4.x",
 	.short_name =		"visor",
 	.id_table =		id_table,
 	.num_interrupt_in =	NUM_DONT_CARE,
@@ -303,7 +303,7 @@
 /* device info for the Sony Clie OS version 3.5 */
 static struct usb_serial_device_type clie_3_5_device = {
 	.owner =		THIS_MODULE,
-	.name =			"Sony Clié 3.5",
+	.name =			"Sony Clie 3.5",
 	.short_name =		"clie_3.5",
 	.id_table =		clie_id_3_5_table,
 	.num_interrupt_in =	0,
