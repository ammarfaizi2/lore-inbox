Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261577AbVATSXt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261577AbVATSXt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jan 2005 13:23:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261578AbVATSWA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jan 2005 13:22:00 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:56587 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261608AbVATSPa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jan 2005 13:15:30 -0500
Date: Thu, 20 Jan 2005 19:15:27 +0100
From: Adrian Bunk <bunk@stusta.de>
To: len.brown@intel.com
Cc: acpi-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [RFC: 2.6 patch] i386: unexport acpi_strict
Message-ID: <20050120181527.GF3174@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I haven't found any possible modular usage of acpi_strict.

Is the patch below correct?


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.11-rc1-mm2-full/arch/i386/kernel/acpi/boot.c.old	2005-01-20 18:15:48.000000000 +0100
+++ linux-2.6.11-rc1-mm2-full/arch/i386/kernel/acpi/boot.c	2005-01-20 18:16:09.000000000 +0100
@@ -71,7 +71,6 @@
 int acpi_lapic;
 int acpi_ioapic;
 int acpi_strict;
-EXPORT_SYMBOL(acpi_strict);
 
 acpi_interrupt_flags acpi_sci_flags __initdata;
 int acpi_sci_override_gsi __initdata;

