Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261559AbSKCC2P>; Sat, 2 Nov 2002 21:28:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261565AbSKCC2P>; Sat, 2 Nov 2002 21:28:15 -0500
Received: from verein.lst.de ([212.34.181.86]:56325 "EHLO verein.lst.de")
	by vger.kernel.org with ESMTP id <S261559AbSKCC2L>;
	Sat, 2 Nov 2002 21:28:11 -0500
Date: Sun, 3 Nov 2002 03:34:33 +0100
From: Christoph Hellwig <hch@lst.de>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] add CONFIG_MMU and CONFIG_SWAP
Message-ID: <20021103033433.A3383@lst.de>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>, torvalds@transmeta.com,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Now that m68knommu and v850 are merged we need all other architectures
to define CONFIG_SWAP and CONFIG_MMU so that we can make code
conditional on it.


--- 1.1/arch/alpha/Kconfig	Tue Oct 29 20:17:14 2002
+++ edited/arch/alpha/Kconfig	Sat Nov  2 18:37:51 2002
@@ -12,6 +12,14 @@
 	  port. The Alpha Linux project has a home page at
 	  <http://www.alphalinux.org/>.
 
+config MMU
+	bool
+	default y
+
+config SWAP
+	bool
+	default y
+
 config UID16
 	bool
 
--- 1.2/arch/arm/Kconfig	Fri Nov  1 18:58:58 2002
+++ edited/arch/arm/Kconfig	Sat Nov  2 18:35:13 2002
@@ -16,6 +16,14 @@
 	  Europe.  There is an ARM Linux project with a web page at
 	  <http://www.arm.linux.org.uk/>.
 
+config MMU
+	bool
+	default y
+
+config SWAP
+	bool
+	default y
+
 config EISA
 	bool
 	---help---
--- 1.1/arch/cris/Kconfig	Tue Oct 29 20:17:14 2002
+++ edited/arch/cris/Kconfig	Sat Nov  2 18:35:18 2002
@@ -5,6 +5,14 @@
 
 mainmenu "Linux/CRIS Kernel Configuration"
 
+config MMU
+	bool
+	default y
+
+config SWAP
+	bool
+	default y
+
 config UID16
 	bool
 	default y
--- 1.2/arch/i386/Kconfig	Wed Oct 30 06:19:44 2002
+++ edited/arch/i386/Kconfig	Sat Nov  2 18:35:24 2002
@@ -14,6 +14,14 @@
 	  486, 586, Pentiums, and various instruction-set-compatible chips by
 	  AMD, Cyrix, and others.
 
+config MMU
+	bool
+	default y
+
+config SWAP
+	bool
+	default y
+
 config SBUS
 	bool
 
--- 1.2/arch/ia64/Kconfig	Fri Nov  1 00:45:21 2002
+++ edited/arch/ia64/Kconfig	Sat Nov  2 18:35:28 2002
@@ -13,6 +13,14 @@
 	  page at <http://www.linuxia64.org/> and a mailing list at
 	  linux-ia64@linuxia64.org.
 
+config MMU
+	bool
+	default y
+
+config SWAP
+	bool
+	default y
+
 config RWSEM_GENERIC_SPINLOCK
 	bool
 	default y
--- 1.1/arch/m68k/Kconfig	Tue Oct 29 20:17:14 2002
+++ edited/arch/m68k/Kconfig	Sat Nov  2 18:35:31 2002
@@ -6,6 +6,14 @@
 	bool
 	default y
 
+config MMU
+	bool
+	default y
+
+config SWAP
+	bool
+	default y
+
 config UID16
 	bool
 	default y
--- 1.1/arch/mips/Kconfig	Tue Oct 29 20:17:14 2002
+++ edited/arch/mips/Kconfig	Sat Nov  2 18:35:51 2002
@@ -6,6 +6,14 @@
 	bool
 	default y
 
+config MMU
+	bool
+	default y
+
+config SWAP
+	bool
+	default y
+
 config SMP
 	bool
 	---help---
--- 1.1/arch/mips64/Kconfig	Tue Oct 29 20:17:14 2002
+++ edited/arch/mips64/Kconfig	Sat Nov  2 18:35:42 2002
@@ -5,6 +5,14 @@
 
 mainmenu "Linux Kernel Configuration"
 
+config MMU
+	bool
+	default y
+
+config SWAP
+	bool
+	default y
+
 source "init/Kconfig"
 
 
