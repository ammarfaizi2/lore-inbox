Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262120AbTDHWYX (for <rfc822;willy@w.ods.org>); Tue, 8 Apr 2003 18:24:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262180AbTDHWYX (for <rfc822;linux-kernel-outgoing>); Tue, 8 Apr 2003 18:24:23 -0400
Received: from tomts6.bellnexxia.net ([209.226.175.26]:19617 "EHLO
	tomts6-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S262120AbTDHWYW (for <rfc822;linux-kernel@vger.kernel.org>); Tue, 8 Apr 2003 18:24:22 -0400
Date: Tue, 8 Apr 2003 18:31:44 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@dell
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH]  menu fix: move # CPUs option to better location
Message-ID: <Pine.LNX.4.44.0304081828430.15140-100000@dell>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  strictly an aesthetic fix, to move a sub-option directly underneath
its parent option, where it belongs.



diff -Nru linux-2.5.67/arch/i386/Kconfig rday-2.5.67/arch/i386/Kconfig
--- linux-2.5.67/arch/i386/Kconfig	2003-03-24 17:00:07.000000000 -0500
+++ rday-2.5.67/arch/i386/Kconfig	2003-04-05 14:20:36.000000000 -0500
@@ -413,6 +413,18 @@
 
 	  If you don't know what to do here, say N.
 
+config NR_CPUS
+	int "Maximum number of CPUs (2-32)"
+	depends on SMP
+	default "32"
+	help
+	  This allows you to specify the maximum number of CPUs which this
+	  kernel will support.  The maximum supported value is 32 and the
+	  minimum value which makes sense is 2.
+
+	  This is purely to save memory - each supported CPU adds
+	  approximately eight kilobytes to the kernel image.
+
 config PREEMPT
 	bool "Preemptible Kernel"
 	help
@@ -464,18 +476,6 @@
 	depends on !SMP && X86_UP_IOAPIC
 	default y
 
-config NR_CPUS
-	int "Maximum number of CPUs (2-32)"
-	depends on SMP
-	default "32"
-	help
-	  This allows you to specify the maximum number of CPUs which this
-	  kernel will support.  The maximum supported value is 32 and the
-	  minimum value which makes sense is 2.
-
-	  This is purely to save memory - each supported CPU adds
-	  approximately eight kilobytes to the kernel image.
-
 config X86_TSC
 	bool
 	depends on (MWINCHIP3D || MWINCHIP2 || MCRUSOE || MCYRIXIII || MK7 || MK6 || MPENTIUM4 || MPENTIUMIII || MPENTIUMII || M686 || M586MMX || M586TSC || MK8 || MVIAC3_2) && !X86_NUMAQ



