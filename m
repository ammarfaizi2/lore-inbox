Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275384AbTHSGch (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 02:32:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275386AbTHSGcg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 02:32:36 -0400
Received: from nessie.weebeastie.net ([61.8.7.205]:64493 "EHLO
	nessie.weebeastie.net") by vger.kernel.org with ESMTP
	id S275384AbTHSGcd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 02:32:33 -0400
Date: Tue, 19 Aug 2003 16:33:47 +1000
From: CaT <cat@zip.com.au>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 1/10] 2.6.0-t3: struct C99 initialiser conversion
Message-ID: <20030819063347.GG643@zip.com.au>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="rS8CxjVDS/+yyDmU"
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Organisation: Furball Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--rS8CxjVDS/+yyDmU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

linux/Documentation/ patch

-- 
"How can I not love the Americans? They helped me with a flat tire the
other day," he said.
	- http://tinyurl.com/h6fo

--rS8CxjVDS/+yyDmU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="2.6.0-t3.c99.Documentation.patch"

diff -aur linux.backup/Documentation/DocBook/writing_usb_driver.tmpl linux/Documentation/DocBook/writing_usb_driver.tmpl
--- linux.backup/Documentation/DocBook/writing_usb_driver.tmpl	Thu Oct 31 11:42:55 2002
+++ linux/Documentation/DocBook/writing_usb_driver.tmpl	Sat Aug 16 15:45:01 2003
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
+++ linux/Documentation/usb/hotplug.txt	Sat Aug 16 15:45:01 2003
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
 

--rS8CxjVDS/+yyDmU--
