Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269334AbUHZSm4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269334AbUHZSm4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 14:42:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269346AbUHZSkW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 14:40:22 -0400
Received: from atlrel9.hp.com ([156.153.255.214]:65241 "EHLO atlrel9.hp.com")
	by vger.kernel.org with ESMTP id S269308AbUHZSci (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 14:32:38 -0400
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH] export acpi_strict
Date: Thu, 26 Aug 2004 12:32:34 -0600
User-Agent: KMail/1.6.2
Cc: Len Brown <len.brown@intel.com>, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200408261232.34350.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I sent this to acpi-devel, but probably more appropriate for the general
list, since it's not under drivers/acpi/.


Export acpi_strict for use in modular drivers.  This will enable
drivers to work around BIOS deficiencies, while still allowing the
drivers to be more picky under acpi_strict.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

===== arch/i386/kernel/acpi/boot.c 1.69 vs edited =====
--- 1.69/arch/i386/kernel/acpi/boot.c	2004-07-14 14:00:16 -06:00
+++ edited/arch/i386/kernel/acpi/boot.c	2004-08-26 09:21:44 -06:00
@@ -71,6 +71,7 @@
 int acpi_lapic;
 int acpi_ioapic;
 int acpi_strict;
+EXPORT_SYMBOL(acpi_strict);
 
 acpi_interrupt_flags acpi_sci_flags __initdata;
 int acpi_sci_override_gsi __initdata;

