Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268856AbRIDUEp>; Tue, 4 Sep 2001 16:04:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268896AbRIDUEc>; Tue, 4 Sep 2001 16:04:32 -0400
Received: from fencepost.gnu.org ([199.232.76.164]:22532 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP
	id <S268856AbRIDUEY>; Tue, 4 Sep 2001 16:04:24 -0400
Date: Tue, 4 Sep 2001 16:04:43 -0400 (EDT)
From: Pavel Roskin <proski@gnu.org>
X-X-Sender: <proski@portland.hansa.lan>
To: <linux-kernel@vger.kernel.org>
Subject: [PATCH] G450 help text again
Message-ID: <Pine.LNX.4.33.0109041558470.8901-100000@portland.hansa.lan>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

Andrzej M. Krzysztofowicz has noticed that my patch applied to 2.4.9-ac7
in incomplete.  There are still places where G450 was missing and G400 was
written as g400.

Sorry that I couldn't get this thivial thing right the first time.
Here's the patch against 2.4.9-ac7.

---------------------------------------------
--- linux.orig/Documentation/Configure.help
+++ linux/Documentation/Configure.help
@@ -16350,9 +16350,9 @@

 Matrox G200/G400/G450
 CONFIG_DRM_MGA
-  Choose this option if you have a Matrox g200 or g400 graphics card.
-  If M is selected, the module will be called mga.o.  AGP support is
-  required for this driver to work.
+  Choose this option if you have a Matrox G200, G400 or G450 graphics
+  card.  If M is selected, the module will be called mga.o.  AGP
+  support is required for this driver to work.

 3dfx Banshee/Voodoo3+
 CONFIG_DRM40_TDFX
@@ -16386,9 +16386,9 @@

 Matrox G200/G400/G450
 CONFIG_DRM40_MGA
-  Choose this option if you have a Matrox g200 or g400 graphics card.
-  If M is selected, the module will be called mga.o.  AGP support is
-  required for this driver to work.
+  Choose this option if you have a Matrox G200, G400 or G450 graphics
+  card.  If M is selected, the module will be called mga.o.  AGP
+  support is required for this driver to work.

 Creator/Creator3D/Elite3D
 CONFIG_DRM_FFB
--- linux.orig/drivers/char/drm-4.0/Config.in
+++ linux/drivers/char/drm-4.0/Config.in
@@ -10,4 +10,4 @@
 dep_tristate '  ATI Rage 128' CONFIG_DRM40_R128 $CONFIG_AGP
 dep_tristate '  ATI Radeon' CONFIG_DRM40_RADEON $CONFIG_AGP
 dep_tristate '  Intel I810' CONFIG_DRM40_I810 $CONFIG_AGP
-dep_tristate '  Matrox G200/G400' CONFIG_DRM40_MGA $CONFIG_AGP
+dep_tristate '  Matrox G200/G400/G450' CONFIG_DRM40_MGA $CONFIG_AGP
---------------------------------------------

By the way, I confirm that G450 works with CONFIG_DRM40_MGA and
XFree86-4.0.3 on VIA Technologies, Inc. VT8363/8365 [KT133/KM133 AGP]

-- 
Regards,
Pavel Roskin

