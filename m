Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132930AbRAFUgf>; Sat, 6 Jan 2001 15:36:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132900AbRAFUgZ>; Sat, 6 Jan 2001 15:36:25 -0500
Received: from adsl-63-195-162-81.dsl.snfc21.pacbell.net ([63.195.162.81]:5393
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S132930AbRAFUgP>; Sat, 6 Jan 2001 15:36:15 -0500
Date: Sat, 6 Jan 2001 12:35:41 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Peter Denison <peterd@pnd-pc.demon.co.uk>
cc: saw@saw.sw.com.sg, jmaurer@cck.uni-kl.de, linux-kernel@vger.kernel.org,
        torvalds@transmeta.com
Subject: Re: [PATCH] PCI device IDs for Intel i815E chipset (2.4.0)
In-Reply-To: <Pine.LNX.4.21.0101061849330.21275-100000@pnd-pc.demon.co.uk>
Message-ID: <Pine.LNX.4.10.10101061234520.7666-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I gave it a label based on the stamp on the chips, and "Intel Secret" was
above that label.

Cheers,

On Sat, 6 Jan 2001, Peter Denison wrote:

> Description:
> Includes new PCI device IDs for the Intel i815E chipset, and corrects some
> of the names for the associated parts of the chipset. This has effects in
> the EEPro100 network driver and the PCI IDE driver.
> 
> Detail & Justification:
> The Intel ICH2 (I/O Controller Hub 2) is used in several chipsets, not
> just the 820 (Camino) chipset it is accredited to in the PCI ID database.
> Nor is the IDE portion of the ICH2 really a PIIX4 chip, though it is very
> similar and PIIX driver works on both. These changes are just
> internal macro naming and minor user interface tweaks.
> 
> According to Intel there are 3 versions of the I/O Controller hub:
> Name   Chip Number     Used in "chipset"
> 
> ICH    82801AA         820, 815, 810E, 810
> ICH0   82801AB         820, 810E, 810
> ICH2   82801BA         820E, 815E
> 
> The difference between the 810E and the 810 is the E version of the 82810
> GMCH Host interface. Presumably the choice between an ICH and an ICH0 is
> one for the motherboard designer to make...
> 
> 
> Patch applies to 2.4.0:
> 
> --- include/linux/pci_ids.h	Sat Jan  6 17:51:13 2001
> +++ include/linux/pci_ids.h.new	Sat Jan  6 19:22:51 2001
> @@ -1336,6 +1336,9 @@
>  #define PCI_DEVICE_ID_INTEL_82430	0x0486
>  #define PCI_DEVICE_ID_INTEL_82434	0x04a3
>  #define PCI_DEVICE_ID_INTEL_I960	0x0960
> +#define PCI_DEVICE_ID_INTEL_82815_0	0x1130
> +#define PCI_DEVICE_ID_INTEL_82815_1	0x1131
> +#define PCI_DEVICE_ID_INTEL_82815_2	0x1132
>  #define PCI_DEVICE_ID_INTEL_82559ER	0x1209
>  #define PCI_DEVICE_ID_INTEL_82092AA_0	0x1221
>  #define PCI_DEVICE_ID_INTEL_82092AA_1	0x1222
> @@ -1375,13 +1378,16 @@
>  #define PCI_DEVICE_ID_INTEL_82801AB_5	0x2425
>  #define PCI_DEVICE_ID_INTEL_82801AB_6	0x2426
>  #define PCI_DEVICE_ID_INTEL_82801AB_8	0x2428
> -#define PCI_DEVICE_ID_INTEL_82820FW_0	0x2440
> -#define PCI_DEVICE_ID_INTEL_82820FW_1	0x2442
> -#define PCI_DEVICE_ID_INTEL_82820FW_2	0x2443
> -#define PCI_DEVICE_ID_INTEL_82820FW_3	0x2444
> -#define PCI_DEVICE_ID_INTEL_82820FW_4	0x2449
> -#define PCI_DEVICE_ID_INTEL_82820FW_5	0x244b
> -#define PCI_DEVICE_ID_INTEL_82820FW_6	0x244e
> +#define PCI_DEVICE_ID_INTEL_82801BA_0	0x2440
> +#define PCI_DEVICE_ID_INTEL_82801BA_2	0x2442
> +#define PCI_DEVICE_ID_INTEL_82801BA_3	0x2443
> +#define PCI_DEVICE_ID_INTEL_82801BA_4	0x2444
> +#define PCI_DEVICE_ID_INTEL_82801BA_5	0x2445
> +#define PCI_DEVICE_ID_INTEL_82801BA_6	0x2446
> +#define PCI_DEVICE_ID_INTEL_82801BAM	0x2448
> +#define PCI_DEVICE_ID_INTEL_82801BA_9	0x2449
> +#define PCI_DEVICE_ID_INTEL_82801BA_1	0x244b
> +#define PCI_DEVICE_ID_INTEL_82801BA	0x244e
>  #define PCI_DEVICE_ID_INTEL_82810_MC1	0x7120
>  #define PCI_DEVICE_ID_INTEL_82810_IG1	0x7121
>  #define PCI_DEVICE_ID_INTEL_82810_MC3	0x7122
> --- drivers/net/eepro100.c	Thu Dec 21 21:40:27 2000
> +++ drivers/net/eepro100.c.new	Thu Jan  4 18:27:16 2001
> @@ -2192,7 +2192,7 @@
>  		PCI_ANY_ID, PCI_ANY_ID, },
>  	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ID1030,
>  		PCI_ANY_ID, PCI_ANY_ID, },
> -	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82820FW_4,
> +	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801BA_9,
>  		PCI_ANY_ID, PCI_ANY_ID, },
>  	{ 0,}
>  };
> --- drivers/pci/pci.ids	Sat Jan  6 17:51:10 2001
> +++ drivers/pci/pci.ids.new	Sat Jan  6 19:21:24 2001
> @@ -4484,6 +4484,9 @@
>  		1014 0119  Netfinity Gigabit Ethernet SX Adapter
>  		8086 1000  EtherExpress PRO/1000 Gigabit Server Adapter
>  	1030  82559 InBusiness 10/100
> +	1130  82815 GMCH Host-Hub Bridge/DRAM Controller
> +	1131  82815 GMCH AGP Bridge
> +	1132  82815 GMCH Internal Graphics Controller
>  	1161  82806AA PCI64 Hub Advanced Programmable Interrupt Controller
>  	1209  82559ER
>  	1221  82092AA_0
> @@ -4565,32 +4568,33 @@
>  	1a21  82840 840 (Carmel) Chipset Host Bridge (Hub A)
>  	1a23  82840 840 (Carmel) Chipset AGP Bridge
>  	1a24  82840 840 (Carmel) Chipset PCI Bridge (Hub B)
> -	2410  82801AA ISA Bridge (LPC)
> -	2411  82801AA IDE
> -	2412  82801AA USB
> -	2413  82801AA SMBus
> -	2415  82801AA AC'97 Audio
> +	2410  82801AA ICH ISA Bridge (LPC)
> +	2411  82801AA ICH IDE
> +	2412  82801AA ICH USB
> +	2413  82801AA ICH SMBus
> +	2415  82801AA ICH AC'97 Audio
>  		11d4 0040  SoundMAX Integrated Digital Audio
>  		11d4 0048  SoundMAX Integrated Digital Audio
>  		11d4 5340  SoundMAX Integrated Digital Audio
> -	2416  82801AA AC'97 Modem
> -	2418  82801AA PCI Bridge
> -	2420  82801AB ISA Bridge (LPC)
> -	2421  82801AB IDE
> -	2422  82801AB USB
> -	2423  82801AB SMBus
> -	2425  82801AB AC'97 Audio
> +	2416  82801AA ICH AC'97 Modem
> +	2418  82801AA ICH PCI Bridge
> +	2420  82801AB ICH0 ISA Bridge (LPC)
> +	2421  82801AB ICH0 IDE
> +	2422  82801AB ICH0 USB
> +	2423  82801AB ICH0 SMBus
> +	2425  82801AB ICH0 AC'97 Audio
>  		11d4 0040  SoundMAX Integrated Digital Audio
>  		11d4 0048  SoundMAX Integrated Digital Audio
> -	2426  82801AB AC'97 Modem
> -	2428  82801AB PCI Bridge
> -	2440  82820 820 (Camino 2) Chipset ISA Bridge (ICH2)
> -	2442  82820 820 (Camino 2) Chipset USB (Hub A)
> -	2443  82820 820 (Camino 2) Chipset SMBus
> -	2444  82820 820 (Camino 2) Chipset USB (Hub B)
> -	2449  82820 820 (Camino 2) Chipset Ethernet
> -	244b  82820 820 (Camino 2) Chipset IDE U100
> -	244e  82820 820 (Camino 2) Chipset PCI
> +	2426  82801AB ICH0 AC'97 Modem
> +	2428  82801AB ICH0 PCI Bridge
> +	2440  82801BA ICH2 ISA Bridge (LPC)
> +	2442  82801BA ICH2 USB (Hub A)
> +	2443  82801BA ICH2 SMBus
> +	2444  82801BA ICH2 USB (Hub B)
> +	2448  82801BAM ICH2-M Hub-PCI Bridge 
> +	2449  82801BA ICH2 Ethernet
> +	244b  82801BA ICH2 IDE U100
> +	244e  82801BA ICH2 Hub-PCI Bridge
>  	2500  82820 820 (Camino) Chipset Host Bridge (MCH)
>  		1043 801c  P3C-2000 system chipset
>  	2501  82820 820 (Camino) Chipset Host Bridge (MCH)
> --- drivers/ide/piix.c	Sat Jan  6 17:51:09 2001
> +++ drivers/ide/piix.c.new	Sat Jan  6 18:05:12 2001
> @@ -108,15 +108,19 @@
>  	c1 = inb_p((unsigned short)bibma + 0x0a);
>  
>  	switch(bmide_dev->device) {
> -		case PCI_DEVICE_ID_INTEL_82820FW_5:
> -			p += sprintf(p, "\n                                Intel PIIX4 Ultra 100 Chipset.\n");
> +		case PCI_DEVICE_ID_INTEL_82801BA_1:
> +			p += sprintf(p, "\n                                Intel ICH2 Ultra 100 Chipset.\n");
>  			break;
> -		case PCI_DEVICE_ID_INTEL_82372FB_1:
>  		case PCI_DEVICE_ID_INTEL_82801AA_1:
> +			p += sprintf(p, "\n                                Intel ICH Ultra 66 Chipset.\n");
> +			break;
> +		case PCI_DEVICE_ID_INTEL_82801AB_1:
> +			p += sprintf(p, "\n                                Intel ICH0 Ultra 33 Chipset.\n");
> +			break;
> +		case PCI_DEVICE_ID_INTEL_82372FB_1:
>  			p += sprintf(p, "\n                                Intel PIIX4 Ultra 66 Chipset.\n");
>  			break;
>  		case PCI_DEVICE_ID_INTEL_82451NX:
> -		case PCI_DEVICE_ID_INTEL_82801AB_1:
>  		case PCI_DEVICE_ID_INTEL_82443MX_1:
>  		case PCI_DEVICE_ID_INTEL_82371AB:
>  			p += sprintf(p, "\n                                Intel PIIX4 Ultra 33 Chipset.\n");
> @@ -358,7 +362,7 @@
>  	byte			speed;
>  
>  	byte udma_66		= eighty_ninty_three(drive);
> -	int ultra100		= ((dev->device == PCI_DEVICE_ID_INTEL_82820FW_5)) ? 1 : 0;
> +	int ultra100		= ((dev->device == PCI_DEVICE_ID_INTEL_82801BA_1)) ? 1 : 0;
>  	int ultra66		= ((ultra100) ||
>  				   (dev->device == PCI_DEVICE_ID_INTEL_82801AA_1) ||
>  				   (dev->device == PCI_DEVICE_ID_INTEL_82372FB_1)) ? 1 : 0;
> --- drivers/ide/ide-pci.c	Sat Jan  6 17:51:09 2001
> +++ drivers/ide/ide-pci.c.new	Sat Jan  6 18:09:18 2001
> @@ -29,12 +29,12 @@
>  #define DEVID_PIIXb	((ide_pci_devid_t){PCI_VENDOR_ID_INTEL,   PCI_DEVICE_ID_INTEL_82371FB_1})
>  #define DEVID_PIIX3	((ide_pci_devid_t){PCI_VENDOR_ID_INTEL,   PCI_DEVICE_ID_INTEL_82371SB_1})
>  #define DEVID_PIIX4	((ide_pci_devid_t){PCI_VENDOR_ID_INTEL,   PCI_DEVICE_ID_INTEL_82371AB})
> -#define DEVID_PIIX4E	((ide_pci_devid_t){PCI_VENDOR_ID_INTEL,   PCI_DEVICE_ID_INTEL_82801AB_1})
> +#define DEVID_ICH0	((ide_pci_devid_t){PCI_VENDOR_ID_INTEL,   PCI_DEVICE_ID_INTEL_82801AB_1})
>  #define DEVID_PIIX4E2	((ide_pci_devid_t){PCI_VENDOR_ID_INTEL,   PCI_DEVICE_ID_INTEL_82443MX_1})
> -#define DEVID_PIIX4U	((ide_pci_devid_t){PCI_VENDOR_ID_INTEL,   PCI_DEVICE_ID_INTEL_82801AA_1})
> +#define DEVID_ICH	((ide_pci_devid_t){PCI_VENDOR_ID_INTEL,   PCI_DEVICE_ID_INTEL_82801AA_1})
>  #define DEVID_PIIX4U2	((ide_pci_devid_t){PCI_VENDOR_ID_INTEL,   PCI_DEVICE_ID_INTEL_82372FB_1})
>  #define DEVID_PIIX4NX	((ide_pci_devid_t){PCI_VENDOR_ID_INTEL,   PCI_DEVICE_ID_INTEL_82451NX})
> -#define DEVID_PIIX4U3	((ide_pci_devid_t){PCI_VENDOR_ID_INTEL,   PCI_DEVICE_ID_INTEL_82820FW_5})
> +#define DEVID_ICH2	((ide_pci_devid_t){PCI_VENDOR_ID_INTEL,   PCI_DEVICE_ID_INTEL_82801BA_1})
>  #define DEVID_VIA_IDE	((ide_pci_devid_t){PCI_VENDOR_ID_VIA,     PCI_DEVICE_ID_VIA_82C561})
>  #define DEVID_VP_IDE	((ide_pci_devid_t){PCI_VENDOR_ID_VIA,     PCI_DEVICE_ID_VIA_82C586_1})
>  #define DEVID_PDC20246	((ide_pci_devid_t){PCI_VENDOR_ID_PROMISE, PCI_DEVICE_ID_PROMISE_20246})
> @@ -337,12 +337,12 @@
>  	{DEVID_PIIXb,	"PIIX",		NULL,		NULL,		INIT_PIIX,	NULL,		{{0x41,0x80,0x80}, {0x43,0x80,0x80}}, 	ON_BOARD,	0 },
>  	{DEVID_PIIX3,	"PIIX3",	PCI_PIIX,	NULL,		INIT_PIIX,	NULL,		{{0x41,0x80,0x80}, {0x43,0x80,0x80}}, 	ON_BOARD,	0 },
>  	{DEVID_PIIX4,	"PIIX4",	PCI_PIIX,	NULL,		INIT_PIIX,	NULL,		{{0x41,0x80,0x80}, {0x43,0x80,0x80}}, 	ON_BOARD,	0 },
> -	{DEVID_PIIX4E,	"PIIX4",	PCI_PIIX,	NULL,		INIT_PIIX,	NULL,		{{0x41,0x80,0x80}, {0x43,0x80,0x80}},	ON_BOARD,	0 },
> +	{DEVID_ICH0,	"ICH0",		PCI_PIIX,	NULL,		INIT_PIIX,	NULL,		{{0x41,0x80,0x80}, {0x43,0x80,0x80}},	ON_BOARD,	0 },
>  	{DEVID_PIIX4E2,	"PIIX4",	PCI_PIIX,	NULL,		INIT_PIIX,	NULL,		{{0x41,0x80,0x80}, {0x43,0x80,0x80}},	ON_BOARD,	0 },
> -	{DEVID_PIIX4U,	"PIIX4",	PCI_PIIX,	ATA66_PIIX,	INIT_PIIX,	NULL,		{{0x41,0x80,0x80}, {0x43,0x80,0x80}},	ON_BOARD,	0 },
> +	{DEVID_ICH,	"ICH",		PCI_PIIX,	ATA66_PIIX,	INIT_PIIX,	NULL,		{{0x41,0x80,0x80}, {0x43,0x80,0x80}},	ON_BOARD,	0 },
>  	{DEVID_PIIX4U2,	"PIIX4",	PCI_PIIX,	ATA66_PIIX,	INIT_PIIX,	NULL,		{{0x41,0x80,0x80}, {0x43,0x80,0x80}},	ON_BOARD,	0 },
>  	{DEVID_PIIX4NX,	"PIIX4",	PCI_PIIX,	NULL,		INIT_PIIX,	NULL,		{{0x41,0x80,0x80}, {0x43,0x80,0x80}},	ON_BOARD,	0 },
> -	{DEVID_PIIX4U3,	"PIIX4",	PCI_PIIX,	ATA66_PIIX,	INIT_PIIX,	NULL,		{{0x41,0x80,0x80}, {0x43,0x80,0x80}},	ON_BOARD,	0 },
> +	{DEVID_ICH2,	"ICH2",		PCI_PIIX,	ATA66_PIIX,	INIT_PIIX,	NULL,		{{0x41,0x80,0x80}, {0x43,0x80,0x80}},	ON_BOARD,	0 },
>  	{DEVID_VIA_IDE,	"VIA_IDE",	NULL,		NULL,		NULL,		NULL,		{{0x00,0x00,0x00}, {0x00,0x00,0x00}},	ON_BOARD,	0 },
>  	{DEVID_VP_IDE,	"VP_IDE",	PCI_VIA82CXXX,	ATA66_VIA82CXXX,INIT_VIA82CXXX,	DMA_VIA82CXXX,	{{0x40,0x02,0x02}, {0x40,0x01,0x01}}, 	ON_BOARD,	0 },
>  	{DEVID_PDC20246,"PDC20246",	PCI_PDC202XX,	NULL,		INIT_PDC202XX,	NULL,		{{0x50,0x02,0x02}, {0x50,0x04,0x04}}, 	OFF_BOARD,	16 },
> 
> -- 
> Peter Denison <peterd@pnd-pc.demon.co.uk>
> Linux Driver for Promise DC4030VL cards.
> See http://www.pnd-pc.demon.co.uk/promise/promise.html for details
> 

Andre Hedrick
Linux ATA Development

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
