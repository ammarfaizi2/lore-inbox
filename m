Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263917AbTCVWlj>; Sat, 22 Mar 2003 17:41:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263929AbTCVWlZ>; Sat, 22 Mar 2003 17:41:25 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:10885
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S263950AbTCVWjb>; Sat, 22 Mar 2003 17:39:31 -0500
Date: Sat, 22 Mar 2003 23:55:13 GMT
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200303222355.h2MNtDY2020697@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: PATCH: ide typo fixes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65-bk3/drivers/ide/ide.c linux-2.5.65-ac3/drivers/ide/ide.c
--- linux-2.5.65-bk3/drivers/ide/ide.c	2003-03-22 19:35:11.000000000 +0000
+++ linux-2.5.65-ac3/drivers/ide/ide.c	2003-03-22 20:32:12.000000000 +0000
@@ -904,7 +904,7 @@
 EXPORT_SYMBOL(ide_setup_ports);
 
 /*
- * Register an IDE interface, specifing exactly the registers etc
+ * Register an IDE interface, specifying exactly the registers etc
  * Set init=1 iff calling before probes have taken place.
  */
 int ide_register_hw (hw_regs_t *hw, ide_hwif_t **hwifp)
@@ -955,7 +955,7 @@
 EXPORT_SYMBOL(ide_register_hw);
 
 /*
- * Compatability function with existing drivers.  If you want
+ * Compatibility function with existing drivers.  If you want
  * something different, use the function above.
  */
 int ide_register (int arg1, int arg2, int irq)
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65-bk3/drivers/ide/ide-disk.c linux-2.5.65-ac3/drivers/ide/ide-disk.c
--- linux-2.5.65-bk3/drivers/ide/ide-disk.c	2003-03-22 19:35:11.000000000 +0000
+++ linux-2.5.65-ac3/drivers/ide/ide-disk.c	2003-03-22 20:32:12.000000000 +0000
@@ -2,7 +2,7 @@
  *  linux/drivers/ide/ide-disk.c	Version 1.18	Mar 05, 2003
  *
  *  Copyright (C) 1994-1998  Linus Torvalds & authors (see below)
- *  Copyright (C) 1998-2002  Linux ATA Developemt
+ *  Copyright (C) 1998-2002  Linux ATA Development
  *				Andre Hedrick <andre@linux-ide.org>
  *  Copyright (C) 2003	     Red Hat <alan@redhat.com>
  */
@@ -69,7 +69,7 @@
 #include <asm/uaccess.h>
 #include <asm/io.h>
 
-/* FIXME: some day we shouldnt need to look in here! */
+/* FIXME: some day we shouldn't need to look in here! */
 
 #include "legacy/pdc4030.h"
 
@@ -179,7 +179,7 @@
 	if (((long)(rq->current_nr_sectors -= nsect)) <= 0)
 		ide_end_request(drive, 1, rq->hard_cur_sectors);
 	/*
-	 * Another BH Page walker and DATA INTERGRITY Questioned on ERROR.
+	 * Another BH Page walker and DATA INTEGRITY Questioned on ERROR.
 	 * If passed back up on multimode read, BAD DATA could be ACKED
 	 * to FILE SYSTEMS above ...
 	 */
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65-bk3/drivers/ide/ide-iops.c linux-2.5.65-ac3/drivers/ide/ide-iops.c
--- linux-2.5.65-bk3/drivers/ide/ide-iops.c	2003-03-22 19:35:11.000000000 +0000
+++ linux-2.5.65-ac3/drivers/ide/ide-iops.c	2003-03-22 20:32:12.000000000 +0000
@@ -686,7 +686,7 @@
 		int hssbd = 0;
 		int i;
 		/*
-		 * Determime highest Supported SPEC
+		 * Determine highest Supported SPEC
 		 */
 		for (i=1; i<=15; i++)
 			if (drive->id->major_rev_num & (1<<i))
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65-bk3/drivers/ide/ide-probe.c linux-2.5.65-ac3/drivers/ide/ide-probe.c
--- linux-2.5.65-bk3/drivers/ide/ide-probe.c	2003-03-22 19:35:11.000000000 +0000
+++ linux-2.5.65-ac3/drivers/ide/ide-probe.c	2003-03-22 20:32:12.000000000 +0000
@@ -283,7 +283,7 @@
 /**
  *	actual_try_to_identify	-	send ata/atapi identify
  *	@drive: drive to identify
- *	@cmd: comamnd to use
+ *	@cmd: command to use
  *
  *	try_to_identify() sends an ATA(PI) IDENTIFY request to a drive
  *	and waits for a response.  It also monitors irqs while this is
@@ -371,7 +371,7 @@
 /**
  *	try_to_identify	-	try to identify a drive
  *	@drive: drive to probe
- *	@cmd: comamnd to use
+ *	@cmd: command to use
  *
  *	Issue the identify command and then do IRQ probing to
  *	complete the identification when needed by finding the
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65-bk3/drivers/ide/ide-tape.c linux-2.5.65-ac3/drivers/ide/ide-tape.c
--- linux-2.5.65-bk3/drivers/ide/ide-tape.c	2003-03-22 19:35:11.000000000 +0000
+++ linux-2.5.65-ac3/drivers/ide/ide-tape.c	2003-03-22 20:32:12.000000000 +0000
@@ -280,7 +280,7 @@
  *			- Add idetape_onstream_mode_sense_tape_parameter_page
  *			  function to get tape capacity in frames: tape->capacity.
  *			- Add support for DI-50 drives( or any DI- drive).
- *			- 'workaround' for read error/blank block arround block 3000.
+ *			- 'workaround' for read error/blank block around block 3000.
  *			- Implement Early warning for end of media for Onstream.
  *			- Cosmetic code changes for readability.
  *			- Idetape_position_tape should not use SKIP bit during
@@ -514,7 +514,7 @@
  * AUX
  */
 typedef struct os_aux_s {
-	__u32		format_id;		/* hardware compability AUX is based on */
+	__u32		format_id;		/* hardware compatibility AUX is based on */
 	char		application_sig[4];	/* driver used to write this media */
 	__u32		hdwr;			/* reserved */
 	__u32		update_frame_cntr;	/* for configuration frame */
@@ -1005,7 +1005,7 @@
 	struct completion *waiting;
 	int onstream_write_error;		/* write error recovery active */
 	int header_ok;				/* header frame verified ok */
-	int linux_media;			/* reading linux-specifc media */
+	int linux_media;			/* reading linux-specific media */
 	int linux_media_version;
 	char application_sig[5];		/* application signature */
 	int filemark_cnt;
