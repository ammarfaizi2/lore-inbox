Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751518AbWDAPm7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751518AbWDAPm7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Apr 2006 10:42:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751548AbWDAPm7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Apr 2006 10:42:59 -0500
Received: from host-84-9-202-240.bulldogdsl.com ([84.9.202.240]:7620 "EHLO
	aeryn.fluff.org.uk") by vger.kernel.org with ESMTP id S1751518AbWDAPm7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Apr 2006 10:42:59 -0500
Date: Sat, 1 Apr 2006 16:42:46 +0100
From: Ben Dooks <ben-linux@fluff.org>
To: linux-kernel@vger.kernel.org
Cc: rpurdie@rpsys.net
Subject: [RFC] [LEDS] reorganise Kconfig
Message-ID: <20060401154246.GA11649@home.fluff.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="ibTvN161/egqYuK8"
Content-Disposition: inline
X-Disclaimer: I speak for me, myself, and the other one of me.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ibTvN161/egqYuK8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

This patch reorganises the drivers/leds Kconfig
file to have the LED trigger enable with the
triggers themselves.

The patch also adds comments to divide up the
sections into the drivers and triggers

Signed-off-by: Ben Dooks <ben-linux@fluff.org>

--ibTvN161/egqYuK8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="2616-leds-kconfig-reorg.patch"

diff -urpN -X ../dontdiff linux-2.6.16-git20-bjd3/drivers/leds/Kconfig linux-2.6.16-git20-bjd4/drivers/leds/Kconfig
--- linux-2.6.16-git20-bjd3/drivers/leds/Kconfig	2006-04-01 14:49:22.000000000 +0100
+++ linux-2.6.16-git20-bjd4/drivers/leds/Kconfig	2006-04-01 16:37:11.000000000 +0100
@@ -14,13 +14,7 @@ config LEDS_CLASS
 	  This option enables the led sysfs class in /sys/class/leds.  You'll
 	  need this to do anything useful with LEDs.  If unsure, say N.
 
-config LEDS_TRIGGERS
-	bool "LED Trigger support"
-	depends NEW_LEDS
-	help
-	  This option enables trigger support for the leds class.
-	  These triggers allow kernel events to drive the LEDs and can
-	  be configured via sysfs. If unsure, say Y.
+comment "LED drivers"
 
 config LEDS_CORGI
 	tristate "LED Support for the Sharp SL-C7x0 series"
@@ -66,6 +60,16 @@ config LEDS_S3C24XX
 	  This option enables support for LEDs connected to GPIO lines
 	  on Samsung S3C24XX series CPUs, such as the S3C2410 and S3C2440.
 
+comment "LED Triggers"
+
+config LEDS_TRIGGERS
+	bool "LED Trigger support"
+	depends NEW_LEDS
+	help
+	  This option enables trigger support for the leds class.
+	  These triggers allow kernel events to drive the LEDs and can
+	  be configured via sysfs. If unsure, say Y.
+
 config LEDS_TRIGGER_TIMER
 	tristate "LED Timer Trigger"
 	depends LEDS_TRIGGERS

--ibTvN161/egqYuK8--
