Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271775AbRHUSNu>; Tue, 21 Aug 2001 14:13:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271776AbRHUSNk>; Tue, 21 Aug 2001 14:13:40 -0400
Received: from cmailg6.svr.pol.co.uk ([195.92.195.176]:6976 "EHLO
	cmailg6.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S271773AbRHUSNZ>; Tue, 21 Aug 2001 14:13:25 -0400
Date: Tue, 21 Aug 2001 19:12:45 +0100
From: kernel@corrosive.freeserve.co.uk
To: linux-kernel@vger.kernel.org
Cc: jhartmann@precisioninsight.com
Subject: Re: SiS 735 chipset
Message-ID: <20010821191245.A7024@corrosive.freeserve.co.uk>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	jhartmann@precisioninsight.com
In-Reply-To: <0107102112300E.07809@movitslinux.bloomberg.com> <20010817084939.A873@corrosive.freeserve.co.uk> <20010821090302.B2559@corrosive.freeserve.co.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Kj7319i9nmIyA2yE"
Content-Disposition: inline
In-Reply-To: <20010821090302.B2559@corrosive.freeserve.co.uk>
User-Agent: Mutt/1.3.20i
X-Operating-System: Linux corrosive.freeserve.co.uk 2.4.8-ac7 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Kj7319i9nmIyA2yE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 21, 2001 at 09:03:02AM +0100, kernel@corrosive.freeserve.co.uk wrote:


> Hi,
> I've attached the patch that lets the kernel SIS AGP driver recognise the 735
> chipset as it seems fine.  I don't know of any system for testing the AGP
> support so I tried QuakeIII and that ran fine.  The patch is against 2.4.8-ac4
> but since all it changes is a couple of (infrequently) changed tables it should
> work fine on later versions.  I've CC'd Jeff Hartmann with it as he seems to
> be the maintainer of the AGP side (but isn't listed in the MAINTAINERS file).

Well that was a good start, I was /sure/ I attached the patch this morning.
Ok, attempt no.2, apologies to anyone that wanted it...

Cheers,
Adrian.


--Kj7319i9nmIyA2yE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="sis735.patch"

diff -urN linux-2.4.8-ac4/drivers/char/agp/agpgart_be.c linux/drivers/char/agp/agpgart_be.c
--- linux-2.4.8-ac4/drivers/char/agp/agpgart_be.c	Thu Aug 16 18:45:44 2001
+++ linux/drivers/char/agp/agpgart_be.c	Mon Aug 20 08:39:44 2001
@@ -2998,6 +2998,12 @@
 		"SiS",
 		"530",
 		sis_generic_setup },
+	{ PCI_DEVICE_ID_SI_735,
+		PCI_VENDOR_ID_SI,
+		SIS_GENERIC,
+		"SiS",
+		"735",
+		sis_generic_setup },
 	{ PCI_DEVICE_ID_SI_630,
 		PCI_VENDOR_ID_SI,
 		SIS_GENERIC,
@@ -3017,6 +3023,12 @@
 		"Generic",
 		sis_generic_setup },
 	{ PCI_DEVICE_ID_SI_530,
+		PCI_VENDOR_ID_SI,
+		SIS_GENERIC,
+		"SiS",
+		"Generic",
+		sis_generic_setup },
+	{ PCI_DEVICE_ID_SI_735,
 		PCI_VENDOR_ID_SI,
 		SIS_GENERIC,
 		"SiS",
diff -urN linux-2.4.8-ac4/drivers/pci/pci.ids linux/drivers/pci/pci.ids
--- linux-2.4.8-ac4/drivers/pci/pci.ids	Thu Aug 16 18:45:26 2001
+++ linux/drivers/pci/pci.ids	Thu Aug 16 19:10:43 2001
@@ -749,6 +749,7 @@
 	0620  620 Host
 	0630  630 Host
 	0730  730 Host
+	0735  735 Host
 	0900  SiS900 10/100 Ethernet
 		1039 0900  SiS900 10/100 Ethernet Adapter
 	3602  83C602
@@ -781,6 +782,7 @@
 		1569 6326  SiS6326 GUI Accelerator
 	7001  7001
 	7007  OHCI Compliant FireWire Controller
+	7012  SiS7012 PCI Audio Accelerator
 	7016  SiS7016 10/100 Ethernet Adapter
 		1039 7016  SiS7016 10/100 Ethernet Adapter
 	7018  SiS PCI Audio Accelerator

--Kj7319i9nmIyA2yE--
