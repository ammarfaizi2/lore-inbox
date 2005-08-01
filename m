Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262212AbVHAPry@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262212AbVHAPry (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Aug 2005 11:47:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262230AbVHAPpt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Aug 2005 11:45:49 -0400
Received: from mo00.iij4u.or.jp ([210.130.0.19]:52471 "EHLO mo00.iij4u.or.jp")
	by vger.kernel.org with ESMTP id S262237AbVHAPnZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Aug 2005 11:43:25 -0400
Date: Tue, 2 Aug 2005 00:43:19 +0900
From: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
To: Andrew Morton <akpm@osdl.org>
Cc: yuasa@hh.iij4u.or.jp, linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] mips: change system type name in proc for vr41xx
Message-Id: <20050802004319.6617e442.yuasa@hh.iij4u.or.jp>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch has changed system type name in proc for vr41xx.
This patch already has been applied to mips tree.
Please apply.

Yoichi

Signed-off-by: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>

diff -urN -X dontdiff git2-orig/arch/mips/Makefile git2/arch/mips/Makefile
--- git2-orig/arch/mips/Makefile	2005-07-29 07:44:44.000000000 +0900
+++ git2/arch/mips/Makefile	2005-07-30 23:06:55.000000000 +0900
@@ -490,13 +490,11 @@
 #
 # ZAO Networks Capcella (VR4131)
 #
-core-$(CONFIG_ZAO_CAPCELLA)	+= arch/mips/vr41xx/zao-capcella/
 load-$(CONFIG_ZAO_CAPCELLA)	+= 0xffffffff80000000
 
 #
 # Victor MP-C303/304 (VR4122)
 #
-core-$(CONFIG_VICTOR_MPC30X)	+= arch/mips/vr41xx/victor-mpc30x/
 load-$(CONFIG_VICTOR_MPC30X)	+= 0xffffffff80001000
 
 #
@@ -514,13 +512,11 @@
 #
 # TANBAC TB0226 Mbase (VR4131)
 #
-core-$(CONFIG_TANBAC_TB0226)	+= arch/mips/vr41xx/tanbac-tb0226/
 load-$(CONFIG_TANBAC_TB0226)	+= 0xffffffff80000000
 
 #
 # TANBAC TB0229 VR4131DIMM (VR4131)
 #
-core-$(CONFIG_TANBAC_TB0229)	+= arch/mips/vr41xx/tanbac-tb0229/
 load-$(CONFIG_TANBAC_TB0229)	+= 0xffffffff80000000
 
 #
diff -urN -X dontdiff git2-orig/arch/mips/vr41xx/casio-e55/setup.c git2/arch/mips/vr41xx/casio-e55/setup.c
--- git2-orig/arch/mips/vr41xx/casio-e55/setup.c	2005-07-29 07:44:44.000000000 +0900
+++ git2/arch/mips/vr41xx/casio-e55/setup.c	2005-07-30 23:06:55.000000000 +0900
@@ -23,11 +23,6 @@
 #include <asm/io.h>
 #include <asm/vr41xx/e55.h>
 
