Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261761AbTHTH5w (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Aug 2003 03:57:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261763AbTHTH5v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Aug 2003 03:57:51 -0400
Received: from nessie.weebeastie.net ([61.8.7.205]:9933 "EHLO
	nessie.weebeastie.net") by vger.kernel.org with ESMTP
	id S261761AbTHTH5s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Aug 2003 03:57:48 -0400
Date: Wed, 20 Aug 2003 17:58:56 +1000
Message-Id: <200308200758.h7K7wuGE011612@theirongiant.lochness.weebeastie.net>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 1/16] C99: 2.6.0-t3-bk7/Documentation
Cc: Linus Torvalds <torvalds@osdl.org>
From: CaT <cat@zip.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -aur linux.backup/Documentation/DocBook/writing_usb_driver.tmpl linux/Documentation/DocBook/writing_usb_driver.tmpl
--- linux.backup/Documentation/DocBook/writing_usb_driver.tmpl	Thu Oct 31 11:42:55 2002
+++ linux/Documentation/DocBook/writing_usb_driver.tmpl	Wed Aug 20 16:40:22 2003
@@ -111,12 +111,12 @@
   </para>
   <programlisting>
 static struct usb_driver skel_driver = {
-        name:        "skeleton",
-        probe:       skel_probe,
-        disconnect:  skel_disconnect,
-        fops:        &amp;skel_fops,
-        minor:       USB_SKEL_MINOR_BASE,
-        id_table:    skel_table,
+        .name        = "skeleton",
+        .probe       = skel_probe,
+        .disconnect  = skel_disconnect,
+        .fops        = &amp;skel_fops,
+        .minor       = USB_SKEL_MINOR_BASE,
+        .id_table    = skel_table,
 };
   </programlisting>
   <para>
diff -aur linux.backup/Documentation/usb/hotplug.txt linux/Documentation/usb/hotplug.txt
--- linux.backup/Documentation/usb/hotplug.txt	Mon Jan 27 13:43:40 2003
+++ linux/Documentation/usb/hotplug.txt	Wed Aug 20 16:40:22 2003
@@ -122,17 +122,17 @@
 something like this:
 
     static struct usb_driver mydriver = {
-	name:		"mydriver",
-	id_table:	mydriver_id_table,
-	probe:		my_probe,
-	disconnect:	my_disconnect,
+	.name		= "mydriver",
+	.id_table	= mydriver_id_table,
+	.probe		= my_probe,
+	.disconnect	= my_disconnect,
 
 	/*
 	if using the usb chardev framework:
-	    minor:		MY_USB_MINOR_START,
-	    fops:		my_file_ops,
+	    .minor		= MY_USB_MINOR_START,
+	    .fops		= my_file_ops,
 	if exposing any operations through usbdevfs:
-	    ioctl:		my_ioctl,
+	    .ioctl		= my_ioctl,
 	*/
     }
 
