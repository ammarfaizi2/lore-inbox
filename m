Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262330AbUKBNKB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262330AbUKBNKB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 08:10:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262023AbUKBNKA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 08:10:00 -0500
Received: from [212.209.10.221] ([212.209.10.221]:5077 "EHLO krynn.se.axis.com")
	by vger.kernel.org with ESMTP id S262987AbUKBNFN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 08:05:13 -0500
From: "Mikael Starvik" <mikael.starvik@axis.com>
To: <linux-kernel@vger.kernel.org>, <akpm@osdl.org>
Subject: [PATCH 9/10] CRIS architecture update - Move drivers2
Date: Tue, 2 Nov 2004 14:04:53 +0100
Message-ID: <BFECAF9E178F144FAEF2BF4CE739C668014C748D@exmail1.se.axis.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_01E3_01C4C0E4.ED9814E0"
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.6626
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1441
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_01E3_01C4C0E4.ED9814E0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Patches to update Makefiles after drivers have been moved.

Signed-Off-By: starvik@axis.com

/Mikael

------=_NextPart_000_01E3_01C4C0E4.ED9814E0
Content-Type: application/octet-stream;
	name="cris269_9.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="cris269_9.patch"

--- 269_clean/arch/cris/arch-v10/drivers/Makefile	Thu Jan 22 09:24:12 =
2004=0A=
+++ 269_modified/arch/cris/arch-v10/drivers/Makefile	Tue Nov  2 12:33:30 =
2004=0A=
@@ -2,15 +2,11 @@=0A=
 # Makefile for Etrax-specific drivers=0A=
 #=0A=
 =0A=
-obj-$(CONFIG_ETRAX_ETHERNET)            +=3D ethernet.o=0A=
-obj-$(CONFIG_ETRAX_SERIAL)              +=3D serial.o=0A=
 obj-$(CONFIG_ETRAX_AXISFLASHMAP)        +=3D axisflashmap.o=0A=
 obj-$(CONFIG_ETRAX_I2C) 	        +=3D i2c.o=0A=
 obj-$(CONFIG_ETRAX_I2C_EEPROM)          +=3D eeprom.o=0A=
 obj-$(CONFIG_ETRAX_GPIO) 	        +=3D gpio.o=0A=
 obj-$(CONFIG_ETRAX_DS1302)              +=3D ds1302.o=0A=
 obj-$(CONFIG_ETRAX_PCF8563)		+=3D pcf8563.o=0A=
-obj-$(CONFIG_ETRAX_IDE)                 +=3D ide.o=0A=
-obj-$(CONFIG_ETRAX_USB_HOST)            +=3D usb-host.o=0A=
 =0A=
 =0A=
--- 269_clean/drivers/net/Makefile	Tue Oct 19 15:09:44 2004=0A=
+++ 269_modified/drivers/net/Makefile	Tue Nov  2 12:34:49 2004=0A=
@@ -194,5 +194,6 @@=0A=
 obj-$(CONFIG_NET_TULIP) +=3D tulip/=0A=
 obj-$(CONFIG_HAMRADIO) +=3D hamradio/=0A=
 obj-$(CONFIG_IRDA) +=3D irda/=0A=
+obj-$(CONFIG_ETRAX_ETHERNET) +=3D cris/=0A=
 =0A=
 obj-$(CONFIG_NETCONSOLE) +=3D netconsole.o=0A=
--- 269_clean/drivers/net/cris/Makefile	Thu Jan  1 01:00:00 1970=0A=
+++ 269_modified/drivers/net/cris/Makefile	Tue Nov  2 13:07:12 2004=0A=
@@ -0,0 +1 @@=0A=
+obj-$(CONFIG_ETRAX_ARCH_V10)		+=3D v10/=0A=
--- 269_clean/drivers/net/cris/v10/Makefile	Thu Jan  1 01:00:00 1970=0A=
+++ 269_modified/drivers/net/cris/v10/Makefile	Tue Nov  2 12:35:35 2004=0A=
@@ -0,0 +1 @@=0A=
+obj-y		:=3D ethernet.o=0A=
--- 269_clean/drivers/ide/Makefile	Mon Aug 16 14:38:33 2004=0A=
+++ 269_modified/drivers/ide/Makefile	Tue Nov  2 12:28:53 2004=0A=
@@ -52,3 +52,4 @@=0A=
 =0A=
 obj-$(CONFIG_BLK_DEV_IDE)		+=3D legacy/ arm/=0A=
 obj-$(CONFIG_BLK_DEV_HD)		+=3D legacy/=0A=
