Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262097AbVCJWLg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262097AbVCJWLg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 17:11:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262913AbVCJWDa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 17:03:30 -0500
Received: from pimout1-ext.prodigy.net ([207.115.63.77]:2799 "EHLO
	pimout1-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S262806AbVCJVvU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 16:51:20 -0500
Date: Thu, 10 Mar 2005 13:33:09 -0800
From: Chris Wedgwood <cw@f00f.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] 2.4.x --- early boot code references check_acpi_pci()
Message-ID: <20050310213309.GA17298@taniwha.stupidest.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

For x86 (and friends) ACPI_BOOT=y (always) and this code wants to call
check_acpi_pci().

Signed-off-by: Chris Wedgwood <cw@f00f.org>

===== arch/i386/kernel/earlyquirk.c 1.1 vs edited =====
--- 1.1/arch/i386/kernel/earlyquirk.c	2005-02-18 06:53:58 -08:00
+++ edited/arch/i386/kernel/earlyquirk.c	2005-03-10 13:29:55 -08:00
@@ -8,7 +8,7 @@
 #include <asm/pci-direct.h>
 #include <asm/acpi.h>
 
-#ifdef CONFIG_ACPI
+#ifdef CONFIG_ACPI_BOOT
 static int __init check_bridge(int vendor, int device) 
 {
 	/* According to Nvidia all timer overrides are bogus. Just ignore
