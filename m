Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261200AbVAHQGc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261200AbVAHQGc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 11:06:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261201AbVAHQGc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 11:06:32 -0500
Received: from ns3.dataphone.se ([212.37.0.170]:58828 "EHLO
	mail-slave.dataphone.se") by vger.kernel.org with ESMTP
	id S261200AbVAHQGa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 11:06:30 -0500
From: Magnus Damm <damm@opensource.se>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Magnus Damm <damm@opensource.se>
Message-Id: <20050108160509.14026.98420.83109@kubu>
Subject: [PATCH] ide: possible typo in ide-disk.c
Date: Sat,  8 Jan 2005 17:06:28 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

A search for "task_no_data_intr" tells me that this is probably a typo.

/ magnus

Signed-off-by: Magnus Damm <damm@opensource.se>

--- linux-2.6.10/drivers/ide/ide-disk.c	2004-12-24 22:34:32.000000000 +0100
+++ linux-2.6.10-ide_task_no_data_intr_20050108/drivers/ide/ide-disk.c	2005-01-08 16:24:26.000000000 +0100
@@ -1100,7 +1100,7 @@
 	case idedisk_pm_idle:		/* Resume step 1 (idle) */
 		args->tfRegister[IDE_COMMAND_OFFSET] = WIN_IDLEIMMEDIATE;
 		args->command_type = IDE_DRIVE_TASK_NO_DATA;
-		args->handler = task_no_data_intr;
+		args->handler = &task_no_data_intr;
 		return do_rw_taskfile(drive, args);
 
 	case idedisk_pm_restore_dma:	/* Resume step 2 (restore DMA) */
