Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262790AbTKPNJd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Nov 2003 08:09:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262791AbTKPNJd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Nov 2003 08:09:33 -0500
Received: from gprs145-223.eurotel.cz ([160.218.145.223]:3712 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262790AbTKPNJ3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Nov 2003 08:09:29 -0500
Date: Sun, 16 Nov 2003 14:10:00 +0100
From: Pavel Machek <pavel@ucw.cz>
To: kernel list <linux-kernel@vger.kernel.org>,
       Rusty trivial patch monkey Russell 
	<trivial@rustcorp.com.au>
Subject: Fix firmware loader docs
Message-ID: <20031116131000.GA293@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

AFAICS, sysfs should be mounted on /sys these days...

--- tmp/linux/Documentation/firmware_class/README	2003-08-27 12:00:01.000000000 +0200
+++ linux/Documentation/firmware_class/README	2003-11-06 13:50:58.000000000 +0100
@@ -60,9 +60,9 @@
 
 	HOTPLUG_FW_DIR=/usr/lib/hotplug/firmware/
 
-	echo 1 > /sysfs/$DEVPATH/loading
+	echo 1 > /sys/$DEVPATH/loading
 	cat $HOTPLUG_FW_DIR/$FIRMWARE > /sysfs/$DEVPATH/data
-	echo 0 > /sysfs/$DEVPATH/loading
+	echo 0 > /sys/$DEVPATH/loading
 
  Random notes:
  ============
--- tmp/linux/Documentation/firmware_class/hotplug-script	2003-06-24 12:27:38.000000000 +0200
+++ linux/Documentation/firmware_class/hotplug-script	2003-11-06 13:50:55.000000000 +0100
@@ -6,9 +6,9 @@
 
 HOTPLUG_FW_DIR=/usr/lib/hotplug/firmware/
 
-echo 1 > /sysfs/$DEVPATH/loading
+echo 1 > /sys/$DEVPATH/loading
 cat $HOTPLUG_FW_DIR/$FIRMWARE > /sysfs/$DEVPATH/data
-echo 0 > /sysfs/$DEVPATH/loading
+echo 0 > /sys/$DEVPATH/loading
 
 # To cancel the load in case of error:
 #

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
