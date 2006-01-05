Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751879AbWAESk0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751879AbWAESk0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 13:40:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751883AbWAESk0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 13:40:26 -0500
Received: from webbox269.server-home.net ([195.137.213.113]:38821 "EHLO
	blackwhale.net") by vger.kernel.org with ESMTP id S1751879AbWAESk0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 13:40:26 -0500
From: Andreas Happe <andreashappe@snikt.net>
To: jketreno@linux.intel.com
Subject: Re: [ipw2200] add monitor and qos entries to Kconfig
Date: Thu, 5 Jan 2006 19:40:07 +0100
User-Agent: KMail/1.9.1
Cc: jgarzik@pobox.com, linux-kernel@vger.kernel.org
References: <200601051856.13828.andreashappe@snikt.net>
In-Reply-To: <200601051856.13828.andreashappe@snikt.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601051940.08116.andreashappe@snikt.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have made a stupid copy&paste error: QoS option is named IPW_QOS not 
IPW2200_MONITOR. Spotted by Daniel Paschka, thanks.

Add the following config entries for the ipw2200 driver to 
drivers/net/wireless/Kconfig
 * IPW2200_MONITOR
   enables Monitor mode
 * IPW_QOS
   enables QoS feature - this is under development right now, so it depends 
upon EXPERIMENTAL

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
+config IPW_QOS
+        bool "Enable QoS support"
+        depends on IPW2200 && EXPERIMENTAL
+
 config IPW_DEBUG
 	bool "Enable full debugging output in IPW2200 module."
 	depends on IPW2200
