Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751492AbWJRQ0H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751492AbWJRQ0H (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 12:26:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751498AbWJRQ0G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 12:26:06 -0400
Received: from mtagate5.de.ibm.com ([195.212.29.154]:54155 "EHLO
	mtagate5.de.ibm.com") by vger.kernel.org with ESMTP
	id S1751495AbWJRQ0E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 12:26:04 -0400
Date: Wed, 18 Oct 2006 18:26:10 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org, cornelia.huck@de.ibm.com
Subject: [S390] cio: sch_no -> schid.sch_no conversion.
Message-ID: <20061018162610.GC7158@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cornelia Huck <cornelia.huck@de.ibm.com>

[S390] cio: sch_no -> schid.sch_no conversion.

Overlooked one sch_no -> schid.sch_no conversion.

Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/cio/qdio.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -urpN linux-2.6/drivers/s390/cio/qdio.c linux-2.6-patched/drivers/s390/cio/qdio.c
--- linux-2.6/drivers/s390/cio/qdio.c	2006-10-18 17:12:37.000000000 +0200
+++ linux-2.6-patched/drivers/s390/cio/qdio.c	2006-10-18 17:12:53.000000000 +0200
@@ -3529,7 +3529,7 @@ do_QDIO(struct ccw_device *cdev,unsigned
 #ifdef CONFIG_QDIO_DEBUG
 	char dbf_text[20];
 
-	sprintf(dbf_text,"doQD%04x",cdev->private->sch_no);
+	sprintf(dbf_text,"doQD%04x",cdev->private->schid.sch_no);
  	QDIO_DBF_TEXT3(0,trace,dbf_text);
 #endif /* CONFIG_QDIO_DEBUG */
 
