Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261530AbUL2HsW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261530AbUL2HsW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Dec 2004 02:48:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261488AbUL2Hl7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Dec 2004 02:41:59 -0500
Received: from smtp802.mail.sc5.yahoo.com ([66.163.168.181]:17839 "HELO
	smtp802.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261429AbUL2Hd2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Dec 2004 02:33:28 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Vojtech Pavlik <vojtech@suse.cz>
Subject: [PATCH 10/16] Fix building twidjoy module
Date: Wed, 29 Dec 2004 02:27:37 -0500
User-Agent: KMail/1.6.2
Cc: linux-input@atrey.karlin.mff.cuni.cz, LKML <linux-kernel@vger.kernel.org>
References: <200412290217.36282.dtor_core@ameritech.net> <200412290225.17324.dtor_core@ameritech.net> <200412290226.37664.dtor_core@ameritech.net>
In-Reply-To: <200412290226.37664.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200412290227.39294.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


===================================================================


ChangeSet@1.1970, 2004-12-28 00:45:17-05:00, dtor_core@ameritech.net
  Input: twidjoy - apparently Kconfig and Makefile disagreed on the
         name for config option so the module was never built.
  
  Signed-off-by: Dmitry Torokhov <dtor@mail.ru>


 Kconfig   |    2 +-
 twidjoy.c |    4 +++-
 2 files changed, 4 insertions(+), 2 deletions(-)


===================================================================



diff -Nru a/drivers/input/joystick/Kconfig b/drivers/input/joystick/Kconfig
--- a/drivers/input/joystick/Kconfig	2004-12-29 01:50:22 -05:00
+++ b/drivers/input/joystick/Kconfig	2004-12-29 01:50:22 -05:00
@@ -187,7 +187,7 @@
 	  To compile this driver as a module, choose M here: the
 	  module will be called stinger.
 
-config JOYSTICK_TWIDDLER
+config JOYSTICK_TWIDJOY
 	tristate "Twiddler as a joystick"
 	depends on INPUT && INPUT_JOYSTICK
 	select SERIO
diff -Nru a/drivers/input/joystick/twidjoy.c b/drivers/input/joystick/twidjoy.c
--- a/drivers/input/joystick/twidjoy.c	2004-12-29 01:50:22 -05:00
+++ b/drivers/input/joystick/twidjoy.c	2004-12-29 01:50:22 -05:00
@@ -58,7 +58,9 @@
 #include <linux/serio.h>
 #include <linux/init.h>
 
-MODULE_DESCRIPTION("Handykey Twiddler keyboard as a joystick driver");
+#define DRIVER_DESC	"Handykey Twiddler keyboard as a joystick driver"
+
+MODULE_DESCRIPTION(DRIVER_DESC);
 MODULE_LICENSE("GPL");
 
 /*
