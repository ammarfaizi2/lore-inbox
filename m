Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262349AbSJOEbP>; Tue, 15 Oct 2002 00:31:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262355AbSJOEbP>; Tue, 15 Oct 2002 00:31:15 -0400
Received: from out001pub.verizon.net ([206.46.170.140]:11003 "EHLO
	out001.verizon.net") by vger.kernel.org with ESMTP
	id <S262349AbSJOEbO>; Tue, 15 Oct 2002 00:31:14 -0400
Message-ID: <3DAB9B42.FBDE93C7@verizon.net>
Date: Mon, 14 Oct 2002 21:36:18 -0700
From: "Randy.Dunlap" <randy.dunlap@verizon.net>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: [PATCH] 2.5.42 Doc/kernel-parameters
Content-Type: multipart/mixed;
 boundary="------------D97A79D0C6B70020D9C2C9A1"
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at out001.verizon.net from [4.64.197.173] at Mon, 14 Oct 2002 23:37:02 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------D97A79D0C6B70020D9C2C9A1
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hi,

Please apply to 2.5.42.
Updates/corrects Documentation/kernel-parameters.txt file.

Thanks,
~Randy
--------------D97A79D0C6B70020D9C2C9A1
Content-Type: text/plain; charset=us-ascii;
 name="kernprms-2542.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="kernprms-2542.patch"

--- ./Documentation/kernel-parameters.txt.2542	Fri Oct 11 21:22:47 2002
+++ ./Documentation/kernel-parameters.txt	Mon Oct 14 21:27:45 2002
@@ -23,6 +23,7 @@
 	HW	Appropriate hardware is enabled.
 	IA-32	IA-32 aka i386 architecture is enabled.
 	IA-64	IA-64 architecture is enabled.
+	IP_PNP	IP DCHP, BOOTP, or RARP is enabled.
 	ISAPNP  ISA PnP code is enabled.
 	ISDN	Appropriate ISDN support is enabled.
 	JOY 	Appropriate joystick support is enabled.
@@ -257,7 +258,7 @@
 
 	initrd=		[BOOT] Specify the location of the initial ramdisk. 
 
-	ip=		[PNP]
+	ip=		[IP_PNP]
 
 	isapnp=		[ISAPNP] Specify RDP, reset, pci_scan and verbosity.
 
@@ -279,10 +280,14 @@
  
 	kbd-reset	[VT]
 
-	keep_initrd	[HW, ARM]
+	keepinitrd	[HW, ARM]
 
 	load_ramdisk=	[RAM] List of ramdisks to load from floppy.
 
+	lockd.udpport=	[NFS]
+
+	lockd.tcpport=	[NFS]
+
 	logi_busmouse=	[HW, MOUSE]
 
 	lp=0		[LP]	Specify parallel ports to use, e.g,
@@ -323,6 +328,8 @@
 				to off as the mainboard support is not always present.
 				You must activate it as a boot option
 
+	mca-pentium	[BUGS=IA-32]
+
 	mcd=		[HW,CD]
 
 	mcdx=		[HW,CD]
@@ -335,6 +342,11 @@
 
 	megaraid=	[HW,SCSI]
  
+	mem=exactmap	[KNL,BOOT,IA-32] enable setting of an exact
+			e820 memory map, as specified by the user.
+			Such mem=exactmap lines can be constructed
+			based on BIOS output or other requirements.
+
 	mem=nn[KMG]	[KNL,BOOT] force use of a specific amount of
 			memory; to be used when the kernel is not able
 			to see the whole system memory or for test.
@@ -390,7 +402,9 @@
 
 	nohlt		[BUGS=ARM]
  
-	no-hlt		[BUGS=IA-32]
+	no-hlt		[BUGS=IA-32] Tells the kernel that the hlt
+			instruction doesn't work correctly and not to
+			use it.
 
 	noht		[SMP,IA-32] Disables P4 Xeon(tm) HyperThreading.
 
@@ -536,6 +550,10 @@
 	ro		[KNL] Mount root device read-only on boot.
 
 	root=		[KNL] root filesystem.
+
+	rootflags=	[KNL] set root filesystem mount option string
+
+	rootfstype=	[KNL] set root filesystem type
 
 	rw		[KNL] Mount root device read-write on boot.
 

--------------D97A79D0C6B70020D9C2C9A1--

