Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263652AbTKDFGP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Nov 2003 00:06:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263660AbTKDFGP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Nov 2003 00:06:15 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:12283 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S263652AbTKDFGO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Nov 2003 00:06:14 -0500
Subject: [patch] ppc64 configure option fix
From: Robert Love <rml@mvista.com>
To: linux-kernel@vger.kernel.org
Cc: anton@au.ibm.com
Content-Type: text/plain
Message-Id: <1067922350.17109.41.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Tue, 04 Nov 2003 00:05:51 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Anton.

arch/ppc64/Kconfig's entry for CONFIG_PREEMPT is missing the description
after the "bool" statement, so the entry does not show up.

Also, the help description mentions a restriction that is not [any
longer] true.

Patch against 2.6.0-test9.

	Robert Love


 arch/ppc64/Kconfig |    5 +----
 1 files changed, 1 insertion(+), 4 deletions(-)

diff -urN linux-2.6.0-test9/arch/ppc64/Kconfig linux/arch/ppc64/Kconfig
--- linux-2.6.0-test9/arch/ppc64/Kconfig	2003-10-25 14:43:47.000000000 -0400
+++ linux/arch/ppc64/Kconfig	2003-11-03 23:53:54.000000000 -0500
@@ -113,14 +113,11 @@
 	depends on DISCONTIGMEM
 
 config PREEMPT
-	bool
+	bool "Preemptible Kernel"
 	help
 	  This option reduces the latency of the kernel when reacting to
 	  real-time or interactive events by allowing a low priority process to
 	  be preempted even if it is in kernel mode executing a system call.
-	  Unfortunately the kernel code has some race conditions if both
-	  CONFIG_SMP and CONFIG_PREEMPT are enabled, so this option is
-	  currently disabled if you are building an SMP kernel.
 
 	  Say Y here if you are building a kernel for a desktop, embedded
 	  or real-time system.  Say N if you are unsure.


