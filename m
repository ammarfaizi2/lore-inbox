Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936397AbWLAOpX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936397AbWLAOpX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 09:45:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936508AbWLAOpW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 09:45:22 -0500
Received: from xdsl-664.zgora.dialog.net.pl ([81.168.226.152]:20744 "EHLO
	tuxland.pl") by vger.kernel.org with ESMTP id S936397AbWLAOpW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 09:45:22 -0500
From: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
To: Willy Tarreau <wtarreau@hera.kernel.org>
Subject: [2.4 PATCH] scsi 53c7,8xx parenthesis fix
Date: Fri, 1 Dec 2006 15:44:56 +0100
User-Agent: KMail/1.9.5
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612011544.57145.m.kozlowski@tuxland.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

	This patch removes an extra parenthesis in debugger_fn_bs() code.

Signed-off-by: Mariusz Kozlowski <m.kozlowski@tuxland.pl>

 drivers/scsi/53c7,8xx.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2.4.34-pre6-a/drivers/scsi/53c7,8xx.c	2004-11-17 12:54:21.000000000 +0100
+++ linux-2.4.34-pre6-b/drivers/scsi/53c7,8xx.c	2006-12-01 12:21:50.000000000 +0100
@@ -3197,7 +3197,7 @@ debugger_fn_bs (struct Scsi_Host *host, 
 
     bp->address = (u32 *) args[0];
     memcpy ((void *) bp->old_instruction, (void *) bp->address, 8);
-    bp->old_size = (((bp->old_instruction[0] >> 24) & DCMD_TYPE_MASK) ==
+    bp->old_size = ((bp->old_instruction[0] >> 24) & DCMD_TYPE_MASK) ==
 	DCMD_TYPE_MMI ? 3 : 2;
     bp->next = hostdata->breakpoints;
     hostdata->breakpoints = bp->next;


-- 
Regards,

	Mariusz Kozlowski
