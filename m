Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751253AbWIDJY6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751253AbWIDJY6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Sep 2006 05:24:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751267AbWIDJY6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Sep 2006 05:24:58 -0400
Received: from mtagate3.de.ibm.com ([195.212.29.152]:40247 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP
	id S1751253AbWIDJY4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Sep 2006 05:24:56 -0400
Date: Mon, 4 Sep 2006 11:24:55 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org, fpavlic@de.ibm.com
Subject: [S390] qdio slsb processing state.
Message-ID: <20060904092455.GC9215@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frank Pavlic <fpavlic@de.ibm.com>

[S390] qdio slsb processing state.

The last SLSB has to be set to STATE_PROCESSING if we really want to 
use the PROCESSING feature. 

Signed-off-by: Frank Pavlic <fpavlic@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/cio/qdio.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -urpN linux-2.6/drivers/s390/cio/qdio.c linux-2.6-patched/drivers/s390/cio/qdio.c
--- linux-2.6/drivers/s390/cio/qdio.c	2006-09-04 11:08:53.000000000 +0200
+++ linux-2.6-patched/drivers/s390/cio/qdio.c	2006-09-04 11:09:00.000000000 +0200
@@ -1129,7 +1129,7 @@ out:
 
 #ifdef QDIO_USE_PROCESSING_STATE
 	if (last_position>=0)
-		set_slsb(q, &last_position, SLSB_P_INPUT_NOT_INIT, &count);
+		set_slsb(q, &last_position, SLSB_P_INPUT_PROCESSING, &count);
 #endif /* QDIO_USE_PROCESSING_STATE */
 
 	QDIO_DBF_HEX4(0,trace,&q->first_to_check,sizeof(int));

-- 
VGER BF report: H 8.40617e-05