+obj-$(CONFIG_ETRAX_IDE)			+=3D cris/=0A=
\ No newline at end of file=0A=
--- 269_clean/drivers/ide/cris/Makefile	Thu Jan  1 01:00:00 1970=0A=
+++ 269_modified/drivers/ide/cris/Makefile	Tue Nov  2 13:06:57 2004=0A=
@@ -0,0 +1,3 @@=0A=
+obj-$(CONFIG_ETRAX_ARCH_V10)		+=3D v10/=0A=
+=0A=
+EXTRA_CFLAGS	:=3D -Idrivers/ide=0A=
--- 269_clean/drivers/ide/cris/v10/Makefile	Thu Jan  1 01:00:00 1970=0A=
+++ 269_modified/drivers/ide/cris/v10/Makefile	Tue Nov  2 12:33:19 2004=0A=
@@ -0,0 +1,3 @@=0A=
+obj-y		:=3D ide.o=0A=
+=0A=
+EXTRA_CFLAGS	:=3D -Idrivers/ide=0A=
--- 269_clean/drivers/serial/Makefile	Mon Aug 16 10:14:33 2004=0A=
+++ 269_modified/drivers/serial/Makefile	Tue Nov  2 12:36:08 2004=0A=
@@ -41,3 +41,4 @@=0A=
 obj-$(CONFIG_SERIAL_SGI_L1_CONSOLE) +=3D sn_console.o=0A=
 obj-$(CONFIG_SERIAL_CPM) +=3D cpm_uart/=0A=
 obj-$(CONFIG_SERIAL_MPC52xx) +=3D mpc52xx_uart.o=0A=
+obj-$(CONFIG_ETRAX_SERIAL) +=3D cris/=0A=
--- 269_clean/drivers/serial/cris/Makefile	Thu Jan  1 01:00:00 1970=0A=
+++ 269_modified/drivers/serial/cris/Makefile	Tue Nov  2 13:07:26 2004=0A=
@@ -0,0 +1 @@=0A=
+obj-$(CONFIG_ETRAX_ARCH_V10)		:=3D v10/=0A=
--- 269_clean/drivers/serial/cris/v10/Makefile	Thu Jan  1 01:00:00 1970=0A=
+++ 269_modified/drivers/serial/cris/v10/Makefile	Tue Nov  2 12:37:12 =
2004=0A=
@@ -0,0 +1 @@=0A=
+obj-y		:=3D serial.o=0A=
--- 269_clean/drivers/usb/Makefile	Mon Jun 21 12:31:30 2004=0A=
+++ 269_modified/drivers/usb/Makefile	Tue Nov  2 12:38:11 2004=0A=
@@ -67,3 +67,5 @@=0A=
 obj-$(CONFIG_USB_TIGL)		+=3D misc/=0A=
 obj-$(CONFIG_USB_USS720)	+=3D misc/=0A=
 obj-$(CONFIG_USB_PHIDGETSERVO)	+=3D misc/=0A=
+=0A=
+obj-$(CONFIG_ETRAX_USB_HOST)	+=3D host/cris/=0A=
\ No newline at end of file=0A=
--- 269_clean/drivers/usb/host/cris/Makefile	Thu Jan  1 01:00:00 1970=0A=
+++ 269_modified/drivers/usb/host/cris/Makefile	Tue Nov  2 13:07:37 2004=0A=
@@ -0,0 +1 @@=0A=
+obj-$(CONFIG_ETRAX_ARCH_V10)		+=3D v10/=0A=
--- 269_clean/drivers/usb/host/cris/v10/Makefile	Thu Jan  1 01:00:00 1970=0A=
+++ 269_modified/drivers/usb/host/cris/v10/Makefile	Tue Nov  2 12:38:56 =
2004=0A=
@@ -0,0 +1 @@=0A=
+obj-y		:=3D usb-host.o=0A=
\ No newline at end of file=0A=

------=_NextPart_000_01E3_01C4C0E4.ED9814E0--

