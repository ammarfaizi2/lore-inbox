Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265824AbUGHG7p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265824AbUGHG7p (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jul 2004 02:59:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265847AbUGHG7o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jul 2004 02:59:44 -0400
Received: from smtp810.mail.sc5.yahoo.com ([66.163.170.80]:49282 "HELO
	smtp810.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S265824AbUGHG7R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jul 2004 02:59:17 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Vojtech Pavlik <vojtech@suse.cz>
Subject: [PATCH 1/8] New set of input patches
Date: Thu, 8 Jul 2004 01:55:37 -0500
User-Agent: KMail/1.6.2
Cc: LKML <linux-kernel@vger.kernel.org>
References: <200407080155.07827.dtor_core@ameritech.net>
In-Reply-To: <200407080155.07827.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200407080155.38937.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


===================================================================


ChangeSet@1.1820, 2004-07-08 00:21:54-05:00, dtor_core@ameritech.net
  Input: move input/serio closer to the top of drivers/Makefile so
         serio_bus is available early
  
  Signed-off-by: Dmitry Torokhov <dtor@mail.ru>


 Makefile |    4 +++-
 1 files changed, 3 insertions(+), 1 deletion(-)


===================================================================



diff -Nru a/drivers/Makefile b/drivers/Makefile
--- a/drivers/Makefile	2004-07-08 01:34:45 -05:00
+++ b/drivers/Makefile	2004-07-08 01:34:45 -05:00
@@ -15,6 +15,9 @@
 # char/ comes before serial/ etc so that the VT console is the boot-time
 # default.
 obj-y				+= char/
+# we also need input/serio early so serio bus is initialized by the time
+# serial drivers start registering their serio ports
+obj-$(CONFIG_SERIO)		+= input/serio/
 obj-y				+= serial/
 obj-$(CONFIG_PARPORT)		+= parport/
 obj-y				+= base/ block/ misc/ net/ media/
@@ -37,7 +40,6 @@
 obj-$(CONFIG_TC)		+= tc/
 obj-$(CONFIG_USB)		+= usb/
 obj-$(CONFIG_USB_GADGET)	+= usb/gadget/
-obj-$(CONFIG_SERIO)		+= input/serio/
 obj-$(CONFIG_INPUT)		+= input/
 obj-$(CONFIG_GAMEPORT)		+= input/gameport/
 obj-$(CONFIG_I2O)		+= message/
