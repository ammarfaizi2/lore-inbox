Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262954AbTIREIY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Sep 2003 00:08:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262955AbTIREIY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Sep 2003 00:08:24 -0400
Received: from hqemgate00.nvidia.com ([216.228.112.144]:50953 "EHLO
	hqemgate00.nvidia.com") by vger.kernel.org with ESMTP
	id S262954AbTIREIO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Sep 2003 00:08:14 -0400
Message-ID: <8F12FC8F99F4404BA86AC90CD0BFB04F039F7135@mail-sc-6.nvidia.com>
From: Allen Martin <AMartin@nvidia.com>
To: Allen Martin <AMartin@nvidia.com>,
       "Andre Hedrick (andre@linux-ide.org)" <andre@linux-ide.org>
Cc: "LKML (linux-kernel@vger.kernel.org)" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] 2.4.23-pre4 support for new nForce IDE controllers
Date: Wed, 17 Sep 2003 21:08:11 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_000_01C37D9A.79ABE590"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_000_01C37D9A.79ABE590
Content-Type: text/plain

Sorry, my mailer added newlines, resending as attachment.

-Allen

> -----Original Message-----
> From: Allen Martin 
> Sent: Wednesday, September 17, 2003 8:47 PM
> To: Andre Hedrick (andre@linux-ide.org)
> Cc: LKML (linux-kernel@vger.kernel.org)
> Subject: [PATCH] 2.4.23-pre4 support for new nForce IDE controllers
> 
> 
> This adds support for some new and upcoming NVIDIA nForce IDE 
> controllers to
> the combined AMD / NVIDIA IDE driver.  I've also added 
> support for udma6
> (Ultra 133) as a separate patch that depends on this patch.
> 
> 
> diff -ru -X dontdiff linux-2.4.23-pre4/drivers/ide/pci/amd74xx.c
> linux-2.4.23-pre4-nvide/drivers/ide/pci/amd74xx.c
> --- linux-2.4.23-pre4/drivers/ide/pci/amd74xx.c	2003-06-13
> 07:51:33.000000000 -0700
> +++ linux-2.4.23-pre4-nvide/drivers/ide/pci/amd74xx.c	2003-09-17
> 19:58:46.000000000 -0700
> @@ -60,7 +60,13 @@
>  	{ PCI_DEVICE_ID_AMD_OPUS_7441, 0x00, 0x40, AMD_UDMA_100 },
> /* AMD-768 Opus */
>  	{ PCI_DEVICE_ID_AMD_8111_IDE,  0x00, 0x40, AMD_UDMA_100 },
> /* AMD-8111 */
>          { PCI_DEVICE_ID_NVIDIA_NFORCE_IDE, 0x00, 0x50, 
> AMD_UDMA_100 },
> /* nVidia nForce */
> -        { PCI_DEVICE_ID_NVIDIA_NFORCE2_IDE, 0x00, 0x50, 
> AMD_UDMA_100 },
> /* nVidia nForce */
> +        { PCI_DEVICE_ID_NVIDIA_NFORCE2_IDE, 0x00, 0x50, 
> AMD_UDMA_100 },
> /* nVidia nForce2 */
> +        { PCI_DEVICE_ID_NVIDIA_NFORCE2S_IDE, 0x00, 0x50, 
> AMD_UDMA_100 },
> /* nVidia nForce2s */
> +        { PCI_DEVICE_ID_NVIDIA_NFORCE2S_SATA, 0x00, 0x50, 
> AMD_UDMA_100 },
> /* nVidia nForce2s SATA */
> +        { PCI_DEVICE_ID_NVIDIA_NFORCE3_IDE, 0x00, 0x50, 
> AMD_UDMA_100 },
> /* NVIDIA nForce3 */
> +        { PCI_DEVICE_ID_NVIDIA_NFORCE3S_IDE, 0x00, 0x50, 
> AMD_UDMA_100 },
> /* NVIDIA nForce3s */
> +        { PCI_DEVICE_ID_NVIDIA_NFORCE3S_SATA, 0x00, 0x50, 
> AMD_UDMA_100 },
> /* NVIDIA nForce3s SATA */
> +        { PCI_DEVICE_ID_NVIDIA_NFORCE3S_SATA2, 0x00, 0x50, 
> AMD_UDMA_100 },
> /* NVIDIA nForce3s SATA2 */
>  
>  	{ 0 }
>  };
> @@ -454,6 +460,12 @@
>  	{ PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_8111_IDE, 	
> PCI_ANY_ID,
> PCI_ANY_ID, 0, 0, 4},
>  	{ PCI_VENDOR_ID_NVIDIA, 
> PCI_DEVICE_ID_NVIDIA_NFORCE_IDE, PCI_ANY_ID,
> PCI_ANY_ID, 0, 0, 5},
>  	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE2_IDE,
> PCI_ANY_ID, PCI_ANY_ID, 0, 0, 6},
> +	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE2S_IDE,
> PCI_ANY_ID, PCI_ANY_ID, 0, 0, 7},
> +	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE2S_SATA,
> PCI_ANY_ID, PCI_ANY_ID, 0, 0, 8},
> +	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE3_IDE,
> PCI_ANY_ID, PCI_ANY_ID, 0, 0, 9},
> +	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE3S_IDE,
> PCI_ANY_ID, PCI_ANY_ID, 0, 0, 10},
> +	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE3S_SATA,
> PCI_ANY_ID, PCI_ANY_ID, 0, 0, 11},
> +	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE3S_SATA2,
> PCI_ANY_ID, PCI_ANY_ID, 0, 0, 12},
>  	{ 0, },
>  };
>  
> diff -ru -X dontdiff linux-2.4.23-pre4/drivers/ide/pci/amd74xx.h
> linux-2.4.23-pre4-nvide/drivers/ide/pci/amd74xx.h
> --- linux-2.4.23-pre4/drivers/ide/pci/amd74xx.h	2003-09-17
> 18:59:27.000000000 -0700
> +++ linux-2.4.23-pre4-nvide/drivers/ide/pci/amd74xx.h	2003-09-17
> 19:59:15.000000000 -0700
> @@ -124,6 +124,90 @@
>  		.bootable	= ON_BOARD,
>  		.extra		= 0,
>  	},
> +	{	/* 7 */
> +		.vendor		= PCI_VENDOR_ID_NVIDIA,
> +		.device		= PCI_DEVICE_ID_NVIDIA_NFORCE2S_IDE,
> +		.name		= "NFORCE2",
> +		.init_chipset	= init_chipset_amd74xx,
> +		.init_iops	= NULL,
> +		.init_hwif	= init_hwif_amd74xx,
> +		.init_dma	= init_dma_amd74xx,
> +		.channels	= 2,
> +		.autodma	= AUTODMA,
> +		.enablebits	= {{0x50,0x02,0x02}, {0x50,0x01,0x01}},
> +		.bootable	= ON_BOARD,
> +		.extra		= 0,
> +	},
> +	{	/* 8 */
> +		.vendor		= PCI_VENDOR_ID_NVIDIA,
> +		.device		= PCI_DEVICE_ID_NVIDIA_NFORCE2S_SATA,
> +		.name		= "NFORCE2",
> +		.init_chipset	= init_chipset_amd74xx,
> +		.init_iops	= NULL,
> +		.init_hwif	= init_hwif_amd74xx,
> +		.init_dma	= init_dma_amd74xx,
> +		.channels	= 2,
> +		.autodma	= AUTODMA,
> +		.enablebits	= {{0x50,0x02,0x02}, {0x50,0x01,0x01}},
> +		.bootable	= ON_BOARD,
> +		.extra		= 0,
> +	},
> +	{	/* 9 */
> +		.vendor		= PCI_VENDOR_ID_NVIDIA,
> +		.device		= PCI_DEVICE_ID_NVIDIA_NFORCE3_IDE,
> +		.name		= "NFORCE3",
> +		.init_chipset	= init_chipset_amd74xx,
> +		.init_iops	= NULL,
> +		.init_hwif	= init_hwif_amd74xx,
> +		.init_dma	= init_dma_amd74xx,
> +		.channels	= 2,
> +		.autodma	= AUTODMA,
> +		.enablebits	= {{0x50,0x02,0x02}, {0x50,0x01,0x01}},
> +		.bootable	= ON_BOARD,
> +		.extra		= 0,
> +	},
> +	{	/* 10 */
> +		.vendor		= PCI_VENDOR_ID_NVIDIA,
> +		.device		= PCI_DEVICE_ID_NVIDIA_NFORCE3S_IDE,
> +		.name		= "NFORCE3",
> +		.init_chipset	= init_chipset_amd74xx,
> +		.init_iops	= NULL,
> +		.init_hwif	= init_hwif_amd74xx,
> +		.init_dma	= init_dma_amd74xx,
> +		.channels	= 2,
> +		.autodma	= AUTODMA,
> +		.enablebits	= {{0x50,0x02,0x02}, {0x50,0x01,0x01}},
> +		.bootable	= ON_BOARD,
> +		.extra		= 0,
> +	},
> +	{	/* 11 */
> +		.vendor		= PCI_VENDOR_ID_NVIDIA,
> +		.device		= PCI_DEVICE_ID_NVIDIA_NFORCE3S_SATA,
> +		.name		= "NFORCE3",
> +		.init_chipset	= init_chipset_amd74xx,
> +		.init_iops	= NULL,
> +		.init_hwif	= init_hwif_amd74xx,
> +		.init_dma	= init_dma_amd74xx,
> +		.channels	= 2,
> +		.autodma	= AUTODMA,
> +		.enablebits	= {{0x50,0x02,0x02}, {0x50,0x01,0x01}},
> +		.bootable	= ON_BOARD,
> +		.extra		= 0,
> +	},
> +	{	/* 12 */
> +		.vendor		= PCI_VENDOR_ID_NVIDIA,
> +		.device		= PCI_DEVICE_ID_NVIDIA_NFORCE3S_SATA2,
> +		.name		= "NFORCE3",
> +		.init_chipset	= init_chipset_amd74xx,
> +		.init_iops	= NULL,
> +		.init_hwif	= init_hwif_amd74xx,
> +		.init_dma	= init_dma_amd74xx,
> +		.channels	= 2,
> +		.autodma	= AUTODMA,
> +		.enablebits	= {{0x50,0x02,0x02}, {0x50,0x01,0x01}},
> +		.bootable	= ON_BOARD,
> +		.extra		= 0,
> +	},
>  	{
>  		.vendor		= 0,
>  		.device		= 0,
> diff -ru -X dontdiff linux-2.4.23-pre4/include/linux/pci_ids.h
> linux-2.4.23-pre4-nvide/include/linux/pci_ids.h
> --- linux-2.4.23-pre4/include/linux/pci_ids.h	2003-09-17
> 18:56:36.000000000 -0700
> +++ linux-2.4.23-pre4-nvide/include/linux/pci_ids.h	2003-09-17
> 19:58:46.000000000 -0700
> @@ -966,7 +966,13 @@
>  #define PCI_DEVICE_ID_NVIDIA_VTNT2		0x002C
>  #define PCI_DEVICE_ID_NVIDIA_UVTNT2		0x002D
>  #define PCI_DEVICE_ID_NVIDIA_NFORCE2_IDE	0x0065
> +#define PCI_DEVICE_ID_NVIDIA_NFORCE2S_IDE	0x0085
> +#define PCI_DEVICE_ID_NVIDIA_NFORCE2S_SATA	0x008e
>  #define PCI_DEVICE_ID_NVIDIA_ITNT2		0x00A0
> +#define PCI_DEVICE_ID_NVIDIA_NFORCE3_IDE	0x00d5
> +#define PCI_DEVICE_ID_NVIDIA_NFORCE3S_SATA	0x00e3
> +#define PCI_DEVICE_ID_NVIDIA_NFORCE3S_IDE	0x00e5
> +#define PCI_DEVICE_ID_NVIDIA_NFORCE3S_SATA2	0x00ee
>  #define PCI_DEVICE_ID_NVIDIA_GEFORCE_SDR	0x0100
>  #define PCI_DEVICE_ID_NVIDIA_GEFORCE_DDR	0x0101
>  #define PCI_DEVICE_ID_NVIDIA_QUADRO		0x0103
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


------_=_NextPart_000_01C37D9A.79ABE590
Content-Type: application/octet-stream;
	name="linux-2.4.23-pre4-nvide.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="linux-2.4.23-pre4-nvide.patch"

diff -ru -X dontdiff linux-2.4.23-pre4/drivers/ide/pci/amd74xx.c =
linux-2.4.23-pre4-nvide/drivers/ide/pci/amd74xx.c=0A=
--- linux-2.4.23-pre4/drivers/ide/pci/amd74xx.c	2003-06-13 =
07:51:33.000000000 -0700=0A=
+++ linux-2.4.23-pre4-nvide/drivers/ide/pci/amd74xx.c	2003-09-17 =
19:58:46.000000000 -0700=0A=
@@ -60,7 +60,13 @@=0A=
 	{ PCI_DEVICE_ID_AMD_OPUS_7441, 0x00, 0x40, AMD_UDMA_100 },			/* =
AMD-768 Opus */=0A=
 	{ PCI_DEVICE_ID_AMD_8111_IDE,  0x00, 0x40, AMD_UDMA_100 },			/* =
AMD-8111 */=0A=
         { PCI_DEVICE_ID_NVIDIA_NFORCE_IDE, 0x00, 0x50, AMD_UDMA_100 }, =
                 /* nVidia nForce */=0A=
-        { PCI_DEVICE_ID_NVIDIA_NFORCE2_IDE, 0x00, 0x50, AMD_UDMA_100 =
},                  /* nVidia nForce */=0A=
+        { PCI_DEVICE_ID_NVIDIA_NFORCE2_IDE, 0x00, 0x50, AMD_UDMA_100 =
},                 /* nVidia nForce2 */=0A=
+        { PCI_DEVICE_ID_NVIDIA_NFORCE2S_IDE, 0x00, 0x50, AMD_UDMA_100 =
},                /* nVidia nForce2s */=0A=
+        { PCI_DEVICE_ID_NVIDIA_NFORCE2S_SATA, 0x00, 0x50, AMD_UDMA_100 =
},               /* nVidia nForce2s SATA */=0A=
+        { PCI_DEVICE_ID_NVIDIA_NFORCE3_IDE, 0x00, 0x50, AMD_UDMA_100 =
},                 /* NVIDIA nForce3 */=0A=
+        { PCI_DEVICE_ID_NVIDIA_NFORCE3S_IDE, 0x00, 0x50, AMD_UDMA_100 =
},                /* NVIDIA nForce3s */=0A=
+        { PCI_DEVICE_ID_NVIDIA_NFORCE3S_SATA, 0x00, 0x50, AMD_UDMA_100 =
},               /* NVIDIA nForce3s SATA */=0A=
+        { PCI_DEVICE_ID_NVIDIA_NFORCE3S_SATA2, 0x00, 0x50, =
AMD_UDMA_100 },              /* NVIDIA nForce3s SATA2 */=0A=
 =0A=
 	{ 0 }=0A=
 };=0A=
