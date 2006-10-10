Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030497AbWJJVpa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030497AbWJJVpa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 17:45:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030505AbWJJVpO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 17:45:14 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:31428 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1030489AbWJJVo6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 17:44:58 -0400
To: torvalds@osdl.org
Subject: [PATCH] NULL noise removal: advansys
Cc: linux-kernel@vger.kernel.org
Message-Id: <E1GXPPF-0007K9-4t@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Tue, 10 Oct 2006 22:44:57 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 drivers/scsi/advansys.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/advansys.c b/drivers/scsi/advansys.c
index 587eac9..2b34435 100644
--- a/drivers/scsi/advansys.c
+++ b/drivers/scsi/advansys.c
@@ -3951,7 +3951,7 @@ typedef struct _PCI_CONFIG_SPACE_
 
 /* Number of boards detected in system. */
 STATIC int asc_board_count = 0;
-STATIC struct Scsi_Host    *asc_host[ASC_NUM_BOARD_SUPPORTED] = { 0 };
+STATIC struct Scsi_Host    *asc_host[ASC_NUM_BOARD_SUPPORTED] = { NULL };
 
 /* Overrun buffer used by all narrow boards. */
 STATIC uchar overrun_buf[ASC_OVERRUN_BSIZE] = { 0 };
@@ -6621,7 +6621,7 @@ adv_build_req(asc_board_t *boardp, struc
 	        dma_map_single(dev, scp->request_buffer,
 			       scp->request_bufflen, scp->sc_data_direction);
 	} else {
-	    scsiqp->vdata_addr = 0;
+	    scsiqp->vdata_addr = NULL;
 	    scp->SCp.dma_handle = 0;
 	}
 	scsiqp->data_addr = cpu_to_le32(scp->SCp.dma_handle);
-- 
1.4.2.GIT


