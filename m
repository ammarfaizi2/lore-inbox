Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266479AbUFWMtd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266479AbUFWMtd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jun 2004 08:49:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266453AbUFWMrQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jun 2004 08:47:16 -0400
Received: from mail.donpac.ru ([80.254.111.2]:65417 "EHLO donpac.ru")
	by vger.kernel.org with ESMTP id S266455AbUFWMoz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jun 2004 08:44:55 -0400
Subject: [PATCH 5/6] 2.6.7-mm1, remove unused ASUS K7V-RM DMI quirk
In-Reply-To: <10879946874140@donpac.ru>
X-Mailer: gregkh_patchbomb_levon_offspring
Date: Wed, 23 Jun 2004 16:44:51 +0400
Message-Id: <10879946911371@donpac.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Andrey Panin <pazke@donpac.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


BROKEN_ACPI_Sx flag doesn't seem to be used anywhere in the kernel,
so ASUS K7V-RM can be removed.

Signed-off-by: Andrey Panin <pazke@donpac.ru>

 arch/i386/kernel/dmi_scan.c |   17 -----------------
 1 files changed, 17 deletions(-)

diff -urpN -X /usr/share/dontdiff linux-2.6.7-mm1.vanilla/arch/i386/kernel/dmi_scan.c linux-2.6.7-mm1/arch/i386/kernel/dmi_scan.c
--- linux-2.6.7-mm1.vanilla/arch/i386/kernel/dmi_scan.c	Sun May 23 22:59:58 2004
+++ linux-2.6.7-mm1/arch/i386/kernel/dmi_scan.c	Sun May 23 23:00:53 2004
@@ -348,17 +348,6 @@ static __init int swab_apm_power_in_minu
 }
 
 /*
- * ASUS K7V-RM has broken ACPI table defining sleep modes
- */
-
-static __init int broken_acpi_Sx(struct dmi_blacklist *d)
-{
-	printk(KERN_WARNING "Detected ASUS mainboard with broken ACPI sleep table\n");
-	dmi_broken |= BROKEN_ACPI_Sx;
-	return 0;
-}
-
-/*
  * Toshiba keyboard likes to repeat keys when they are not repeated.
  */
 
@@ -712,12 +701,6 @@ static __initdata struct dmi_blacklist d
 	{ local_apic_kills_bios, "ASUS L3C", {
 			MATCH(DMI_BOARD_VENDOR, "ASUSTeK Computer INC."),
 			MATCH(DMI_BOARD_NAME, "P4_L3C"),
-			NO_MATCH, NO_MATCH
-			} },
-
-	{ broken_acpi_Sx, "ASUS K7V-RM", {		/* Bad ACPI Sx table */
-			MATCH(DMI_BIOS_VERSION,"ASUS K7V-RM ACPI BIOS Revision 1003A"),
-			MATCH(DMI_BOARD_NAME, "<K7V-RM>"),
 			NO_MATCH, NO_MATCH
 			} },
 

