Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264443AbUGHM0S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264443AbUGHM0S (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jul 2004 08:26:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262574AbUGHM0R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jul 2004 08:26:17 -0400
Received: from mail.donpac.ru ([80.254.111.2]:60334 "EHLO donpac.ru")
	by vger.kernel.org with ESMTP id S264443AbUGHM0D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jul 2004 08:26:03 -0400
Subject: [PATCH 1/1] 2.6.7-mm6, DMI isn't broken anymore
In-Reply-To: <10892895562540@donpac.ru>
X-Mailer: gregkh_patchbomb_levon_offspring
Date: Thu, 8 Jul 2004 16:26:01 +0400
Message-Id: <10892895612171@donpac.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Andrey Panin <pazke@donpac.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch removes dmi_broken global variable which is not used anymore.

Please consider applying.

Signed-off-by: Andrey Panin <pazke@donpac.ru>

 arch/i386/kernel/dmi_scan.c |    2 --
 include/asm-i386/system.h   |    6 ------
 include/asm-x86_64/acpi.h   |    4 ----
 3 files changed, 12 deletions(-)

diff -urpNX /usr/share/dontdiff linux-2.6.7-mm6.vanilla/arch/i386/kernel/dmi_scan.c linux-2.6.7-mm6/arch/i386/kernel/dmi_scan.c
--- linux-2.6.7-mm6.vanilla/arch/i386/kernel/dmi_scan.c	Wed Jul  7 20:06:49 2004
+++ linux-2.6.7-mm6/arch/i386/kernel/dmi_scan.c	Wed Jul  7 21:39:01 2004
@@ -11,8 +11,6 @@
 #include <linux/dmi.h>
 #include <linux/bootmem.h>
 
-unsigned long dmi_broken;
-EXPORT_SYMBOL(dmi_broken);
 
 int es7000_plat = 0;
 
diff -urpNX /usr/share/dontdiff linux-2.6.7-mm6.vanilla/include/asm-i386/system.h linux-2.6.7-mm6/include/asm-i386/system.h
--- linux-2.6.7-mm6.vanilla/include/asm-i386/system.h	Wed Jul  7 20:07:45 2004
+++ linux-2.6.7-mm6/include/asm-i386/system.h	Wed Jul  7 21:38:56 2004
@@ -465,12 +465,6 @@ struct alt_instr { 
 void disable_hlt(void);
 void enable_hlt(void);
 
-extern unsigned long dmi_broken;
 extern int es7000_plat;
-
-#define BROKEN_ACPI_Sx		0x0001
-#define BROKEN_INIT_AFTER_S1	0x0002
-#define BROKEN_PNP_BIOS		0x0004
-#define BROKEN_CPUFREQ		0x0008
 
 #endif
diff -urpNX /usr/share/dontdiff linux-2.6.7-mm6.vanilla/include/asm-x86_64/acpi.h linux-2.6.7-mm6/include/asm-x86_64/acpi.h
--- linux-2.6.7-mm6.vanilla/include/asm-x86_64/acpi.h	Wed Jul  7 20:07:33 2004
+++ linux-2.6.7-mm6/include/asm-x86_64/acpi.h	Wed Jul  7 22:03:44 2004
@@ -159,10 +159,6 @@ extern void acpi_reserve_bootmem(void);
 extern int acpi_disabled;
 extern int acpi_pci_disabled;
 
-#define dmi_broken (0)
-#define BROKEN_ACPI_Sx		0x0001
-#define BROKEN_INIT_AFTER_S1	0x0002
-
 #endif /*__KERNEL__*/
 
 #endif /*_ASM_ACPI_H*/

