Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267110AbRGJTP5>; Tue, 10 Jul 2001 15:15:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267106AbRGJTPi>; Tue, 10 Jul 2001 15:15:38 -0400
Received: from [194.213.32.142] ([194.213.32.142]:4868 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S267104AbRGJTPS>;
	Tue, 10 Jul 2001 15:15:18 -0400
Message-ID: <20010709230848.B208@bug.ucw.cz>
Date: Mon, 9 Jul 2001 23:08:48 +0200
From: Pavel Machek <pavel@ucw.cz>
To: andrew.grover@intel.com, kernel list <linux-kernel@vger.kernel.org>
Cc: ACPI mailing list <acpi@phobos.fachschaften.tu-muenchen.de>
Subject: Cleanup: evevent.c
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This kills some whitespace from evevent.c, making code way
shorter. Please apply.
								Pavel

Only in linux/drivers/acpi/: common
diff -ur -x .dep* -x .hdep* -x *.[oas] -x *~ -x #* -x *CVS* -x *.orig -x *.rej -x *.old -x .menu* -x asm -x local.h -x System.map -x autoconf.h -x compile.h -x version.h -x .version -x defkeymap.c -x uni_hash.tbl -x zImage -x vmlinu?* -x TAGS -x bootsect -x *RCS* -x conmakehash -x map -x build -x build -x configure -x *target* -x *.flags -x *.bak clean/drivers/acpi/events/evevent.c linux/drivers/acpi/events/evevent.c
--- clean/drivers/acpi/events/evevent.c	Sun Jul  8 23:26:27 2001
+++ linux/drivers/acpi/events/evevent.c	Sun Jul  8 23:25:01 2001
@@ -48,25 +50,15 @@
  ******************************************************************************/
 
 ACPI_STATUS
-acpi_ev_initialize (
-	void)
+acpi_ev_initialize (void)
 {
 	ACPI_STATUS             status;
 
-
-	/* Make sure we have ACPI tables */
-
-	if (!acpi_gbl_DSDT) {
+	if (!acpi_gbl_DSDT)		 	/* Make sure we have ACPI tables */
 		return (AE_NO_ACPI_TABLES);
-	}
-
-
-	/* Make sure the BIOS supports ACPI mode */
 
-	if (SYS_MODE_LEGACY == acpi_hw_get_mode_capabilities()) {
+	if (SYS_MODE_LEGACY == acpi_hw_get_mode_capabilities())	/* Make sure the BIOS supports ACPI mode */
 		return (AE_ERROR);
-	}
-
 
 	acpi_gbl_original_mode = acpi_hw_get_mode();
 
@@ -76,38 +68,18 @@
 	 * before handers are installed.
 	 */
 
-	status = acpi_ev_fixed_event_initialize ();
-	if (ACPI_FAILURE (status)) {
+	if (ACPI_FAILURE (status = acpi_ev_fixed_event_initialize ()))
 		return (status);
-	}
-
-	status = acpi_ev_gpe_initialize ();
-	if (ACPI_FAILURE (status)) {
+	if (ACPI_FAILURE (status = acpi_ev_gpe_initialize ()))
 		return (status);
-	}
-
-	/* Install the SCI handler */
-
-	status = acpi_ev_install_sci_handler ();
-	if (ACPI_FAILURE (status)) {
+	if (ACPI_FAILURE (status = acpi_ev_install_sci_handler ()))
 		return (status);
-	}
-
-
 	/* Install handlers for control method GPE handlers (_Lxx, _Exx) */
-
-	status = acpi_ev_init_gpe_control_methods ();
-	if (ACPI_FAILURE (status)) {
+	if (ACPI_FAILURE (status = acpi_ev_init_gpe_control_methods ()))
 		return (status);
-	}
-
 	/* Install the handler for the Global Lock */
-
-	status = acpi_ev_init_global_lock_handler ();
-	if (ACPI_FAILURE (status)) {
+	if (ACPI_FAILURE (status = acpi_ev_init_global_lock_handler ()))
 		return (status);
-	}
-
 
 	return (status);
 }

-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
