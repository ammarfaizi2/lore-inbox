Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261224AbTINSDm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Sep 2003 14:03:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261227AbTINSDl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Sep 2003 14:03:41 -0400
Received: from ns.suse.de ([195.135.220.2]:54428 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261224AbTINSDk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Sep 2003 14:03:40 -0400
Date: Sun, 14 Sep 2003 20:03:38 +0200
From: Olaf Hering <olh@suse.de>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.4.23 select lowlevel drivers for imsttfb
Message-ID: <20030914180338.GA12580@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


if CONFIG_FB_IMSTT is the only active driver, no lowlevel driver is
compiled. This leads to a dead console.

this patch activates all modes.


diff -purNX /home/olaf/kernel/kernel_exclude.txt linux-2.4.23-pre4/drivers/video/Config.in linux-2.4.23-pre4-7200/drivers/video/Config.in
--- linux-2.4.23-pre4/drivers/video/Config.in	2003-09-14 14:32:02.000000000 +0200
+++ linux-2.4.23-pre4-7200/drivers/video/Config.in	2003-09-14 14:20:35.000000000 +0200
@@ -306,7 +306,7 @@ if [ "$CONFIG_FB" = "y" ]; then
 	   "$CONFIG_FB_MAXINE" = "y" -o "$CONFIG_FB_TX3912" = "y" -o \
 	   "$CONFIG_FB_SIS" = "y" -o "$CONFIG_FB_NEOMAGIC" = "y" -o \
 	   "$CONFIG_FB_STI" = "y" -o "$CONFIG_FB_HP300" = "y" -o \
-	   "$CONFIG_FB_INTEL" = "y" ]; then
+	   "$CONFIG_FB_INTEL" = "y" -o "$CONFIG_FB_IMSTT" = "y" ]; then
 	 define_tristate CONFIG_FBCON_CFB8 y
       else
 	 if [ "$CONFIG_FB_ACORN" = "m" -o "$CONFIG_FB_ATARI" = "m" -o \
@@ -346,7 +347,8 @@ if [ "$CONFIG_FB" = "y" ]; then
 	   "$CONFIG_FB_CYBER2000" = "y" -o "$CONFIG_FB_3DFX" = "y"  -o \
 	   "$CONFIG_FB_SIS" = "y" -o "$CONFIG_FB_SA1100" = "y" -o \
 	   "$CONFIG_FB_PVR2" = "y" -o "$CONFIG_FB_VOODOO1" = "y" -o \
-	   "$CONFIG_FB_NEOMAGIC" = "y" -o "$CONFIG_FB_INTEL" = "y" ]; then
+	   "$CONFIG_FB_NEOMAGIC" = "y" -o "$CONFIG_FB_INTEL" = "y" -o \
+	   "$CONFIG_FB_IMSTT" = "y"  ]; then
 	 define_tristate CONFIG_FBCON_CFB16 y
       else
 	 if [ "$CONFIG_FB_ATARI" = "m" -o "$CONFIG_FB_ATY" = "m" -o \
@@ -372,7 +375,8 @@ if [ "$CONFIG_FB" = "y" ]; then
 	   "$CONFIG_FB_MATROX" = "y" -o "$CONFIG_FB_PM2" = "y" -o \
            "$CONFIG_FB_ATY128" = "y" -o "$CONFIG_FB_RADEON" = "y" -o \
 	   "$CONFIG_FB_CYBER2000" = "y" -o "$CONFIG_FB_PVR2" = "y" -o \
-	   "$CONFIG_FB_VOODOO1" = "y" -o "$CONFIG_FB_NEOMAGIC" = "y" ]; then
+	   "$CONFIG_FB_VOODOO1" = "y" -o "$CONFIG_FB_NEOMAGIC" = "y" -o \
+	   "$CONFIG_FB_IMSTT" = "y"  ]; then
 	 define_tristate CONFIG_FBCON_CFB24 y
       else
 	 if [ "$CONFIG_FB_ATY" = "m" -o "$CONFIG_FB_VIRTUAL" = "m" -o \
@@ -395,7 +400,8 @@ if [ "$CONFIG_FB" = "y" ]; then
 	   "$CONFIG_FB_RADEON" = "y" -o "$CONFIG_FB_PVR2" = "y" -o \
 	   "$CONFIG_FB_3DFX" = "y" -o "$CONFIG_FB_SIS" = "y" -o \
 	   "$CONFIG_FB_VOODOO1" = "y" -o "$CONFIG_FB_CYBER2000" = "y" -o \
-	   "$CONFIG_FB_STI" = "y"  -o "$CONFIG_FB_INTEL" = "y" ]; then
+	   "$CONFIG_FB_STI" = "y"  -o "$CONFIG_FB_INTEL" = "y" -o \
+	   "$CONFIG_FB_IMSTT" = "y" ]; then
 	 define_tristate CONFIG_FBCON_CFB32 y
       else
 	 if [ "$CONFIG_FB_ATARI" = "m" -o "$CONFIG_FB_ATY" = "m" -o \
-- 
USB is for mice, FireWire is for men!

sUse lINUX ag, nÜRNBERG
