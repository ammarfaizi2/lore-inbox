Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964818AbWIKNPa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964818AbWIKNPa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 09:15:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964769AbWIKNPa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 09:15:30 -0400
Received: from havoc.gtf.org ([69.61.125.42]:64899 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S1751475AbWIKNP3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 09:15:29 -0400
Date: Mon, 11 Sep 2006 09:15:28 -0400
From: Jeff Garzik <jeff@garzik.org>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [git patch] net driver fix
Message-ID: <20060911131528.GA5059@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Please pull from 'upstream-linus' branch of
master.kernel.org:/pub/scm/linux/kernel/git/jgarzik/netdev-2.6.git upstream-linus

to receive the following updates:

 drivers/net/dm9000.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Dirk Opfer:
      Fix dm9000 release_resource

diff --git a/drivers/net/dm9000.c b/drivers/net/dm9000.c
index 3d76fa1..a860ebb 100644
--- a/drivers/net/dm9000.c
+++ b/drivers/net/dm9000.c
@@ -377,8 +377,8 @@ dm9000_release_board(struct platform_dev
 		kfree(db->data_req);
 	}
 
-	if (db->addr_res != NULL) {
-		release_resource(db->addr_res);
+	if (db->addr_req != NULL) {
+		release_resource(db->addr_req);
 		kfree(db->addr_req);
 	}
 }
