Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266907AbTATTkw>; Mon, 20 Jan 2003 14:40:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266888AbTATTk3>; Mon, 20 Jan 2003 14:40:29 -0500
Received: from [195.39.17.254] ([195.39.17.254]:3332 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S266837AbTATTiu>;
	Mon, 20 Jan 2003 14:38:50 -0500
Date: Sun, 19 Jan 2003 22:42:31 +0100
From: Pavel Machek <pavel@ucw.cz>
To: kernel list <linux-kernel@vger.kernel.org>,
       Rusty trivial patch monkey Russell 
	<trivial@rustcorp.com.au>,
       torvalds@transmeta.com
Subject: Kill unused code
Message-ID: <20030119214230.GA27874@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Second part of this patch never got in (and I was told it was not bug
in ASUS but in linux), so it is useless junk... Please apply,
								Pavel

--- clean/arch/i386/kernel/dmi_scan.c	2002-11-01 00:37:04.000000000 +0100
+++ linux-swsusp/arch/i386/kernel/dmi_scan.c	2003-01-19 18:10:59.000000000 +0100
@@ -450,17 +450,6 @@
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
 
@@ -746,12 +750,6 @@
 			NO_MATCH, NO_MATCH, NO_MATCH
 			} },
 			
-	{ broken_acpi_Sx, "ASUS K7V-RM", {		/* Bad ACPI Sx table */
-			MATCH(DMI_BIOS_VERSION,"ASUS K7V-RM ACPI BIOS Revision 1003A"),
-			MATCH(DMI_BOARD_NAME, "<K7V-RM>"),
-			NO_MATCH, NO_MATCH
-			} },
-			
 	{ broken_toshiba_keyboard, "Toshiba Satellite 4030cdt", { /* Keyboard generates spurious repeats */
 			MATCH(DMI_PRODUCT_NAME, "S4030CDT/4.3"),
 			NO_MATCH, NO_MATCH, NO_MATCH

-- 
Worst form of spam? Adding advertisment signatures ala sourceforge.net.
What goes next? Inserting advertisment *into* email?
