Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132865AbRDQVYX>; Tue, 17 Apr 2001 17:24:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132864AbRDQVYN>; Tue, 17 Apr 2001 17:24:13 -0400
Received: from snark.tuxedo.org ([207.106.50.26]:56337 "EHLO snark.thyrsus.com")
	by vger.kernel.org with ESMTP id <S132863AbRDQVX7>;
	Tue, 17 Apr 2001 17:23:59 -0400
Date: Tue, 17 Apr 2001 17:24:58 -0400
Message-Id: <200104172124.f3HLOw006149@snark.thyrsus.com>
From: "Eric S. Raymond" <esr@snark.thyrsus.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, torvalds@transmeta.com,
        axel@uni-paderborn.de, linux-kernel@vger.kernel.org,
        kbuild-devel@lists.sourceforge.net
Subject: Supplying missing entries for Configure.help, part 1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch supplies sixteen missing entries for the Configure.help
file.  It changes one entry that hadn't caught up to a rename of the
relevant symbol.  More to come...

--- Configure.help	2001/04/17 19:32:34	1.1
+++ Configure.help	2001/04/17 21:11:43
@@ -11889,6 +11889,28 @@
 
   If unsure, say N.
 
+Acorn partition support
+CONFIG_ACORN_PARTITION
+  Support hard disks partitioned under Acorn operating systems.
+
+Native filecore partition support
+CONFIG_ACORN_PARTITION_ADFS
+  The Acorn Disc Filing System is the standard file system of the
+  RiscOS operating system which runs on Acorn's ARM-based Risc PC
+  systems and the Acorn Archimedes range of machines.  If you say
+  `Y' here, Linux will support disk partitions created under ADFS.
+
+PowerTec partition support
+CONFIG_ACORN_PARTITION_POWERTEC
+  Support reading partition tables created on Acorn machines using
+  the PowerTec SCSI drive.
+
+RISCiX partition support
+CONFIG_ACORN_PARTITION_RISCIX
+  Once upon a time, there was a native Unix port for the Acorn series
+  of machines called RISCiX. If you say 'Y' here, Linux will be able to
+  read disks partitioned under RISCiX.
+
 Alpha OSF partition support
 CONFIG_OSF_PARTITION
   Say Y here if you would like to use hard disks under Linux which
@@ -12605,8 +12627,20 @@
 
   If unsure, say Y.
 
+Apple Desktop Bus (ADB) support
+CONFIG_ADB
+  Include support for peripherals connected via the Apple Desktop Bus, ADB.
+
+Include CUDA ADB driver
+CONFIG_ADB_CUDA
+  Macintosh PowerPCs feature an intelligent power switch called a Cuda;
+  its job is to turn system power on and off, manage system resets from
+  various commands, maintain parameter RAM (PRAM), and manage the 
+  real-time clock.  If you say `Y' the Linux kernel will support the 
+  Cuda directly.
+
 Support for PowerMac keyboard
-CONFIG_MAC_KEYBOARD
+CONFIG_ADB_KEYBOARD
   This option allows you to use an ADB keyboard attached to your
   machine. Note that this disables any other (ie. PS/2) keyboard
   support, even if your machine is physically capable of using both at
@@ -13690,6 +13724,16 @@
   The ACPI mailing list may also be of interest:
   http://phobos.fs.tum.de/acpi/index.html
 
+Enable ACPI 2.0 with errata 1.3
+CONFIG_ACPI20
+  Enable support for the 2.0 version of the ACPI interpreter.  See the
+  help for ACPI for caveats and discussion.
+
+ACPI kernel configuration manager
+CONFIG_ACPI_KERNEL_CONFIG
+  If you say `Y' here, Linux's ACPI support will use the hardware-level
+  system descriptions found on IA64 machines.
+
 Advanced Power Management BIOS support
 CONFIG_APM
   APM is a BIOS specification for saving power using several different
@@ -15705,6 +15749,35 @@
   you plan to use this kernel on an Amiga, say Y here and browse the
   material available in Documentation/m68k; otherwise say N.
 
+Commodore A2232 serial support
+CONFIG_A2232
+  This option supports the 2232 7-port serial card shipped with Amiga 3000
+  and other Zorro-bus machines, dating from 1989.  At a max of 19,200 bps, 
+  the ports are served by a 6551 ACIA UART chip each, plus a 8520 CIA, and
+  a master 6502 CPU and buffer as well. The ports were connected with 8 pin
+  DIN connectors on the card bracket, for which 8 pin to DB25 adapters were
+  supplied. The card also had jumpers internally to toggle various pinning
+  configurations.
+
+  This driver is also available as a module ( = code which can be
+  inserted in and removed from the running kernel whenever you want).
+
+A3000 WD33C93A support
+CONFIG_A3000_SCSI
+  Support for the WD33C93A SCSSI controller on the Amiga 3000.
+  This driver is also available as a module ( = code which can be
+  inserted in and removed from the running kernel whenever you want).
+
+A4000T SCSI support
+CONFIG_A4000T_SCSI
+  Support for the NCR53C710 SCSI controller on the Amiga 4000T.
+
+A4091 SCSI support
+CONFIG_A4091_SCSI
+  Support for the NCR53C710 chip on the Amiga 4091 Z3 SCSI2 controller 
+  (1993).  Very obscure -- the 4091 was part of an Amiga 4000 upgrade plan
+  at the time the Amiga business was sold to DKB.
+
 Atari support
 CONFIG_ATARI
   This option enables support for the 68000-based Atari series of
@@ -16824,6 +16897,25 @@
 FBA devices
 CONFIG_DASD_FBA
   FBA devices are currently unsupported.
+
+Support for 3215 line mode terminal
+CONFIG_3215
+  Include support for IBM 3215 line-mode terminals.  Can't be used
+  if 3270 support is compiled in statically.
+
+Support for console on 3215 line mode terminal
+CONFIG_3215_CONSOLE
+  Include support for using an IBM 3215 line-mode terminal as the
+  system console.  Can't be used if 3270 support is compiled in statically.
+
+Support for 3270 line mode terminal
+CONFIG_3270
+  Include support for IBM 3270 line-mode terminals.
+
+Support for console on 3270 line mode terminal
+CONFIG_3270_CONSOLE
+  Include support for using an IBM 3270 line-mode terminal as the
+  system console.  Excludes using 3215s.
 
 SAB3036 tuner support
 CONFIG_TUNER_3036

-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

"If I must write the truth, I am disposed to avoid every assembly 
of bishops; for of no synod have I seen a profitable end, but
rather an addition to than a diminution of evils; for the love 
of strife and the thirst for superiority are beyond the power 
of words to express."
	-- Father Gregory Nazianzen, 381 AD
