Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262045AbVCVV7O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262045AbVCVV7O (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 16:59:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262011AbVCVV4c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 16:56:32 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:53004 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262054AbVCVVyB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 16:54:01 -0500
Date: Tue, 22 Mar 2005 22:53:54 +0100
From: Adrian Bunk <bunk@stusta.de>
To: jgarzik@pobox.com
Cc: linux-net@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/net/eql.c: kill dead code
Message-ID: <20050322215354.GM1948@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes some obviously dead code found by the Coverity 
checker.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.12-rc1-mm1-full/drivers/net/eql.c.old	2005-03-22 21:20:24.000000000 +0100
+++ linux-2.6.12-rc1-mm1-full/drivers/net/eql.c	2005-03-22 21:23:19.000000000 +0100
@@ -498,10 +498,8 @@
 	if (!slave_dev)
 		return -ENODEV;
 
 	ret = -EINVAL;
-	if (!slave_dev)
-		return ret;
 
 	spin_lock_bh(&eql->queue.lock);
 	if (eql_is_slave(slave_dev)) {
 		slave = __eql_find_slave_dev(&eql->queue, slave_dev);
@@ -535,10 +533,8 @@
 	if (!slave_dev)
 		return -ENODEV;
 
 	ret = -EINVAL;
-	if (!slave_dev)
-		return ret;
 
 	eql = netdev_priv(dev);
 	spin_lock_bh(&eql->queue.lock);
 	if (eql_is_slave(slave_dev)) {

