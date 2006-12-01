Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1162238AbWLAXc3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162238AbWLAXc3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 18:32:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162269AbWLAXcO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 18:32:14 -0500
Received: from mx1.suse.de ([195.135.220.2]:39565 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1162270AbWLAXXk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 18:23:40 -0500
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 25/36] Driver core: add dev_archdata to struct device
Date: Fri,  1 Dec 2006 15:21:55 -0800
Message-Id: <11650154071138-git-send-email-greg@kroah.com>
X-Mailer: git-send-email 1.4.4.1
In-Reply-To: <11650154032080-git-send-email-greg@kroah.com>
References: <20061201231620.GA7560@kroah.com> <11650153262399-git-send-email-greg@kroah.com> <11650153293531-git-send-email-greg@kroah.com> <1165015333344-git-send-email-greg@kroah.com> <11650153362310-git-send-email-greg@kroah.com> <11650153392022-git-send-email-greg@kroah.com> <11650153432284-git-send-email-greg@kroah.com> <11650153463092-git-send-email-greg@kroah.com> <1165015349830-git-send-email-greg@kroah.com> <11650153522862-git-send-email-greg@kroah.com> <116501535622-git-send-email-greg@kroah.com> <11650153591876-git-send-email-greg@kroah.com> <11650153631070-git-send-email-greg@kroah.com> <1165015366759-git-send-email-greg@kroah.com> <11650153704007-git-send-email-greg@kroah.com> <11650153733277-git-send-email-greg@kroah.com> <11650153763330-git-send-email-greg@kroah.com> <11650153792132-git-send-email-greg@kroah.com> <11650153833896-git-send-email-greg@kroah.com> <11650153861854-git-send-email-greg@kroah.com> <11650153891878-git-send-email-greg@kroah.com> <11650153
 922117-git-send-email-greg@kroah.com> <11650153961479-git-send-email-greg@kroah.com> <11650154001320-git-send-email-greg@kroah.com> <11650154032080-git-send-email-greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Add arch specific dev_archdata to struct device

Adds an arch specific struct dev_arch to struct device. This enables
architecture to add specific fields to every device in the system, like
DMA operation pointers, NUMA node ID, firmware specific data, etc...

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Acked-by: Andi Kleen <ak@suse.de>
Acked-By: David Howells <dhowells@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 include/asm-alpha/device.h     |    7 +++++++
 include/asm-arm/device.h       |    7 +++++++
 include/asm-arm26/device.h     |    7 +++++++
 include/asm-avr32/device.h     |    7 +++++++
 include/asm-cris/device.h      |    7 +++++++
 include/asm-frv/device.h       |    7 +++++++
 include/asm-generic/device.h   |   12 ++++++++++++
 include/asm-h8300/device.h     |    7 +++++++
 include/asm-i386/device.h      |    7 +++++++
 include/asm-ia64/device.h      |    7 +++++++
 include/asm-m32r/device.h      |    7 +++++++
 include/asm-m68k/device.h      |    7 +++++++
 include/asm-m68knommu/device.h |    7 +++++++
 include/asm-mips/device.h      |    7 +++++++
 include/asm-parisc/device.h    |    7 +++++++
 include/asm-powerpc/device.h   |    7 +++++++
 include/asm-ppc/device.h       |    7 +++++++
 include/asm-s390/device.h      |    7 +++++++
 include/asm-sh/device.h        |    7 +++++++
 include/asm-sh64/device.h      |    7 +++++++
 include/asm-sparc/device.h     |    7 +++++++
 include/asm-sparc64/device.h   |    7 +++++++
 include/asm-um/device.h        |    7 +++++++
 include/asm-v850/device.h      |    7 +++++++
 include/asm-x86_64/device.h    |    7 +++++++
 include/asm-xtensa/device.h    |    7 +++++++
 include/linux/device.h         |    3 +++
 27 files changed, 190 insertions(+), 0 deletions(-)

