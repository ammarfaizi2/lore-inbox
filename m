Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422931AbWHZRYb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422931AbWHZRYb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Aug 2006 13:24:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422934AbWHZRYb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Aug 2006 13:24:31 -0400
Received: from xenotime.net ([66.160.160.81]:22188 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1422931AbWHZRYb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Aug 2006 13:24:31 -0400
Date: Sat, 26 Aug 2006 10:27:40 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: lkml <linux-kernel@vger.kernel.org>
Cc: akpm <akpm@osdl.org>
Subject: [PATCH -mm] cdrom/gdsc: fix printk format warning
Message-Id: <20060826102740.f8718be0.rdunlap@xenotime.net>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@xenotime.net>

Fix printk format warning:
drivers/cdrom/gscd.c:269: warning: format ‘%lu’ expects type ‘long unsigned int’, but argument 2 has type ‘unsigned int’

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
---
 drivers/cdrom/gscd.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2618-rc4mm2-all.orig/drivers/cdrom/gscd.c
+++ linux-2618-rc4mm2-all/drivers/cdrom/gscd.c
@@ -266,7 +266,7 @@ repeat:
 		goto out;
 
 	if (req->cmd != READ) {
-		printk("GSCD: bad cmd %lu\n", rq_data_dir(req));
+		printk("GSCD: bad cmd %u\n", rq_data_dir(req));
 		end_request(req, 0);
 		goto repeat;
 	}


---