--- 1.1/arch/parisc/Kconfig	Tue Oct 29 20:17:14 2002
+++ edited/arch/parisc/Kconfig	Sat Nov  2 18:35:55 2002
@@ -13,6 +13,14 @@
 	  Hewlett-Packard and used in their line of workstations.  The PA-RISC
 	  Linux project has a home page at <www.parisc-linux.org>.
 
+config MMU
+	bool
+	default y
+
+config SWAP
+	bool
+	default y
+
 config UID16
 	bool
 
--- 1.1/arch/ppc/Kconfig	Tue Oct 29 20:17:14 2002
+++ edited/arch/ppc/Kconfig	Sat Nov  2 18:36:12 2002
@@ -1,6 +1,15 @@
 # For a description of the syntax of this configuration file,
 # see Documentation/kbuild/config-language.txt.
 #
+
+config MMU
+	bool
+	default y
+
+config SWAP
+	bool
+	default y
+
 config UID16
 	bool
 
--- 1.1/arch/ppc64/Kconfig	Tue Oct 29 20:17:14 2002
+++ edited/arch/ppc64/Kconfig	Sat Nov  2 18:36:04 2002
@@ -2,6 +2,15 @@
 # For a description of the syntax of this configuration file,
 # see Documentation/kbuild/config-language.txt.
 #
+
+config MMU
+	bool
+	default y
+
+config SWAP
+	bool
+	default y
+
 config UID16
 	bool
 
--- 1.1/arch/s390/Kconfig	Tue Oct 29 20:17:14 2002
+++ edited/arch/s390/Kconfig	Sat Nov  2 18:36:19 2002
@@ -2,6 +2,15 @@
 # For a description of the syntax of this configuration file,
 # see Documentation/kbuild/config-language.txt.
 #
+
+config MMU
+	bool
+	default y
+
+config SWAP
+	bool
+	default y
+
 config ISA
 	bool
 	help
--- 1.1/arch/s390x/Kconfig	Tue Oct 29 20:17:14 2002
+++ edited/arch/s390x/Kconfig	Sat Nov  2 18:36:27 2002
@@ -2,6 +2,15 @@
 # For a description of the syntax of this configuration file,
 # see Documentation/kbuild/config-language.txt.
 #
+
+config MMU
+	bool
+	default y
+
+config SWAP
+	bool
+	default y
+
 config ISA
 	bool
 	help
--- 1.1/arch/sh/Kconfig	Tue Oct 29 20:17:15 2002
+++ edited/arch/sh/Kconfig	Sat Nov  2 18:36:36 2002
@@ -14,6 +14,14 @@
 	  gaming console.  The SuperH port has a home page at
 	  <http://www.sh-linux.org/>.
 
+config MMU
+	bool
+	default y
+
+config SWAP
+	bool
+	default y
+
 config UID16
 	bool
 	default y
--- 1.1/arch/sparc/Kconfig	Tue Oct 29 20:17:15 2002
+++ edited/arch/sparc/Kconfig	Sat Nov  2 18:36:52 2002
@@ -5,6 +5,14 @@
 
 mainmenu "Linux/SPARC Kernel Configuration"
 
+config MMU
+	bool
+	default y
+
+config SWAP
+	bool
+	default y
+
 config UID16
 	bool
 	default y
--- 1.1/arch/sparc64/Kconfig	Tue Oct 29 20:17:15 2002
+++ edited/arch/sparc64/Kconfig	Sat Nov  2 18:36:44 2002
@@ -5,6 +5,14 @@
 
 mainmenu "Linux/UltraSPARC Kernel Configuration"
 
+config MMU
+	bool
+	default y
+
+config SWAP
+	bool
+	default y
+
 source "init/Kconfig"
 
 
--- 1.1/arch/um/Kconfig	Tue Oct 29 20:17:15 2002
+++ edited/arch/um/Kconfig	Sat Nov  2 18:37:18 2002
@@ -2,6 +2,14 @@
 	bool
 	default y
 
+# XXX: does UM have a mmu/swap?
+config MMU
+	bool
+	default y
+
+config SWAP
+	bool
+	default y
 
 mainmenu "Linux/Usermode Kernel Configuration"
 
--- 1.1/arch/x86_64/Kconfig	Tue Oct 29 20:17:15 2002
+++ edited/arch/x86_64/Kconfig	Sat Nov  2 18:37:49 2002
@@ -25,6 +25,14 @@
 	  486, 586, Pentiums, and various instruction-set-compatible chips by
 	  AMD, Cyrix, and others.
 
+config MMU
+	bool
+	default y
+
+config SWAP
+	bool
+	default y
+
 config ISA
 	bool
 	help
