Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267480AbTBDVrq>; Tue, 4 Feb 2003 16:47:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267488AbTBDVrq>; Tue, 4 Feb 2003 16:47:46 -0500
Received: from pasky.ji.cz ([62.44.12.54]:24051 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id <S267480AbTBDVrQ>;
	Tue, 4 Feb 2003 16:47:16 -0500
Date: Tue, 4 Feb 2003 22:56:49 +0100
From: Petr Baudis <pasky@ucw.cz>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org, "Randy.Dunlap" <randy.dunlap@verizon.net>
Subject: [PATCH] Updated Documentation/kernel-parameters.txt
Message-ID: <20030204215649.GJ10207@pasky.ji.cz>
Mail-Followup-To: torvalds@transmeta.com, linux-kernel@vger.kernel.org,
	"Randy.Dunlap" <randy.dunlap@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hello,

  this patch (against 2.5.59) updates Documentation/kernel-parameters.txt to
the (more-or-less; I certainly missed some parameters) current state of kernel.
Note also that I will probably send up another update after few further kernel
releases..

  I hope the patch is ok, there should be no problems with it. Please apply.

 Documentation/kernel-parameters.txt |   57 ++++++++++++++++++++++++------------
 1 files changed, 39 insertions(+), 18 deletions(-)

  Kind regards,
				Petr Baudis

--- linux/Documentation/kernel-parameters.txt	Tue Feb  4 15:36:01 2003
+++ linux+pasky/Documentation/kernel-parameters.txt	Tue Feb  4 22:13:05 2003
@@ -1,4 +1,4 @@
-November 2002             Kernel Parameters                     v2.5.49
+February 2003             Kernel Parameters                     v2.5.59
                           ~~~~~~~~~~~~~~~~~
 
 The following is a consolidated list of the kernel parameters as implemented
@@ -60,6 +60,7 @@
 	V4L	Video For Linux support is enabled.
 	VGA	The VGA console has been enabled.
 	VT	Virtual terminal support is enabled.
+	WDT	Watchdog support is enabled.
 	XT	IBM PC/XT MFM hard disk support is enabled.
 
 In addition, the following text indicates that the option:
@@ -98,6 +99,9 @@
 	advansys=	[HW,SCSI]
 			See header of drivers/scsi/advansys.c.
 
+	advwdt=		[HW,WDT] Advantech WDT
+			Format: <iostart>,<iostop>
+
 	aedsp16=	[HW,OSS] Audio Excel DSP 16
 			Format: <io>,<irq>,<dma>,<mss_io>,<mpu_io>,<mpu_irq>
 			See also header of sound/oss/aedsp16.c.
@@ -111,6 +115,9 @@
 	aic7xxx=	[HW,SCSI]
 			See Documentation/scsi/aic7xxx.txt.
 
+	aic79xx=	[HW,SCSI]
+			See Documentation/scsi/aic79xx.txt.
+
 	allowdma0	[ISAPNP]
 
 	AM53C974=	[HW,SCSI]
@@ -230,20 +237,12 @@
 
 	cs89x0_media=	[HW,NET]
 			Format: { rj45 | aui | bnc }
-
-	ctc=		[HW,NET]
-			See drivers/s390/net/ctcmain.c, comment before function
-			ctc_setup().
  
 	cyclades=	[HW,SERIAL] Cyclades multi-serial port adapter.
  
 	dasd=		[HW,NET]    
 			See header of drivers/s390/block/dasd_devmap.c.
 
-	dasd_discipline=
-			[HW,NET]
-			See header of drivers/s390/block/dasd.c.
-
 	db9=		[HW,JOY]
 	db9_2=
 	db9_3=
@@ -254,9 +253,6 @@
 			Format: <area>[,<node>]
 			See also Documentation/networking/decnet.txt.
 
-	decr_overclock= [PPC]
-	decr_overclock_proc0=
-
 	devfs=		[DEVFS]
 			See Documentation/filesystems/devfs/boot-options.
  
@@ -305,6 +301,9 @@
 			This option is obsoleted by the "netdev=" option, which
 			has equivalent usage. See its documentation for details.
 
+	eurwdt=		[HW,WDT] Eurotech CPU-1220/1410 onboard watchdog.
+			Format: <io>[,<irq>]
+
 	fd_mcs=		[HW,SCSI]
 			See header of drivers/scsi/fd_mcs.c.
 
@@ -350,7 +349,7 @@
 	hisax=		[HW,ISDN]
 			See Documentation/isdn/README.HiSax.
 
-	hugepages=	[HW,IA-32] Maximal number of HugeTLB pages
+	hugepages=	[HW,IA-32,IA-64] Maximal number of HugeTLB pages.
 
 	i8042_direct	[HW] Non-translated mode
 	i8042_dumbkbd
@@ -394,6 +393,10 @@
 
 	inttest=	[IA64]
 
+	io7=		[HW] IO7 for Marvel based alpha systems
+			See comment before marvel_specify_io7 in
+			arch/alpha/kernel/core_marvel.c.
+
 	ip=		[IP_PNP]
 			See Documentation/nfsroot.txt.
 
@@ -495,6 +498,7 @@
  
 	mdacon=		[MDA]
 			Format: <first>,<last>
+			Specifies range of consoles to be captured by the MDA.
  
 	mem=exactmap	[KNL,BOOT,IA-32] Enable setting of an exact
 			E820 memory map, as specified by the user.
@@ -576,6 +580,8 @@
  
 	nodisconnect	[HW,SCSI,M68K] Disables SCSI disconnects.
 
+	noexec		[IA-64]
+
 	nofxsr		[BUGS=IA-32]
 
 	nohighio	[BUGS=IA-32] Disable highmem block I/O.
@@ -599,7 +605,9 @@
 
 	noresume	[SWSUSP] Disables resume and restore original swap space.
  
-	no-scroll	[VGA]
+	no-scroll	[VGA] Disables scrollback.
+			This is required for the Braillex ib80-piezo Braille
+			reader made by F.H. Papenmeier (Germany).
 
 	nosbagart	[IA-64]
 
@@ -809,6 +817,9 @@
 			See a comment before function sbpcd_setup() in
 			drivers/cdrom/sbpcd.c.
 
+	sc1200wdt=	[HW,WDT] SC1200 WDT (watchdog) driver
+			Format: <io>[,<timeout>[,<isapnp>]]
+
 	scsi_debug_*=	[SCSI]
 			See drivers/scsi/scsi_debug.c.
 
@@ -997,9 +1008,6 @@
 	spia_pedr=
 	spia_peddr=
 
-	spread_lpevents=
-			[PPC]
-
 	sscape=		[HW,OSS]
 			Format: <io>,<irq>,<dma>,<mpu_io>,<mpu_irq>
  
@@ -1009,6 +1017,19 @@
 	st0x=		[HW,SCSI]
 			See header of drivers/scsi/seagate.c.
 
+	sti=		[HW]
+			Format: <num>
+			Set the STI (builtin display/keyboard on the HP-PARISC
+			machines) console (graphic card) which should be used
+			as the initial boot-console.
+			See also comment in drivers/video/console/sticore.c.
+
+	sti_font=	[HW]
+			See comment in drivers/video/console/sticore.c.
+
+	stifb=		[HW]
+			Format: bpp:<bpp1>[:<bpp2>[:<bpp3>...]]
+
 	stram_swap=	[HW,M68k]
 
 	swiotlb=	[IA-64] Number of I/O TLB slabs
@@ -1079,7 +1100,7 @@
 	wd7000=		[HW,SCSI]
 			See header of drivers/scsi/wd7000.c.
 
-	wdt=		[HW] Watchdog
+	wdt=		[WDT] Watchdog
 			See Documentation/watchdog.txt.
 
 	xd=		[HW,XT] Original XT pre-IDE (RLL encoded) disks.
