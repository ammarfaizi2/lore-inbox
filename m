Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267883AbTBRSFy>; Tue, 18 Feb 2003 13:05:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267897AbTBRSFS>; Tue, 18 Feb 2003 13:05:18 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:40201 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S267874AbTBRSEp>; Tue, 18 Feb 2003 13:04:45 -0500
Subject: PATCH: add a 'NO_IRQ' definition to IDE
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Date: Tue, 18 Feb 2003 18:15:08 +0000 (GMT)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E18lCGq-0006AW-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(second hunk just makes 2.4/2.5 header match format)

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.61/include/linux/ide.h linux-2.5.61-ac2/include/linux/ide.h
--- linux-2.5.61/include/linux/ide.h	2003-02-10 18:38:20.000000000 +0000
+++ linux-2.5.61-ac2/include/linux/ide.h	2003-02-18 18:02:56.000000000 +0000
@@ -71,6 +71,13 @@
 #endif
 
 /*
+ * Used to indicate "no IRQ", should be a value that cannot be an IRQ
+ * number.
+ */
+ 
+#define IDE_NO_IRQ		(-1)
+
+/*
  * IDE_DRIVE_CMD is used to implement many features of the hdparm utility
  */
 #define IDE_DRIVE_CMD			99	/* (magic) undef to reduce kernel size*/
@@ -106,6 +113,7 @@
 /*
  * state flags
  */
+
 #define DMA_PIO_RETRY	1	/* retrying in PIO */
 
 /*
