Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262149AbVAEO42@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262149AbVAEO42 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jan 2005 09:56:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262396AbVAEO42
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jan 2005 09:56:28 -0500
Received: from mx1.redhat.com ([66.187.233.31]:32921 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262149AbVAEOzr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jan 2005 09:55:47 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <Pine.GSO.4.61.0501051450040.26733@waterleaf.sonytel.be> 
References: <Pine.GSO.4.61.0501051450040.26733@waterleaf.sonytel.be>  <200501050712.j057CSTU032672@hera.kernel.org> 
To: torvalds@osdl.org, akpm@osdl.org,
       Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: [PATCH] FRV: Update banner comments at the top of frv arch files
X-Mailer: MH-E 7.82; nmh 1.0.4; GNU Emacs 21.3.50.1
Date: Wed, 05 Jan 2005 14:54:34 +0000
Message-ID: <29755.1104936874@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The attached patch updates the banner comments at the top of the frv arch
files so that they don't proclaim to be part of the m68k arch and also to
attribute responsibility for them to myself.

Signed-Off-By: David Howells <dhowells@redhat.com>
---
warthog>diffstat frv-comments-2610bk8.diff 
 kernel/process.c       |   18 ++++-----
 kernel/ptrace.c        |   23 ++++--------
 kernel/setup.c         |   23 ++++--------
 kernel/signal.c        |   13 ++++--
 kernel/sys_frv.c       |   14 ++++---
 kernel/time.c          |   16 ++++----
 mb93090-mb00/pci-frv.c |   93 ++++---------------------------------------------
 mm/kmap.c              |   12 ++++--
 8 files changed, 68 insertions(+), 144 deletions(-)

diff -uNrp /warthog/kernels/linux-2.6.10-bk8/arch/frv/kernel/process.c linux-2.6.10-bk8-frv/arch/frv/kernel/process.c
--- /warthog/kernels/linux-2.6.10-bk8/arch/frv/kernel/process.c	2005-01-05 13:21:26.000000000 +0000
+++ linux-2.6.10-bk8-frv/arch/frv/kernel/process.c	2005-01-05 14:39:32.354359656 +0000
@@ -1,15 +1,13 @@
-/*
- *  linux/arch/m68k/kernel/process.c
- *
- *  Copyright (C) 1995  Hamish Macdonald
+/* process.c: FRV specific parts of process handling
  *
- *  68060 fixes by Jesper Skov
+ * Copyright (C) 2003-5 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ * - Derived from arch/m68k/kernel/process.c
  *
- *  uClinux changes Copyright (C) 2000-2002, David McCullough <davidm@snapgear.com>
- */
-
-/*
- * This file handles the architecture-dependent parts of process handling..
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
  */
 
 #include <linux/config.h>
diff -uNrp /warthog/kernels/linux-2.6.10-bk8/arch/frv/kernel/ptrace.c linux-2.6.10-bk8-frv/arch/frv/kernel/ptrace.c
--- /warthog/kernels/linux-2.6.10-bk8/arch/frv/kernel/ptrace.c	2005-01-05 13:21:26.000000000 +0000
+++ linux-2.6.10-bk8-frv/arch/frv/kernel/ptrace.c	2005-01-05 14:40:51.244760904 +0000
@@ -1,13 +1,13 @@
-/*
- *  linux/arch/m68k/kernel/ptrace.c
+/* ptrace.c: FRV specific parts of process tracing
  *
- *  Copyright (C) 1994 by Hamish Macdonald
- *  Taken from linux/kernel/ptrace.c and modified for M680x0.
- *  linux/kernel/ptrace.c is by Ross Biro 1/23/92, edited by Linus Torvalds
+ * Copyright (C) 2003-5 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ * - Derived from arch/m68k/kernel/ptrace.c
  *
- * This file is subject to the terms and conditions of the GNU General
- * Public License.  See the file COPYING in the main directory of
- * this archive for more details.
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
  */
 
 #include <linux/kernel.h>
@@ -33,13 +33,6 @@
  * in exit.c or in signal.c.
  */
 
-/* determines which bits in the SR the user has access to. */
-/* 1 = access 0 = no access */
-#define SR_MASK 0x001f
-
-/* sets the trace bits. */
-#define TRACE_BITS 0x8000
-
 /*
  * Get contents of register REGNO in task TASK.
  */
diff -uNrp /warthog/kernels/linux-2.6.10-bk8/arch/frv/kernel/setup.c linux-2.6.10-bk8-frv/arch/frv/kernel/setup.c
--- /warthog/kernels/linux-2.6.10-bk8/arch/frv/kernel/setup.c	2005-01-05 13:21:26.000000000 +0000
+++ linux-2.6.10-bk8-frv/arch/frv/kernel/setup.c	2005-01-05 14:41:36.661962184 +0000
@@ -1,18 +1,13 @@
-/*
- *  linux/arch/frvnommu/kernel/setup.c
+/* setup.c: FRV specific setup
  *
- *  Copyleft  ()) 2000       James D. Schettine {james@telos-systems.com}
- *  Copyright (C) 1999-2003  Greg Ungerer (gerg@snapgear.com)
- *  Copyright (C) 1998,1999  D. Jeff Dionne <jeff@lineo.ca>
- *  Copyright (C) 1998       Kenneth Albanowski <kjahds@kjahds.com>
- *  Copyright (C) 1995       Hamish Macdonald
- *  Copyright (C) 2000       Lineo Inc. (www.lineo.com)
- *  Copyright (C) 2001 	     Lineo, Inc. <www.lineo.com>
- *  Copyright (C) 2003,2004  David Howells <dhowells@redhat.com>, Red Hat, Inc.
- */
-
-/*
- * This file handles the architecture-dependent parts of system setup
+ * Copyright (C) 2003-5 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ * - Derived from arch/m68k/kernel/setup.c
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
  */
 
 #include <linux/config.h>
diff -uNrp /warthog/kernels/linux-2.6.10-bk8/arch/frv/kernel/signal.c linux-2.6.10-bk8-frv/arch/frv/kernel/signal.c
--- /warthog/kernels/linux-2.6.10-bk8/arch/frv/kernel/signal.c	2005-01-05 13:21:26.000000000 +0000
+++ linux-2.6.10-bk8-frv/arch/frv/kernel/signal.c	2005-01-05 14:42:07.317398219 +0000
@@ -1,10 +1,13 @@
-/*
- *  linux/arch/frvnommu/kernel/signal.c
+/* signal.c: FRV specific bits of signal handling
  *
- *  Copyright (C) 1991, 1992  Linus Torvalds
+ * Copyright (C) 2003-5 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ * - Derived from arch/m68k/kernel/signal.c
  *
- *  1997-11-28  Modified for POSIX.1b signals by Richard Henderson
- *  2000-06-20  Pentium III FXSR, SSE support by Gareth Hughes
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
  */
 
 #include <linux/sched.h>
diff -uNrp /warthog/kernels/linux-2.6.10-bk8/arch/frv/kernel/sys_frv.c linux-2.6.10-bk8-frv/arch/frv/kernel/sys_frv.c
--- /warthog/kernels/linux-2.6.10-bk8/arch/frv/kernel/sys_frv.c	2005-01-05 13:21:26.000000000 +0000
+++ linux-2.6.10-bk8-frv/arch/frv/kernel/sys_frv.c	2005-01-05 14:43:03.281717614 +0000
@@ -1,9 +1,13 @@
-/*
- * linux/arch/frvnommu/kernel/sys_frv.c
+/* sys_frv.c: FRV arch-specific syscall wrappers
+ *
+ * Copyright (C) 2003-5 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ * - Derived from arch/m68k/kernel/sys_m68k.c
  *
- * This file contains various random system calls that
- * have a non-standard calling sequence on the Linux/FRV
- * platform.
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
  */
 
 #include <linux/errno.h>
diff -uNrp /warthog/kernels/linux-2.6.10-bk8/arch/frv/kernel/time.c linux-2.6.10-bk8-frv/arch/frv/kernel/time.c
--- /warthog/kernels/linux-2.6.10-bk8/arch/frv/kernel/time.c	2005-01-05 13:21:26.000000000 +0000
+++ linux-2.6.10-bk8-frv/arch/frv/kernel/time.c	2005-01-05 14:43:44.253291055 +0000
@@ -1,13 +1,13 @@
-/*
- *  linux/arch/m68k/kernel/time.c
- *
- *  Copyright (C) 1991, 1992, 1995  Linus Torvalds
+/* time.c: FRV arch-specific time handling
  *
- * This file contains the m68k-specific time handling details.
- * Most of the stuff is located in the machine specific files.
+ * Copyright (C) 2003-5 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ * - Derived from arch/m68k/kernel/time.c
  *
- * 1997-09-10	Updated NTP code according to technical memorandum Jan '96
- *		"A Kernel Model for Precision Timekeeping" by Dave Mills
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
  */
 
 #include <linux/config.h> /* CONFIG_HEARTBEAT */
diff -uNrp /warthog/kernels/linux-2.6.10-bk8/arch/frv/mb93090-mb00/pci-frv.c linux-2.6.10-bk8-frv/arch/frv/mb93090-mb00/pci-frv.c
--- /warthog/kernels/linux-2.6.10-bk8/arch/frv/mb93090-mb00/pci-frv.c	2005-01-05 13:21:26.000000000 +0000
+++ linux-2.6.10-bk8-frv/arch/frv/mb93090-mb00/pci-frv.c	2005-01-05 14:49:38.027911679 +0000
@@ -1,88 +1,13 @@
-/*
- *	Low-Level PCI Access for FRV machines
- *
- * Copyright 1993, 1994 Drew Eckhardt
- *      Visionary Computing
- *      (Unix and Linux consulting and custom programming)
- *      Drew@Colorado.EDU
- *      +1 (303) 786-7975
- *
- * Drew's work was sponsored by:
- *	iX Multiuser Multitasking Magazine
- *	Hannover, Germany
- *	hm@ix.de
- *
- * Copyright 1997--2000 Martin Mares <mj@ucw.cz>
- *
- * For more information, please consult the following manuals (look at
- * http://www.pcisig.com/ for how to get them):
- *
- * PCI BIOS Specification
- * PCI Local Bus Specification
- * PCI to PCI Bridge Specification
- * PCI System Design Guide
- *
- *
- * CHANGELOG :
- * Jun 17, 1994 : Modified to accommodate the broken pre-PCI BIOS SPECIFICATION
- *	Revision 2.0 present on <thys@dennis.ee.up.ac.za>'s ASUS mainboard.
- *
- * Jan 5,  1995 : Modified to probe PCI hardware at boot time by Frederic
- *     Potter, potter@cao-vlsi.ibp.fr
- *
- * Jan 10, 1995 : Modified to store the information about configured pci
- *      devices into a list, which can be accessed via /proc/pci by
- *      Curtis Varner, cvarner@cs.ucr.edu
- *
- * Jan 12, 1995 : CPU-PCI bridge optimization support by Frederic Potter.
- *	Alpha version. Intel & UMC chipset support only.
- *
- * Apr 16, 1995 : Source merge with the DEC Alpha PCI support. Most of the code
- *	moved to drivers/pci/pci.c.
- *
- * Dec 7, 1996  : Added support for direct configuration access of boards
- *      with Intel compatible access schemes (tsbogend@alpha.franken.de)
- *
- * Feb 3, 1997  : Set internal functions to static, save/restore flags
- *	avoid dead locks reading broken PCI BIOS, werner@suse.de
- *
- * Apr 26, 1997 : Fixed case when there is BIOS32, but not PCI BIOS
- *	(mj@atrey.karlin.mff.cuni.cz)
- *
- * May 7,  1997 : Added some missing cli()'s. [mj]
- *
- * Jun 20, 1997 : Corrected problems in "conf1" type accesses.
- *      (paubert@iram.es)
- *
- * Aug 2,  1997 : Split to PCI BIOS handling and direct PCI access parts
- *	and cleaned it up...     Martin Mares <mj@atrey.karlin.mff.cuni.cz>
- *
- * Feb 6,  1998 : No longer using BIOS to find devices and device classes. [mj]
- *
- * May 1,  1998 : Support for peer host bridges. [mj]
- *
- * Jun 19, 1998 : Changed to use spinlocks, so that PCI configuration space
- *	can be accessed from interrupts even on SMP systems. [mj]
- *
- * August  1998 : Better support for peer host bridges and more paranoid
- *	checks for direct hardware access. Ugh, this file starts to look as
- *	a large gallery of common hardware bug workarounds (watch the comments)
- *	-- the PCI specs themselves are sane, but most implementors should be
- *	hit hard with \hammer scaled \magstep5. [mj]
- *
- * Jan 23, 1999 : More improvements to peer host bridge logic. i450NX fixup. [mj]
- *
- * Feb 8,  1999 : Added UM8886BF I/O address fixup. [mj]
- *
- * August  1999 : New resource management and configuration access stuff. [mj]
- *
- * Sep 19, 1999 : Use PCI IRQ routing tables for detection of peer host bridges.
- *		  Based on ideas by Chris Frantz and David Hinds. [mj]
- *
- * Sep 28, 1999 : Handle unreported/unassigned IRQs. Thanks to Shuu Yamaguchi
- *		  for a lot of patience during testing. [mj]
+/* pci-frv.c: low-level PCI access routines
  *
- * Oct  8, 1999 : Split to pci-i386.c, pci-pc.c and pci-visws.c. [mj]
+ * Copyright (C) 2003-5 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ * - Derived from the i386 equivalent stuff
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
  */
 
 #include <linux/types.h>
diff -uNrp /warthog/kernels/linux-2.6.10-bk8/arch/frv/mm/kmap.c linux-2.6.10-bk8-frv/arch/frv/mm/kmap.c
--- /warthog/kernels/linux-2.6.10-bk8/arch/frv/mm/kmap.c	2005-01-05 13:21:26.000000000 +0000
+++ linux-2.6.10-bk8-frv/arch/frv/mm/kmap.c	2005-01-05 14:47:04.566619375 +0000
@@ -1,7 +1,13 @@
-/*
- *  linux/arch/m68knommu/mm/kmap.c
+/* kmap.c: ioremapping handlers
+ *
+ * Copyright (C) 2003-5 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ * - Derived from arch/m68k/mm/kmap.c
  *
- *  Copyright (C) 2000 Lineo, <davidm@lineo.com>
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
  */
 
 #include <linux/config.h>
