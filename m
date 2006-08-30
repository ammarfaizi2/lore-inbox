Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750909AbWH3MpP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750909AbWH3MpP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 08:45:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750898AbWH3MpP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 08:45:15 -0400
Received: from mtagate3.de.ibm.com ([195.212.29.152]:29202 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP
	id S1750909AbWH3MpN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 08:45:13 -0400
Date: Wed, 30 Aug 2006 14:45:10 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org, horst.hummel@de.ibm.com
Subject: [S390] dasd default debug level.
Message-ID: <20060830124510.GG22276@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Horst Hummel <horst.hummel@de.ibm.com>

[S390] dasd default debug level.

Enhanced default DBF level to get most important messages
in debug feature files.

Signed-off-by: Horst Hummel <horst.hummel@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/block/dasd.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff -urpN linux-2.6/drivers/s390/block/dasd.c linux-2.6-patched/drivers/s390/block/dasd.c
--- linux-2.6/drivers/s390/block/dasd.c	2006-08-30 14:24:59.000000000 +0200
+++ linux-2.6-patched/drivers/s390/block/dasd.c	2006-08-30 14:24:59.000000000 +0200
@@ -184,7 +184,7 @@ dasd_state_known_to_basic(struct dasd_de
 	device->debug_area = debug_register(device->cdev->dev.bus_id, 1, 2,
 					    8 * sizeof (long));
 	debug_register_view(device->debug_area, &debug_sprintf_view);
-	debug_set_level(device->debug_area, DBF_EMERG);
+	debug_set_level(device->debug_area, DBF_WARNING);
 	DBF_DEV_EVENT(DBF_EMERG, device, "%s", "debug area created");
 
 	device->state = DASD_STATE_BASIC;
@@ -2169,7 +2169,7 @@ dasd_init(void)
 		goto failed;
 	}
 	debug_register_view(dasd_debug_area, &debug_sprintf_view);
-	debug_set_level(dasd_debug_area, DBF_EMERG);
+	debug_set_level(dasd_debug_area, DBF_WARNING);
 
 	DBF_EVENT(DBF_EMERG, "%s", "debug area created");
 
