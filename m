Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261528AbUKCJQ3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261528AbUKCJQ3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 04:16:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261537AbUKCJPm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 04:15:42 -0500
Received: from pimout1-ext.prodigy.net ([207.115.63.77]:39313 "EHLO
	pimout1-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S261528AbUKCJLU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 04:11:20 -0500
Date: Wed, 3 Nov 2004 01:11:01 -0800
From: Chris Wedgwood <cw@f00f.org>
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
       LKML <linux-kernel@vger.kernel.org>
Cc: Jeff Garzik <jgarzik@pobox.com>, Andrew Morton <akpm@osdl.org>
Subject: [PATCH] IDE remove some cruft from ide.h
Message-ID: <20041103091101.GC22469@taniwha.stupidest.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove some accumulated (unused) cruft from ide.h

Signed-off-by: Chris Wedgwood <cw@f00f.org>
---

Bart, How does this look?  I know a XXX comment has sneaked in, I
think it should stay for now but you can trim the patch if you
prfer...


===== include/linux/ide.h 1.155 vs edited =====
--- 1.155/include/linux/ide.h	2004-11-01 09:06:50 -08:00
+++ edited/include/linux/ide.h	2004-11-02 11:32:44 -08:00
@@ -39,7 +39,6 @@
  *
  * REALLY_SLOW_IO can be defined in ide.c and ide-cd.c, if necessary
  */
-#define REALLY_FAST_IO			/* define if ide ports are perfect */
 #define INITIAL_MULT_COUNT	0	/* off=0; on=2,4,8,16,32, etc.. */
 
 #ifndef SUPPORT_SLOW_DATA_PORTS		/* 1 to support slow data ports */
@@ -56,6 +55,7 @@
 #define DISABLE_IRQ_NOSYNC	0
 #endif
 
+/* XXX this needs to be killed */
 /*
  * Used to indicate "no IRQ", should be a value that cannot be an IRQ
  * number.
@@ -64,18 +64,6 @@
 #define IDE_NO_IRQ		(-1)
 
 /*
- * IDE_DRIVE_CMD is used to implement many features of the hdparm utility
- */
-#define IDE_DRIVE_CMD			99	/* (magic) undef to reduce kernel size*/
-
-#define IDE_DRIVE_TASK			98
-
-/*
- * IDE_DRIVE_TASKFILE is used to implement many features needed for raw tasks
- */
-#define IDE_DRIVE_TASKFILE		97
-
-/*
  *  "No user-serviceable parts" beyond this point  :)
  *****************************************************************************/
 
@@ -197,13 +185,8 @@ typedef unsigned char	byte;	/* used ever
 /*
  * Some more useful definitions
  */
-#define IDE_MAJOR_NAME	"hd"	/* the same for all i/f; see also genhd.c */
-#define MAJOR_NAME	IDE_MAJOR_NAME
 #define PARTN_BITS	6	/* number of minor dev bits for partitions */
-#define PARTN_MASK	((1<<PARTN_BITS)-1)	/* a useful bit mask */
 #define MAX_DRIVES	2	/* per interface; 2 assumed by lots of code */
-#define SECTOR_SIZE	512
-#define SECTOR_WORDS	(SECTOR_SIZE / 4)	/* number of 32bit words per sector */
 #define IDE_LARGE_SEEK(b1,b2,t)	(((b1) > (b2) + (t)) || ((b2) > (b1) + (t)))
 
 /*
