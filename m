Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267992AbRHJNcz>; Fri, 10 Aug 2001 09:32:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268022AbRHJNcp>; Fri, 10 Aug 2001 09:32:45 -0400
Received: from green.mif.pg.gda.pl ([153.19.42.8]:12548 "EHLO
	green.mif.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S267992AbRHJNcZ>; Fri, 10 Aug 2001 09:32:25 -0400
From: Andrzej Krzysztofowicz <ankry@green.mif.pg.gda.pl>
Message-Id: <200108101333.PAA01292@green.mif.pg.gda.pl>
Subject: Re: [PATCH] double DRM - fixes
To: alan@lxorguk.ukuu.org.uk (Alan Cox),
        linux-kernel@vger.kernel.org (kernel list), faith@valinux.com,
        elenstev@mesatop.com
Date: Fri, 10 Aug 2001 15:33:01 +0200 (CEST)
X-Mailer: ELM [version 2.5 PL0pre8]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
  This is update of Configure.help file related to the -ac10 DRM version
split and my suggested config fixes (Renamed config variables). Just
duplicated appropriate entries...

BTW: Alan, do you think it would be worth to be able to compile both versions
     together (in the modular case) ?

Andrzej

************************************************************************
diff -uNr linux-2.4.7-ac10/Documentation/Configure.help linux/Documentation/Configure.help
--- linux-2.4.7-ac10/Documentation/Configure.help	Wed Aug  8 20:13:56 2001
+++ linux/Documentation/Configure.help	Fri Aug 10 09:29:55 2001
@@ -16158,6 +16158,12 @@
   details.  You should also select and configure AGP
   (/dev/agpgart) support.
 
+Build drivers for new (XFree 4.1) DRM
+CONFIG_DRM_NEW
+  If you set this option, the new DRM version needed by XFree86 4.1
+  will be used.  Otherwise, the old DRM version will be used,
+  appropriate for XFree86 4.0.
+
 3dfx Banshee/Voodoo3+
 CONFIG_DRM_TDFX
   Choose this option if you have a 3dfx Banshee or Voodoo3 (or later),
@@ -16190,6 +16196,42 @@
 
 Matrox g200/g400
 CONFIG_DRM_MGA
+  Choose this option if you have a Matrox g200 or g400 graphics card.  If M
+  is selected, the module will be called mga.o.  AGP support is required
+  for this driver to work.
+
+3dfx Banshee/Voodoo3+
+CONFIG_DRM40_TDFX
+  Choose this option if you have a 3dfx Banshee or Voodoo3 (or later),
+  graphics card.  If M is selected, the module will be called tdfx.o.
+
+3dlabs GMX 2000
+CONFIG_DRM40_GAMMA
+  Choose this option if you have a 3dlabs GMX 2000 graphics card.
+  If M is selected, the module will be called gamma.o.
+
+ATI Rage 128
+CONFIG_DRM40_R128
+  Choose this option if you have an ATI Rage 128 graphics card.  If M
+  is selected, the module will be called r128.o.  AGP support for
+  this card is strongly suggested (unless you have a PCI version).
+
+ATI Radeon
+CONFIG_DRM40_RADEON
+  Choose this option if you have an ATI Radeon graphics card.  There
+  are both PCI and AGP versions.  You don't need to choose this to
+  run the Radeon in plain VGA mode.  There is a product page at
+  <http://www.ati.com/na/pages/products/pc/radeon32/index.html>.
+  If M is selected, the module will be called radeon.o.
+
+Intel I810
+CONFIG_DRM40_I810
+  Choose this option if you have an Intel I810 graphics card.  If M is
+  selected, the module will be called i810.o.  AGP support is required
+  for this driver to work.
+
+Matrox g200/g400
+CONFIG_DRM40_MGA
   Choose this option if you have a Matrox g200 or g400 graphics card.  If M
   is selected, the module will be called mga.o.  AGP support is required
   for this driver to work.


-- 
=======================================================================
  Andrzej M. Krzysztofowicz               ankry@mif.pg.gda.pl
  phone (48)(58) 347 14 61
Faculty of Applied Phys. & Math.,   Technical University of Gdansk
