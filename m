Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266741AbUJFCaT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266741AbUJFCaT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 22:30:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266775AbUJFCaS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 22:30:18 -0400
Received: from mail.renesas.com ([202.234.163.13]:4345 "EHLO
	mail01.idc.renesas.com") by vger.kernel.org with ESMTP
	id S266741AbUJFC3i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 22:29:38 -0400
Date: Wed, 06 Oct 2004 11:29:25 +0900 (JST)
Message-Id: <20041006.112925.295395530.takata.hirokazu@renesas.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, takata@linux-m32r.org
Subject: [PATCH 2.6.9-rc3-mm2 1/5] [m32r] Remove arch/m32r/drivers
From: Hirokazu Takata <takata@linux-m32r.org>
In-Reply-To: <20041006.112743.635726864.takata.hirokazu@renesas.com>
References: <20041006.112743.635726864.takata.hirokazu@renesas.com>
X-Mailer: Mew version 3.3 on XEmacs 21.4.15 (Security Through Obscurity)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH 2.6.9-rc3-mm2 1/5] [m32r] Remove arch/m32r/drivers

Please remove obsolete m32r-specific driver files,
which are no longer used.

Thanks.

Signed-off-by: Hirokazu Takata <takata@linux-m32r.org>
---

 arch/m32r/Kconfig          |    2 --
 arch/m32r/Makefile         |    1 -
 arch/m32r/drivers/Kconfig  |   34 ----------------------------------
 arch/m32r/drivers/Makefile |    7 -------
 4 files changed, 44 deletions(-)


diff -ruNp a/arch/m32r/Kconfig b/arch/m32r/Kconfig
--- a/arch/m32r/Kconfig	2004-10-01 11:14:53.000000000 +0900
+++ b/arch/m32r/Kconfig	2004-10-05 20:51:34.000000000 +0900
@@ -253,8 +253,6 @@ config NUMA
 	depends on SMP
 	default n
 
-source "arch/m32r/drivers/Kconfig"
-
 # turning this on wastes a bunch of space.
 # Summit needs it only when NUMA is on
 config BOOT_IOREMAP
diff -ruNp a/arch/m32r/Makefile b/arch/m32r/Makefile
--- a/arch/m32r/Makefile	2004-10-01 11:14:53.000000000 +0900
+++ b/arch/m32r/Makefile	2004-10-05 20:51:34.000000000 +0900
@@ -36,7 +36,6 @@ core-y	+= arch/m32r/kernel/	\
 	   arch/m32r/mm/	\
 	   arch/m32r/boot/
 
-drivers-y			+= arch/m32r/drivers/
 drivers-$(CONFIG_OPROFILE)	+= arch/m32r/oprofile/
 
 boot := arch/m32r/boot
diff -ruNp a/arch/m32r/drivers/Kconfig b/arch/m32r/drivers/Kconfig
--- a/arch/m32r/drivers/Kconfig	2004-10-01 11:14:54.000000000 +0900
+++ b/arch/m32r/drivers/Kconfig	1970-01-01 09:00:00.000000000 +0900
@@ -1,34 +0,0 @@
-#
-# For a description of the syntax of this configuration file,
-# see Documentation/kbuild/kconfig-language.txt.
-#
-
-menu "M32R drivers"
-
-config M32RPCC
-	bool "M32R PCMCIA I/F"
-	depends on CHIP_M32700
-
-config M32R_CFC
-	bool "CF I/F Controller"
-	depends on PLAT_USRV || PLAT_M32700UT || PLAT_MAPPI2 || PLAT_OPSPUT
-
-config M32700UT_CFC
-	bool
-	depends on M32R_CFC
-	default y
-
-config CFC_NUM
-	int "CF I/F number"
-	depends on PLAT_USRV || PLAT_M32700UT
-	default "1" if PLAT_USRV || PLAT_M32700UT || PLAT_MAPPI2 || PLAT_OPSPUT
-
-config MTD_M32R
-	bool "Flash device mapped on M32R"
-	depends on PLAT_USRV || PLAT_M32700UT || PLAT_MAPPI2
-
-config M32700UT_DS1302
-	bool "DS1302 Real Time Clock support"
-	depends on PLAT_M32700UT || PLAT_OPSPUT
-
-endmenu
diff -ruNp a/arch/m32r/drivers/Makefile b/arch/m32r/drivers/Makefile
--- a/arch/m32r/drivers/Makefile	2004-10-01 11:14:54.000000000 +0900
+++ b/arch/m32r/drivers/Makefile	1970-01-01 09:00:00.000000000 +0900
@@ -1,7 +0,0 @@
-#
-# Makefile for the Linux/M32R driver
-#
-
-obj-$(CONFIG_M32RPCC)		+= m32r_pcc.o
-obj-$(CONFIG_M32R_CFC)		+= m32r_cfc.o
-obj-$(CONFIG_M32700UT_DS1302)	+= ds1302.o

--
Hirokazu Takata <takata@linux-m32r.org>
Linux/M32R Project:  http://www.linux-m32r.org/
