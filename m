Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291620AbSCIAB0>; Fri, 8 Mar 2002 19:01:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291717AbSCIABG>; Fri, 8 Mar 2002 19:01:06 -0500
Received: from tomts7.bellnexxia.net ([209.226.175.40]:6822 "EHLO
	tomts7-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S291620AbSCIAA7>; Fri, 8 Mar 2002 19:00:59 -0500
Content-Type: text/plain; charset=US-ASCII
From: jason <jasonmc@sympatico.ca>
To: torvalds@transmeta.com
Subject: [patch] ide-scsi compile fix
Date: Fri, 8 Mar 2002 18:58:51 -0500
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020308235852.FAQN13574.tomts7-srv.bellnexxia.net@there>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

GCC gives an error about an undefined reference to idescsi_init from ide.c when compiling 2.5.6 with ide scsi emulation enabled, this patch corrects the problem.

--- a/drivers/scsi/ide-scsi.c   Fri Mar  8 17:22:52 2002
+++ b/drivers/scsi/ide-scsi.c   Fri Mar  8 17:23:00 2002
@@ -565,7 +565,7 @@
 /*
  *     idescsi_init will register the driver for each scsi.
  */
-static int idescsi_init(void)
+int idescsi_init(void)
 {
        ide_drive_t *drive;
        idescsi_scsi_t *scsi;

