Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263304AbTJZQwP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Oct 2003 11:52:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263307AbTJZQwP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Oct 2003 11:52:15 -0500
Received: from m77.net81-65-140.noos.fr ([81.65.140.77]:23721 "EHLO
	deep-space-9.dsnet") by vger.kernel.org with ESMTP id S263304AbTJZQwK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Oct 2003 11:52:10 -0500
Date: Sun, 26 Oct 2003 17:51:33 +0100
From: Stelian Pop <stelian@popies.net>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH 2.6.0-test9] sonypi driver update
Message-ID: <20031026165133.GU4013@deep-space-9.dsnet>
Reply-To: Stelian Pop <stelian@popies.net>
Mail-Followup-To: Stelian Pop <stelian@popies.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This small patch corrects the Zoom and Thumbphrase button events.

Linus, please apply.

Thanks,

Stelian.

===== drivers/char/sonypi.h 1.18 vs edited =====
--- 1.18/drivers/char/sonypi.h	Mon Sep  1 12:37:24 2003
+++ edited/drivers/char/sonypi.h	Fri Oct 24 21:13:49 2003
@@ -37,7 +37,7 @@
 #ifdef __KERNEL__
 
 #define SONYPI_DRIVER_MAJORVERSION	 1
-#define SONYPI_DRIVER_MINORVERSION	20
+#define SONYPI_DRIVER_MINORVERSION	21
 
 #define SONYPI_DEVICE_MODEL_TYPE1	1
 #define SONYPI_DEVICE_MODEL_TYPE2	2
@@ -329,8 +329,8 @@
 	{ SONYPI_DEVICE_MODEL_TYPE2, 0x08, SONYPI_PKEY_MASK, sonypi_pkeyev },
 	{ SONYPI_DEVICE_MODEL_TYPE2, 0x11, SONYPI_BACK_MASK, sonypi_backev },
 	{ SONYPI_DEVICE_MODEL_TYPE2, 0x08, SONYPI_HELP_MASK, sonypi_helpev },
-	{ SONYPI_DEVICE_MODEL_TYPE2, 0x08, SONYPI_ZOOM_MASK, sonypi_zoomev },
-	{ SONYPI_DEVICE_MODEL_TYPE2, 0x08, SONYPI_THUMBPHRASE_MASK, sonypi_thumbphraseev },
+	{ SONYPI_DEVICE_MODEL_TYPE2, 0x21, SONYPI_ZOOM_MASK, sonypi_zoomev },
+	{ SONYPI_DEVICE_MODEL_TYPE2, 0x20, SONYPI_THUMBPHRASE_MASK, sonypi_thumbphraseev },
 	{ SONYPI_DEVICE_MODEL_TYPE2, 0x31, SONYPI_MEMORYSTICK_MASK, sonypi_memorystickev },
 	{ SONYPI_DEVICE_MODEL_TYPE2, 0x41, SONYPI_BATTERY_MASK, sonypi_batteryev },
 
-- 
Stelian Pop <stelian@popies.net>
