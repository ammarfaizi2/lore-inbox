Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268100AbRH0UCU>; Mon, 27 Aug 2001 16:02:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268071AbRH0UCD>; Mon, 27 Aug 2001 16:02:03 -0400
Received: from mail.mesatop.com ([208.164.122.9]:64785 "EHLO thor.mesatop.com")
	by vger.kernel.org with ESMTP id <S267997AbRH0UBq>;
	Mon, 27 Aug 2001 16:01:46 -0400
Message-Id: <200108272001.f7RK1qe22448@thor.mesatop.com>
Content-Type: text/plain; charset=US-ASCII
From: Steven Cole <elenstev@mesatop.com>
Reply-To: elenstev@mesatop.com
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] 2.4.9-ac2 fix make xconfig problem
Date: Mon, 27 Aug 2001 14:00:46 -0400
X-Mailer: KMail [version 1.2.3]
Cc: <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I found and fixed what was causing make xconfig to fail.
It looks like someone got a little too happy with the "-o"s
when modifying drivers/video/Config.in.

Here is the patch, including my necessary but not sufficient
first patch for this file.

Steven

--- linux/drivers/video/Config.in.ac2	Mon Aug 27 12:18:00 2001
+++ linux/drivers/video/Config.in	Mon Aug 27 13:53:59 2001
@@ -292,10 +292,10 @@
 	      "$CONFIG_FB_P9100" = "m" -o "$CONFIG_FB_ATY128" = "m" -o \
 	      "$CONFIG_FB_RIVA" = "m" -o "$CONFIG_FB_3DFX" = "m" -o \
 	      "$CONFIG_FB_SGIVW" = "m" -o "$CONFIG_FB_CYBER2000" = "m" -o \
-	      "$CONFIG_FB_PMAG_BA" = "m" -o "CONFIG_FB_PMAGB_B" = "m" -o \
+	      "$CONFIG_FB_PMAG_BA" = "m" -o "$CONFIG_FB_PMAGB_B" = "m" -o \
 	      "$CONFIG_FB_MAXINE" = "m" -o "$CONFIG_FB_RADEON" = "m" -o \
 	      "$CONFIG_FB_SA1100" = "m" -o "$CONFIG_FB_SIS" = "m" -o \
-	      "$CONFIG_FB_TX3912" = "m" -o ]; then
+	      "$CONFIG_FB_TX3912" = "m" ]; then
 	    define_tristate CONFIG_FBCON_CFB8 m
 	 fi
       fi
