Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263781AbTEODTl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 23:19:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263783AbTEODSt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 23:18:49 -0400
Received: from deviant.impure.org.uk ([195.82.120.238]:12780 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id S263785AbTEODSU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 23:18:20 -0400
Date: Thu, 15 May 2003 04:31:07 +0100
Message-Id: <200305150331.h4F3V7TY000619@deviant.impure.org.uk>
To: jgarzik@pobox.com
From: davej@codemonkey.org.uk
Cc: linux-kernel@vger.kernel.org
Subject: Nuke stale comment from bmac
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Leftovers from before we used memset to clear the struct.

diff -urpN --exclude-from=/home/davej/.exclude bk-linus/drivers/net/bmac.c linux-2.5/drivers/net/bmac.c
--- bk-linus/drivers/net/bmac.c	2003-05-11 22:59:28.000000000 +0100
+++ linux-2.5/drivers/net/bmac.c	2003-05-11 23:20:44.000000000 +0100
@@ -1407,7 +1407,6 @@ static void __init bmac_probe1(struct de
 	skb_queue_head_init(bp->queue);
 
 	init_timer(&bp->tx_timeout);
-	/*     bp->timeout_active = 0; */
 
 	ret = request_irq(dev->irq, bmac_misc_intr, 0, "BMAC-misc", dev);
 	if (ret) {
