Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964936AbWGER51@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964936AbWGER51 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 13:57:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964937AbWGER51
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 13:57:27 -0400
Received: from palinux.external.hp.com ([192.25.206.14]:36779 "EHLO
	palinux.external.hp.com") by vger.kernel.org with ESMTP
	id S964936AbWGER50 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 13:57:26 -0400
Date: Wed, 5 Jul 2006 11:57:25 -0600
From: Matthew Wilcox <matthew@wil.cx>
To: Dave Jones <davej@redhat.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: [PATCH] Limit VIA and SIS AGP choices to x86
Message-ID: <20060705175725.GL1605@parisc-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


As far as I am aware, Alpha, PPC and IA64 don't have VIA or SIS AGP
chipsets available.

Signed-off-by: Matthew Wilcox <matthew@wil.cx>

Index: ./drivers/char/agp/Kconfig
===================================================================
RCS file: /var/cvs/linux-2.6/drivers/char/agp/Kconfig,v
retrieving revision 1.16
diff -u -p -r1.16 Kconfig
--- ./drivers/char/agp/Kconfig	13 Jun 2006 16:25:20 -0000	1.16
+++ ./drivers/char/agp/Kconfig	5 Jul 2006 17:52:48 -0000
@@ -75,8 +75,6 @@ config AGP_INTEL
 	  E7205 and E7505 chipsets and full support for the 810, 815, 830M,
 	  845G, 852GM, 855GM, 865G and I915 integrated graphics chipsets.
 
-
-
 config AGP_NVIDIA
 	tristate "NVIDIA nForce/nForce2 chipset support"
 	depends on AGP && X86_32
@@ -86,7 +84,7 @@ config AGP_NVIDIA
 
 config AGP_SIS
 	tristate "SiS chipset support"
-	depends on AGP
+	depends on AGP && X86
 	help
 	  This option gives you AGP support for the GLX component of
 	  X on Silicon Integrated Systems [SiS] chipsets.
@@ -103,7 +101,7 @@ config AGP_SWORKS
 
 config AGP_VIA
 	tristate "VIA chipset support"
-	depends on AGP
+	depends on AGP && X86
 	help
 	  This option gives you AGP support for the GLX component of
 	  X on VIA MVP3/Apollo Pro chipsets.
