Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266014AbUBCPvf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Feb 2004 10:51:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266009AbUBCPvf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Feb 2004 10:51:35 -0500
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:49601 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S266007AbUBCPv0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Feb 2004 10:51:26 -0500
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: linux-ide@vger.kernel.org
Subject: [PATCH] remove unused ide_devices_t from ide.c and ide.h
Date: Tue, 3 Feb 2004 16:55:25 +0100
User-Agent: KMail/1.5.3
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200402031655.25774.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Introduced in 2.4.21 and never used.

 linux-2.6.2-rc3-bk3-root/drivers/ide/ide.c   |   12 ------------
 linux-2.6.2-rc3-bk3-root/include/linux/ide.h |   14 --------------
 2 files changed, 26 deletions(-)

diff -puN drivers/ide/ide.c~ide_devices_cleanup drivers/ide/ide.c
--- linux-2.6.2-rc3-bk3/drivers/ide/ide.c~ide_devices_cleanup	2004-02-03 15:57:04.080097824 +0100
+++ linux-2.6.2-rc3-bk3-root/drivers/ide/ide.c	2004-02-03 15:57:04.091096152 +0100
@@ -197,18 +197,6 @@ ide_hwif_t ide_hwifs[MAX_HWIFS];	/* mast
 
 EXPORT_SYMBOL(ide_hwifs);
 
-ide_devices_t *idedisk;
-ide_devices_t *idecd;
-ide_devices_t *idefloppy;
-ide_devices_t *idetape;
-ide_devices_t *idescsi;
-
-EXPORT_SYMBOL(idedisk);
-EXPORT_SYMBOL(idecd);
-EXPORT_SYMBOL(idefloppy);
-EXPORT_SYMBOL(idetape);
-EXPORT_SYMBOL(idescsi);
-
 extern ide_driver_t idedefault_driver;
 static void setup_driver_defaults(ide_driver_t *driver);
 
diff -puN include/linux/ide.h~ide_devices_cleanup include/linux/ide.h
--- linux-2.6.2-rc3-bk3/include/linux/ide.h~ide_devices_cleanup	2004-02-03 15:57:04.084097216 +0100
+++ linux-2.6.2-rc3-bk3-root/include/linux/ide.h	2004-02-03 15:57:04.094095696 +0100
@@ -1214,13 +1214,6 @@ typedef struct ide_driver_s {
 
 extern int generic_ide_ioctl(struct block_device *, unsigned, unsigned long);
 
-typedef struct ide_devices_s {
-	char			name[4];		/* hdX */
-	unsigned		attached	: 1;	/* native */
-	unsigned		alttached	: 1;	/* alternate */
-	struct ide_devices_s	*next;
-} ide_devices_t;
-
 /*
  * ide_hwifs[] is the master data structure used to keep track
  * of just about everything in ide.c.  Whenever possible, routines
@@ -1231,13 +1224,6 @@ typedef struct ide_devices_s {
  */
 #ifndef _IDE_C
 extern	ide_hwif_t	ide_hwifs[];		/* master data repository */
-
-extern ide_devices_t   *idedisk;
-extern ide_devices_t   *idecd;
-extern ide_devices_t   *idefloppy;
-extern ide_devices_t   *idetape;
-extern ide_devices_t   *idescsi;
-
 #endif
 extern int noautodma;
 

_

