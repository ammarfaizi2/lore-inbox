Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932080AbWDOWXs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932080AbWDOWXs (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Apr 2006 18:23:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932508AbWDOWXs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Apr 2006 18:23:48 -0400
Received: from dspnet.fr.eu.org ([213.186.44.138]:50961 "EHLO dspnet.fr.eu.org")
	by vger.kernel.org with ESMTP id S932080AbWDOWXs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Apr 2006 18:23:48 -0400
Date: Sun, 16 Apr 2006 00:23:40 +0200
From: Jean-Luc =?iso-8859-1?Q?L=E9ger?= 
	<jean-luc.leger@dspnet.fr.eu.org>
To: linux-kernel@vger.kernel.org
Subject: [2.6 patch] cleanup default value of USB_ISP116X_HCD, USB_SL811_HCD and USB_SL811_CS
Message-ID: <20060415222340.GD47644@dspnet.fr.eu.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Default values for boolean and tristate options can only be 'y', 'm' or 'n'.
This patch removes wrong default for USB_ISP116X_HCD, USB_SL811_HCD and USB_SL811_CS.

Signed-off-by: Jean-Luc Léger <jean-luc.leger@dspnet.fr.eu.org>

Index: linux-2.6.17-rc1/drivers/usb/host/Kconfig
===================================================================
--- linux-2.6.17-rc1/drivers/usb/host/Kconfig.old       2006-04-15 22:18:51.000000000 +0200
+++ linux-2.6.17-rc1/drivers/usb/host/Kconfig   2006-04-15 22:20:00.000000000 +0200
@@ -52,7 +52,6 @@
 config USB_ISP116X_HCD
 	tristate "ISP116X HCD support"
 	depends on USB
-	default N
 	---help---
 	  The ISP1160 and ISP1161 chips are USB host controllers. Enable this
 	  option if your board has this chip. If unsure, say N.
@@ -127,7 +126,6 @@
 config USB_SL811_HCD
 	tristate "SL811HS HCD support"
 	depends on USB
-	default N
 	help
 	  The SL811HS is a single-port USB controller that supports either
 	  host side or peripheral side roles.  Enable this option if your
@@ -140,7 +138,6 @@
 config USB_SL811_CS
 	tristate "CF/PCMCIA support for SL811HS HCD"
 	depends on USB_SL811_HCD && PCMCIA
-	default N
 	help
 	  Wraps a PCMCIA driver around the SL811HS HCD, supporting the RATOC
 	  REX-CFU1U CF card (often used with PDAs).  If unsure, say N.

