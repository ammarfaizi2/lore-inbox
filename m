Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262106AbSIYUOk>; Wed, 25 Sep 2002 16:14:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262105AbSIYUOj>; Wed, 25 Sep 2002 16:14:39 -0400
Received: from [195.39.17.254] ([195.39.17.254]:4100 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S262106AbSIYUOc>;
	Wed, 25 Sep 2002 16:14:32 -0400
Date: Wed, 25 Sep 2002 20:57:23 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Rusty trivial patch monkey Russell <trivial@rustcorp.com.au>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Typo in ide
Message-ID: <20020925185715.GA779@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Tiny cleanups in IDE...
							Pavel


--- clean/drivers/ide/ide-disk.c	2002-09-23 00:09:13.000000000 +0200
+++ linux-swsusp/drivers/ide/ide-disk.c	2002-09-25 20:30:26.000000000 +0200
@@ -68,7 +68,7 @@
 #include <asm/uaccess.h>
 #include <asm/io.h>
 
-/* FIXME: soem day we shouldnt need to look in here! */
+/* FIXME: some day we shouldnt need to look in here! */
 
 #include "legacy/pdc4030.h"
 
--- clean/drivers/ide/ide-proc.c	2002-09-22 23:46:57.000000000 +0200
+++ linux-swsusp/drivers/ide/ide-proc.c	2002-09-22 23:53:21.000000000 +0200
@@ -590,7 +590,7 @@
 	(char *page, char **start, off_t off, int count, int *eof, void *data)
 {
 	ide_drive_t	*drive = (ide_drive_t *) data;
-	ide_driver_t	*driver = (ide_driver_t *) drive->driver;
+	ide_driver_t	*driver = drive->driver;
 	int		len;
 
 	if (!driver)
@@ -720,7 +720,6 @@
 	struct proc_dir_entry *ent;
 	struct proc_dir_entry *parent = hwif->proc;
 	char name[64];
-//	ide_driver_t *driver = drive->driver;
 
 	if (drive->present && !drive->proc) {
 		drive->proc = proc_mkdir(drive->name, parent);
--- clean/drivers/ide/ide.c	2002-09-23 00:09:13.000000000 +0200
+++ linux-swsusp/drivers/ide/ide.c	2002-09-23 23:14:14.000000000 +0200
@@ -153,6 +153,7 @@
 #include <linux/cdrom.h>
 #include <linux/seq_file.h>
 #include <linux/device.h>
+#include <linux/kmod.h>
 
 #include <asm/byteorder.h>
 #include <asm/irq.h>
@@ -162,7 +163,6 @@
 
 #include "ide_modes.h"
 
-#include <linux/kmod.h>
 
 /* default maximum number of failures */
 #define IDE_DEFAULT_MAX_FAILURES 	1

-- 
Worst form of spam? Adding advertisment signatures ala sourceforge.net.
What goes next? Inserting advertisment *into* email?
