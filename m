Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266710AbUF3PaR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266710AbUF3PaR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jun 2004 11:30:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266735AbUF3P3p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jun 2004 11:29:45 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:16053 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S266712AbUF3PZe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jun 2004 11:25:34 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: linux-ide@vger.kernel.org
Subject: [PATCH] ide-taskfile.c fixups/cleanups part #2 [5/9]
Date: Wed, 30 Jun 2004 17:28:35 +0200
User-Agent: KMail/1.5.3
Cc: linux-kernel@vger.kernel.org, rmk@arm.linux.org.uk
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200406301725.23876.bzolnier@elka.pw.edu.pl>
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[PATCH] remove pre_task_out_intr() comment (CONFIG_IDE_TASKFILE_IO=n)

disable_irq_nosync() in ide-io.c:ide_do_request() protects
pre_task_out_intr() from racing with the task_out_intr().

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>

 linux-2.6.7-bk11-bzolnier/drivers/ide/ide-taskfile.c |    4 ----
 1 files changed, 4 deletions(-)

diff -puN drivers/ide/ide-taskfile.c~ide_pre_task_out_intr drivers/ide/ide-taskfile.c
--- linux-2.6.7-bk11/drivers/ide/ide-taskfile.c~ide_pre_task_out_intr	2004-06-28 21:25:10.454621008 +0200
+++ linux-2.6.7-bk11-bzolnier/drivers/ide/ide-taskfile.c	2004-06-28 21:25:10.458620400 +0200
@@ -369,10 +369,6 @@ ide_startstop_t task_mulin_intr (ide_dri
 
 EXPORT_SYMBOL(task_mulin_intr);
 
-/*
- * VERIFY ME before 2.4 ... unexpected race is possible based on details
- * RMK with 74LS245/373/374 TTL buffer logic because of passthrough.
- */
 ide_startstop_t pre_task_out_intr (ide_drive_t *drive, struct request *rq)
 {
 	ide_startstop_t startstop;

_

