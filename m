Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932441AbWAWQiI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932441AbWAWQiI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 11:38:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932436AbWAWQiH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 11:38:07 -0500
Received: from e31.co.us.ibm.com ([32.97.110.149]:38845 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S932276AbWAWQiG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 11:38:06 -0500
Subject: [PATCH] tpm: tpm_bios remove unused variable
From: Kylene Jo Hall <kjhall@us.ibm.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Mon, 23 Jan 2006 10:39:14 -0600
Message-Id: <1138034354.5076.22.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Removing event_data_size since it was pointed out in tpm_bios-indexing-
fix.patch that is was ugly and it wasn't actually being used.

Signed-off-by: Kylene Hall <kjhall@us.ibm.com>
--- 
diff -uprN --exclude-from=linux_excludes linux-2.6.16-rc1/drivers/char/tpm/tpm_bios.c linux-2.6.16-rc1-tpm/drivers/char/tpm/tpm_bios.c
--- linux-2.6.16-rc1/drivers/char/tpm/tpm_bios.c	2006-01-20 14:21:13.000000000 -0600
+++ linux-2.6.16-rc1-tpm/drivers/char/tpm/tpm_bios.c	2006-01-20 14:05:41.000000000 -0600
@@ -191,7 +191,7 @@ static int get_event_name(char *dest, st
 	const char *name = "";
 	char data[40] = "";
 	int i, n_len = 0, d_len = 0;
-	u32 event_id, event_data_size;
+	u32 event_id;
 
 	switch(event->event_type) {
 	case PREBOOT:
@@ -221,7 +221,6 @@ static int get_event_name(char *dest, st
 		break;
 	case EVENT_TAG:
 		event_id = be32_to_cpu(*((u32 *)event_entry));
-		event_data_size = be32_to_cpu(((u32 *)event_entry)[1]);
 
 		/* ToDo Row data -> Base64 */
 


