Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422650AbVLOJX3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422650AbVLOJX3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 04:23:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422652AbVLOJX1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 04:23:27 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:62083 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1422650AbVLOJSz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 04:18:55 -0500
To: torvalds@osdl.org
Subject: [PATCH] drivers/atm/adummy.c NULL noise removal
Cc: linux-kernel@vger.kernel.org
Message-Id: <E1EmpGJ-00080m-3z@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Thu, 15 Dec 2005 09:18:55 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>


---

 drivers/atm/adummy.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

ade4747aab9e9bacbab04d37acdf8fb69a903934
diff --git a/drivers/atm/adummy.c b/drivers/atm/adummy.c
index d15c194..d1387cf 100644
--- a/drivers/atm/adummy.c
+++ b/drivers/atm/adummy.c
@@ -123,7 +123,7 @@ static int __init adummy_init(void)
 	}
 	memset(adummy_dev, 0, sizeof(struct adummy_dev));
 
-	atm_dev = atm_dev_register(DEV_LABEL, &adummy_ops, -1, 0);
+	atm_dev = atm_dev_register(DEV_LABEL, &adummy_ops, -1, NULL);
 	if (!atm_dev) {
 		printk(KERN_ERR DEV_LABEL ": atm_dev_register() failed\n");
 		err = -ENODEV;
-- 
0.99.9.GIT

