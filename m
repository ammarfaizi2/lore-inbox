Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263780AbTDGWxd (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 18:53:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263774AbTDGWwF (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 18:52:05 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:42368
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S263762AbTDGWve (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 7 Apr 2003 18:51:34 -0400
Date: Tue, 8 Apr 2003 01:10:25 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200304080010.h380AP7D008961@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: PATCH: compatmac not needed uaccess.h is
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Fixes unknown symbol copy_.. in some builds
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.67/drivers/acpi/processor.c linux-2.5.67-ac1/drivers/acpi/processor.c
--- linux-2.5.67/drivers/acpi/processor.c	2003-04-08 00:37:35.000000000 +0100
+++ linux-2.5.67-ac1/drivers/acpi/processor.c	2003-04-04 01:03:11.000000000 +0100
@@ -36,13 +36,13 @@
 #include <linux/pci.h>
 #include <linux/pm.h>
 #include <linux/cpufreq.h>
-#include <linux/compatmac.h>
 #include <linux/proc_fs.h>
 #include <linux/seq_file.h>
 
 #include <asm/io.h>
 #include <asm/system.h>
 #include <asm/delay.h>
+#include <asm/uaccess.h>
 
 #include <acpi/acpi_bus.h>
 #include <acpi/acpi_drivers.h>
