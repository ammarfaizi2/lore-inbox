Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261209AbVGQPJ0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261209AbVGQPJ0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Jul 2005 11:09:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261312AbVGQPJ0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Jul 2005 11:09:26 -0400
Received: from mail-in-06.arcor-online.net ([151.189.21.46]:35742 "EHLO
	mail-in-01.arcor-online.net") by vger.kernel.org with ESMTP
	id S261209AbVGQPHZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Jul 2005 11:07:25 -0400
Date: Sun, 17 Jul 2005 17:07:48 +0200 (CEST)
From: Bodo Eggert <7eggert@gmx.de>
To: 7eggert@gmx.de, akpm@osdl.org, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: [PATCH] use select in sound/isa/Kconfig
Message-ID: <Pine.LNX.4.58.0507171702030.12446@be1.lrz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-be10.7eggert.dyndns.org-MailScanner-Information: See www.mailscanner.info for information
X-be10.7eggert.dyndns.org-MailScanner: Found to be clean
X-be10.7eggert.dyndns.org-MailScanner-From: 7eggert@web.de
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In sound/isa/Kconfig, select ISAPNP and depend on ISAPNP are intermixed, 
resulting in funny behaviour. (Soundcarts get selectable if other 
soundcards are selected).

This patch changes the "depend on ISAPNP"s to select.

 sound/isa/Kconfig |   15 ++++++++++-----
 1 files changed, 10 insertions(+), 5 deletions(-)

Signed-Off-By: Bodo Eggert <7eggert@gmx.de>

--- a/sound/isa/Kconfig	2005-07-17 08:10:20.000000000 +0200
+++ b/sound/isa/Kconfig	2005-07-17 16:57:53.000000000 +0200
@@ -15,7 +15,8 @@ config SND_CS4231_LIB
 
 config SND_AD1816A
 	tristate "Analog Devices SoundPort AD1816A"
-	depends on SND && ISAPNP
+	depends on SND
+	select ISAPNP
 	select SND_OPL3_LIB
 	select SND_MPU401_UART
 	select SND_PCM
@@ -80,7 +81,8 @@ config SND_CS4236
 
 config SND_ES968
 	tristate "Generic ESS ES968 driver"
-	depends on SND && ISAPNP
+	depends on SND
+	select ISAPNP
 	select SND_MPU401_UART
 	select SND_PCM
 	help
@@ -291,7 +293,8 @@ config SND_WAVEFRONT
 
 config SND_ALS100
 	tristate "Avance Logic ALS100/ALS120"
-	depends on SND && ISAPNP
+	depends on SND
+	select ISAPNP
 	select SND_OPL3_LIB
 	select SND_MPU401_UART
 	select SND_PCM
@@ -304,7 +307,8 @@ config SND_ALS100
 
 config SND_AZT2320
 	tristate "Aztech Systems AZT2320"
-	depends on SND && ISAPNP
+	depends on SND
+	select ISAPNP
 	select SND_OPL3_LIB
 	select SND_MPU401_UART
 	select SND_CS4231_LIB
@@ -328,7 +332,8 @@ config SND_CMI8330
 
 config SND_DT019X
 	tristate "Diamond Technologies DT-019X, Avance Logic ALS-007"
-	depends on SND && ISAPNP
+	depends on SND
+	select ISAPNP
 	select SND_OPL3_LIB
 	select SND_MPU401_UART
 	select SND_PCM

-- 
Funny quotes:
3. On the other hand, you have different fingers.
