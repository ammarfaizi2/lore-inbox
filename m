Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313184AbSDYQUw>; Thu, 25 Apr 2002 12:20:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313265AbSDYQUw>; Thu, 25 Apr 2002 12:20:52 -0400
Received: from tstac.esa.lanl.gov ([128.165.46.3]:6301 "EHLO
	tstac.esa.lanl.gov") by vger.kernel.org with ESMTP
	id <S313184AbSDYQUv>; Thu, 25 Apr 2002 12:20:51 -0400
Subject: [PATCH] 2.5.9-dj1, move choice selection in arch/ia64/config.in.
From: Steven Cole <elenstev@mesatop.com>
To: davidm@hpl.hp.com
Cc: Dave Jones <davej@suse.de>, linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2-5mdk 
Date: 25 Apr 2002 10:16:31 -0600
Message-Id: <1019751391.2540.26.camel@spc9.esa.lanl.gov>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch moves the choice selection for Physical memory granularity
from the "Kernel hacking" section to the "Processor type and features"
section right after the choices for IA-64 processor type, IA-64 system type, 
and Kernel page size.  This seems to be a less obscure place for this option.

Steven

--- linux-2.5.9-dj1/arch/ia64/config.in.orig	Thu Apr 25 10:02:48 2002
+++ linux-2.5.9-dj1/arch/ia64/config.in	Thu Apr 25 10:04:35 2002
@@ -32,6 +32,10 @@
 	 16KB			CONFIG_IA64_PAGE_SIZE_16KB		\
 	 64KB			CONFIG_IA64_PAGE_SIZE_64KB" 16KB
 
+choice 'Physical memory granularity'				\
+	"16MB			CONFIG_IA64_GRANULE_16MB	\
+	 64MB			CONFIG_IA64_GRANULE_64MB" 64MB
+
 if [ "$CONFIG_IA64_HP_SIM" = "n" ]; then
   define_bool CONFIG_ACPI y
   define_bool CONFIG_ACPI_EFI y
@@ -236,10 +240,6 @@
 
 mainmenu_option next_comment
 comment 'Kernel hacking'
-
-choice 'Physical memory granularity'				\
-	"16MB			CONFIG_IA64_GRANULE_16MB	\
-	 64MB			CONFIG_IA64_GRANULE_64MB" 64MB
 
 bool 'Kernel debugging' CONFIG_DEBUG_KERNEL
 if [ "$CONFIG_DEBUG_KERNEL" != "n" ]; then





