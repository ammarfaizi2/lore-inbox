Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317362AbSGTE54>; Sat, 20 Jul 2002 00:57:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317363AbSGTE54>; Sat, 20 Jul 2002 00:57:56 -0400
Received: from mail2.alphalink.com.au ([202.161.124.58]:19246 "EHLO
	mail2.alphalink.com.au") by vger.kernel.org with ESMTP
	id <S317362AbSGTE5x>; Sat, 20 Jul 2002 00:57:53 -0400
Message-ID: <3D38EE30.4C40B813@alphalink.com.au>
Date: Sat, 20 Jul 2002 14:59:28 +1000
From: Greg Banks <gnb@alphalink.com.au>
Organization: Corpus Canem Pty Ltd.
X-Mailer: Mozilla 4.73 [en] (X11; I; Linux 2.2.15-4mdkfb i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Kernel Build Mailing List 
	<kbuild-devel@lists.sourceforge.net>
Subject: PATCH 2.5: kconfig remove ia64 ACPI relics
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

G'day,

There are several traces in kconfig of CONFIG_ACPI_KERNEL_CONFIG,
a leftover from the days when there was ACPI code in the IA64 tree.
This patch removes them.

diff -ruN --exclude-from=dontdiff linux-2.5.26+patches7/arch/ia64/Config.help linux-2.5.26/arch/ia64/Config.help
--- linux-2.5.26+patches7/arch/ia64/Config.help	Fri Jul 19 18:16:41 2002
+++ linux-2.5.26/arch/ia64/Config.help	Sat Jul 20 14:36:12 2002
@@ -381,10 +381,6 @@
   The ACPI Sourceforge project may also be of interest:
   <http://sf.net/projects/acpi/>
 
-CONFIG_ACPI_KERNEL_CONFIG
-  If you say `Y' here, Linux's ACPI support will use the
-  hardware-level system descriptions found on IA64 machines.
-
 CONFIG_MAGIC_SYSRQ
   If you say Y here, you will have some control over the system even
   if the system crashes for example during kernel debugging (e.g., you
diff -ruN --exclude-from=dontdiff linux-2.5.26+patches7/arch/ia64/config.in linux-2.5.26/arch/ia64/config.in
--- linux-2.5.26+patches7/arch/ia64/config.in	Fri Jul 19 18:16:41 2002
+++ linux-2.5.26/arch/ia64/config.in	Sat Jul 20 14:36:32 2002
@@ -43,7 +43,6 @@
   define_bool CONFIG_ACPI y
   define_bool CONFIG_ACPI_EFI y
   define_bool CONFIG_ACPI_INTERPRETER y
-  define_bool CONFIG_ACPI_KERNEL_CONFIG y
 fi
 
 if [ "$CONFIG_ITANIUM" = "y" ]; then
diff -ruN --exclude-from=dontdiff linux-2.5.26+patches7/arch/ia64/defconfig linux-2.5.26/arch/ia64/defconfig
--- linux-2.5.26+patches7/arch/ia64/defconfig	Fri Jul 19 18:16:41 2002
+++ linux-2.5.26/arch/ia64/defconfig	Sat Jul 20 14:35:53 2002
@@ -47,7 +47,6 @@
 CONFIG_ACPI=y
 CONFIG_ACPI_EFI=y
 CONFIG_ACPI_INTERPRETER=y
-CONFIG_ACPI_KERNEL_CONFIG=y
 CONFIG_IA64_BRL_EMU=y
 # CONFIG_ITANIUM_BSTEP_SPECIFIC is not set
 CONFIG_IA64_L1_CACHE_SHIFT=6
diff -ruN --exclude-from=dontdiff linux-2.5.26+patches7/arch/ia64/sn/configs/sn1/defconfig-bigsur-mp linux-2.5.26/arch/ia64/sn/configs/sn1/defconfig-bigsur-mp
--- linux-2.5.26+patches7/arch/ia64/sn/configs/sn1/defconfig-bigsur-mp	Fri Jul 19 18:16:41 2002
+++ linux-2.5.26/arch/ia64/sn/configs/sn1/defconfig-bigsur-mp	Sat Jul 20 14:38:12 2002
@@ -25,7 +25,6 @@
 CONFIG_ACPI=y
 CONFIG_ACPI_EFI=y
 CONFIG_ACPI_INTERPRETER=y
-CONFIG_ACPI_KERNEL_CONFIG=y
 CONFIG_ITANIUM=y
 # CONFIG_MCKINLEY is not set
 # CONFIG_IA64_GENERIC is not set
diff -ruN --exclude-from=dontdiff linux-2.5.26+patches7/arch/ia64/sn/configs/sn1/defconfig-bigsur-sp linux-2.5.26/arch/ia64/sn/configs/sn1/defconfig-bigsur-sp
--- linux-2.5.26+patches7/arch/ia64/sn/configs/sn1/defconfig-bigsur-sp	Fri Jul 19 18:16:41 2002
+++ linux-2.5.26/arch/ia64/sn/configs/sn1/defconfig-bigsur-sp	Sat Jul 20 14:38:12 2002
@@ -25,7 +25,6 @@
 CONFIG_ACPI=y
 CONFIG_ACPI_EFI=y
 CONFIG_ACPI_INTERPRETER=y
-CONFIG_ACPI_KERNEL_CONFIG=y
 CONFIG_ITANIUM=y
 # CONFIG_MCKINLEY is not set
 # CONFIG_IA64_GENERIC is not set
diff -ruN --exclude-from=dontdiff linux-2.5.26+patches7/arch/ia64/sn/configs/sn1/defconfig-dig-mp linux-2.5.26/arch/ia64/sn/configs/sn1/defconfig-dig-mp
--- linux-2.5.26+patches7/arch/ia64/sn/configs/sn1/defconfig-dig-mp	Fri Jul 19 18:16:41 2002
+++ linux-2.5.26/arch/ia64/sn/configs/sn1/defconfig-dig-mp	Sat Jul 20 14:38:12 2002
@@ -25,7 +25,6 @@
 CONFIG_ACPI=y
 CONFIG_ACPI_EFI=y
 CONFIG_ACPI_INTERPRETER=y
-CONFIG_ACPI_KERNEL_CONFIG=y
 CONFIG_ITANIUM=y
 # CONFIG_MCKINLEY is not set
 # CONFIG_IA64_GENERIC is not set
diff -ruN --exclude-from=dontdiff linux-2.5.26+patches7/arch/ia64/sn/configs/sn1/defconfig-dig-sp linux-2.5.26/arch/ia64/sn/configs/sn1/defconfig-dig-sp
--- linux-2.5.26+patches7/arch/ia64/sn/configs/sn1/defconfig-dig-sp	Fri Jul 19 18:16:41 2002
+++ linux-2.5.26/arch/ia64/sn/configs/sn1/defconfig-dig-sp	Sat Jul 20 14:38:12 2002
@@ -25,7 +25,6 @@
 CONFIG_ACPI=y
 CONFIG_ACPI_EFI=y
 CONFIG_ACPI_INTERPRETER=y
-CONFIG_ACPI_KERNEL_CONFIG=y
 CONFIG_ITANIUM=y
 # CONFIG_MCKINLEY is not set
 # CONFIG_IA64_GENERIC is not set
diff -ruN --exclude-from=dontdiff linux-2.5.26+patches7/arch/ia64/sn/configs/sn1/defconfig-generic-mp linux-2.5.26/arch/ia64/sn/configs/sn1/defconfig-generic-mp
--- linux-2.5.26+patches7/arch/ia64/sn/configs/sn1/defconfig-generic-mp	Fri Jul 19 18:16:41 2002
+++ linux-2.5.26/arch/ia64/sn/configs/sn1/defconfig-generic-mp	Sat Jul 20 14:38:12 2002
@@ -25,7 +25,6 @@
 CONFIG_ACPI=y
 CONFIG_ACPI_EFI=y
 CONFIG_ACPI_INTERPRETER=y
-CONFIG_ACPI_KERNEL_CONFIG=y
 CONFIG_ITANIUM=y
 # CONFIG_MCKINLEY is not set
 CONFIG_IA64_GENERIC=y
diff -ruN --exclude-from=dontdiff linux-2.5.26+patches7/arch/ia64/sn/configs/sn1/defconfig-generic-sp linux-2.5.26/arch/ia64/sn/configs/sn1/defconfig-generic-sp
--- linux-2.5.26+patches7/arch/ia64/sn/configs/sn1/defconfig-generic-sp	Fri Jul 19 18:16:41 2002
+++ linux-2.5.26/arch/ia64/sn/configs/sn1/defconfig-generic-sp	Sat Jul 20 14:38:12 2002
@@ -25,7 +25,6 @@
 CONFIG_ACPI=y
 CONFIG_ACPI_EFI=y
 CONFIG_ACPI_INTERPRETER=y
-CONFIG_ACPI_KERNEL_CONFIG=y
 CONFIG_ITANIUM=y
 # CONFIG_MCKINLEY is not set
 CONFIG_IA64_GENERIC=y
diff -ruN --exclude-from=dontdiff linux-2.5.26+patches7/arch/ia64/sn/configs/sn1/defconfig-prom-medusa linux-2.5.26/arch/ia64/sn/configs/sn1/defconfig-prom-medusa
--- linux-2.5.26+patches7/arch/ia64/sn/configs/sn1/defconfig-prom-medusa	Fri Jul 19 18:16:41 2002
+++ linux-2.5.26/arch/ia64/sn/configs/sn1/defconfig-prom-medusa	Sat Jul 20 14:38:12 2002
@@ -25,7 +25,6 @@
 CONFIG_ACPI=y
 CONFIG_ACPI_EFI=y
 CONFIG_ACPI_INTERPRETER=y
-CONFIG_ACPI_KERNEL_CONFIG=y
 CONFIG_ITANIUM=y
 # CONFIG_MCKINLEY is not set
 # CONFIG_IA64_GENERIC is not set
diff -ruN --exclude-from=dontdiff linux-2.5.26+patches7/arch/ia64/sn/configs/sn1/defconfig-sn1-mp linux-2.5.26/arch/ia64/sn/configs/sn1/defconfig-sn1-mp
--- linux-2.5.26+patches7/arch/ia64/sn/configs/sn1/defconfig-sn1-mp	Fri Jul 19 18:16:41 2002
+++ linux-2.5.26/arch/ia64/sn/configs/sn1/defconfig-sn1-mp	Sat Jul 20 14:38:12 2002
@@ -25,7 +25,6 @@
 CONFIG_ACPI=y
 CONFIG_ACPI_EFI=y
 CONFIG_ACPI_INTERPRETER=y
-CONFIG_ACPI_KERNEL_CONFIG=y
 CONFIG_ITANIUM=y
 # CONFIG_MCKINLEY is not set
 # CONFIG_IA64_GENERIC is not set
diff -ruN --exclude-from=dontdiff linux-2.5.26+patches7/arch/ia64/sn/configs/sn1/defconfig-sn1-mp-modules linux-2.5.26/arch/ia64/sn/configs/sn1/defconfig-sn1-mp-modules
--- linux-2.5.26+patches7/arch/ia64/sn/configs/sn1/defconfig-sn1-mp-modules	Fri Jul 19 18:16:41 2002
+++ linux-2.5.26/arch/ia64/sn/configs/sn1/defconfig-sn1-mp-modules	Sat Jul 20 14:38:12 2002
@@ -27,7 +27,6 @@
 CONFIG_ACPI=y
 CONFIG_ACPI_EFI=y
 CONFIG_ACPI_INTERPRETER=y
-CONFIG_ACPI_KERNEL_CONFIG=y
 CONFIG_ITANIUM=y
 # CONFIG_MCKINLEY is not set
 # CONFIG_IA64_GENERIC is not set
diff -ruN --exclude-from=dontdiff linux-2.5.26+patches7/arch/ia64/sn/configs/sn1/defconfig-sn1-mp-syn1-0 linux-2.5.26/arch/ia64/sn/configs/sn1/defconfig-sn1-mp-syn1-0
--- linux-2.5.26+patches7/arch/ia64/sn/configs/sn1/defconfig-sn1-mp-syn1-0	Fri Jul 19 18:16:41 2002
+++ linux-2.5.26/arch/ia64/sn/configs/sn1/defconfig-sn1-mp-syn1-0	Sat Jul 20 14:38:12 2002
@@ -25,7 +25,6 @@
 CONFIG_ACPI=y
 CONFIG_ACPI_EFI=y
 CONFIG_ACPI_INTERPRETER=y
-CONFIG_ACPI_KERNEL_CONFIG=y
 CONFIG_ITANIUM=y
 # CONFIG_MCKINLEY is not set
 # CONFIG_IA64_GENERIC is not set
diff -ruN --exclude-from=dontdiff linux-2.5.26+patches7/arch/ia64/sn/configs/sn1/defconfig-sn1-sp linux-2.5.26/arch/ia64/sn/configs/sn1/defconfig-sn1-sp
--- linux-2.5.26+patches7/arch/ia64/sn/configs/sn1/defconfig-sn1-sp	Fri Jul 19 18:16:41 2002
+++ linux-2.5.26/arch/ia64/sn/configs/sn1/defconfig-sn1-sp	Sat Jul 20 14:38:12 2002
@@ -25,7 +25,6 @@
 CONFIG_ACPI=y
 CONFIG_ACPI_EFI=y
 CONFIG_ACPI_INTERPRETER=y
-CONFIG_ACPI_KERNEL_CONFIG=y
 CONFIG_ITANIUM=y
 # CONFIG_MCKINLEY is not set
 # CONFIG_IA64_GENERIC is not set
diff -ruN --exclude-from=dontdiff linux-2.5.26+patches7/arch/ia64/sn/configs/sn2/defconfig-dig-numa linux-2.5.26/arch/ia64/sn/configs/sn2/defconfig-dig-numa
--- linux-2.5.26+patches7/arch/ia64/sn/configs/sn2/defconfig-dig-numa	Fri Jul 19 18:16:41 2002
+++ linux-2.5.26/arch/ia64/sn/configs/sn2/defconfig-dig-numa	Sat Jul 20 14:39:02 2002
@@ -25,7 +25,6 @@
 CONFIG_ACPI=y
 CONFIG_ACPI_EFI=y
 CONFIG_ACPI_INTERPRETER=y
-CONFIG_ACPI_KERNEL_CONFIG=y
 CONFIG_ITANIUM=y
 # CONFIG_MCKINLEY is not set
 # CONFIG_IA64_GENERIC is not set
diff -ruN --exclude-from=dontdiff linux-2.5.26+patches7/arch/ia64/sn/configs/sn2/defconfig-sn2-dig-mp linux-2.5.26/arch/ia64/sn/configs/sn2/defconfig-sn2-dig-mp
--- linux-2.5.26+patches7/arch/ia64/sn/configs/sn2/defconfig-sn2-dig-mp	Fri Jul 19 18:16:41 2002
+++ linux-2.5.26/arch/ia64/sn/configs/sn2/defconfig-sn2-dig-mp	Sat Jul 20 14:39:02 2002
@@ -25,7 +25,6 @@
 CONFIG_ACPI=y
 CONFIG_ACPI_EFI=y
 CONFIG_ACPI_INTERPRETER=y
-CONFIG_ACPI_KERNEL_CONFIG=y
 CONFIG_ITANIUM=y
 # CONFIG_MCKINLEY is not set
 # CONFIG_IA64_GENERIC is not set
diff -ruN --exclude-from=dontdiff linux-2.5.26+patches7/arch/ia64/sn/configs/sn2/defconfig-sn2-dig-sp linux-2.5.26/arch/ia64/sn/configs/sn2/defconfig-sn2-dig-sp
--- linux-2.5.26+patches7/arch/ia64/sn/configs/sn2/defconfig-sn2-dig-sp	Fri Jul 19 18:16:41 2002
+++ linux-2.5.26/arch/ia64/sn/configs/sn2/defconfig-sn2-dig-sp	Sat Jul 20 14:39:02 2002
@@ -25,7 +25,6 @@
 CONFIG_ACPI=y
 CONFIG_ACPI_EFI=y
 CONFIG_ACPI_INTERPRETER=y
-CONFIG_ACPI_KERNEL_CONFIG=y
 CONFIG_ITANIUM=y
 # CONFIG_MCKINLEY is not set
 # CONFIG_IA64_GENERIC is not set
diff -ruN --exclude-from=dontdiff linux-2.5.26+patches7/arch/ia64/sn/configs/sn2/defconfig-sn2-mp linux-2.5.26/arch/ia64/sn/configs/sn2/defconfig-sn2-mp
--- linux-2.5.26+patches7/arch/ia64/sn/configs/sn2/defconfig-sn2-mp	Fri Jul 19 18:16:41 2002
+++ linux-2.5.26/arch/ia64/sn/configs/sn2/defconfig-sn2-mp	Sat Jul 20 14:39:02 2002
@@ -25,7 +25,6 @@
 CONFIG_ACPI=y
 CONFIG_ACPI_EFI=y
 CONFIG_ACPI_INTERPRETER=y
-CONFIG_ACPI_KERNEL_CONFIG=y
 # CONFIG_ITANIUM is not set
 CONFIG_MCKINLEY=y
 # CONFIG_IA64_GENERIC is not set
diff -ruN --exclude-from=dontdiff linux-2.5.26+patches7/arch/ia64/sn/configs/sn2/defconfig-sn2-mp-modules linux-2.5.26/arch/ia64/sn/configs/sn2/defconfig-sn2-mp-modules
--- linux-2.5.26+patches7/arch/ia64/sn/configs/sn2/defconfig-sn2-mp-modules	Fri Jul 19 18:16:41 2002
+++ linux-2.5.26/arch/ia64/sn/configs/sn2/defconfig-sn2-mp-modules	Sat Jul 20 14:39:02 2002
@@ -27,7 +27,6 @@
 CONFIG_ACPI=y
 CONFIG_ACPI_EFI=y
 CONFIG_ACPI_INTERPRETER=y
-CONFIG_ACPI_KERNEL_CONFIG=y
 # CONFIG_ITANIUM is not set
 CONFIG_MCKINLEY=y
 # CONFIG_IA64_GENERIC is not set
diff -ruN --exclude-from=dontdiff linux-2.5.26+patches7/arch/ia64/sn/configs/sn2/defconfig-sn2-prom-medusa linux-2.5.26/arch/ia64/sn/configs/sn2/defconfig-sn2-prom-medusa
--- linux-2.5.26+patches7/arch/ia64/sn/configs/sn2/defconfig-sn2-prom-medusa	Fri Jul 19 18:16:41 2002
+++ linux-2.5.26/arch/ia64/sn/configs/sn2/defconfig-sn2-prom-medusa	Sat Jul 20 14:39:02 2002
@@ -25,7 +25,6 @@
 CONFIG_ACPI=y
 CONFIG_ACPI_EFI=y
 CONFIG_ACPI_INTERPRETER=y
-CONFIG_ACPI_KERNEL_CONFIG=y
 # CONFIG_ITANIUM is not set
 CONFIG_MCKINLEY=y
 # CONFIG_IA64_GENERIC is not set
diff -ruN --exclude-from=dontdiff linux-2.5.26+patches7/arch/ia64/sn/configs/sn2/defconfig-sn2-sp linux-2.5.26/arch/ia64/sn/configs/sn2/defconfig-sn2-sp
--- linux-2.5.26+patches7/arch/ia64/sn/configs/sn2/defconfig-sn2-sp	Fri Jul 19 18:16:41 2002
+++ linux-2.5.26/arch/ia64/sn/configs/sn2/defconfig-sn2-sp	Sat Jul 20 14:39:02 2002
@@ -25,7 +25,6 @@
 CONFIG_ACPI=y
 CONFIG_ACPI_EFI=y
 CONFIG_ACPI_INTERPRETER=y
-CONFIG_ACPI_KERNEL_CONFIG=y
 # CONFIG_ITANIUM is not set
 CONFIG_MCKINLEY=y
 # CONFIG_IA64_GENERIC is not set

Greg.
-- 
the price of civilisation today is a courageous willingness to prevail,
with force, if necessary, against whatever vicious and uncomprehending
enemies try to strike it down.     - Roger Sandall, The Age, 28Sep2001.
