Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314551AbSGRExM>; Thu, 18 Jul 2002 00:53:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316390AbSGRExM>; Thu, 18 Jul 2002 00:53:12 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:27835 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S314551AbSGRExL>;
	Thu, 18 Jul 2002 00:53:11 -0400
Date: Wed, 17 Jul 2002 21:52:35 -0700
From: Anton Blanchard <anton@samba.org>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] flags must be unsigned long
Message-ID: <20020718045235.GB1204@krispykreme>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

We must pass an unsigned long into __save_flags() etc.

Anton

===== drivers/scsi/scsi_lib.c 1.27 vs edited =====
--- 1.27/drivers/scsi/scsi_lib.c	Tue Jul  2 07:44:25 2002
+++ edited/drivers/scsi/scsi_lib.c	Wed Jul 17 21:46:04 2002
@@ -360,7 +360,7 @@
 {
 	request_queue_t *q = &SCpnt->device->request_queue;
 	struct request *req = SCpnt->request;
-	int flags;
+	unsigned long flags;
 
 	ASSERT_LOCK(q->queue_lock, 0);
