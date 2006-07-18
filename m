Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751320AbWGRLxe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751320AbWGRLxe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jul 2006 07:53:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751322AbWGRLxe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jul 2006 07:53:34 -0400
Received: from mtagate4.de.ibm.com ([195.212.29.153]:50627 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP
	id S1751320AbWGRLxd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jul 2006 07:53:33 -0400
Date: Tue, 18 Jul 2006 13:53:39 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org, cornelia.huck@de.ibm.com
Subject: [patch 3/6] s390: channel measurement interval display.
Message-ID: <20060718115339.GC20884@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cornelia Huck <cornelia.huck@de.ibm.com>

[S390] channel measurement interval display.

Display avg_sample_interval in nanoseconds, like it is documented.

Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/cio/cmf.c |    1 +
 1 files changed, 1 insertion(+)

diff -urpN linux-2.6/drivers/s390/cio/cmf.c linux-2.6-patched/drivers/s390/cio/cmf.c
--- linux-2.6/drivers/s390/cio/cmf.c	2006-07-18 13:40:28.000000000 +0200
+++ linux-2.6-patched/drivers/s390/cio/cmf.c	2006-07-18 13:40:44.000000000 +0200
@@ -1068,6 +1068,7 @@ cmb_show_avg_sample_interval(struct devi
 	if (count) {
 		interval = cmb_data->last_update -
 			cdev->private->cmb_start_time;
+		interval = (interval * 1000) >> 12;
 		interval /= count;
 	} else
 		interval = -1;
