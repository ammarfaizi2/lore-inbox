Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317664AbSHCSQV>; Sat, 3 Aug 2002 14:16:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317649AbSHCSOL>; Sat, 3 Aug 2002 14:14:11 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:11536 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S317653AbSHCSM4>; Sat, 3 Aug 2002 14:12:56 -0400
To: Petr Vandrovec <vandrove@vc.cvut.cz>,
       James Simmons <jsimmons@transvirtual.com>
CC: <linux-kernel@vger.kernel.org>
From: Russell King <rmk@arm.linux.org.uk>
Subject: [PATCH] 5: 2.5.29-matrox
Message-Id: <E17b3Ro-0006wN-00@flint.arm.linux.org.uk>
Date: Sat, 03 Aug 2002 19:16:16 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch has been verified to apply cleanly to 2.5.30

Obvious bug descovered by Dirk Uffmann, patch ARM Linux patch system, id 1129/1.

Dirk says:

  Patch already discussed with Petr Vandrovec. Gave his o.k. to it.

 drivers/video/matrox/matroxfb_misc.c |    2 +-
 1 files changed, 1 insertion, 1 deletion

diff -urN orig/drivers/video/matrox/matroxfb_misc.c linux/drivers/video/matrox/matroxfb_misc.c
--- orig/drivers/video/matrox/matroxfb_misc.c	Tue Mar  5 20:01:03 2002
+++ linux/drivers/video/matrox/matroxfb_misc.c	Sat Apr 27 21:29:57 2002
@@ -872,7 +872,7 @@
 	mult = bd->pins[4]?8000:6000;
 	
 	MINFO->limits.pixel.vcomax	= (bd->pins[ 38] == 0xFF) ? 600000			: bd->pins[ 38] * mult;
-	MINFO->limits.system.vcomax	= (bd->pins[ 36] == 0xFF) ? MINFO->limits.pixel.vcomax	: bd->pins[ 39] * mult;
+	MINFO->limits.system.vcomax	= (bd->pins[ 36] == 0xFF) ? MINFO->limits.pixel.vcomax	: bd->pins[ 36] * mult;
 	MINFO->limits.video.vcomax	= (bd->pins[ 37] == 0xFF) ? MINFO->limits.system.vcomax	: bd->pins[ 37] * mult;
 	MINFO->limits.pixel.vcomin	= (bd->pins[123] == 0xFF) ? 256000			: bd->pins[123] * mult;
 	MINFO->limits.system.vcomin	= (bd->pins[121] == 0xFF) ? MINFO->limits.pixel.vcomin	: bd->pins[121] * mult;

