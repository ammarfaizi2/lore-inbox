Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268150AbTBNVNs>; Fri, 14 Feb 2003 16:13:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268046AbTBNVNR>; Fri, 14 Feb 2003 16:13:17 -0500
Received: from 24-168-145-62.nj.rr.com ([24.168.145.62]:5932 "EHLO
	mail.larvalstage.com") by vger.kernel.org with ESMTP
	id <S268150AbTBNVMT>; Fri, 14 Feb 2003 16:12:19 -0500
Date: Fri, 14 Feb 2003 16:21:52 -0500 (EST)
From: John Kim <john@larvalstage.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 2.5.60-bk4] fix compile breakage on drivers/scsi/NCR53c406a.c
Message-ID: <Pine.LNX.4.53.0302141620060.21601@quinn.larvalstage.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This fixes compile breakage due to recent changes to scsi.h

John Kim


--- linux-2.5.60-bk4/drivers/scsi/NCR53c406a.c	2003-02-10 13:38:31.000000000 -0500
+++ linux-2.5.60-bk4-new/drivers/scsi/NCR53c406a.c	2003-02-14 15:41:10.000000000 -0500
@@ -697,7 +697,7 @@
 
 	/* We are locked here already by the mid layer */
 	REG0;
-	outb(SCpnt->target, DEST_ID);	/* set destination */
+	outb(SCpnt->device->id, DEST_ID);	/* set destination */
 	outb(FLUSH_FIFO, CMD_REG);	/* reset the fifos */
 
 	for (i = 0; i < SCpnt->cmd_len; i++) {
