Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030243AbWBCVM3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030243AbWBCVM3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 16:12:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030201AbWBCVM3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 16:12:29 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:62989 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1030243AbWBCVM2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 16:12:28 -0500
Date: Fri, 3 Feb 2006 22:12:27 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, Chuck Ebbert <76306.1226@compuserve.com>
Cc: linux-kernel@vger.kernel.org
Subject: [-mm patch] arch/i386/kernel/cpu/: make tons of functions static
Message-ID: <20060203211227.GO4408@stusta.de>
References: <20060203000704.3964a39f.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060203000704.3964a39f.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 03, 2006 at 12:07:04AM -0800, Andrew Morton wrote:
>...
> Changes since 2.6.15-mm4:
>...
> +i386-cpu-hotplug-dont-access-freed-memory.patch
> 
>  init sectoin fix
>...


Functions only used in the files they are defined in should be static.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 arch/i386/kernel/cpu/amd.c       |    2 +-
 arch/i386/kernel/cpu/centaur.c   |    2 +-
 arch/i386/kernel/cpu/cyrix.c     |    4 ++--
 arch/i386/kernel/cpu/nexgen.c    |    2 +-
 arch/i386/kernel/cpu/rise.c      |    2 +-
 arch/i386/kernel/cpu/transmeta.c |    2 +-
 arch/i386/kernel/cpu/umc.c       |    2 +-
 7 files changed, 8 insertions(+), 8 deletions(-)

--- linux-2.6.16-rc1-mm5-full/arch/i386/kernel/cpu/amd.c.old	2006-02-03 16:14:11.000000000 +0100
+++ linux-2.6.16-rc1-mm5-full/arch/i386/kernel/cpu/amd.c	2006-02-03 16:14:24.000000000 +0100
@@ -283,7 +283,7 @@
 
 //early_arch_initcall(amd_init_cpu);
 
-int __init amd_exit_cpu(void)
+static int __init amd_exit_cpu(void)
 {
 	cpu_devs[X86_VENDOR_AMD] = NULL;
 	return 0;
--- linux-2.6.16-rc1-mm5-full/arch/i386/kernel/cpu/centaur.c.old	2006-02-03 16:14:32.000000000 +0100
+++ linux-2.6.16-rc1-mm5-full/arch/i386/kernel/cpu/centaur.c	2006-02-03 16:14:42.000000000 +0100
@@ -471,7 +471,7 @@
 
 //early_arch_initcall(centaur_init_cpu);
 
-int __init centaur_exit_cpu(void)
+static int __init centaur_exit_cpu(void)
 {
 	cpu_devs[X86_VENDOR_CENTAUR] = NULL;
 	return 0;
--- linux-2.6.16-rc1-mm5-full/arch/i386/kernel/cpu/cyrix.c.old	2006-02-03 16:15:00.000000000 +0100
+++ linux-2.6.16-rc1-mm5-full/arch/i386/kernel/cpu/cyrix.c	2006-02-03 16:15:21.000000000 +0100
@@ -444,7 +444,7 @@
 
 //early_arch_initcall(cyrix_init_cpu);
 
-int __init cyrix_exit_cpu(void)
+static int __init cyrix_exit_cpu(void)
 {
 	cpu_devs[X86_VENDOR_CYRIX] = NULL;
 	return 0;
@@ -467,7 +467,7 @@
 
 //early_arch_initcall(nsc_init_cpu);
 
-int __init nsc_exit_cpu(void)
+static int __init nsc_exit_cpu(void)
 {
 	cpu_devs[X86_VENDOR_NSC] = NULL;
 	return 0;
--- linux-2.6.16-rc1-mm5-full/arch/i386/kernel/cpu/nexgen.c.old	2006-02-03 16:15:38.000000000 +0100
+++ linux-2.6.16-rc1-mm5-full/arch/i386/kernel/cpu/nexgen.c	2006-02-03 16:15:44.000000000 +0100
@@ -62,7 +62,7 @@
 
 //early_arch_initcall(nexgen_init_cpu);
 
-int __init nexgen_exit_cpu(void)
+static int __init nexgen_exit_cpu(void)
 {
 	cpu_devs[X86_VENDOR_NEXGEN] = NULL;
 	return 0;
--- linux-2.6.16-rc1-mm5-full/arch/i386/kernel/cpu/rise.c.old	2006-02-03 16:15:57.000000000 +0100
+++ linux-2.6.16-rc1-mm5-full/arch/i386/kernel/cpu/rise.c	2006-02-03 16:16:27.000000000 +0100
@@ -52,7 +52,7 @@
 
 //early_arch_initcall(rise_init_cpu);
 
-int __init rise_exit_cpu(void)
+static int __init rise_exit_cpu(void)
 {
 	cpu_devs[X86_VENDOR_RISE] = NULL;
 	return 0;
--- linux-2.6.16-rc1-mm5-full/arch/i386/kernel/cpu/transmeta.c.old	2006-02-03 16:16:37.000000000 +0100
+++ linux-2.6.16-rc1-mm5-full/arch/i386/kernel/cpu/transmeta.c	2006-02-03 16:16:50.000000000 +0100
@@ -112,7 +112,7 @@
 
 //early_arch_initcall(transmeta_init_cpu);
 
-int __init transmeta_exit_cpu(void)
+static int __init transmeta_exit_cpu(void)
 {
 	cpu_devs[X86_VENDOR_TRANSMETA] = NULL;
 	return 0;
--- linux-2.6.16-rc1-mm5-full/arch/i386/kernel/cpu/umc.c.old	2006-02-03 16:17:02.000000000 +0100
+++ linux-2.6.16-rc1-mm5-full/arch/i386/kernel/cpu/umc.c	2006-02-03 16:17:12.000000000 +0100
@@ -32,7 +32,7 @@
 
 //early_arch_initcall(umc_init_cpu);
 
-int __init umc_exit_cpu(void)
+static int __init umc_exit_cpu(void)
 {
 	cpu_devs[X86_VENDOR_UMC] = NULL;
 	return 0;

