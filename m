Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283560AbRLDWRD>; Tue, 4 Dec 2001 17:17:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283558AbRLDWQ4>; Tue, 4 Dec 2001 17:16:56 -0500
Received: from aboukir-101-1-1-maz.adsl.nerim.net ([62.4.18.26]:49288 "EHLO
	shin-kicker.wild-wind.fr.eu.org") by vger.kernel.org with ESMTP
	id <S283559AbRLDWQh>; Tue, 4 Dec 2001 17:16:37 -0500
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Permedia2 fb on PPC
Organization: Metropolis -- Nowhere
X-Attribution: maz
X-Baby-1: =?iso-8859-1?q?Lo=EBn?= 12 juin 1996 13:10
Reply-to: mzyngier@freesurf.fr
From: Marc ZYNGIER <mzyngier@freesurf.fr>
Date: 04 Dec 2001 23:16:13 +0100
Message-ID: <wrpk7w2tyvm.fsf@hina.wild-wind.fr.eu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

The following patchlet allows the Permedia2 framebuffer to work
properly on power-pc (instead of crashing the machine...).

This has been tested with a PCI Formac Promedia3D (aka formacGA8) on a
PowerMac 7500 (with a G3 card, if that matters...).

Patch is against 2.4.16, but should apply to any recent 2.[45] kernel.

        M.

--- drivers/video/pm2fb.c.orig	Fri Sep 14 22:44:49 2001
+++ drivers/video/pm2fb.c	Tue Dec  4 20:44:18 2001
@@ -48,7 +48,7 @@
 #error	"The endianness of the target host has not been defined."
 #endif
 
-#if defined(__BIG_ENDIAN) && !defined(__sparc__)
+#if defined(__BIG_ENDIAN) && !defined(__sparc__) && (!defined(CONFIG_PPC) || defined(CONFIG_FB_PM2_CVPPC))
 #define PM2FB_BE_APERTURE
 #endif
 

-- 
Places change, faces change. Life is so very strange.
