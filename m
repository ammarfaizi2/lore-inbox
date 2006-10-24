Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932388AbWJXDSe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932388AbWJXDSe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 23:18:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932389AbWJXDSe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 23:18:34 -0400
Received: from xenotime.net ([66.160.160.81]:60382 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932388AbWJXDSe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 23:18:34 -0400
Date: Mon, 23 Oct 2006 20:20:11 -0700
From: Randy Dunlap <rdunlap@xenotime.net>
To: lkml <linux-kernel@vger.kernel.org>
Cc: akpm <akpm@osdl.org>, Alex Dubov <oakad@yahoo.com>
Subject: [PATCH] tifm: fix NULL ptr and style
Message-Id: <20061023202011.146f7fc0.rdunlap@xenotime.net>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <randy.dunlap@oracle.com>

Fix sparse NULL warning;
drivers/misc/tifm_core.c:223:17: warning: Using plain integer as NULL pointer

Fix style while there.

Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
---
 drivers/misc/tifm_core.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

--- linux-2.6.19-rc2-git8.orig/drivers/misc/tifm_core.c
+++ linux-2.6.19-rc2-git8/drivers/misc/tifm_core.c
@@ -219,8 +219,9 @@ static int tifm_device_remove(struct dev
 	struct tifm_driver *drv = fm_dev->drv;
 
 	if (drv) {
-		if (drv->remove) drv->remove(fm_dev);
-		fm_dev->drv = 0;
+		if (drv->remove)
+			drv->remove(fm_dev);
+		fm_dev->drv = NULL;
 	}
 
 	put_device(dev);


---
