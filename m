Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262321AbUBXRlr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 12:41:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262322AbUBXRlr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 12:41:47 -0500
Received: from stat1.steeleye.com ([65.114.3.130]:20417 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S262321AbUBXRlm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 12:41:42 -0500
Subject: [PATCH] fix IRQBALANCE Kconfig dependencies
From: James Bottomley <James.Bottomley@steeleye.com>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       mbligh@aracnet.com
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 24 Feb 2004 11:41:35 -0600
Message-Id: <1077644497.1804.186.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

CONFIG_IRQBALANCE only affects arch/i386/kernel/io_apic.c, so you should
only see it as an option if you actually have one of those.  This patch
makes IRQBALANCE depend on X86_IO_APIC.

James

===== arch/i386/Kconfig 1.101 vs edited =====
--- 1.101/arch/i386/Kconfig	Fri Feb 20 10:57:29 2004
+++ edited/arch/i386/Kconfig	Tue Feb 24 11:36:42 2004
@@ -828,7 +828,7 @@
 
 config IRQBALANCE
  	bool "Enable kernel irq balancing"
-	depends on SMP
+	depends on SMP && X86_IO_APIC
 	default y
 	help
  	  The defalut yes will allow the kernel to do irq load balancing.


