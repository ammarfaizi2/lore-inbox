Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423977AbWKIA6X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423977AbWKIA6X (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 19:58:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423960AbWKIA6X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 19:58:23 -0500
Received: from gate.crashing.org ([63.228.1.57]:21652 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1423977AbWKIA6W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 19:58:22 -0500
Subject: [PATCH 1/2] Add dev_sysdata to struct device
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linux Kernel list <linux-kernel@vger.kernel.org>
Cc: Len Brown <len.brown@intel.com>, Andrew Morton <akpm@osdl.org>,
       Greg KH <greg@kroah.com>
Content-Type: text/plain
Date: Thu, 09 Nov 2006 11:58:07 +1100
Message-Id: <1163033887.28571.801.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adds an arch specific struct dev_sysdata to struct device. This enables
architecture to add specific fields to every device in the system, like
DMA operation pointers, NUMA node ID, firmware specific data, etc...

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Index: linux-cell/include/asm-alpha/device.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-cell/include/asm-alpha/device.h	2006-11-09 11:20:28.000000000 +1100
@@ -0,0 +1,14 @@
+/*
+ * Arch specific extensions to struct device
+ *
+ * This file is released under the GPLv2
+ *
+ * See Documentation/driver-model/ for more information.
+ */
+#ifndef _ASM_DEVICE_H
+#define _ASM_DEVICE_H
+
+struct dev_sysdata {
+};
+
+#endif /* _ASM_DEVICE_H */
Index: linux-cell/include/asm-arm/device.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-cell/include/asm-arm/device.h	2006-11-09 11:20:28.000000000 +1100
@@ -0,0 +1,14 @@
+/*
+ * Arch specific extensions to struct device
+ *
+ * This file is released under the GPLv2
+ *
+ * See Documentation/driver-model/ for more information.
+ */
+#ifndef _ASM_DEVICE_H
+#define _ASM_DEVICE_H
+
+struct dev_sysdata {
+};
+
+#endif /* _ASM_DEVICE_H */
Index: linux-cell/include/asm-arm26/device.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-cell/include/asm-arm26/device.h	2006-11-09 11:20:28.000000000 +1100
@@ -0,0 +1,14 @@
+/*
+ * Arch specific extensions to struct device
+ *
+ * This file is released under the GPLv2
+ *
+ * See Documentation/driver-model/ for more information.
+ */
+#ifndef _ASM_DEVICE_H
+#define _ASM_DEVICE_H
+
+struct dev_sysdata {
+};
+
+#endif /* _ASM_DEVICE_H */
Index: linux-cell/include/asm-avr32/device.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-cell/include/asm-avr32/device.h	2006-11-09 11:20:28.000000000 +1100
@@ -0,0 +1,14 @@
+/*
+ * Arch specific extensions to struct device
+ *
+ * This file is released under the GPLv2
+ *
+ * See Documentation/driver-model/ for more information.
+ */
+#ifndef _ASM_DEVICE_H
+#define _ASM_DEVICE_H
+
+struct dev_sysdata {
+};
+
+#endif /* _ASM_DEVICE_H */
Index: linux-cell/include/asm-cris/device.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-cell/include/asm-cris/device.h	2006-11-09 11:20:28.000000000 +1100
@@ -0,0 +1,14 @@
+/*
+ * Arch specific extensions to struct device
+ *
+ * This file is released under the GPLv2
+ *
+ * See Documentation/driver-model/ for more information.
+ */
+#ifndef _ASM_DEVICE_H
+#define _ASM_DEVICE_H
+
+struct dev_sysdata {
+};
+
+#endif /* _ASM_DEVICE_H */
Index: linux-cell/include/asm-frv/device.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-cell/include/asm-frv/device.h	2006-11-09 11:20:28.000000000 +1100
@@ -0,0 +1,14 @@
+/*
+ * Arch specific extensions to struct device
+ *
+ * This file is released under the GPLv2
+ *
+ * See Documentation/driver-model/ for more information.
+ */
+#ifndef _ASM_DEVICE_H
+#define _ASM_DEVICE_H
+
+struct dev_sysdata {
+};
+
+#endif /* _ASM_DEVICE_H */
Index: linux-cell/include/asm-generic/device.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-cell/include/asm-generic/device.h	2006-11-09 11:20:28.000000000 +1100
@@ -0,0 +1,14 @@
+/*
+ * Arch specific extensions to struct device
+ *
+ * This file is released under the GPLv2
+ *
+ * See Documentation/driver-model/ for more information.
+ */
+#ifndef _ASM_DEVICE_H
+#define _ASM_DEVICE_H
+
+struct dev_sysdata {
+};
+
+#endif /* _ASM_DEVICE_H */
Index: linux-cell/include/asm-h8300/device.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-cell/include/asm-h8300/device.h	2006-11-09 11:20:28.000000000 +1100
@@ -0,0 +1,14 @@
+/*
+ * Arch specific extensions to struct device
+ *
+ * This file is released under the GPLv2
+ *
+ * See Documentation/driver-model/ for more information.
+ */
+#ifndef _ASM_DEVICE_H
+#define _ASM_DEVICE_H
+
+struct dev_sysdata {
+};
+
+#endif /* _ASM_DEVICE_H */
Index: linux-cell/include/asm-i386/device.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-cell/include/asm-i386/device.h	2006-11-09 11:20:28.000000000 +1100
@@ -0,0 +1,14 @@
+/*
+ * Arch specific extensions to struct device
+ *
+ * This file is released under the GPLv2
+ *
+ * See Documentation/driver-model/ for more information.
+ */
+#ifndef _ASM_DEVICE_H
+#define _ASM_DEVICE_H
+
+struct dev_sysdata {
+};
+
+#endif /* _ASM_DEVICE_H */
Index: linux-cell/include/asm-ia64/device.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-cell/include/asm-ia64/device.h	2006-11-09 11:20:28.000000000 +1100
@@ -0,0 +1,14 @@
+/*
+ * Arch specific extensions to struct device
+ *
+ * This file is released under the GPLv2
+ *
+ * See Documentation/driver-model/ for more information.
+ */
+#ifndef _ASM_DEVICE_H
+#define _ASM_DEVICE_H
+
+struct dev_sysdata {
+};
+
+#endif /* _ASM_DEVICE_H */
Index: linux-cell/include/asm-m32r/device.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-cell/include/asm-m32r/device.h	2006-11-09 11:20:28.000000000 +1100
@@ -0,0 +1,14 @@
+/*
+ * Arch specific extensions to struct device
+ *
+ * This file is released under the GPLv2
+ *
+ * See Documentation/driver-model/ for more information.
+ */
+#ifndef _ASM_DEVICE_H
+#define _ASM_DEVICE_H
+
+struct dev_sysdata {
+};
+
+#endif /* _ASM_DEVICE_H */
Index: linux-cell/include/asm-m68k/device.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-cell/include/asm-m68k/device.h	2006-11-09 11:20:28.000000000 +1100
@@ -0,0 +1,14 @@
+/*
+ * Arch specific extensions to struct device
+ *
+ * This file is released under the GPLv2
+ *
+ * See Documentation/driver-model/ for more information.
+ */
+#ifndef _ASM_DEVICE_H
+#define _ASM_DEVICE_H
+
+struct dev_sysdata {
+};
+
+#endif /* _ASM_DEVICE_H */
Index: linux-cell/include/asm-m68knommu/device.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-cell/include/asm-m68knommu/device.h	2006-11-09 11:20:29.000000000 +1100
@@ -0,0 +1,14 @@
+/*
+ * Arch specific extensions to struct device
+ *
+ * This file is released under the GPLv2
+ *
+ * See Documentation/driver-model/ for more information.
+ */
+#ifndef _ASM_DEVICE_H
+#define _ASM_DEVICE_H
+
+struct dev_sysdata {
+};
+
+#endif /* _ASM_DEVICE_H */
Index: linux-cell/include/asm-mips/device.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-cell/include/asm-mips/device.h	2006-11-09 11:20:29.000000000 +1100
@@ -0,0 +1,14 @@
+/*
+ * Arch specific extensions to struct device
+ *
+ * This file is released under the GPLv2
+ *
+ * See Documentation/driver-model/ for more information.
+ */
+#ifndef _ASM_DEVICE_H
+#define _ASM_DEVICE_H
+
+struct dev_sysdata {
+};
+
+#endif /* _ASM_DEVICE_H */
Index: linux-cell/include/asm-parisc/device.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-cell/include/asm-parisc/device.h	2006-11-09 11:20:29.000000000 +1100
@@ -0,0 +1,14 @@
+/*
+ * Arch specific extensions to struct device
+ *
+ * This file is released under the GPLv2
+ *
+ * See Documentation/driver-model/ for more information.
+ */
+#ifndef _ASM_DEVICE_H
+#define _ASM_DEVICE_H
+
+struct dev_sysdata {
+};
+
+#endif /* _ASM_DEVICE_H */
Index: linux-cell/include/asm-powerpc/device.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-cell/include/asm-powerpc/device.h	2006-11-09 11:20:29.000000000 +1100
@@ -0,0 +1,14 @@
+/*
+ * Arch specific extensions to struct device
+ *
+ * This file is released under the GPLv2
+ *
+ * See Documentation/driver-model/ for more information.
+ */
+#ifndef _ASM_DEVICE_H
+#define _ASM_DEVICE_H
+
+struct dev_sysdata {
+};
+
+#endif /* _ASM_DEVICE_H */
Index: linux-cell/include/asm-ppc/device.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-cell/include/asm-ppc/device.h	2006-11-09 11:20:29.000000000 +1100
@@ -0,0 +1,14 @@
+/*
+ * Arch specific extensions to struct device
+ *
+ * This file is released under the GPLv2
+ *
+ * See Documentation/driver-model/ for more information.
+ */
+#ifndef _ASM_DEVICE_H
+#define _ASM_DEVICE_H
+
+struct dev_sysdata {
+};
+
+#endif /* _ASM_DEVICE_H */
Index: linux-cell/include/asm-s390/device.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-cell/include/asm-s390/device.h	2006-11-09 11:20:29.000000000 +1100
@@ -0,0 +1,14 @@
+/*
+ * Arch specific extensions to struct device
+ *
+ * This file is released under the GPLv2
+ *
+ * See Documentation/driver-model/ for more information.
+ */
+#ifndef _ASM_DEVICE_H
+#define _ASM_DEVICE_H
+
+struct dev_sysdata {
+};
+
+#endif /* _ASM_DEVICE_H */
Index: linux-cell/include/asm-sh/device.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-cell/include/asm-sh/device.h	2006-11-09 11:20:29.000000000 +1100
@@ -0,0 +1,14 @@
+/*
+ * Arch specific extensions to struct device
+ *
+ * This file is released under the GPLv2
+ *
+ * See Documentation/driver-model/ for more information.
+ */
+#ifndef _ASM_DEVICE_H
+#define _ASM_DEVICE_H
+
+struct dev_sysdata {
+};
+
+#endif /* _ASM_DEVICE_H */
Index: linux-cell/include/asm-sh64/device.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-cell/include/asm-sh64/device.h	2006-11-09 11:20:29.000000000 +1100
@@ -0,0 +1,14 @@
+/*
+ * Arch specific extensions to struct device
+ *
+ * This file is released under the GPLv2
+ *
+ * See Documentation/driver-model/ for more information.
+ */
+#ifndef _ASM_DEVICE_H
+#define _ASM_DEVICE_H
+
+struct dev_sysdata {
+};
+
+#endif /* _ASM_DEVICE_H */
Index: linux-cell/include/asm-sparc/device.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-cell/include/asm-sparc/device.h	2006-11-09 11:20:29.000000000 +1100
@@ -0,0 +1,14 @@
+/*
+ * Arch specific extensions to struct device
+ *
+ * This file is released under the GPLv2
+ *
+ * See Documentation/driver-model/ for more information.
+ */
+#ifndef _ASM_DEVICE_H
+#define _ASM_DEVICE_H
+
+struct dev_sysdata {
+};
+
+#endif /* _ASM_DEVICE_H */
Index: linux-cell/include/asm-sparc64/device.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-cell/include/asm-sparc64/device.h	2006-11-09 11:20:29.000000000 +1100
@@ -0,0 +1,14 @@
+/*
+ * Arch specific extensions to struct device
+ *
+ * This file is released under the GPLv2
+ *
+ * See Documentation/driver-model/ for more information.
+ */
+#ifndef _ASM_DEVICE_H
+#define _ASM_DEVICE_H
+
+struct dev_sysdata {
+};
+
+#endif /* _ASM_DEVICE_H */
Index: linux-cell/include/asm-um/device.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-cell/include/asm-um/device.h	2006-11-09 11:20:29.000000000 +1100
@@ -0,0 +1,14 @@
+/*
+ * Arch specific extensions to struct device
+ *
+ * This file is released under the GPLv2
+ *
+ * See Documentation/driver-model/ for more information.
+ */
+#ifndef _ASM_DEVICE_H
+#define _ASM_DEVICE_H
+
+struct dev_sysdata {
+};
+
+#endif /* _ASM_DEVICE_H */
Index: linux-cell/include/asm-v850/device.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-cell/include/asm-v850/device.h	2006-11-09 11:20:29.000000000 +1100
@@ -0,0 +1,14 @@
+/*
+ * Arch specific extensions to struct device
+ *
+ * This file is released under the GPLv2
+ *
+ * See Documentation/driver-model/ for more information.
+ */
+#ifndef _ASM_DEVICE_H
+#define _ASM_DEVICE_H
+
+struct dev_sysdata {
+};
+
+#endif /* _ASM_DEVICE_H */
Index: linux-cell/include/asm-x86_64/device.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-cell/include/asm-x86_64/device.h	2006-11-09 11:20:29.000000000 +1100
@@ -0,0 +1,14 @@
+/*
+ * Arch specific extensions to struct device
+ *
+ * This file is released under the GPLv2
+ *
+ * See Documentation/driver-model/ for more information.
+ */
+#ifndef _ASM_DEVICE_H
+#define _ASM_DEVICE_H
+
+struct dev_sysdata {
+};
+
+#endif /* _ASM_DEVICE_H */
Index: linux-cell/include/asm-xtensa/device.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-cell/include/asm-xtensa/device.h	2006-11-09 11:20:29.000000000 +1100
@@ -0,0 +1,14 @@
+/*
+ * Arch specific extensions to struct device
+ *
+ * This file is released under the GPLv2
+ *
+ * See Documentation/driver-model/ for more information.
+ */
+#ifndef _ASM_DEVICE_H
+#define _ASM_DEVICE_H
+
+struct dev_sysdata {
+};
+
+#endif /* _ASM_DEVICE_H */
Index: linux-cell/include/linux/device.h
===================================================================
--- linux-cell.orig/include/linux/device.h	2006-11-08 15:09:35.000000000 +1100
+++ linux-cell/include/linux/device.h	2006-11-09 11:17:36.000000000 +1100
@@ -21,6 +21,7 @@
 #include <linux/pm.h>
 #include <asm/semaphore.h>
 #include <asm/atomic.h>
+#include <asm/device.h>
 
 #define DEVICE_NAME_SIZE	50
 #define DEVICE_NAME_HALF	__stringify(20)	/* Less than half to accommodate slop */
@@ -382,6 +383,8 @@ struct device {
 
 	struct dma_coherent_mem	*dma_mem; /* internal for coherent mem
 					     override */
+	/* arch specific additions */
+	struct dev_sysdata	sysdata;
 
 	/* class_device migration path */
 	struct list_head	node;


