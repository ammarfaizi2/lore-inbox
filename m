Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264232AbVBEC5S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264232AbVBEC5S (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 21:57:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264156AbVBECy2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 21:54:28 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:21508 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S265532AbVBECoI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 21:44:08 -0500
Date: Sat, 5 Feb 2005 03:44:04 +0100
From: Adrian Bunk <bunk@stusta.de>
To: B.Zolnierkiewicz@elka.pw.edu.pl
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Subject: [RFC: 2.6 patch] IDE: unsexport 3 functions
Message-ID: <20050205024404.GK19408@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch removes three unneeded EXPORT_SYMBOL's.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/ide/ide-iops.c     |    4 ----
 drivers/ide/ide-taskfile.c |    2 --
 2 files changed, 6 deletions(-)

--- linux-2.6.11-rc3-mm1-full/drivers/ide/ide-iops.c.old	2005-02-05 02:54:15.000000000 +0100
+++ linux-2.6.11-rc3-mm1-full/drivers/ide/ide-iops.c	2005-02-05 02:55:21.000000000 +0100
@@ -104,8 +104,6 @@
 	hwif->INSL	= ide_insl;
 }
 
-EXPORT_SYMBOL(default_hwif_iops);
-
 /*
  *	MMIO operations, typically used for SATA controllers
  */
@@ -329,8 +327,6 @@
 	hwif->atapi_output_bytes	= atapi_output_bytes;
 }
 
-EXPORT_SYMBOL(default_hwif_transport);
-
 /*
  * Beginning of Taskfile OPCODE Library and feature sets.
  */
--- linux-2.6.11-rc3-mm1-full/drivers/ide/ide-taskfile.c.old	2005-02-05 02:57:03.000000000 +0100
+++ linux-2.6.11-rc3-mm1-full/drivers/ide/ide-taskfile.c	2005-02-05 02:57:12.000000000 +0100
@@ -161,8 +161,6 @@
 	return ide_stopped;
 }
 
-EXPORT_SYMBOL(do_rw_taskfile);
-
 /*
  * set_multmode_intr() is invoked on completion of a WIN_SETMULT cmd.
  */

