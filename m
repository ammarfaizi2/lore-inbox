Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261915AbUCPOms (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 09:42:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261909AbUCPOm0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 09:42:26 -0500
Received: from styx.suse.cz ([82.208.2.94]:60033 "EHLO shadow.ucw.cz")
	by vger.kernel.org with ESMTP id S261915AbUCPOTg convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 09:19:36 -0500
Content-Transfer-Encoding: 7BIT
Message-Id: <10794467773458@twilight.ucw.cz>
Content-Type: text/plain; charset=US-ASCII
Subject: [PATCH 13/44] Remove the obsolete busmouse.c helper driver
X-Mailer: gregkh_patchbomb_levon_offspring
To: torvalds@osdl.org, vojtech@ucw.cz, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Date: Tue, 16 Mar 2004 15:19:37 +0100
In-Reply-To: <1079446776714@twilight.ucw.cz>
From: Vojtech Pavlik <vojtech@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You can pull this changeset from:
	bk://kernel.bkbits.net/vojtech/input

===================================================================

ChangeSet@1.1474.188.14, 2004-01-27 21:01:27+01:00, aris@cathedrallabs.org
  input: Remove the obsolete "busmouse.c" helper driver.


 arch/arm26/Kconfig         |    5 -----
 drivers/char/Kconfig       |   24 ------------------------
 drivers/char/Makefile      |    1 -
 include/linux/miscdevice.h |    1 -
 4 files changed, 31 deletions(-)

===================================================================

diff -Nru a/arch/arm26/Kconfig b/arch/arm26/Kconfig
--- a/arch/arm26/Kconfig	Tue Mar 16 13:19:32 2004
+++ b/arch/arm26/Kconfig	Tue Mar 16 13:19:32 2004
@@ -216,11 +216,6 @@
 
 source "drivers/char/Kconfig"
 
-config KBDMOUSE
-	bool
-	depends on ARCH_ACORN && BUSMOUSE=y
-	default y
-
 source "drivers/media/Kconfig"
 
 source "fs/Kconfig"
diff -Nru a/drivers/char/Kconfig b/drivers/char/Kconfig
--- a/drivers/char/Kconfig	Tue Mar 16 13:19:32 2004
+++ b/drivers/char/Kconfig	Tue Mar 16 13:19:32 2004
@@ -588,30 +588,6 @@
 	bool "Support for console on line printer"
 	depends on PC9800_OLDLP
 
-
-menu "Mice"
-
-config BUSMOUSE
-	tristate "Bus Mouse Support"
-	---help---
-	  Say Y here if your machine has a bus mouse as opposed to a serial
-	  mouse. Most people have a regular serial MouseSystem or
-	  Microsoft mouse (made by Logitech) that plugs into a COM port
-	  (rectangular with 9 or 25 pins). These people say N here. 
-
-	  If you have a laptop, you either have to check the documentation or
-	  experiment a bit to find out whether the trackball is a serial mouse
-	  or not; it's best to say Y here for you.
-
-	  This is the generic bus mouse driver code. If you have a bus mouse,
-	  you will have to say Y here and also to the specific driver for your
-	  mouse below.
-
-	  To compile this driver as a module, choose M here: the
-	  module will be called busmouse.
-
-endmenu
-
 config QIC02_TAPE
 	tristate "QIC-02 tape support"
 	help
diff -Nru a/drivers/char/Makefile b/drivers/char/Makefile
--- a/drivers/char/Makefile	Tue Mar 16 13:19:32 2004
+++ b/drivers/char/Makefile	Tue Mar 16 13:19:32 2004
@@ -49,7 +49,6 @@
 obj-$(CONFIG_TIPAR) += tipar.o
 obj-$(CONFIG_PC9800_OLDLP) += lp_old98.o
 
-obj-$(CONFIG_BUSMOUSE) += busmouse.o
 obj-$(CONFIG_DTLK) += dtlk.o
 obj-$(CONFIG_R3964) += n_r3964.o
 obj-$(CONFIG_APPLICOM) += applicom.o
diff -Nru a/include/linux/miscdevice.h b/include/linux/miscdevice.h
--- a/include/linux/miscdevice.h	Tue Mar 16 13:19:32 2004
+++ b/include/linux/miscdevice.h	Tue Mar 16 13:19:32 2004
@@ -3,7 +3,6 @@
 #include <linux/module.h>
 #include <linux/major.h>
 
-#define BUSMOUSE_MINOR 0
 #define PSMOUSE_MINOR  1
 #define MS_BUSMOUSE_MINOR 2
 #define ATIXL_BUSMOUSE_MINOR 3

