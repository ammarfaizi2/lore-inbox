Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261250AbVCON70@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261250AbVCON70 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 08:59:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261256AbVCON70
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 08:59:26 -0500
Received: from aun.it.uu.se ([130.238.12.36]:1511 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S261250AbVCON7N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 08:59:13 -0500
From: Mikael Pettersson <mikpe@user.it.uu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16950.59948.810534.979691@alkaid.it.uu.se>
Date: Tue, 15 Mar 2005 14:59:08 +0100
To: linux-kernel@vger.kernel.org
Subject: [PATCH][2.6.11] drivers/media/dvb/bt8xx/bt878.h gcc4 fix
Cc: linux-dvb-maintainer@linuxtv.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix one array-of-incomplete-type error from gcc4 in bt878.h.

/Mikael

--- linux-2.6.11/drivers/media/dvb/bt8xx/bt878.h.~1~	2004-12-25 12:16:19.000000000 +0100
+++ linux-2.6.11/drivers/media/dvb/bt8xx/bt878.h	2005-03-15 11:47:50.000000000 +0100
@@ -89,7 +89,6 @@
 #define BT878_RISC_SYNC_MASK	(1 << 15)
 
 extern int bt878_num;
-extern struct bt878 bt878[BT878_MAX];
 
 struct bt878 {
 	struct semaphore  gpio_lock;
@@ -124,6 +123,8 @@ struct bt878 {
 	int shutdown;	
 };
 
+extern struct bt878 bt878[BT878_MAX];
+
 void bt878_start(struct bt878 *bt, u32 controlreg, u32 op_sync_orin,
 		u32 irq_err_ignore);
 void bt878_stop(struct bt878 *bt);	     
