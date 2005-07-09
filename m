Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263056AbVGIAvR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263056AbVGIAvR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 20:51:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263039AbVGIAsy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 20:48:54 -0400
Received: from smtp3.brturbo.com.br ([200.199.201.164]:44963 "EHLO
	smtp3.brturbo.com.br") by vger.kernel.org with ESMTP
	id S263047AbVGIAs1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 20:48:27 -0400
Message-ID: <42CF1ED9.8080603@brturbo.com.br>
Date: Fri, 08 Jul 2005 21:48:25 -0300
From: Mauro Carvalho Chehab <mchehab@brturbo.com.br>
User-Agent: Mozilla Thunderbird 1.0.2-3mdk (X11/20050322)
X-Accept-Language: pt-br, pt, es, en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Linux and Kernel Video <video4linux-list@redhat.com>,
       LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/14 2.6.13-rc2-mm1] V4L drivers/media/video/Kconfig
X-Enigmail-Version: 0.91.0.0
Content-Type: multipart/mixed;
 boundary="------------010603070303020708070800"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010603070303020708070800
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit


--------------010603070303020708070800
Content-Type: text/x-patch;
 name="v4l_kconfig.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="v4l_kconfig.diff"

- Removed obsolete option. Current code needs multi tuner.

Signed-off-by: Mauro Carvalho Chehab <mchehab@brturbo.com.br>

 drivers/media/video/Kconfig |   13 -------------
 1 files changed, 13 deletions(-)

--- linux-2.6.13-rc2-mm1/drivers/media/video/Kconfig.orig	2005-07-07 22:08:59.000000000 -0300
+++ linux/drivers/media/video/Kconfig	2005-07-07 22:14:37.000000000 -0300
@@ -7,19 +7,6 @@ menu "Video For Linux"
 
 comment "Video Adapters"
 
-config TUNER_MULTI_I2C
-	bool "Enable support for multiple I2C devices on Video Adapters (EXPERIMENTAL)"
-	depends on VIDEO_DEV && EXPERIMENTAL
-	---help---
-	  Some video adapters have more than one tuner inside. This patch
-	  enables support for using more than one tuner. This is required
-	  for some cards to allow tunning  both video and radio.
-	  It also improves I2C autodetection for these cards.
-
-	  Only few tuners currently is supporting this. More to come.
-
-	  It is safe to say 'Y' here even if your card has only one I2C tuner.
-
 config VIDEO_BT848
 	tristate "BT848 Video For Linux"
 	depends on VIDEO_DEV && PCI && I2C

--------------010603070303020708070800--
