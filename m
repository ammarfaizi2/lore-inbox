Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268480AbUHQWLY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268480AbUHQWLY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 18:11:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268478AbUHQWK4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 18:10:56 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:60586 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S268475AbUHQWKh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 18:10:37 -0400
Subject: [PATCH] 2.6.8.1-mm1 - move CONFIG_SCHEDSTATS  to
	arch/ppc64/Kconfig.debug
From: Nathan Lynch <nathanl@austin.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>
Content-Type: text/plain
Message-Id: <1092780837.23599.160.camel@pants.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 17 Aug 2004 17:13:57 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Otherwise it shows up under "iSeries device drivers", which doesn't
seem right.

Signed-off-by: Nathan Lynch <nathanl@austin.ibm.com>


---


diff -puN arch/ppc64/Kconfig~schedstats-to-ppc64-debug-kconfig arch/ppc64/Kconfig
--- 2.6.8.1-mm1/arch/ppc64/Kconfig~schedstats-to-ppc64-debug-kconfig	2004-08-17 17:03:41.000000000 -0500
+++ 2.6.8.1-mm1-nathanl/arch/ppc64/Kconfig	2004-08-17 17:03:41.000000000 -0500
@@ -334,18 +334,6 @@ config VIOTAPE
 	  If you are running Linux on an iSeries system and you want Linux
 	  to read and/or write a tape drive owned by OS/400, say Y here.
 
-config SCHEDSTATS
-	bool "Collect scheduler statistics"
-	depends on DEBUG_KERNEL && PROC_FS
-	help
-	  If you say Y here, additional code will be inserted into the
-	  scheduler and related routines to collect statistics about
-	  scheduler behavior and provide them in /proc/schedstat.  These
-	  stats may be useful for both tuning and debugging the scheduler
-	  If you aren't debugging the scheduler or trying to tune a specific
-	  application, you can say N to avoid the very slight overhead
-	  this adds.
-
 endmenu
 
 config VIOPATH
diff -puN arch/ppc64/Kconfig.debug~schedstats-to-ppc64-debug-kconfig arch/ppc64/Kconfig.debug
--- 2.6.8.1-mm1/arch/ppc64/Kconfig.debug~schedstats-to-ppc64-debug-kconfig	2004-08-17 17:03:41.000000000 -0500
+++ 2.6.8.1-mm1-nathanl/arch/ppc64/Kconfig.debug	2004-08-17 17:03:41.000000000 -0500
@@ -54,4 +54,16 @@ config SPINLINE
 
 	  If in doubt, say N.
 
+config SCHEDSTATS
+	bool "Collect scheduler statistics"
+	depends on DEBUG_KERNEL && PROC_FS
+	help
+	  If you say Y here, additional code will be inserted into the
+	  scheduler and related routines to collect statistics about
+	  scheduler behavior and provide them in /proc/schedstat.  These
+	  stats may be useful for both tuning and debugging the scheduler
+	  If you aren't debugging the scheduler or trying to tune a specific
+	  application, you can say N to avoid the very slight overhead
+	  this adds.
+
 endmenu

_


