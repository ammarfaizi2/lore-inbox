Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263571AbSJREoU>; Fri, 18 Oct 2002 00:44:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263211AbSJREnM>; Fri, 18 Oct 2002 00:43:12 -0400
Received: from out002pub.verizon.net ([206.46.170.141]:18875 "EHLO
	out002.verizon.net") by vger.kernel.org with ESMTP
	id <S262914AbSJREmd>; Fri, 18 Oct 2002 00:42:33 -0400
Message-ID: <3DAF926A.F9BA759F@verizon.net>
Date: Thu, 17 Oct 2002 21:47:38 -0700
From: "Randy.Dunlap" <randy.dunlap@verizon.net>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: [PATCH] 2.5.43: more kernel-parameters updates
Content-Type: multipart/mixed;
 boundary="------------A29991F0A991A1D2604C23D2"
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at out002.verizon.net from [4.64.197.173] at Thu, 17 Oct 2002 23:48:27 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------A29991F0A991A1D2604C23D2
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hi,

I have more kernel-parameters updates for you
(and more yet to do).

Please apply to 2.5.43.

~Randy
--------------A29991F0A991A1D2604C23D2
Content-Type: text/plain; charset=us-ascii;
 name="kernprms-2543.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="kernprms-2543.patch"

--- ./Documentation/kernel-parameters.txt.2543	Tue Oct 15 20:29:07 2002
+++ ./Documentation/kernel-parameters.txt	Thu Oct 17 21:40:18 2002
@@ -1,4 +1,4 @@
-July 2000		  Kernel Parameters			v2.4.0
+October 2002		  Kernel Parameters			v2.5.0
 			  ~~~~~~~~~~~~~~~~~
 
 The following is a consolidated list of the kernel parameters as implemented
@@ -105,6 +105,10 @@
 
 	atascsi=	[HW,SCSI] Atari SCSI.
 
+	atkbd_set=	[HW] select keyboard code set
+
+	atkbd_reset	[HW] reset keyboard during initialization
+
 	awe=            [HW,SOUND]
  
 	aztcd=		[HW,CD] Aztec CD driver.
@@ -238,6 +242,19 @@
 
 	hisax=		[HW,ISDN]
 
+	i8042_direct	[HW] non-translated mode
+
+	i8042_dumbkbd	[HW]
+
+	i8042_noaux	[HW]
+
+	i8042_nomux	[HW]
+
+	i8042_reset	[HW] reset the 8042 controller during init
+			and cleanup
+
+	i8042_unlock	[HW] unlock (ignore) the keylock
+
 	i810=		[HW,DRM]
 
 	ibmmcascsi=	[HW,MCA,SCSI] IBM MicroChannel SCSI adapter.
@@ -258,8 +275,12 @@
 
 	initrd=		[BOOT] Specify the location of the initial ramdisk. 
 
+	inport_irq=	[HW,MOUSE] set inport busmouse IRQ
+
 	ip=		[IP_PNP]
 
+	ip2=		[HW] set IO/IRQ pairs for up to 4 IntelliPort boards
+
 	isapnp=		[ISAPNP] Specify RDP, reset, pci_scan and verbosity.
 
 	isapnp_reserve_irq= [ISAPNP] Exclude IRQs for the autoconfiguration.
@@ -280,7 +301,7 @@
  
 	kbd-reset	[VT]
 
-	keepinitrd	[HW, ARM]
+	keepinitrd	[HW,ARM]
 
 	load_ramdisk=	[RAM] List of ramdisks to load from floppy.
 
@@ -288,7 +309,9 @@
 
 	lockd.tcpport=	[NFS]
 
-	logi_busmouse=	[HW, MOUSE]
+	logi_busmouse=	[HW,MOUSE]
+
+	logibm_irq=	[HW,MOUSE] set mouse IRQ
 
 	lp=0		[LP]	Specify parallel ports to use, e.g,
 	lp=port[,port...]	lp=none,parport0 (lp0 not configured, lp1 uses
@@ -356,6 +379,8 @@
 	mem=nopentium	[BUGS=IA-32] Disable usage of 4MB pages for kernel
 			memory.
 
+	meye=		[HW] set MotionEye Camera parameters
+
 	mga=		[HW,DRM]
 
 	mpu401=		[HW,SOUND]
@@ -393,12 +418,12 @@
 	noapic		[SMP,APIC] Tells the kernel not to make use of any
 			APIC that may be present on the system.
 
-	noasync		[HW, M68K] Disables async and sync negotiation for
+	noasync		[HW,M68K] Disables async and sync negotiation for
 			all devices.
 
 	nocache		[ARM]
  
-	nodisconnect	[HW,SCSI, M68K] Disables SCSI disconnects.
+	nodisconnect	[HW,SCSI,M68K] Disables SCSI disconnects.
 
 	nohlt		[BUGS=ARM]
  
@@ -421,10 +446,12 @@
 
 	nosmp		[SMP] Tells an SMP kernel to act as a UP kernel.
 
-	nosync		[HW, M68K] Disables sync negotiation for all devices.
+	nosync		[HW,M68K] Disables sync negotiation for all devices.
 
 	notsc           [BUGS=IA-32] Disable Time Stamp Counter
 
+	nousb		[HW] disable USB subsystem
+
 	nowb		[ARM]
  
 	opl3=		[HW,SOUND]
@@ -503,6 +530,8 @@
 					have no effect if ACPI IRQ routing is
 					enabled.
 
+	pcmv=		[HW] BadgePad 4 PCMCIA parameters
+
 	pd.		[PARIDE]
 
 	pf.		[PARIDE]
@@ -519,6 +548,8 @@
 	prompt_ramdisk=	[RAM] List of RAM disks to prompt for floppy disk
 			before loading.
 
+	psmouse_noext	[HW,MOUSE] prevent probing for PS/2 mouse extensions
+
 	pss=		[HW,SOUND] 
  
 	pt.		[PARIDE]
@@ -567,6 +598,8 @@
 
 	scsihosts=	[SCSI]
 
+	sf16fm=		[HW] set IO address
+
 	sg_def_reserved_size=
 			[SCSI]
  
@@ -582,6 +615,9 @@
  
 	sonycd535=	[HW,CD]
 
+	sonypi=		[HW] set parameters for Sony Programmable
+			I/O Control Device
+
 	sound=		[SOUND]
 
 	soundmodem=	[HW,AX25,SOUND] Use sound card as packet radio modem.
@@ -598,7 +634,7 @@
 
 	swiotlb=        [IA-64] Number of I/O TLB slabs.
  
-	switches=	[HW, M68K]
+	switches=	[HW,M68K]
 
 	sym53c416=	[HW,SCSI]
 
@@ -614,6 +650,8 @@
 
 	tgfx_3=		[HW,JOY]
  
+ 	tiusb=		[HW] set timeout for TI USB GraphLink
+
 	tmc8xx=		[HW,SCSI]
 
 	tmscsim=	[HW,SCSI]

--------------A29991F0A991A1D2604C23D2--

