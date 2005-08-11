Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751078AbVHKPRb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751078AbVHKPRb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 11:17:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751079AbVHKPRb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 11:17:31 -0400
Received: from mo01.iij4u.or.jp ([210.130.0.20]:1772 "EHLO mo01.iij4u.or.jp")
	by vger.kernel.org with ESMTP id S1751078AbVHKPRa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 11:17:30 -0400
Date: Fri, 12 Aug 2005 00:17:25 +0900
From: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
To: Andrew Morton <akpm@osdl.org>
Cc: yuasa@hh.iij4u.or.jp, linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH][2/4] mips: add default select configs for vr41xx
Message-Id: <20050812001725.4614f379.yuasa@hh.iij4u.or.jp>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch has added default select configs for vr41xx.
Please apply.

Yoichi

Signed-off-by: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>

diff -urN -X dontdiff mm1-orig/arch/mips/Kconfig mm1/arch/mips/Kconfig
--- mm1-orig/arch/mips/Kconfig	2005-08-11 23:21:13.000000000 +0900
+++ mm1/arch/mips/Kconfig	2005-08-11 23:27:17.000000000 +0900
@@ -80,6 +80,7 @@
 	select DMA_NONCOHERENT
 	select IRQ_CPU
 	select HW_HAS_PCI
+	select PCI
 	select PCI_VR41XX
 
 config ROCKHOPPER
@@ -91,6 +92,7 @@
 config CASIO_E55
 	bool "Support for CASIO CASSIOPEIA E-10/15/55/65"
 	depends on MACH_VR41XX
+	select CPU_LITTLE_ENDIAN
 	select DMA_NONCOHERENT
 	select IRQ_CPU
 	select ISA
@@ -98,6 +100,7 @@
 config IBM_WORKPAD
 	bool "Support for IBM WorkPad z50"
 	depends on MACH_VR41XX
+	select CPU_LITTLE_ENDIAN
 	select DMA_NONCOHERENT
 	select IRQ_CPU
 	select ISA
@@ -128,17 +131,23 @@
 
 config VICTOR_MPC30X
 	bool "Support for Victor MP-C303/304"
+	depends on MACH_VR41XX
+	select CPU_LITTLE_ENDIAN
 	select DMA_NONCOHERENT
-	select HW_HAS_PCI
 	select IRQ_CPU
-	depends on MACH_VR41XX
+	select HW_HAS_PCI
+	select PCI
+	select PCI_VR41XX
 
 config ZAO_CAPCELLA
 	bool "Support for ZAO Networks Capcella"
 	depends on MACH_VR41XX
+	select CPU_LITTLE_ENDIAN
 	select DMA_NONCOHERENT
-	select HW_HAS_PCI
 	select IRQ_CPU
+	select HW_HAS_PCI
+	select PCI
+	select PCI_VR41XX
 
 config PCI_VR41XX
 	bool "Add PCI control unit support of NEC VR4100 series"

