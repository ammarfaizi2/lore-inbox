Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751132AbWAPRDn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751132AbWAPRDn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jan 2006 12:03:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751127AbWAPRDn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jan 2006 12:03:43 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:18915 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751125AbWAPRDm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jan 2006 12:03:42 -0500
Subject: PATCH: Remove old firmware headers from rio drivers
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@osdl.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 16 Jan 2006 17:07:54 +0000
Message-Id: <1137431274.15553.46.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.15-git12/drivers/char/rio/rupstat.h linux-2.6.15-git12/drivers/char/rio/rupstat.h
--- linux.vanilla-2.6.15-git12/drivers/char/rio/rupstat.h	2006-01-16 14:19:13.000000000 +0000
+++ linux-2.6.15-git12/drivers/char/rio/rupstat.h	1970-01-01 01:00:00.000000000 +0100
@@ -1,50 +0,0 @@
-/****************************************************************************
- *******                                                              *******
- *******                      RUPSTAT
- *******                                                              *******
- ****************************************************************************
-
- Author  : Jeremy Rolls
- Date    :
-
- *
- *  (C) 1990 - 2000 Specialix International Ltd., Byfleet, Surrey, UK.
- *
- *      This program is free software; you can redistribute it and/or modify
- *      it under the terms of the GNU General Public License as published by
- *      the Free Software Foundation; either version 2 of the License, or
- *      (at your option) any later version.
- *
- *      This program is distributed in the hope that it will be useful,
- *      but WITHOUT ANY WARRANTY; without even the implied warranty of
- *      MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *      GNU General Public License for more details.
- *
- *      You should have received a copy of the GNU General Public License
- *      along with this program; if not, write to the Free Software
- *      Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
-
- Version : 0.01
-
-
-                            Mods
- ----------------------------------------------------------------------------
-  Date     By                Description
- ----------------------------------------------------------------------------
-
- ***************************************************************************/
-
-#ifndef _rupstat_h
-#define _rupstat_h
-
-#ifndef lint
-#ifdef SCCS_LABELS
-static char *_rio_rupstat_h_sccs = "@(#)rupstat.h	1.1";
-#endif
-#endif
-
-#define    STATUS_SYNC    0
-#define    STATUS_REQ_TOP 1
-#define    STATUS_TOPOLOGY    2
-
-#endif
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.15-git12/drivers/char/rio/selftest.h linux-2.6.15-git12/drivers/char/rio/selftest.h
--- linux.vanilla-2.6.15-git12/drivers/char/rio/selftest.h	2006-01-16 14:19:13.000000000 +0000
+++ linux-2.6.15-git12/drivers/char/rio/selftest.h	1970-01-01 01:00:00.000000000 +0100
@@ -1,73 +0,0 @@
-/*
-** File:		selftest.h
-**
-** Author:		David Dix
-**
-** Created:		15th March 1993
-**
-** Last modified:	94/06/14
-**
- *
- *  (C) 1990 - 2000 Specialix International Ltd., Byfleet, Surrey, UK.
- *
- *      This program is free software; you can redistribute it and/or modify
- *      it under the terms of the GNU General Public License as published by
- *      the Free Software Foundation; either version 2 of the License, or
- *      (at your option) any later version.
- *
- *      This program is distributed in the hope that it will be useful,
- *      but WITHOUT ANY WARRANTY; without even the implied warranty of
- *      MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *      GNU General Public License for more details.
- *
- *      You should have received a copy of the GNU General Public License
- *      along with this program; if not, write to the Free Software
- *      Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
-*/
-
-#ifndef	_selftests_h_
-#define _selftests_h_
-
-/*
-** Selftest identifier...
-*/
-#define SELFTEST_MAGIC	0x5a5a
-
-/*
-** This is the structure of the packet that is sent back after each
-** selftest on a booting RTA.
-*/
-typedef struct {
-	short magic;		/* Identifies packet type */
-	int test;		/* Test number, see below */
-	unsigned int result;	/* Result value */
-	unsigned int dataIn;
-	unsigned int dataOut;
-} selftestStruct;
-
-/*
-** The different tests are identified by the following data values.
-*/
-enum test {
-	TESTS_COMPLETE = 0x00,
-	MEMTEST_ADDR = 0x01,
-	MEMTEST_BIT = 0x02,
-	MEMTEST_FILL = 0x03,
-	MEMTEST_DATABUS = 0x04,
-	MEMTEST_ADDRBUS = 0x05,
-	CD1400_INIT = 0x10,
-	CD1400_LOOP = 0x11,
-	CD1400_INTERRUPT = 0x12
-};
-
-enum result {
-	E_PORT = 0x10,
-	E_TX = 0x11,
-	E_RX = 0x12,
-	E_EXCEPT = 0x13,
-	E_COMPARE = 0x14,
-	E_MODEM = 0x15,
-	E_TIMEOUT = 0x16,
-	E_INTERRUPT = 0x17
-};
-#endif				/* _selftests_h_ */
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.15-git12/drivers/char/rio/sysmap.h linux-2.6.15-git12/drivers/char/rio/sysmap.h
--- linux.vanilla-2.6.15-git12/drivers/char/rio/sysmap.h	2006-01-16 14:19:13.000000000 +0000
+++ linux-2.6.15-git12/drivers/char/rio/sysmap.h	1970-01-01 01:00:00.000000000 +0100
@@ -1,62 +0,0 @@
-
-/****************************************************************************
- *******                                                              *******
- *******          S Y S T E M   M A P   H E A D E R
- *******                                                              *******
- ****************************************************************************
-
- Author  : Ian Nandhra
- Date    :
-
- *
- *  (C) 1990 - 2000 Specialix International Ltd., Byfleet, Surrey, UK.
- *
- *      This program is free software; you can redistribute it and/or modify
- *      it under the terms of the GNU General Public License as published by
- *      the Free Software Foundation; either version 2 of the License, or
- *      (at your option) any later version.
- *
- *      This program is distributed in the hope that it will be useful,
- *      but WITHOUT ANY WARRANTY; without even the implied warranty of
- *      MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *      GNU General Public License for more details.
- *
- *      You should have received a copy of the GNU General Public License
- *      along with this program; if not, write to the Free Software
- *      Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
-
- Version : 0.01
-
-
-                            Mods
- ----------------------------------------------------------------------------
-  Date     By                Description
- ----------------------------------------------------------------------------
-
- ***************************************************************************/
-
-#ifndef lint
-#ifdef SCCS_LABELS
-static char *_rio_sysmap_h_sccs = "@(#)sysmap.h	1.1";
-#endif
-#endif
-
-#define SYSTEM_MAP_LEN     64	/* Len of System Map array */
-
-
-typedef struct SYS_MAP SYS_MAP;
-typedef struct SYS_MAP_LINK SYS_MAP_LINK;
-
-struct SYS_MAP_LINK {
-	short id;		/* Unit Id */
-	short link;		/* Id's Link */
-	short been_here;	/* Used by map_gen */
-};
-
-struct SYS_MAP {
-	char serial_num[4];
-	SYS_MAP_LINK link[4];
-};
-
-
-/*********** end of file ***********/
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.15-git12/drivers/char/rio/timeouts.h linux-2.6.15-git12/drivers/char/rio/timeouts.h
--- linux.vanilla-2.6.15-git12/drivers/char/rio/timeouts.h	2006-01-16 14:19:13.000000000 +0000
+++ linux-2.6.15-git12/drivers/char/rio/timeouts.h	1970-01-01 01:00:00.000000000 +0100
@@ -1,50 +0,0 @@
-
-/****************************************************************************
- *******                                                              *******
- *******                     T I M E O U T S
- *******                                                              *******
- ****************************************************************************
-
- Author  : Ian Nandhra
- Date    :
-
- *
- *  (C) 1990 - 2000 Specialix International Ltd., Byfleet, Surrey, UK.
- *
- *      This program is free software; you can redistribute it and/or modify
- *      it under the terms of the GNU General Public License as published by
- *      the Free Software Foundation; either version 2 of the License, or
- *      (at your option) any later version.
- *
- *      This program is distributed in the hope that it will be useful,
- *      but WITHOUT ANY WARRANTY; without even the implied warranty of
- *      MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *      GNU General Public License for more details.
- *
- *      You should have received a copy of the GNU General Public License
- *      along with this program; if not, write to the Free Software
- *      Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
-
- Version : 0.01
-
-
-                            Mods
- ----------------------------------------------------------------------------
-  Date     By                Description
- ----------------------------------------------------------------------------
-
- ***************************************************************************/
-
-#ifndef lint
-#ifdef SCCS_LABELS
-static char *_rio_defaults_h_sccs = "@(#)timeouts.h	1.3";
-#endif
-#endif
-
-#define MILLISECOND           (int) (1000/64)	/* 15.625 low ticks */
-#define SECOND                (int) 15625	/* Low priority ticks */
-
-#define TX_TIMEOUT          (int) (200 * MILLISECOND)
-
-
-/*********** end of file ***********/

