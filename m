Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287972AbSAMC6L>; Sat, 12 Jan 2002 21:58:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288008AbSAMC4L>; Sat, 12 Jan 2002 21:56:11 -0500
Received: from PHNX1-UBR2-4-hfc-0251-d1dae065.rdc1.az.coxatwork.com ([209.218.224.101]:53635
	"EHLO mail.labsysgrp.com") by vger.kernel.org with ESMTP
	id <S287966AbSAMCyR>; Sat, 12 Jan 2002 21:54:17 -0500
Message-ID: <005d01c19bdd$a19838b0$6caaa8c0@kevin>
From: "Kevin P. Fleming" <kevin@labsysgrp.com>
To: <linux-kernel@vger.kernel.org>
Cc: "Paul Bristow" <paul@paulbristow.net>
Subject: [CFT][PATCH] ide-floppy cleanups/media change detection (2/5)
Date: Sat, 12 Jan 2002 19:54:34 -0700
Organization: LSG, Inc.
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patch 2 follows:

diff -X dontdiff -urN linux-1/drivers/ide/ide-floppy.c
linux-2/drivers/ide/ide-floppy.c
--- linux-1/drivers/ide/ide-floppy.c Sat Jan 12 16:33:08 2002
+++ linux-2/drivers/ide/ide-floppy.c Sat Jan 12 16:48:05 2002
@@ -1957,17 +1957,6 @@
   for (i = 0; i < 1 << PARTN_BITS; i++)
    max_sectors[major][minor + i] = 64;
  }
-  /*
-   *      Guess what?  The IOMEGA Clik! drive also needs the
-   *      above fix.  It makes nasty clicking noises without
-   *      it, so please don't remove this.
-   */
-  if (strcmp(drive->id->model, "IOMEGA Clik! 40 CZ ATAPI") == 0)
-  {
-    for (i = 0; i < 1 << PARTN_BITS; i++)
-      max_sectors[major][minor + i] = 64;
-    set_bit(IDEFLOPPY_CLIK_DRIVE, &floppy->flags);
-  }

  /*
  *      Guess what?  The IOMEGA Clik! drive also needs the



