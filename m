Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261847AbSL2V4B>; Sun, 29 Dec 2002 16:56:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261857AbSL2V4B>; Sun, 29 Dec 2002 16:56:01 -0500
Received: from verein.lst.de ([212.34.181.86]:39435 "EHLO verein.lst.de")
	by vger.kernel.org with ESMTP id <S261847AbSL2V4A>;
	Sun, 29 Dec 2002 16:56:00 -0500
Date: Sun, 29 Dec 2002 23:04:19 +0100
From: Christoph Hellwig <hch@lst.de>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] remove CONFIG_X86_NUMA
Message-ID: <20021229230419.A12194@lst.de>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>, torvalds@transmeta.com,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It's only used to hide two entries in arch/i386/Kconfig.

ACKed my mbligh.


--- 1.14/arch/i386/Kconfig	Tue Dec 17 19:50:36 2002
+++ edited/arch/i386/Kconfig	Sat Dec 21 18:10:12 2002
@@ -385,14 +385,8 @@
 	  This is purely to save memory - each supported CPU adds
 	  approximately eight kilobytes to the kernel image.
 
-config X86_NUMA
-	bool "Multi-node NUMA system support"
-	depends on SMP
-
-#Platform Choices
 config X86_NUMAQ
 	bool "Multiquad (IBM/Sequent) NUMAQ support"
-	depends on X86_NUMA
 	help
 	  This option is used for getting Linux to run on a (IBM/Sequent) NUMA 
 	  multiquad box. This changes the way that processors are bootstrapped,
@@ -402,7 +396,6 @@
 
 config X86_SUMMIT
 	bool "IBM x440 (Summit/EXA) support"
-	depends on X86_NUMA
 	help
 	  This option is needed for IBM systems that use the Summit/EXA chipset.
 	  In particular, it is needed for the x440.
@@ -411,7 +404,7 @@
 
 config CLUSTERED_APIC
 	bool
-	depends on X86_NUMA && (X86_NUMAQ || X86_SUMMIT)
+	depends on X86_NUMAQ || X86_SUMMIT
 	default y
 
 # Common NUMA Features
