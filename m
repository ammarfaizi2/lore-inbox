Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261785AbTH3Omt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Aug 2003 10:42:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261829AbTH3Omt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Aug 2003 10:42:49 -0400
Received: from dsl-hkigw4a35.dial.inet.fi ([80.222.48.53]:27317 "EHLO
	dsl-hkigw4a35.dial.inet.fi") by vger.kernel.org with ESMTP
	id S261785AbTH3Omr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Aug 2003 10:42:47 -0400
Date: Sat, 30 Aug 2003 17:42:45 +0300 (EEST)
From: Petri Koistinen <petri.koistinen@iki.fi>
X-X-Sender: petri@dsl-hkigw4a35.dial.inet.fi
To: trivial@rustcorp.com.au
Cc: linux-kernel@vger.kernel.org
Subject: [TRIVIAL] include/asm-i386/module.h defined() fix
Message-ID: <Pine.LNX.4.56.0308301717480.18600@dsl-hkigw4a35.dial.inet.fi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Take a look at The C Programming Language (2nd ed.) page 91. "The
expression defined(name) in a #if is 1 if the name has been defined, and 0
otherwise." So defined should be used with parenthesis, I think. At least
most of Linux kernel source code is doing so. Ok?

Petri

--- linux-2.5/include/asm-i386/module.h.~1.7.~	2003-02-15 22:24:11.000000000 +0200
+++ linux-2.5/include/asm-i386/module.h	2003-08-30 17:16:06.000000000 +0300
@@ -12,41 +12,41 @@

 #ifdef CONFIG_M386
 #define MODULE_PROC_FAMILY "386 "
-#elif defined CONFIG_M486
+#elif defined(CONFIG_M486)
 #define MODULE_PROC_FAMILY "486 "
-#elif defined CONFIG_M586
+#elif defined(CONFIG_M586)
 #define MODULE_PROC_FAMILY "586 "
-#elif defined CONFIG_M586TSC
+#elif defined(CONFIG_M586TSC)
 #define MODULE_PROC_FAMILY "586TSC "
-#elif defined CONFIG_M586MMX
+#elif defined(CONFIG_M586MMX)
 #define MODULE_PROC_FAMILY "586MMX "
-#elif defined CONFIG_M686
+#elif defined(CONFIG_M686)
 #define MODULE_PROC_FAMILY "686 "
-#elif defined CONFIG_MPENTIUMII
+#elif defined(CONFIG_MPENTIUMII)
 #define MODULE_PROC_FAMILY "PENTIUMII "
-#elif defined CONFIG_MPENTIUMIII
+#elif defined(CONFIG_MPENTIUMIII)
 #define MODULE_PROC_FAMILY "PENTIUMIII "
-#elif defined CONFIG_MPENTIUM4
+#elif defined(CONFIG_MPENTIUM4)
 #define MODULE_PROC_FAMILY "PENTIUM4 "
-#elif defined CONFIG_MK6
+#elif defined(CONFIG_MK6)
 #define MODULE_PROC_FAMILY "K6 "
-#elif defined CONFIG_MK7
+#elif defined(CONFIG_MK7)
 #define MODULE_PROC_FAMILY "K7 "
-#elif defined CONFIG_MK8
+#elif defined(CONFIG_MK8)
 #define MODULE_PROC_FAMILY "K8 "
-#elif defined CONFIG_MELAN
+#elif defined(CONFIG_MELAN)
 #define MODULE_PROC_FAMILY "ELAN "
-#elif defined CONFIG_MCRUSOE
+#elif defined(CONFIG_MCRUSOE)
 #define MODULE_PROC_FAMILY "CRUSOE "
-#elif defined CONFIG_MWINCHIPC6
+#elif defined(CONFIG_MWINCHIPC6)
 #define MODULE_PROC_FAMILY "WINCHIPC6 "
-#elif defined CONFIG_MWINCHIP2
+#elif defined(CONFIG_MWINCHIP2)
 #define MODULE_PROC_FAMILY "WINCHIP2 "
-#elif defined CONFIG_MWINCHIP3D
+#elif defined(CONFIG_MWINCHIP3D)
 #define MODULE_PROC_FAMILY "WINCHIP3D "
-#elif defined CONFIG_MCYRIXIII
+#elif defined(CONFIG_MCYRIXIII)
 #define MODULE_PROC_FAMILY "CYRIXIII "
-#elif CONFIG_MVIAC3_2
+#elif defined(CONFIG_MVIAC3_2)
 #define MODULE_PROC_FAMILY "VIAC3-2 "
 #else
 #error unknown processor family
