Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264492AbUDSPF5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Apr 2004 11:05:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264490AbUDSPF4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Apr 2004 11:05:56 -0400
Received: from linux-bt.org ([217.160.111.169]:11201 "EHLO mail.holtmann.net")
	by vger.kernel.org with ESMTP id S263654AbUDSPFw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Apr 2004 11:05:52 -0400
Subject: [PATCH] Add compat ioctl's for CAPI
From: Marcel Holtmann <marcel@holtmann.org>
To: Linus Torvalds <torvalds@osdl.org>, Karsten Keil <kkeil@suse.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="=-UbJP6I4ZCckx3VdENRGE"
Message-Id: <1082387131.4403.54.camel@pegasus>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 19 Apr 2004 17:05:33 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-UbJP6I4ZCckx3VdENRGE
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Linus,

this patch adds the needed compat ioctl's for the CAPI on 64bit
platforms.

Regards

Marcel


--=-UbJP6I4ZCckx3VdENRGE
Content-Disposition: attachment; filename=patch
Content-Type: text/plain; name=patch; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

===== fs/compat_ioctl.c 1.24 vs edited =====
--- 1.24/fs/compat_ioctl.c	Mon Apr 12 19:54:18 2004
+++ edited/fs/compat_ioctl.c	Mon Apr 19 15:26:07 2004
@@ -70,8 +70,10 @@
 
 #include <net/sock.h>          /* siocdevprivate_ioctl */
 #include <net/bluetooth/bluetooth.h>
-#include <net/bluetooth/rfcomm.h>
 #include <net/bluetooth/hci.h>
+#include <net/bluetooth/rfcomm.h>
+
+#include <linux/capi.h>
 
 #include <scsi/scsi.h>
 /* Ugly hack. */
===== include/linux/compat_ioctl.h 1.21 vs edited =====
--- 1.21/include/linux/compat_ioctl.h	Sat Apr 17 20:19:27 2004
+++ edited/include/linux/compat_ioctl.h	Mon Apr 19 15:25:39 2004
@@ -597,7 +597,7 @@
 COMPATIBLE_IOCTL(RNDADDENTROPY)
 COMPATIBLE_IOCTL(RNDZAPENTCNT)
 COMPATIBLE_IOCTL(RNDCLEARPOOL)
-/* Bluetooth ioctls */
+/* Bluetooth */
 COMPATIBLE_IOCTL(HCIDEVUP)
 COMPATIBLE_IOCTL(HCIDEVDOWN)
 COMPATIBLE_IOCTL(HCIDEVRESET)
@@ -631,6 +631,20 @@
 COMPATIBLE_IOCTL(CMTPCONNDEL)
 COMPATIBLE_IOCTL(CMTPGETCONNLIST)
 COMPATIBLE_IOCTL(CMTPGETCONNINFO)
+/* CAPI */
+COMPATIBLE_IOCTL(CAPI_REGISTER)
+COMPATIBLE_IOCTL(CAPI_GET_MANUFACTURER)
+COMPATIBLE_IOCTL(CAPI_GET_VERSION)
+COMPATIBLE_IOCTL(CAPI_GET_SERIAL)
+COMPATIBLE_IOCTL(CAPI_GET_PROFILE)
+COMPATIBLE_IOCTL(CAPI_MANUFACTURER_CMD)
+COMPATIBLE_IOCTL(CAPI_GET_ERRCODE)
+COMPATIBLE_IOCTL(CAPI_INSTALLED)
+COMPATIBLE_IOCTL(CAPI_GET_FLAGS)
+COMPATIBLE_IOCTL(CAPI_SET_FLAGS)
+COMPATIBLE_IOCTL(CAPI_CLR_FLAGS)
+COMPATIBLE_IOCTL(CAPI_NCCI_OPENCOUNT)
+COMPATIBLE_IOCTL(CAPI_NCCI_GETUNIT)
 /* Misc. */
 COMPATIBLE_IOCTL(0x41545900)		/* ATYIO_CLKR */
 COMPATIBLE_IOCTL(0x41545901)		/* ATYIO_CLKW */

--=-UbJP6I4ZCckx3VdENRGE--

