Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264510AbUATC2k (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jan 2004 21:28:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265213AbUATAKL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jan 2004 19:10:11 -0500
Received: from mail.kroah.org ([65.200.24.183]:17580 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265061AbUATAAA convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jan 2004 19:00:00 -0500
Subject: Re: [PATCH] i2c driver fixes for 2.6.1
In-Reply-To: <1074556763176@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 19 Jan 2004 15:59:23 -0800
Message-Id: <1074556763161@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1474.98.13, 2004/01/14 11:52:05-08:00, willy@debian.org

[PATCH] I2C: Kconfig cleanups

This patch attempts to reduce the number of inappropriate questions being
asked by menuconfig.


 drivers/i2c/Kconfig        |    6 +++---
 drivers/i2c/algos/Kconfig  |    1 +
 drivers/i2c/busses/Kconfig |    1 +
 drivers/i2c/chips/Kconfig  |    1 +
 4 files changed, 6 insertions(+), 3 deletions(-)


diff -Nru a/drivers/i2c/Kconfig b/drivers/i2c/Kconfig
--- a/drivers/i2c/Kconfig	Mon Jan 19 15:30:56 2004
+++ b/drivers/i2c/Kconfig	Mon Jan 19 15:30:56 2004
@@ -37,9 +37,9 @@
 	  This support is also available as a module.  If so, the module 
 	  will be called i2c-dev.
 
-	source drivers/i2c/algos/Kconfig
-	source drivers/i2c/busses/Kconfig
-	source drivers/i2c/chips/Kconfig
+source drivers/i2c/algos/Kconfig
+source drivers/i2c/busses/Kconfig
+source drivers/i2c/chips/Kconfig
 
 endmenu
 
diff -Nru a/drivers/i2c/algos/Kconfig b/drivers/i2c/algos/Kconfig
--- a/drivers/i2c/algos/Kconfig	Mon Jan 19 15:30:56 2004
+++ b/drivers/i2c/algos/Kconfig	Mon Jan 19 15:30:56 2004
@@ -3,6 +3,7 @@
 #
 
 menu "I2C Algorithms"
+	depends on I2C
 
 config I2C_ALGOBIT
 	tristate "I2C bit-banging interfaces"
diff -Nru a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
--- a/drivers/i2c/busses/Kconfig	Mon Jan 19 15:30:56 2004
+++ b/drivers/i2c/busses/Kconfig	Mon Jan 19 15:30:56 2004
@@ -3,6 +3,7 @@
 #
 
 menu "I2C Hardware Bus support"
+	depends on I2C
 
 config I2C_ALI1535
 	tristate "ALI 1535"
diff -Nru a/drivers/i2c/chips/Kconfig b/drivers/i2c/chips/Kconfig
--- a/drivers/i2c/chips/Kconfig	Mon Jan 19 15:30:56 2004
+++ b/drivers/i2c/chips/Kconfig	Mon Jan 19 15:30:56 2004
@@ -3,6 +3,7 @@
 #
 
 menu "I2C Hardware Sensors Chip support"
+	depends on I2C
 
 config I2C_SENSOR
 	tristate

