Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291475AbSBABBS>; Thu, 31 Jan 2002 20:01:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291477AbSBABBH>; Thu, 31 Jan 2002 20:01:07 -0500
Received: from mbr.sphere.ne.jp ([203.138.71.91]:5798 "EHLO mbr.sphere.ne.jp")
	by vger.kernel.org with ESMTP id <S291475AbSBABAt>;
	Thu, 31 Jan 2002 20:00:49 -0500
Date: Fri, 1 Feb 2002 10:00:31 +0900
From: Bruce Harada <harada@mbr.sphere.ne.jp>
To: Jeff Garzik <garzik@havoc.gtf.org>
Cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: [PATCH] PIIX4->ICH user message changes
Message-Id: <20020201100031.09c240e9.harada@mbr.sphere.ne.jp>
In-Reply-To: <20020131141025.E669@havoc.gtf.org>
In-Reply-To: <20020131224122.59d1de9e.bruce@ask.ne.jp>
	<E16WIFn-0002Iy-00@the-village.bc.nu>
	<20020201022958.7b58493f.harada@mbr.sphere.ne.jp>
	<20020131141025.E669@havoc.gtf.org>
X-Mailer: Sylpheed version 0.7.0 (GTK+ 1.2.6; i686-pc-linux-gnu)
X-Face: $qrUU,Lz=B[A}i%m2Rg^Ik;~V@]$Ay)$S`wUf3:^aZ1UdLf,_;1y7_xbEh=Yv*wB0=Fv]a1hj14_qQsl[f1KX]q4IdhwmSIeP6>Ap@[e$c$G;;ObLI7?Y<H5";4<{GAPoak2U)!da]-ZJb}!.#>Xsq*)M'3Jp<M,l~'4F{qWpM$%"%p'
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


And lastly, here's the user message changes:

diff -urN -X dontdiff linux-2.4.18-pre7/drivers/ide/piix.c linux-2.4.18-pre7-bjh/drivers/ide/piix.c
--- linux-2.4.18-pre7/drivers/ide/piix.c	Fri Oct 26 05:53:47 2001
+++ linux-2.4.18-pre7-bjh/drivers/ide/piix.c	Fri Feb  1 00:13:10 2002
@@ -89,17 +89,24 @@
 	u8  reg44 = 0, reg48 = 0, reg4a = 0, reg4b = 0, reg54 = 0, reg55 = 0;
 
 	switch(bmide_dev->device) {
+	        case PCI_DEVICE_ID_INTEL_82801CA_10:
+	        case PCI_DEVICE_ID_INTEL_82801CA_11:
+			p += sprintf(p, "\n                                Intel ICH3 Ultra 100 Chipset.\n");
+			break;
 		case PCI_DEVICE_ID_INTEL_82801BA_8:
 		case PCI_DEVICE_ID_INTEL_82801BA_9:
-	        case PCI_DEVICE_ID_INTEL_82801CA_10:
-			p += sprintf(p, "\n                                Intel PIIX4 Ultra 100 Chipset.\n");
+			p += sprintf(p, "\n                                Intel ICH2 Ultra 100 Chipset.\n");
 			break;
-		case PCI_DEVICE_ID_INTEL_82372FB_1:
 		case PCI_DEVICE_ID_INTEL_82801AA_1:
+			p += sprintf(p, "\n                                Intel ICH Ultra 66 Chipset.\n");
+			break;
+		case PCI_DEVICE_ID_INTEL_82372FB_1:
 			p += sprintf(p, "\n                                Intel PIIX4 Ultra 66 Chipset.\n");
 			break;
-		case PCI_DEVICE_ID_INTEL_82451NX:
 		case PCI_DEVICE_ID_INTEL_82801AB_1:
+			p += sprintf(p, "\n                                Intel ICH0 Ultra 33 Chipset.\n");
+			break;
+		case PCI_DEVICE_ID_INTEL_82451NX:
 		case PCI_DEVICE_ID_INTEL_82443MX_1:
 		case PCI_DEVICE_ID_INTEL_82371AB:
 			p += sprintf(p, "\n                                Intel PIIX4 Ultra 33 Chipset.\n");
