Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751538AbWHJUit@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751538AbWHJUit (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 16:38:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751563AbWHJUO0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 16:14:26 -0400
Received: from cantor2.suse.de ([195.135.220.15]:45547 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932613AbWHJTgU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 15:36:20 -0400
From: Andi Kleen <ak@suse.de>
References: <20060810 935.775038000@suse.de>
In-Reply-To: <20060810 935.775038000@suse.de>
Subject: [PATCH for review] [63/145] x86_64: Remove some unneeded ACPI externs in mpparse.c
Message-Id: <20060810193618.CCA2D13B90@wotan.suse.de>
Date: Thu, 10 Aug 2006 21:36:18 +0200 (CEST)
To: undisclosed-recipients:;
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

r

They are not used in this file so remove them. i386 didn't have them either.

Cc: len.brown@intel.com
Signed-off-by: Andi Kleen <ak@suse.de>

---
 arch/x86_64/kernel/mpparse.c |    9 ---------
 1 files changed, 9 deletions(-)

Index: linux/arch/x86_64/kernel/mpparse.c
===================================================================
--- linux.orig/arch/x86_64/kernel/mpparse.c
+++ linux/arch/x86_64/kernel/mpparse.c
@@ -70,15 +70,6 @@ unsigned disabled_cpus __initdata;
 /* Bitmask of physically existing CPUs */
 physid_mask_t phys_cpu_present_map = PHYSID_MASK_NONE;
 
-/* ACPI MADT entry parsing functions */
-#ifdef CONFIG_ACPI
-extern struct acpi_boot_flags acpi_boot;
-extern int acpi_parse_lapic (acpi_table_entry_header *header);
-extern int acpi_parse_lapic_addr_ovr (acpi_table_entry_header *header);
-extern int acpi_parse_lapic_nmi (acpi_table_entry_header *header);
-extern int acpi_parse_ioapic (acpi_table_entry_header *header);
-#endif /*CONFIG_ACPI*/
-
 u8 bios_cpu_apicid[NR_CPUS] = { [0 ... NR_CPUS-1] = BAD_APICID };
 
 
