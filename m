Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266399AbUAIBmK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jan 2004 20:42:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266410AbUAIBmK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jan 2004 20:42:10 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:34259 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S266399AbUAIBiy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jan 2004 20:38:54 -0500
Date: Fri, 9 Jan 2004 02:38:50 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Andrew Morton <akpm@osdl.org>, davidm@hpl.hp.com
Cc: linux-kernel@vger.kernel.org, linux-ia64@linuxia64.org
Subject: [2.6 patch] use range for NR_CPUS
Message-ID: <20040109013850.GI13867@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The 2.6 Kconfig language allows to set the range for integer questions.

The patch below adds a range line on all architectures that have a 
NR_CPUS question except ia64.

The help text on ia64 didn't suggest any values. Could someone tell the 
correct values for ia64 (and if it's only a minimum value of 2)?


diffstat output:

 arch/alpha/Kconfig   |    1 +
 arch/i386/Kconfig    |    1 +
 arch/mips/Kconfig    |    1 +
 arch/parisc/Kconfig  |    1 +
 arch/ppc/Kconfig     |    1 +
 arch/ppc64/Kconfig   |    1 +
 arch/s390/Kconfig    |    2 ++
 arch/sh/Kconfig      |    1 +
 arch/sparc/Kconfig   |    1 +
 arch/sparc64/Kconfig |    1 +
 arch/um/Kconfig      |    1 +
 arch/x86_64/Kconfig  |    1 +
 12 files changed, 13 insertions(+)


cu
Adrian

--- linux-2.6.1-rc2-mm1/arch/sparc64/Kconfig.old	2004-01-09 02:17:58.000000000 +0100
+++ linux-2.6.1-rc2-mm1/arch/sparc64/Kconfig	2004-01-09 02:18:54.000000000 +0100
@@ -128,6 +128,7 @@
 
 config NR_CPUS
 	int "Maximum number of CPUs (2-64)"
+	range 2 64
 	depends on SMP
 	default "64"
 
--- linux-2.6.1-rc2-mm1/arch/i386/Kconfig.old	2004-01-09 02:17:58.000000000 +0100
+++ linux-2.6.1-rc2-mm1/arch/i386/Kconfig	2004-01-09 02:19:09.000000000 +0100
@@ -495,6 +495,7 @@
 
 config NR_CPUS
 	int "Maximum number of CPUs (2-255)"
+	range 2 255
 	depends on SMP
 	default "32" if X86_NUMAQ || X86_SUMMIT || X86_BIGSMP || X86_ES7000
 	default "8"
--- linux-2.6.1-rc2-mm1/arch/sparc/Kconfig.old	2004-01-09 02:17:58.000000000 +0100
+++ linux-2.6.1-rc2-mm1/arch/sparc/Kconfig	2004-01-09 02:19:28.000000000 +0100
@@ -112,6 +112,7 @@
 
 config NR_CPUS
 	int "Maximum number of CPUs (2-32)"
+	range 2 32
 	depends on SMP
 	default "32"
 
--- linux-2.6.1-rc2-mm1/arch/ppc/Kconfig.old	2004-01-09 02:17:58.000000000 +0100
+++ linux-2.6.1-rc2-mm1/arch/ppc/Kconfig	2004-01-09 02:19:40.000000000 +0100
@@ -681,6 +681,7 @@
 
 config NR_CPUS
 	int "Maximum number of CPUs (2-32)"
+	range 2 32
 	depends on SMP
 	default "4"
 
--- linux-2.6.1-rc2-mm1/arch/um/Kconfig.old	2004-01-09 02:17:58.000000000 +0100
+++ linux-2.6.1-rc2-mm1/arch/um/Kconfig	2004-01-09 02:21:25.000000000 +0100
@@ -128,6 +128,7 @@
 
 config NR_CPUS
 	int "Maximum number of CPUs (2-32)"
+	range 2 32
 	depends on SMP
 	default "32"
 
--- linux-2.6.1-rc2-mm1/arch/mips/Kconfig.old	2004-01-09 02:17:58.000000000 +0100
+++ linux-2.6.1-rc2-mm1/arch/mips/Kconfig	2004-01-09 02:21:36.000000000 +0100
@@ -981,6 +981,7 @@
 
 config NR_CPUS
 	int "Maximum number of CPUs (2-32)"
+	range 2 32
 	depends on SMP
 	default "32"
 	help
--- linux-2.6.1-rc2-mm1/arch/sh/Kconfig.old	2004-01-09 02:17:58.000000000 +0100
+++ linux-2.6.1-rc2-mm1/arch/sh/Kconfig	2004-01-09 02:21:47.000000000 +0100
@@ -467,6 +467,7 @@
 
 config NR_CPUS
 	int "Maximum number of CPUs (2-32)"
+	range 2 32
 	depends on SMP
 	default "2"
 	help
--- linux-2.6.1-rc2-mm1/arch/alpha/Kconfig.old	2004-01-09 02:17:58.000000000 +0100
+++ linux-2.6.1-rc2-mm1/arch/alpha/Kconfig	2004-01-09 02:22:44.000000000 +0100
@@ -509,6 +509,7 @@
 
 config NR_CPUS
 	int "Maximum number of CPUs (2-64)"
+	range 2 64
 	depends on SMP
 	default "64"
 
--- linux-2.6.1-rc2-mm1/arch/ppc64/Kconfig.old	2004-01-09 02:17:58.000000000 +0100
+++ linux-2.6.1-rc2-mm1/arch/ppc64/Kconfig	2004-01-09 02:22:58.000000000 +0100
@@ -97,6 +97,7 @@
 
 config NR_CPUS
 	int "Maximum number of CPUs (2-128)"
+	range 2 128
 	depends on SMP
 	default "32"
 
--- linux-2.6.1-rc2-mm1/arch/parisc/Kconfig.old	2004-01-09 02:17:58.000000000 +0100
+++ linux-2.6.1-rc2-mm1/arch/parisc/Kconfig	2004-01-09 02:23:10.000000000 +0100
@@ -154,6 +154,7 @@
 
 config NR_CPUS
 	int "Maximum number of CPUs (2-32)"
+	range 2 32
 	depends on SMP
 	default "32"
 
--- linux-2.6.1-rc2-mm1/arch/x86_64/Kconfig.old	2004-01-09 02:17:58.000000000 +0100
+++ linux-2.6.1-rc2-mm1/arch/x86_64/Kconfig	2004-01-09 02:23:30.000000000 +0100
@@ -233,6 +233,7 @@
 # to use clustered mode or whatever your big iron needs
 config NR_CPUS
 	int "Maximum number of CPUs (2-8)"
+	range 2 8
 	depends on SMP
 	default "8"
 	help
--- linux-2.6.1-rc2-mm1/arch/s390/Kconfig.old	2004-01-09 02:17:58.000000000 +0100
+++ linux-2.6.1-rc2-mm1/arch/s390/Kconfig	2004-01-09 02:24:19.000000000 +0100
@@ -97,6 +97,7 @@
 
 config NR_CPUS
 	int "Maximum number of CPUs (2-32)"
+	range 2 32
 	depends on SMP && ARCH_S390X = 'n'
 	default "32"
 	help
@@ -109,6 +110,7 @@
 	
 config NR_CPUS
 	int "Maximum number of CPUs (2-64)"
+	range 2 64
 	depends on SMP && ARCH_S390X
 	default "64"
 	help
