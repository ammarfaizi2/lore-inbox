Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129997AbQKNNrP>; Tue, 14 Nov 2000 08:47:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130414AbQKNNrG>; Tue, 14 Nov 2000 08:47:06 -0500
Received: from linuxcare.com.au ([203.29.91.49]:14084 "EHLO
	front.linuxcare.com.au") by vger.kernel.org with ESMTP
	id <S129997AbQKNNqu>; Tue, 14 Nov 2000 08:46:50 -0500
Message-Id: <200011141314.eAEDEWs01810@wattle.linuxcare.com.au>
To: torvalds@transmeta.com
cc: linux-kernel@vger.kernel.org, Rik van Riel <riel@nl.linux.org>,
        andrew.grover@intel.com, acpi@phobos.fachschaften.tu-muenchen.de
Subject: [MINI PATCH] sysctl values for ACPI and APM
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1807.974207668.1@linuxcare.com.au>
Date: Wed, 15 Nov 2000 00:14:30 +1100
From: Stephen Rothwell <sfr@linuxcare.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Since ACPI is now in the kernel, I figure that its top level
sysctl tag should be in sysctl.h. Also, this patch claims an
tag for APM as I want to add some sysctl's for APM soon.

By the way, is there a "correct" way to claim sysctl tags?

Cheers,
Stephen
-- 
Stephen Rothwell, Open Source Researcher, Linuxcare, Inc.
+61-2-62628990 tel, +61-2-62628991 fax 
sfr@linuxcare.com, http://www.linuxcare.com/ 
Linuxcare. Support for the revolution.

diff -ruN 2.4.0-test11pre4/Documentation/sysctl/README 2.4.0-test11pre4-APM.2/Documentation/sysctl/README
--- 2.4.0-test11pre4/Documentation/sysctl/README	Tue Jul  6 13:04:47 1999
+++ 2.4.0-test11pre4-APM.2/Documentation/sysctl/README	Tue Nov 14 23:36:16 2000
@@ -55,6 +55,8 @@
 by piece basis, or just some 'thematic frobbing'.
 
 The subdirs are about:
+acpi/		Advanced Configuration and Power Interface
+		information and control
 debug/		<empty>
 dev/		device specific information (eg dev/cdrom/info)
 fs/		specific filesystems
diff -ruN 2.4.0-test11pre4/include/linux/acpi.h 2.4.0-test11pre4-APM.2/include/linux/acpi.h
--- 2.4.0-test11pre4/include/linux/acpi.h	Wed Oct  4 10:36:16 2000
+++ 2.4.0-test11pre4-APM.2/include/linux/acpi.h	Tue Nov 14 23:27:10 2000
@@ -208,11 +208,6 @@
 
 enum
 {
-	CTL_ACPI = 10
-};
-
-enum
-{
 	ACPI_FACP = 1,
 	ACPI_DSDT,
 	ACPI_PM1_ENABLE,
diff -ruN 2.4.0-test11pre4/include/linux/sysctl.h 2.4.0-test11pre4-APM.2/include/linux/sysctl.h
--- 2.4.0-test11pre4/include/linux/sysctl.h	Tue Nov 14 23:25:43 2000
+++ 2.4.0-test11pre4-APM.2/include/linux/sysctl.h	Tue Nov 14 23:57:10 2000
@@ -57,7 +57,9 @@
 	CTL_FS=5,		/* Filesystems */
 	CTL_DEBUG=6,		/* Debugging */
 	CTL_DEV=7,		/* Devices */
-	CTL_BUS=8		/* Buses */
+	CTL_BUS=8,		/* Buses */
+	CTL_APM=9,		/* Advanced Power Management */
+	CTL_ACPI=10,		/* Advanced Configuration and Power Interface */
 };
 
 /* CTL_BUS names: */
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
