Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267770AbUJCKD5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267770AbUJCKD5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Oct 2004 06:03:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267772AbUJCKD5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Oct 2004 06:03:57 -0400
Received: from mta3.srv.hcvlny.cv.net ([167.206.5.69]:17718 "EHLO
	mta3.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id S267770AbUJCKDz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Oct 2004 06:03:55 -0400
Date: Sun, 03 Oct 2004 06:03:55 -0400
From: "Josef 'Jeff' Sipek" <jeffpc@optonline.net>
Subject: [PATCH 2.6][resend] Use proper sysfs mount-point
To: Linux Kernel Development <linux-kernel@vger.kernel.org>
Cc: akpm@osdl.org, torvalds@osdl.org, trivial@rustcorp.com.au
Message-id: <20041003100355.GA5804@optonline.net>
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

