Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268881AbUIXRcs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268881AbUIXRcs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 13:32:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268954AbUIXRcr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 13:32:47 -0400
Received: from mta7.srv.hcvlny.cv.net ([167.206.5.74]:23185 "EHLO
	mta7.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id S268881AbUIXRaq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 13:30:46 -0400
Date: Fri, 24 Sep 2004 13:30:44 -0400
From: "Josef 'Jeff' Sipek" <jeffpc@optonline.net>
Subject: [Patch 2.6] Use proper sysfs mount-point
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, torvalds@osdl.org
Message-id: <20040924173044.GB17723@optonline.net>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Content-disposition: inline
User-Agent: Mutt/1.5.6+20040803i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Use proper sysfs mount-point.

Jeff Sipek.
   
Signed-off-by: Josef "Jeff" Sipek <jeffpc@optonline.net>
 
diff -Nru a/Documentation/firmware_class/README b/Documentation/firmware_class/README
--- a/Documentation/firmware_class/README	2004-09-24 13:08:57 -04:00
+++ b/Documentation/firmware_class/README	2004-09-24 13:08:57 -04:00
@@ -61,7 +61,7 @@
 	HOTPLUG_FW_DIR=/usr/lib/hotplug/firmware/
 
 	echo 1 > /sys/$DEVPATH/loading
-	cat $HOTPLUG_FW_DIR/$FIRMWARE > /sysfs/$DEVPATH/data
+	cat $HOTPLUG_FW_DIR/$FIRMWARE > /sys/$DEVPATH/data
 	echo 0 > /sys/$DEVPATH/loading
 
  Random notes:
diff -Nru a/Documentation/firmware_class/hotplug-script b/Documentation/firmware_class/hotplug-script
--- a/Documentation/firmware_class/hotplug-script	2004-09-24 13:08:57 -04:00
+++ b/Documentation/firmware_class/hotplug-script	2004-09-24 13:08:57 -04:00
@@ -7,10 +7,10 @@
 HOTPLUG_FW_DIR=/usr/lib/hotplug/firmware/
 
 echo 1 > /sys/$DEVPATH/loading
-cat $HOTPLUG_FW_DIR/$FIRMWARE > /sysfs/$DEVPATH/data
+cat $HOTPLUG_FW_DIR/$FIRMWARE > /sys/$DEVPATH/data
 echo 0 > /sys/$DEVPATH/loading
 
 # To cancel the load in case of error:
 #
-#	echo -1 > /sysfs/$DEVPATH/loading
+#	echo -1 > /sys/$DEVPATH/loading
 #