diff --git a/include/asm-alpha/device.h b/include/asm-alpha/device.h
new file mode 100644
index 0000000..d8f9872
--- /dev/null
+++ b/include/asm-alpha/device.h
@@ -0,0 +1,7 @@
+/*
+ * Arch specific extensions to struct device
+ *
+ * This file is released under the GPLv2
+ */
+#include <asm-generic/device.h>
+
diff --git a/include/asm-arm/device.h b/include/asm-arm/device.h
new file mode 100644
index 0000000..d8f9872
--- /dev/null
+++ b/include/asm-arm/device.h
@@ -0,0 +1,7 @@
+/*
+ * Arch specific extensions to struct device
+ *
+ * This file is released under the GPLv2
+ */
+#include <asm-generic/device.h>
+
diff --git a/include/asm-arm26/device.h b/include/asm-arm26/device.h
new file mode 100644
index 0000000..d8f9872
--- /dev/null
+++ b/include/asm-arm26/device.h
@@ -0,0 +1,7 @@
+/*
+ * Arch specific extensions to struct device
+ *
+ * This file is released under the GPLv2
+ */
+#include <asm-generic/device.h>
+
diff --git a/include/asm-avr32/device.h b/include/asm-avr32/device.h
new file mode 100644
index 0000000..d8f9872
--- /dev/null
+++ b/include/asm-avr32/device.h
@@ -0,0 +1,7 @@
+/*
+ * Arch specific extensions to struct device
+ *
+ * This file is released under the GPLv2
+ */
+#include <asm-generic/device.h>
+
diff --git a/include/asm-cris/device.h b/include/asm-cris/device.h
new file mode 100644
index 0000000..d8f9872
--- /dev/null
+++ b/include/asm-cris/device.h
@@ -0,0 +1,7 @@
+/*
+ * Arch specific extensions to struct device
+ *
+ * This file is released under the GPLv2
+ */
+#include <asm-generic/device.h>
+
diff --git a/include/asm-frv/device.h b/include/asm-frv/device.h
new file mode 100644
index 0000000..d8f9872
--- /dev/null
+++ b/include/asm-frv/device.h
@@ -0,0 +1,7 @@
+/*
+ * Arch specific extensions to struct device
+ *
+ * This file is released under the GPLv2
+ */
+#include <asm-generic/device.h>
+
diff --git a/include/asm-generic/device.h b/include/asm-generic/device.h
new file mode 100644
index 0000000..c17c960
--- /dev/null
+++ b/include/asm-generic/device.h
@@ -0,0 +1,12 @@
+/*
+ * Arch specific extensions to struct device
+ *
+ * This file is released under the GPLv2
+ */
+#ifndef _ASM_GENERIC_DEVICE_H
+#define _ASM_GENERIC_DEVICE_H
+
+struct dev_archdata {
+};
+
+#endif /* _ASM_GENERIC_DEVICE_H */
diff --git a/include/asm-h8300/device.h b/include/asm-h8300/device.h
new file mode 100644
index 0000000..d8f9872
--- /dev/null
+++ b/include/asm-h8300/device.h
@@ -0,0 +1,7 @@
+/*
+ * Arch specific extensions to struct device
+ *
+ * This file is released under the GPLv2
+ */
+#include <asm-generic/device.h>
+
diff --git a/include/asm-i386/device.h b/include/asm-i386/device.h
new file mode 100644
index 0000000..d8f9872
--- /dev/null
+++ b/include/asm-i386/device.h
@@ -0,0 +1,7 @@
+/*
+ * Arch specific extensions to struct device
+ *
+ * This file is released under the GPLv2
+ */
+#include <asm-generic/device.h>
+
diff --git a/include/asm-ia64/device.h b/include/asm-ia64/device.h
new file mode 100644
index 0000000..d8f9872
--- /dev/null
+++ b/include/asm-ia64/device.h
@@ -0,0 +1,7 @@
+/*
+ * Arch specific extensions to struct device
+ *
+ * This file is released under the GPLv2
+ */
+#include <asm-generic/device.h>
+
diff --git a/include/asm-m32r/device.h b/include/asm-m32r/device.h
new file mode 100644
index 0000000..d8f9872
--- /dev/null
+++ b/include/asm-m32r/device.h
@@ -0,0 +1,7 @@
+/*
+ * Arch specific extensions to struct device
+ *
+ * This file is released under the GPLv2
+ */
+#include <asm-generic/device.h>
+
diff --git a/include/asm-m68k/device.h b/include/asm-m68k/device.h
new file mode 100644
index 0000000..d8f9872
--- /dev/null
+++ b/include/asm-m68k/device.h
@@ -0,0 +1,7 @@
+/*
+ * Arch specific extensions to struct device
+ *
+ * This file is released under the GPLv2
+ */
+#include <asm-generic/device.h>
+
diff --git a/include/asm-m68knommu/device.h b/include/asm-m68knommu/device.h
new file mode 100644
index 0000000..d8f9872
--- /dev/null
+++ b/include/asm-m68knommu/device.h
@@ -0,0 +1,7 @@
+/*
+ * Arch specific extensions to struct device
+ *
+ * This file is released under the GPLv2
+ */
+#include <asm-generic/device.h>
+
diff --git a/include/asm-mips/device.h b/include/asm-mips/device.h
new file mode 100644
index 0000000..d8f9872
--- /dev/null
+++ b/include/asm-mips/device.h
@@ -0,0 +1,7 @@
+/*
+ * Arch specific extensions to struct device
+ *
+ * This file is released under the GPLv2
+ */
+#include <asm-generic/device.h>
+
diff --git a/include/asm-parisc/device.h b/include/asm-parisc/device.h
new file mode 100644
index 0000000..d8f9872
--- /dev/null
+++ b/include/asm-parisc/device.h
@@ -0,0 +1,7 @@
+/*
+ * Arch specific extensions to struct device
+ *
+ * This file is released under the GPLv2
+ */
+#include <asm-generic/device.h>
+
diff --git a/include/asm-powerpc/device.h b/include/asm-powerpc/device.h
new file mode 100644
index 0000000..d8f9872
--- /dev/null
+++ b/include/asm-powerpc/device.h
@@ -0,0 +1,7 @@
+/*
+ * Arch specific extensions to struct device
+ *
+ * This file is released under the GPLv2
+ */
+#include <asm-generic/device.h>
+
diff --git a/include/asm-ppc/device.h b/include/asm-ppc/device.h
new file mode 100644
index 0000000..d8f9872
--- /dev/null
+++ b/include/asm-ppc/device.h
@@ -0,0 +1,7 @@
+/*
+ * Arch specific extensions to struct device
+ *
+ * This file is released under the GPLv2
+ */
+#include <asm-generic/device.h>
+
diff --git a/include/asm-s390/device.h b/include/asm-s390/device.h
new file mode 100644
index 0000000..d8f9872
--- /dev/null
+++ b/include/asm-s390/device.h
@@ -0,0 +1,7 @@
+/*
+ * Arch specific extensions to struct device
+ *
+ * This file is released under the GPLv2
+ */
+#include <asm-generic/device.h>
+
diff --git a/include/asm-sh/device.h b/include/asm-sh/device.h
new file mode 100644
index 0000000..d8f9872
--- /dev/null
+++ b/include/asm-sh/device.h
@@ -0,0 +1,7 @@
+/*
+ * Arch specific extensions to struct device
+ *
+ * This file is released under the GPLv2
+ */
+#include <asm-generic/device.h>
+
diff --git a/include/asm-sh64/device.h b/include/asm-sh64/device.h
new file mode 100644
index 0000000..d8f9872
--- /dev/null
+++ b/include/asm-sh64/device.h
@@ -0,0 +1,7 @@
+/*
+ * Arch specific extensions to struct device
+ *
+ * This file is released under the GPLv2
+ */
+#include <asm-generic/device.h>
+
diff --git a/include/asm-sparc/device.h b/include/asm-sparc/device.h
new file mode 100644
index 0000000..d8f9872
--- /dev/null
+++ b/include/asm-sparc/device.h
@@ -0,0 +1,7 @@
+/*
+ * Arch specific extensions to struct device
+ *
+ * This file is released under the GPLv2
+ */
+#include <asm-generic/device.h>
+
diff --git a/include/asm-sparc64/device.h b/include/asm-sparc64/device.h
new file mode 100644
index 0000000..d8f9872
--- /dev/null
+++ b/include/asm-sparc64/device.h
@@ -0,0 +1,7 @@
+/*
+ * Arch specific extensions to struct device
+ *
+ * This file is released under the GPLv2
+ */
+#include <asm-generic/device.h>
+
diff --git a/include/asm-um/device.h b/include/asm-um/device.h
new file mode 100644
index 0000000..d8f9872
--- /dev/null
+++ b/include/asm-um/device.h
@@ -0,0 +1,7 @@
+/*
+ * Arch specific extensions to struct device
+ *
+ * This file is released under the GPLv2
+ */
+#include <asm-generic/device.h>
+
diff --git a/include/asm-v850/device.h b/include/asm-v850/device.h
new file mode 100644
index 0000000..d8f9872
--- /dev/null
+++ b/include/asm-v850/device.h
@@ -0,0 +1,7 @@
+/*
+ * Arch specific extensions to struct device
+ *
+ * This file is released under the GPLv2
+ */
+#include <asm-generic/device.h>
+
diff --git a/include/asm-x86_64/device.h b/include/asm-x86_64/device.h
new file mode 100644
index 0000000..d8f9872
--- /dev/null
+++ b/include/asm-x86_64/device.h
@@ -0,0 +1,7 @@
+/*
+ * Arch specific extensions to struct device
+ *
+ * This file is released under the GPLv2
+ */
+#include <asm-generic/device.h>
+
diff --git a/include/asm-xtensa/device.h b/include/asm-xtensa/device.h
new file mode 100644
index 0000000..d8f9872
--- /dev/null
+++ b/include/asm-xtensa/device.h
@@ -0,0 +1,7 @@
+/*
+ * Arch specific extensions to struct device
+ *
+ * This file is released under the GPLv2
+ */
+#include <asm-generic/device.h>
+
diff --git a/include/linux/device.h b/include/linux/device.h
index 00b29e0..5b54d75 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -21,6 +21,7 @@
 #include <linux/pm.h>
 #include <asm/semaphore.h>
 #include <asm/atomic.h>
+#include <asm/device.h>
 
 #define DEVICE_NAME_SIZE	50
 #define DEVICE_NAME_HALF	__stringify(20)	/* Less than half to accommodate slop */
@@ -383,6 +384,8 @@ struct device {
 
 	struct dma_coherent_mem	*dma_mem; /* internal for coherent mem
 					     override */
+	/* arch specific additions */
+	struct dev_archdata	archdata;
 
 	/* class_device migration path */
 	struct list_head	node;
-- 
1.4.4.1

