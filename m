Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271135AbRICDoy>; Sun, 2 Sep 2001 23:44:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271165AbRICDoo>; Sun, 2 Sep 2001 23:44:44 -0400
Received: from fencepost.gnu.org ([199.232.76.164]:14093 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP
	id <S271135AbRICDo0>; Sun, 2 Sep 2001 23:44:26 -0400
Date: Sun, 2 Sep 2001 23:45:48 -0400 (EDT)
From: Pavel Roskin <proski@gnu.org>
X-X-Sender: <proski@portland.hansa.lan>
To: <linux-kernel@vger.kernel.org>
Subject: [PATCH] Add Matrox G450 to description of CONFIG_DRM_MGA
Message-ID: <Pine.LNX.4.33.0109022338050.26017-100000@portland.hansa.lan>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

This trivial patch adds G450 to the list of Matrox cards in the DRM
configurations menus and in Configure.help.  It also changes "g" to "G",
for consistency with other documentation.

The patch is against 2.4.9-ac6

------------------------------
--- linux.orig/Documentation/Configure.help
+++ linux/Documentation/Configure.help
@@ -16348,7 +16348,7 @@
   selected, the module will be called i810.o.  AGP support is required
   for this driver to work.

-Matrox g200/g400
+Matrox G200/G400/G450
 CONFIG_DRM_MGA
   Choose this option if you have a Matrox g200 or g400 graphics card.
   If M is selected, the module will be called mga.o.  AGP support is
@@ -16384,7 +16384,7 @@
   selected, the module will be called i810.o.  AGP support is required
   for this driver to work.

-Matrox g200/g400
+Matrox G200/G400/G450
 CONFIG_DRM40_MGA
   Choose this option if you have a Matrox g200 or g400 graphics card.
   If M is selected, the module will be called mga.o.  AGP support is
--- linux.orig/drivers/char/drm-4.0/Config.in
+++ linux/drivers/char/drm-4.0/Config.in
@@ -10,4 +10,4 @@
 dep_tristate '  ATI Rage 128' CONFIG_DRM40_R128 $CONFIG_AGP
 dep_tristate '  ATI Radeon' CONFIG_DRM40_RADEON $CONFIG_AGP
 dep_tristate '  Intel I810' CONFIG_DRM40_I810 $CONFIG_AGP
-dep_tristate '  Matrox g200/g400' CONFIG_DRM40_MGA $CONFIG_AGP
+dep_tristate '  Matrox G200/G400/G450' CONFIG_DRM40_MGA $CONFIG_AGP
--- linux.orig/drivers/char/drm/Config.in
+++ linux/drivers/char/drm/Config.in
@@ -10,4 +10,4 @@
 tristate '  ATI Rage 128' CONFIG_DRM_R128
 dep_tristate '  ATI Radeon' CONFIG_DRM_RADEON $CONFIG_AGP
 dep_tristate '  Intel I810' CONFIG_DRM_I810 $CONFIG_AGP
-dep_tristate '  Matrox g200/g400' CONFIG_DRM_MGA $CONFIG_AGP
+dep_tristate '  Matrox G200/G400/G450' CONFIG_DRM_MGA $CONFIG_AGP
------------------------------

-- 
Regards,
Pavel Roskin