@@ -454,6 +460,12 @@=0A=
 	{ PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_8111_IDE, 	PCI_ANY_ID, =
PCI_ANY_ID, 0, 0, 4},=0A=
 	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_IDE, PCI_ANY_ID, =
PCI_ANY_ID, 0, 0, 5},=0A=
 	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE2_IDE, PCI_ANY_ID, =
PCI_ANY_ID, 0, 0, 6},=0A=
+	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE2S_IDE, =
PCI_ANY_ID, PCI_ANY_ID, 0, 0, 7},=0A=
+	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE2S_SATA, =
PCI_ANY_ID, PCI_ANY_ID, 0, 0, 8},=0A=
+	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE3_IDE, PCI_ANY_ID, =
PCI_ANY_ID, 0, 0, 9},=0A=
+	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE3S_IDE, =
PCI_ANY_ID, PCI_ANY_ID, 0, 0, 10},=0A=
+	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE3S_SATA, =
PCI_ANY_ID, PCI_ANY_ID, 0, 0, 11},=0A=
+	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE3S_SATA2, =
PCI_ANY_ID, PCI_ANY_ID, 0, 0, 12},=0A=
 	{ 0, },=0A=
 };=0A=
 =0A=
diff -ru -X dontdiff linux-2.4.23-pre4/drivers/ide/pci/amd74xx.h =
linux-2.4.23-pre4-nvide/drivers/ide/pci/amd74xx.h=0A=
--- linux-2.4.23-pre4/drivers/ide/pci/amd74xx.h	2003-09-17 =
18:59:27.000000000 -0700=0A=
+++ linux-2.4.23-pre4-nvide/drivers/ide/pci/amd74xx.h	2003-09-17 =
19:59:15.000000000 -0700=0A=
@@ -124,6 +124,90 @@=0A=
 		.bootable	=3D ON_BOARD,=0A=
 		.extra		=3D 0,=0A=
 	},=0A=
