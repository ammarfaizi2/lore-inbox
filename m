Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261828AbVAHJZZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261828AbVAHJZZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 04:25:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261832AbVAHJYg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 04:24:36 -0500
Received: from mail.kroah.org ([69.55.234.183]:30597 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261828AbVAHFsG convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 00:48:06 -0500
Subject: Re: [PATCH] USB and Driver Core patches for 2.6.10
In-Reply-To: <110516325823@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 7 Jan 2005 21:47:38 -0800
Message-Id: <11051632583265@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1938.439.52, 2005/01/07 08:45:22-08:00, david-b@pacbell.net

[PATCH] USB: minor usb doc/comment fixes

Some minor doc/comment fixes for USB.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/usb/gadget/epautoconf.c |    3 +++
 drivers/usb/gadget/omap_udc.c   |    2 +-
 include/linux/usb.h             |    4 ++--
 3 files changed, 6 insertions(+), 3 deletions(-)


diff -Nru a/drivers/usb/gadget/epautoconf.c b/drivers/usb/gadget/epautoconf.c
--- a/drivers/usb/gadget/epautoconf.c	2005-01-07 15:36:43 -08:00
+++ b/drivers/usb/gadget/epautoconf.c	2005-01-07 15:36:43 -08:00
@@ -55,6 +55,9 @@
  *
  * Type suffixes are "-bulk", "-iso", or "-int".  Numbers are decimal.
  * Less common restrictions are implied by gadget_is_*().
+ *
+ * NOTE:  each endpoint is unidirectional, as specified by its USB
+ * descriptor; and isn't specific to a configuration or altsetting.
  */
 static int __init
 ep_matches (
diff -Nru a/drivers/usb/gadget/omap_udc.c b/drivers/usb/gadget/omap_udc.c
--- a/drivers/usb/gadget/omap_udc.c	2005-01-07 15:36:43 -08:00
+++ b/drivers/usb/gadget/omap_udc.c	2005-01-07 15:36:43 -08:00
@@ -1,5 +1,5 @@
 /*
- * omap_udc.c -- for OMAP 1610 udc, with OTG support
+ * omap_udc.c -- for OMAP full speed udc; most chips support OTG.
  *
  * Copyright (C) 2004 Texas Instruments, Inc.
  * Copyright (C) 2004 David Brownell
diff -Nru a/include/linux/usb.h b/include/linux/usb.h
--- a/include/linux/usb.h	2005-01-07 15:36:43 -08:00
+++ b/include/linux/usb.h	2005-01-07 15:36:43 -08:00
@@ -739,8 +739,8 @@
  * to poll for transfers.  After the URB has been submitted, the interval
  * field reflects how the transfer was actually scheduled.
  * The polling interval may be more frequent than requested.
- * For example, some controllers have a maximum interval of 32 microseconds,
- * while others support intervals of up to 1024 microseconds.
+ * For example, some controllers have a maximum interval of 32 milliseconds,
+ * while others support intervals of up to 1024 milliseconds.
  * Isochronous URBs also have transfer intervals.  (Note that for isochronous
  * endpoints, as well as high speed interrupt endpoints, the encoding of
  * the transfer interval in the endpoint descriptor is logarithmic.

