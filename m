Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964957AbWFNOHS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964957AbWFNOHS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jun 2006 10:07:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964959AbWFNOHS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jun 2006 10:07:18 -0400
Received: from mtagate3.de.ibm.com ([195.212.29.152]:34421 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP id S964955AbWFNOHQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jun 2006 10:07:16 -0400
Date: Wed, 14 Jun 2006 16:07:17 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org, wein@de.ibm.com
Subject: [patch 22/24] s390: dasd eer data format.
Message-ID: <20060614140717.GW9475@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefan Weinhuber <wein@de.ibm.com>

[S390] dasd eer data format.

The struct dasd_eer_header needs the packed attribute, or there will
be 6 additional bytes of random data between the fixed header and
the variable length part of the eer data.

Signed-off-by: Stefan Weinhuber <wein@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/block/dasd_eer.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -urpN linux-2.6/drivers/s390/block/dasd_eer.c linux-2.6-patched/drivers/s390/block/dasd_eer.c
--- linux-2.6/drivers/s390/block/dasd_eer.c	2006-06-14 14:29:47.000000000 +0200
+++ linux-2.6-patched/drivers/s390/block/dasd_eer.c	2006-06-14 14:30:02.000000000 +0200
@@ -276,7 +276,7 @@ struct dasd_eer_header {
 	__u64 tv_sec;
 	__u64 tv_usec;
 	char busid[DASD_EER_BUSID_SIZE];
-};
+} __attribute__ ((packed));
 
 /*
  * The following function can be used for those triggers that have
