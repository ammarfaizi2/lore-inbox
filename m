Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291470AbSBAAz5>; Thu, 31 Jan 2002 19:55:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291471AbSBAAzi>; Thu, 31 Jan 2002 19:55:38 -0500
Received: from mbr.sphere.ne.jp ([203.138.71.91]:56229 "EHLO mbr.sphere.ne.jp")
	by vger.kernel.org with ESMTP id <S291470AbSBAAze>;
	Thu, 31 Jan 2002 19:55:34 -0500
Date: Fri, 1 Feb 2002 09:54:57 +0900
From: Bruce Harada <harada@mbr.sphere.ne.jp>
To: Jeff Garzik <garzik@havoc.gtf.org>
Cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: [PATCH] Misc ICH ID changes/additions
Message-Id: <20020201095457.23a30eb5.harada@mbr.sphere.ne.jp>
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

On Thu, 31 Jan 2002 14:10:25 -0500
Jeff Garzik <garzik@havoc.gtf.org> wrote:

> Would it be possible to produce two patches, the first adding new ids,
> and the second doing the rename you want?

Sure, no problem. Here's the ID additions/changes:

diff -urN -X dontdiff linux-2.4.18-pre7/drivers/pci/pci.ids linux-2.4.18-pre7-bjh/drivers/pci/pci.ids
--- linux-2.4.18-pre7/drivers/pci/pci.ids	Thu Jan 31 20:29:13 2002
+++ linux-2.4.18-pre7-bjh/drivers/pci/pci.ids	Fri Feb  1 00:35:02 2002
@@ -5015,38 +5015,42 @@
 	1a24  82840 840 (Carmel) Chipset PCI Bridge (Hub B)
 	1a30  82845 845 (Brookdale) Chipset Host Bridge
 	1a31  82845 845 (Brookdale) Chipset AGP Bridge
-	2410  82801AA ISA Bridge (LPC)
-	2411  82801AA IDE
-	2412  82801AA USB
-	2413  82801AA SMBus
-	2415  82801AA AC'97 Audio
+	2410  82801AA ICH ISA Bridge (LPC)
+	2411  82801AA ICH IDE
+	2412  82801AA ICH USB
+	2413  82801AA ICH SMBus
+	2415  82801AA ICH AC'97 Audio
 		11d4 0040  SoundMAX Integrated Digital Audio
 		11d4 0048  SoundMAX Integrated Digital Audio
 		11d4 5340  SoundMAX Integrated Digital Audio
-	2416  82801AA AC'97 Modem
-	2418  82801AA PCI Bridge
-	2420  82801AB ISA Bridge (LPC)
-	2421  82801AB IDE
-	2422  82801AB USB
-	2423  82801AB SMBus
-	2425  82801AB AC'97 Audio
+	2416  82801AA ICH AC'97 Modem
+	2418  82801AA ICH PCI Bridge
+	2420  82801AB ICH0 ISA Bridge (LPC)
+	2421  82801AB ICH0 IDE
+	2422  82801AB ICH0 USB
+	2423  82801AB ICH0 SMBus
+	2425  82801AB ICH0 AC'97 Audio
 		11d4 0040  SoundMAX Integrated Digital Audio
 		11d4 0048  SoundMAX Integrated Digital Audio
-	2426  82801AB AC'97 Modem
-	2428  82801AB PCI Bridge
-	2440  82820 820 (Camino 2) Chipset ISA Bridge (ICH2)
-	2442  82820 820 (Camino 2) Chipset USB (Hub A)
-	2443  82820 820 (Camino 2) Chipset SMBus
-	2444  82820 820 (Camino 2) Chipset USB (Hub B)
-	2445  82820 820 (Camino 2) Chipset AC'97 Audio Controller
-	2446  82820 820 (Camino 2) Chipset AC'97 Modem Controller
-	2448  82820 820 (Camino 2) Chipset PCI (-M)
-	2449  82820 (ICH2) Chipset Ethernet Controller
-	244a  82820 820 (Camino 2) Chipset IDE U100 (-M)
-	244b  82820 820 (Camino 2) Chipset IDE U100
-	244c  82820 820 (Camino 2) Chipset ISA Bridge (ICH2-M)
-	244e  82820 820 (Camino 2) Chipset PCI
+	2426  82801AB ICH0 AC'97 Modem
+	2428  82801AB ICH0 PCI Bridge
+	2440  82801BA ICH2 ISA Bridge (LPC)
+	2441  82801BA ICH2-LE IDE U66
+	2442  82801BA ICH2 USB (Hub A)
+	2443  82801BA ICH2 SMBus
+	2444  82801BA ICH2 USB (Hub B)
+	2445  82801BA ICH2 AC'97 Audio Controller
+	2446  82801BA ICH2 AC'97 Modem Controller
+	2448  82801BA ICH2-M PCI Bridge
+	2449  82801BA ICH2 Ethernet Controller
+	244a  82801BA ICH2-M IDE U100
+	244b  82801BA ICH2 IDE U100
+	244c  82801BA ICH2-M ISA Bridge
+	244e  82801BA ICH2 PCI Bridge
+	2481  82801CA ICH3-LE UDE U66
 	2485  AC'97 Audio Controller
+	248a  82801CA ICH3-M IDE U100
+	248b  82801CA ICH3 IDE U100
 	2500  82820 820 (Camino) Chipset Host Bridge (MCH)
 		1043 801c  P3C-2000 system chipset
 	2501  82820 820 (Camino) Chipset Host Bridge (MCH)
