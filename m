Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262398AbVAPHjh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262398AbVAPHjh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jan 2005 02:39:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262413AbVAPHjh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jan 2005 02:39:37 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:11790 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262398AbVAPHja (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jan 2005 02:39:30 -0500
Date: Sun, 16 Jan 2005 08:39:27 +0100
From: Adrian Bunk <bunk@stusta.de>
To: len.brown@intel.com, acpi-devel@lists.sourceforge.net, pavel@suse.cz
Cc: linux-kernel@vger.kernel.org, ak@suse.de, discuss@x86-64.org
Subject: [2.6 patch] i386/x86_64: acpi/sleep.c: kill unused acpi_save_state_disk
Message-ID: <20050116073927.GU4274@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

acpi_save_state_disk does nothing and is completely unused.

Unless some usage is planned in the near future, I'm therefore proposing 
the patch below to kill it.


diffstat output:
 arch/i386/kernel/acpi/sleep.c   |    9 ---------
 arch/x86_64/kernel/acpi/sleep.c |    9 ---------
 include/asm-i386/acpi.h         |    1 -
 include/asm-i386/suspend.h      |    1 -
 include/asm-x86_64/acpi.h       |    1 -
 include/asm-x86_64/suspend.h    |    1 -
 6 files changed, 22 deletions(-)


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.11-rc1-mm1-full/include/asm-i386/acpi.h.old	2005-01-16 04:25:17.000000000 +0100
+++ linux-2.6.11-rc1-mm1-full/include/asm-i386/acpi.h	2005-01-16 04:25:23.000000000 +0100
@@ -174,7 +174,6 @@
 
 /* routines for saving/restoring kernel state */
 extern int acpi_save_state_mem(void);
-extern int acpi_save_state_disk(void);
 extern void acpi_restore_state_mem(void);
 
 extern unsigned long acpi_wakeup_address;
--- linux-2.6.11-rc1-mm1-full/include/asm-i386/suspend.h.old	2005-01-16 04:25:31.000000000 +0100
+++ linux-2.6.11-rc1-mm1-full/include/asm-i386/suspend.h	2005-01-16 04:25:35.000000000 +0100
@@ -61,5 +61,4 @@
 
 /* routines for saving/restoring kernel state */
 extern int acpi_save_state_mem(void);
-extern int acpi_save_state_disk(void);
 #endif
--- linux-2.6.11-rc1-mm1-full/include/asm-x86_64/acpi.h.old	2005-01-16 04:25:44.000000000 +0100
+++ linux-2.6.11-rc1-mm1-full/include/asm-x86_64/acpi.h	2005-01-16 04:25:48.000000000 +0100
@@ -153,7 +153,6 @@
 
 /* routines for saving/restoring kernel state */
 extern int acpi_save_state_mem(void);
-extern int acpi_save_state_disk(void);
 extern void acpi_restore_state_mem(void);
 
 extern unsigned long acpi_wakeup_address;
--- linux-2.6.11-rc1-mm1-full/include/asm-x86_64/suspend.h.old	2005-01-16 04:25:56.000000000 +0100
+++ linux-2.6.11-rc1-mm1-full/include/asm-x86_64/suspend.h	2005-01-16 04:26:00.000000000 +0100
@@ -55,5 +55,4 @@
 
 /* routines for saving/restoring kernel state */
 extern int acpi_save_state_mem(void);
-extern int acpi_save_state_disk(void);
 #endif
--- linux-2.6.11-rc1-mm1-full/arch/i386/kernel/acpi/sleep.c.old	2005-01-16 04:26:23.000000000 +0100
+++ linux-2.6.11-rc1-mm1-full/arch/i386/kernel/acpi/sleep.c	2005-01-16 04:26:30.000000000 +0100
@@ -47,15 +47,6 @@
 	return 0;
 }
 
-/**
- * acpi_save_state_disk - save kernel state to disk
- *
- */
-int acpi_save_state_disk (void)
-{
-	return 1;
-}
-
 /*
  * acpi_restore_state - undo effects of acpi_save_state_mem
  */
--- linux-2.6.11-rc1-mm1-full/arch/x86_64/kernel/acpi/sleep.c.old	2005-01-16 04:26:43.000000000 +0100
+++ linux-2.6.11-rc1-mm1-full/arch/x86_64/kernel/acpi/sleep.c	2005-01-16 04:26:50.000000000 +0100
@@ -87,15 +87,6 @@
 	return 0;
 }
 
-/**
- * acpi_save_state_disk - save kernel state to disk
- *
- */
-int acpi_save_state_disk (void)
-{
-	return 1;
-}
-
 /*
  * acpi_restore_state
  */

