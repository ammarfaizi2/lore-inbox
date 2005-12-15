Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422644AbVLOJ2J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422644AbVLOJ2J (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 04:28:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422642AbVLOJ16
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 04:27:58 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:12458 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1422644AbVLOJSA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 04:18:00 -0500
To: torvalds@osdl.org
Subject: [PATCH] dell_rbu: NULL noise removal
Cc: linux-kernel@vger.kernel.org
Message-Id: <E1EmpFQ-0007zB-0k@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Thu, 15 Dec 2005 09:18:00 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>


---

 drivers/firmware/dell_rbu.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

fa3469085286914802dc906a61e87922a827b5c6
diff --git a/drivers/firmware/dell_rbu.c b/drivers/firmware/dell_rbu.c
index 6d83299..dfedb77 100644
--- a/drivers/firmware/dell_rbu.c
+++ b/drivers/firmware/dell_rbu.c
@@ -105,8 +105,8 @@ static int create_packet(void *data, siz
 	int ordernum = 0;
 	int retval = 0;
 	unsigned int packet_array_size = 0;
-	void **invalid_addr_packet_array = 0;
-	void *packet_data_temp_buf = 0;
+	void **invalid_addr_packet_array = NULL;
+	void *packet_data_temp_buf = NULL;
 	unsigned int idx = 0;
 
 	pr_debug("create_packet: entry \n");
@@ -178,7 +178,7 @@ static int create_packet(void *data, siz
 						packet_data_temp_buf),
 					allocation_floor);
 			invalid_addr_packet_array[idx++] = packet_data_temp_buf;
-			packet_data_temp_buf = 0;
+			packet_data_temp_buf = NULL;
 		}
 	}
 	spin_lock(&rbu_data.lock);
-- 
0.99.9.GIT

