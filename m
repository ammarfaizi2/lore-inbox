Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932108AbWAER4j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932108AbWAER4j (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 12:56:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932105AbWAER4j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 12:56:39 -0500
Received: from webbox269.server-home.net ([195.137.213.113]:29090 "EHLO
	blackwhale.net") by vger.kernel.org with ESMTP id S932108AbWAER4i
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 12:56:38 -0500
From: Andreas Happe <andreashappe@snikt.net>
To: jketreno@linux.intel.com, jgarzik@pobox.com, linux-kernel@vger.kernel.org
Subject: [ipw2200] add monitor and qos entries to Kconfig
Date: Thu, 5 Jan 2006 18:56:13 +0100
User-Agent: KMail/1.9.1
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200601051856.13828.andreashappe@snikt.net>
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add the following config entries for the ipw2200 driver to
drivers/net/wireless/Kconfig
 * IPW2200_MONITOR
   enables Monitor mode
 * IPW2200_QOS
   enables QoS feature - this is under development right now, so it depends 
   upon EXPERIMENTAL

driver compiles and enters monitor mode.

Signed-off-by: Andreas Happe <andreashappe@snikt.net>
--- drivers/net/wireless/Kconfig.orig	2006-01-05 18:30:10.000000000 +0100
+++ drivers/net/wireless/Kconfig	2006-01-05 18:30:13.000000000 +0100
@@ -217,6 +217,19 @@ config IPW2200
           say M here and read <file:Documentation/modules.txt>.  The module
           will be called ipw2200.ko.
 
+config IPW2200_MONITOR
+        bool "Enable promiscuous mode"
+        depends on IPW2200
+        ---help---
+	  Enables promiscuous/monitor mode support for the ipw2200 driver.
+	  With this feature compiled into the driver, you can switch to 
+	  promiscuous mode via the Wireless Tool's Monitor mode.  While in this
+	  mode, no packets can be sent.
+
+config IPW2200_MONITOR
+        bool "Enable QoS support"
+        depends on IPW2200 && EXPERIMENTAL
+
 config IPW_DEBUG
 	bool "Enable full debugging output in IPW2200 module."
 	depends on IPW2200
