Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271837AbRH0So4>; Mon, 27 Aug 2001 14:44:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271841AbRH0Soq>; Mon, 27 Aug 2001 14:44:46 -0400
Received: from mail.mesatop.com ([208.164.122.9]:39697 "EHLO thor.mesatop.com")
	by vger.kernel.org with ESMTP id <S271840AbRH0Som>;
	Mon, 27 Aug 2001 14:44:42 -0400
Message-Id: <200108271844.f7RIihe21559@thor.mesatop.com>
Content-Type: text/plain; charset=US-ASCII
From: Steven Cole <elenstev@mesatop.com>
Reply-To: elenstev@mesatop.com
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] 2.4.9-ac2 fix typo in drivers/video/Config.in
Date: Mon, 27 Aug 2001 12:43:34 -0400
X-Mailer: KMail [version 1.2.3]
Cc: <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is a patchlet to fix a typo (missing $).  I found this while trying to fix
this problem observed while trying to make xconfig for 2.4.9-ac2:

Error in startup script: syntax error in expression "($CONFIG_VT == 1) && ($CONFIG_EXPERIMENTAL == 1) && ($CONFIG"
    ("if" test expression)
    while compiling
"if {($CONFIG_VT == 1) && ($CONFIG_EXPERIMENTAL == 1) && ($CONFIG_FB == 1) && ($CONFIG_FBCON_ADVANCED != 1) && ($CONFIG_FB_ACORN != 1 && $CONFIG_FB_ATA..."
    (compiling body of proc "update_define_menu63", line 180)
    invoked from within
"update_define_menu$i"
    (procedure "update_define" line 3)
    invoked from within
"update_define 1 $total_menus 0"
    (file "scripts/kconfig.tk" line 23383)
make: *** [xconfig] Error 1

The following patch doesn't fix that, but it seems to be related.

Steven

--- linux/drivers/video/Config.in.ac2	Mon Aug 27 12:18:00 2001
+++ linux/drivers/video/Config.in	Mon Aug 27 12:23:15 2001
@@ -292,7 +292,7 @@
 	      "$CONFIG_FB_P9100" = "m" -o "$CONFIG_FB_ATY128" = "m" -o \
 	      "$CONFIG_FB_RIVA" = "m" -o "$CONFIG_FB_3DFX" = "m" -o \
 	      "$CONFIG_FB_SGIVW" = "m" -o "$CONFIG_FB_CYBER2000" = "m" -o \
-	      "$CONFIG_FB_PMAG_BA" = "m" -o "CONFIG_FB_PMAGB_B" = "m" -o \
+	      "$CONFIG_FB_PMAG_BA" = "m" -o "$CONFIG_FB_PMAGB_B" = "m" -o \
 	      "$CONFIG_FB_MAXINE" = "m" -o "$CONFIG_FB_RADEON" = "m" -o \
 	      "$CONFIG_FB_SA1100" = "m" -o "$CONFIG_FB_SIS" = "m" -o \
 	      "$CONFIG_FB_TX3912" = "m" -o ]; then