+	{	/* 7 */=0A=
+		.vendor		=3D PCI_VENDOR_ID_NVIDIA,=0A=
+		.device		=3D PCI_DEVICE_ID_NVIDIA_NFORCE2S_IDE,=0A=
+		.name		=3D "NFORCE2",=0A=
+		.init_chipset	=3D init_chipset_amd74xx,=0A=
+		.init_iops	=3D NULL,=0A=
+		.init_hwif	=3D init_hwif_amd74xx,=0A=
+		.init_dma	=3D init_dma_amd74xx,=0A=
+		.channels	=3D 2,=0A=
+		.autodma	=3D AUTODMA,=0A=
+		.enablebits	=3D {{0x50,0x02,0x02}, {0x50,0x01,0x01}},=0A=
+		.bootable	=3D ON_BOARD,=0A=
+		.extra		=3D 0,=0A=
+	},=0A=
+	{	/* 8 */=0A=
+		.vendor		=3D PCI_VENDOR_ID_NVIDIA,=0A=
+		.device		=3D PCI_DEVICE_ID_NVIDIA_NFORCE2S_SATA,=0A=
+		.name		=3D "NFORCE2",=0A=
+		.init_chipset	=3D init_chipset_amd74xx,=0A=
+		.init_iops	=3D NULL,=0A=
+		.init_hwif	=3D init_hwif_amd74xx,=0A=
+		.init_dma	=3D init_dma_amd74xx,=0A=
+		.channels	=3D 2,=0A=
+		.autodma	=3D AUTODMA,=0A=
+		.enablebits	=3D {{0x50,0x02,0x02}, {0x50,0x01,0x01}},=0A=
+		.bootable	=3D ON_BOARD,=0A=
+		.extra		=3D 0,=0A=
+	},=0A=
+	{	/* 9 */=0A=
+		.vendor		=3D PCI_VENDOR_ID_NVIDIA,=0A=
+		.device		=3D PCI_DEVICE_ID_NVIDIA_NFORCE3_IDE,=0A=
+		.name		=3D "NFORCE3",=0A=
+		.init_chipset	=3D init_chipset_amd74xx,=0A=
+		.init_iops	=3D NULL,=0A=
+		.init_hwif	=3D init_hwif_amd74xx,=0A=
+		.init_dma	=3D init_dma_amd74xx,=0A=
+		.channels	=3D 2,=0A=
+		.autodma	=3D AUTODMA,=0A=
+		.enablebits	=3D {{0x50,0x02,0x02}, {0x50,0x01,0x01}},=0A=
+		.bootable	=3D ON_BOARD,=0A=
+		.extra		=3D 0,=0A=
+	},=0A=
+	{	/* 10 */=0A=
+		.vendor		=3D PCI_VENDOR_ID_NVIDIA,=0A=
+		.device		=3D PCI_DEVICE_ID_NVIDIA_NFORCE3S_IDE,=0A=
+		.name		=3D "NFORCE3",=0A=
+		.init_chipset	=3D init_chipset_amd74xx,=0A=
+		.init_iops	=3D NULL,=0A=
+		.init_hwif	=3D init_hwif_amd74xx,=0A=
+		.init_dma	=3D init_dma_amd74xx,=0A=
+		.channels	=3D 2,=0A=
+		.autodma	=3D AUTODMA,=0A=
+		.enablebits	=3D {{0x50,0x02,0x02}, {0x50,0x01,0x01}},=0A=
+		.bootable	=3D ON_BOARD,=0A=
+		.extra		=3D 0,=0A=
+	},=0A=
+	{	/* 11 */=0A=
+		.vendor		=3D PCI_VENDOR_ID_NVIDIA,=0A=
+		.device		=3D PCI_DEVICE_ID_NVIDIA_NFORCE3S_SATA,=0A=
+		.name		=3D "NFORCE3",=0A=
+		.init_chipset	=3D init_chipset_amd74xx,=0A=
+		.init_iops	=3D NULL,=0A=
+		.init_hwif	=3D init_hwif_amd74xx,=0A=
+		.init_dma	=3D init_dma_amd74xx,=0A=
+		.channels	=3D 2,=0A=
+		.autodma	=3D AUTODMA,=0A=
+		.enablebits	=3D {{0x50,0x02,0x02}, {0x50,0x01,0x01}},=0A=
+		.bootable	=3D ON_BOARD,=0A=
+		.extra		=3D 0,=0A=
+	},=0A=
+	{	/* 12 */=0A=
+		.vendor		=3D PCI_VENDOR_ID_NVIDIA,=0A=
+		.device		=3D PCI_DEVICE_ID_NVIDIA_NFORCE3S_SATA2,=0A=
+		.name		=3D "NFORCE3",=0A=
+		.init_chipset	=3D init_chipset_amd74xx,=0A=
+		.init_iops	=3D NULL,=0A=
+		.init_hwif	=3D init_hwif_amd74xx,=0A=
+		.init_dma	=3D init_dma_amd74xx,=0A=
+		.channels	=3D 2,=0A=
+		.autodma	=3D AUTODMA,=0A=
+		.enablebits	=3D {{0x50,0x02,0x02}, {0x50,0x01,0x01}},=0A=
+		.bootable	=3D ON_BOARD,=0A=
+		.extra		=3D 0,=0A=
+	},=0A=
 	{=0A=
 		.vendor		=3D 0,=0A=
 		.device		=3D 0,=0A=
diff -ru -X dontdiff linux-2.4.23-pre4/include/linux/pci_ids.h =
linux-2.4.23-pre4-nvide/include/linux/pci_ids.h=0A=
--- linux-2.4.23-pre4/include/linux/pci_ids.h	2003-09-17 =
18:56:36.000000000 -0700=0A=
+++ linux-2.4.23-pre4-nvide/include/linux/pci_ids.h	2003-09-17 =
19:58:46.000000000 -0700=0A=
@@ -966,7 +966,13 @@=0A=
 #define PCI_DEVICE_ID_NVIDIA_VTNT2		0x002C=0A=
 #define PCI_DEVICE_ID_NVIDIA_UVTNT2		0x002D=0A=
 #define PCI_DEVICE_ID_NVIDIA_NFORCE2_IDE	0x0065=0A=
+#define PCI_DEVICE_ID_NVIDIA_NFORCE2S_IDE	0x0085=0A=
+#define PCI_DEVICE_ID_NVIDIA_NFORCE2S_SATA	0x008e=0A=
 #define PCI_DEVICE_ID_NVIDIA_ITNT2		0x00A0=0A=
+#define PCI_DEVICE_ID_NVIDIA_NFORCE3_IDE	0x00d5=0A=
+#define PCI_DEVICE_ID_NVIDIA_NFORCE3S_SATA	0x00e3=0A=
+#define PCI_DEVICE_ID_NVIDIA_NFORCE3S_IDE	0x00e5=0A=
+#define PCI_DEVICE_ID_NVIDIA_NFORCE3S_SATA2	0x00ee=0A=
 #define PCI_DEVICE_ID_NVIDIA_GEFORCE_SDR	0x0100=0A=
 #define PCI_DEVICE_ID_NVIDIA_GEFORCE_DDR	0x0101=0A=
 #define PCI_DEVICE_ID_NVIDIA_QUADRO		0x0103=0A=

------_=_NextPart_000_01C37D9A.79ABE590--
