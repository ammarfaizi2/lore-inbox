Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266189AbUFPHGM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266189AbUFPHGM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jun 2004 03:06:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266199AbUFPHGM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jun 2004 03:06:12 -0400
Received: from honk1.physik.uni-konstanz.de ([134.34.140.224]:21438 "EHLO
	honk1.physik.uni-konstanz.de") by vger.kernel.org with ESMTP
	id S266189AbUFPHGJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jun 2004 03:06:09 -0400
Date: Wed, 16 Jun 2004 09:03:27 +0200
From: Guido Guenther <agx@sigxcpu.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: [Patch]: Fix rivafb's NV_ARCH_ 
Message-ID: <20040616070326.GE28487@bogon.ms20.nix>
References: <20040601041604.GA2344@bogon.ms20.nix> <1086064086.1978.0.camel@gaston> <20040601135335.GA5406@bogon.ms20.nix>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040601135335.GA5406@bogon.ms20.nix>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
here's another piece of rivafb fixing that helps the driver on ppc
pbooks again a bit further. It corrects several wrong NV_ARCH_20
settings which are actually NV_ARCH_10 as determined by the PCIId.
Patch is against 2.6.7-rc3.
Cheers,
 -- Guido

signed-off-by: Guido Guenther <agx@sigxcpu.org>

--- ../linux-2.6.7-rc2.orig/drivers/video/riva/fbdev.c	2004-06-04 17:40:30.000000000 +0200
+++ drivers/video/riva/fbdev.c	2004-06-16 08:50:41.122924416 +0200
@@ -173,18 +174,18 @@
 	{ "GeForce2-GTS", NV_ARCH_10 },
 	{ "GeForce2-ULTRA", NV_ARCH_10 },
 	{ "Quadro2-PRO", NV_ARCH_10 },
-	{ "GeForce4-MX-460", NV_ARCH_20 },
-	{ "GeForce4-MX-440", NV_ARCH_20 },
-	{ "GeForce4-MX-420", NV_ARCH_20 },
-	{ "GeForce4-440-GO", NV_ARCH_20 },
-	{ "GeForce4-420-GO", NV_ARCH_20 },
-	{ "GeForce4-420-GO-M32", NV_ARCH_20 },
-	{ "Quadro4-500-XGL", NV_ARCH_20 },
-	{ "GeForce4-440-GO-M64", NV_ARCH_20 },
-	{ "Quadro4-200", NV_ARCH_20 },
-	{ "Quadro4-550-XGL", NV_ARCH_20 },
-	{ "Quadro4-500-GOGL", NV_ARCH_20 },
-	{ "GeForce2", NV_ARCH_20 },
+	{ "GeForce4-MX-460", NV_ARCH_10 },
+	{ "GeForce4-MX-440", NV_ARCH_10 },
+	{ "GeForce4-MX-420", NV_ARCH_10 },
+	{ "GeForce4-440-GO", NV_ARCH_10 },
+	{ "GeForce4-420-GO", NV_ARCH_10 },
+	{ "GeForce4-420-GO-M32", NV_ARCH_10 },
+	{ "Quadro4-500-XGL", NV_ARCH_10 },
+	{ "GeForce4-440-GO-M64", NV_ARCH_10 },
+	{ "Quadro4-200", NV_ARCH_10 },
+	{ "Quadro4-550-XGL", NV_ARCH_10 },
+	{ "Quadro4-500-GOGL", NV_ARCH_10 },
+	{ "GeForce2", NV_ARCH_10 },
 	{ "GeForce3", NV_ARCH_20 }, 
 	{ "GeForce3 Ti 200", NV_ARCH_20 },
 	{ "GeForce3 Ti 500", NV_ARCH_20 },
