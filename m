Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265815AbSL3BwR>; Sun, 29 Dec 2002 20:52:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265819AbSL3BwR>; Sun, 29 Dec 2002 20:52:17 -0500
Received: from verein.lst.de ([212.34.181.86]:26380 "EHLO verein.lst.de")
	by vger.kernel.org with ESMTP id <S265815AbSL3BwQ>;
	Sun, 29 Dec 2002 20:52:16 -0500
Date: Mon, 30 Dec 2002 03:00:35 +0100
From: Christoph Hellwig <hch@lst.de>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] clean up subarchitecture selection
Message-ID: <20021230030035.A13575@lst.de>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>, torvalds@transmeta.com,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

shorter and/or more descriptive choice names, add a full (tho still
commented out entry) for the visw, based on the 2.4 Configure.help
entry.

--- 1.21/arch/i386/Kconfig	Sun Dec 29 19:45:51 2002
+++ edited/arch/i386/Kconfig	Mon Dec 30 02:03:34 2002
@@ -43,13 +43,13 @@
 	default PC
 
 config PC
-	bool PC
+	bool "IBM PC (and compatible)"
 	help
 	  Choose this option if your computer is a standard PC or compatible.
 
 config VOYAGER
-	bool "NCR Voyager Architecture"
-	---help---
+	bool "NCR Voyager"
+	help
 	  Voyager is a MCA based 32 way capable SMP architecture proprietary
 	  to NCR Corp.  Machine classes 345x/35xx/4100/51xx are voyager based.
 	  
@@ -59,7 +59,7 @@
 	  say N here otherwise the kernel you build will not be bootable.
 
 config X86_NUMAQ
-	bool "Multiquad (IBM/Sequent) NUMAQ support"
+	bool "IBM/Sequent NUMAQ"
 	help
 	  This option is used for getting Linux to run on a (IBM/Sequent) NUMA 
 	  multiquad box. This changes the way that processors are bootstrapped,
@@ -68,7 +68,7 @@
 	  email to Martin.Bligh@us.ibm.com
 
 config X86_SUMMIT
-	bool "IBM x440 (Summit/EXA) support"
+	bool "IBM x440 (Summit/EXA)"
 	help
 	  This option is needed for IBM systems that use the Summit/EXA chipset.
 	  In particular, it is needed for the x440.
@@ -77,7 +77,16 @@
 
 # Visual Workstation support is utterly broken.
 # If you want to see it working mail an VW540 to hch@infradead.org 8)
-#bool 'SGI Visual Workstation support' CONFIG_VISWS
+#config X86_VISWS
+#	bool "SGI 320/540 (Visual Workstation)"
+#	help
+#	  The SGI Visual Workstation series is an IA32-based workstation
+#	  based on SGI systems chips with some legacy PC hardware attached.
+#
+#	  Say Y here to create a kernel to run on the SGI 320 or 540.
+#
+#	  A kernel compiled for the Visual Workstation will not run on PCs
+#	  and vice versa. See <file:Documentation/sgi-visws.txt> for details.
 
 endchoice
 