-const char *get_system_type(void)
-{
-	return "CASIO CASSIOPEIA E-11/15/55/65";
-}
-
 static int __init casio_e55_setup(void)
 {
 	set_io_port_base(IO_PORT_BASE);
diff -urN -X dontdiff git2-orig/arch/mips/vr41xx/common/Makefile git2/arch/mips/vr41xx/common/Makefile
--- git2-orig/arch/mips/vr41xx/common/Makefile	2005-07-30 23:27:44.000000000 +0900
+++ git2/arch/mips/vr41xx/common/Makefile	2005-07-30 23:06:55.000000000 +0900
@@ -2,7 +2,7 @@
 # Makefile for common code of the NEC VR4100 series.
 #
 
-obj-y				+= bcu.o cmu.o icu.o init.o int-handler.o irq.o pmu.o
+obj-y				+= bcu.o cmu.o icu.o init.o int-handler.o irq.o pmu.o type.o
 obj-$(CONFIG_VRC4173)		+= vrc4173.o
 
 EXTRA_AFLAGS := $(CFLAGS)
diff -urN -X dontdiff git2-orig/arch/mips/vr41xx/common/type.c git2/arch/mips/vr41xx/common/type.c
--- git2-orig/arch/mips/vr41xx/common/type.c	1970-01-01 09:00:00.000000000 +0900
+++ git2/arch/mips/vr41xx/common/type.c	2005-07-30 23:06:55.000000000 +0900
@@ -0,0 +1,24 @@
+/*
+ *  type.c, System type for NEC VR4100 series.
+ *
+ *  Copyright (C) 2005  Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+
+const char *get_system_type(void)
+{
+	return "NEC VR4100 series";
+}
diff -urN -X dontdiff git2-orig/arch/mips/vr41xx/ibm-workpad/setup.c git2/arch/mips/vr41xx/ibm-workpad/setup.c
--- git2-orig/arch/mips/vr41xx/ibm-workpad/setup.c	2005-07-29 07:44:44.000000000 +0900
+++ git2/arch/mips/vr41xx/ibm-workpad/setup.c	2005-07-30 23:06:55.000000000 +0900
@@ -23,11 +23,6 @@
 #include <asm/io.h>
 #include <asm/vr41xx/workpad.h>
 
-const char *get_system_type(void)
-{
-	return "IBM WorkPad z50";
-}
-
 static int __init ibm_workpad_setup(void)
 {
 	set_io_port_base(IO_PORT_BASE);
diff -urN -X dontdiff git2-orig/arch/mips/vr41xx/nec-cmbvr4133/init.c git2/arch/mips/vr41xx/nec-cmbvr4133/init.c
--- git2-orig/arch/mips/vr41xx/nec-cmbvr4133/init.c	2005-07-29 07:44:44.000000000 +0900
+++ git2/arch/mips/vr41xx/nec-cmbvr4133/init.c	2005-07-30 23:06:55.000000000 +0900
@@ -16,11 +16,6 @@
  * Manish Lachwani (mlachwani@mvista.com)
  */
 #include <linux/config.h>
-#include <linux/init.h>
-#include <linux/kernel.h>
-#include <linux/string.h>
-
-#include <asm/bootinfo.h>
 
 #ifdef CONFIG_ROCKHOPPER
 #include <asm/io.h>
@@ -28,14 +23,7 @@
 
 #define PCICONFDREG	0xaf000c14
 #define PCICONFAREG	0xaf000c18
-#endif
-
-const char *get_system_type(void)
-{
-	return "NEC CMB-VR4133";
-}
 
-#ifdef CONFIG_ROCKHOPPER
 void disable_pcnet(void)
 {
 	u32 data;
diff -urN -X dontdiff git2-orig/arch/mips/vr41xx/tanbac-tb0226/Makefile git2/arch/mips/vr41xx/tanbac-tb0226/Makefile
--- git2-orig/arch/mips/vr41xx/tanbac-tb0226/Makefile	2005-07-29 07:44:44.000000000 +0900
+++ git2/arch/mips/vr41xx/tanbac-tb0226/Makefile	1970-01-01 09:00:00.000000000 +0900
@@ -1,5 +0,0 @@
-#
-# Makefile for the TANBAC TB0226 specific parts of the kernel
-#
-
-obj-y			+= setup.o
diff -urN -X dontdiff git2-orig/arch/mips/vr41xx/tanbac-tb0226/setup.c git2/arch/mips/vr41xx/tanbac-tb0226/setup.c
--- git2-orig/arch/mips/vr41xx/tanbac-tb0226/setup.c	2005-07-29 07:44:44.000000000 +0900
+++ git2/arch/mips/vr41xx/tanbac-tb0226/setup.c	1970-01-01 09:00:00.000000000 +0900
@@ -1,24 +0,0 @@
-/*
- *  setup.c, Setup for the TANBAC TB0226.
- *
- *  Copyright (C) 2002-2005  Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
- */
-
-const char *get_system_type(void)
-{
-	return "TANBAC TB0226";
-}
diff -urN -X dontdiff git2-orig/arch/mips/vr41xx/tanbac-tb0229/Makefile git2/arch/mips/vr41xx/tanbac-tb0229/Makefile
--- git2-orig/arch/mips/vr41xx/tanbac-tb0229/Makefile	2005-07-29 07:44:44.000000000 +0900
+++ git2/arch/mips/vr41xx/tanbac-tb0229/Makefile	1970-01-01 09:00:00.000000000 +0900
@@ -1,5 +0,0 @@
-#
-# Makefile for the TANBAC TB0229(VR4131DIMM) specific parts of the kernel
-#
-
-obj-y				:= setup.o
diff -urN -X dontdiff git2-orig/arch/mips/vr41xx/tanbac-tb0229/setup.c git2/arch/mips/vr41xx/tanbac-tb0229/setup.c
--- git2-orig/arch/mips/vr41xx/tanbac-tb0229/setup.c	2005-07-29 07:44:44.000000000 +0900
+++ git2/arch/mips/vr41xx/tanbac-tb0229/setup.c	1970-01-01 09:00:00.000000000 +0900
@@ -1,27 +0,0 @@
-/*
- *  setup.c, Setup for the TANBAC TB0229 (VR4131DIMM)
- *
- *  Copyright (C) 2002-2005  Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
- *
- *  Modified for TANBAC TB0229:
- *  Copyright (C) 2003  Megasolution Inc.  <matsu@megasolution.jp>
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
- */
-
-const char *get_system_type(void)
-{
-	return "TANBAC TB0229";
-}
diff -urN -X dontdiff git2-orig/arch/mips/vr41xx/victor-mpc30x/Makefile git2/arch/mips/vr41xx/victor-mpc30x/Makefile
--- git2-orig/arch/mips/vr41xx/victor-mpc30x/Makefile	2005-07-29 07:44:44.000000000 +0900
+++ git2/arch/mips/vr41xx/victor-mpc30x/Makefile	1970-01-01 09:00:00.000000000 +0900
@@ -1,5 +0,0 @@
-#
-# Makefile for the Victor MP-C303/304 specific parts of the kernel
-#
-
-obj-y			+= setup.o
diff -urN -X dontdiff git2-orig/arch/mips/vr41xx/victor-mpc30x/setup.c git2/arch/mips/vr41xx/victor-mpc30x/setup.c
--- git2-orig/arch/mips/vr41xx/victor-mpc30x/setup.c	2005-07-29 07:44:44.000000000 +0900
+++ git2/arch/mips/vr41xx/victor-mpc30x/setup.c	1970-01-01 09:00:00.000000000 +0900
@@ -1,24 +0,0 @@
-/*
- *  setup.c, Setup for the Victor MP-C303/304.
- *
- *  Copyright (C) 2002-2005  Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
- */
-
-const char *get_system_type(void)
-{
-	return "Victor MP-C303/304";
-}
diff -urN -X dontdiff git2-orig/arch/mips/vr41xx/zao-capcella/Makefile git2/arch/mips/vr41xx/zao-capcella/Makefile
--- git2-orig/arch/mips/vr41xx/zao-capcella/Makefile	2005-07-29 07:44:44.000000000 +0900
+++ git2/arch/mips/vr41xx/zao-capcella/Makefile	1970-01-01 09:00:00.000000000 +0900
@@ -1,5 +0,0 @@
-#
-# Makefile for the ZAO Networks Capcella  specific parts of the kernel
-#
-
-obj-y			+= setup.o
diff -urN -X dontdiff git2-orig/arch/mips/vr41xx/zao-capcella/setup.c git2/arch/mips/vr41xx/zao-capcella/setup.c
--- git2-orig/arch/mips/vr41xx/zao-capcella/setup.c	2005-07-29 07:44:44.000000000 +0900
+++ git2/arch/mips/vr41xx/zao-capcella/setup.c	1970-01-01 09:00:00.000000000 +0900
@@ -1,24 +0,0 @@
-/*
- *  setup.c, Setup for the ZAO Networks Capcella.
- *
- *  Copyright (C) 2002-2005  Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
- */
-
-const char *get_system_type(void)
-{
-	return "ZAO Networks Capcella";
-}

