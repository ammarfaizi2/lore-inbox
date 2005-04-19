Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261278AbVDSCmA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261278AbVDSCmA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Apr 2005 22:42:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261279AbVDSCmA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Apr 2005 22:42:00 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:58125 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261278AbVDSClg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Apr 2005 22:41:36 -0400
Date: Tue, 19 Apr 2005 04:41:33 +0200
From: Adrian Bunk <bunk@stusta.de>
To: irda-users@lists.sourceforge.net
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com
Subject: [2.6 patch] drivers/net/irda/irport.c: cleanups
Message-ID: <20050419024133.GV5489@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch contains the following cleanups:
- make a needlessly global function static
- remove the unneeded global function irport_probe

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/net/irda/irport.c |   15 +--------------
 1 files changed, 1 insertion(+), 14 deletions(-)

--- linux-2.6.12-rc2-mm3-full/drivers/net/irda/irport.c.old	2005-04-19 03:06:12.000000000 +0200
+++ linux-2.6.12-rc2-mm3-full/drivers/net/irda/irport.c	2005-04-19 03:06:45.000000000 +0200
@@ -286,19 +286,6 @@
 }
 
 /*
- * Function irport_probe (void)
- *
- *    Start IO port 
- *
- */
-int irport_probe(int iobase)
-{
-	IRDA_DEBUG(4, "%s(), iobase=%#x\n", __FUNCTION__, iobase);
-
-	return 0;
-}
-
-/*
  * Function irport_get_fcr (speed)
  *
  *    Compute value of fcr
@@ -383,7 +370,7 @@
  *    we cannot use schedule_timeout() when we are in interrupt context
  *
  */
-int __irport_change_speed(struct irda_task *task)
+static int __irport_change_speed(struct irda_task *task)
 {
 	struct irport_cb *self;
 	__u32 speed = (__u32) task->param;

