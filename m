Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261841AbVEBCgi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261841AbVEBCgi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 May 2005 22:36:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261757AbVEBCQv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 May 2005 22:16:51 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:26896 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261633AbVEBBqg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 May 2005 21:46:36 -0400
Date: Mon, 2 May 2005 03:46:34 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com
Subject: [2.6 patch] drivers/net/arcnet/capmode.c: make a struct static
Message-ID: <20050502014634.GP3592@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes a needlessly global struct static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 19 Apr 2005

--- linux-2.6.12-rc2-mm3-full/drivers/net/arcnet/capmode.c.old	2005-04-19 03:03:23.000000000 +0200
+++ linux-2.6.12-rc2-mm3-full/drivers/net/arcnet/capmode.c	2005-04-19 03:03:53.000000000 +0200
@@ -48,7 +48,7 @@
 static int ack_tx(struct net_device *dev, int acked);
 
 
-struct ArcProto capmode_proto =
+static struct ArcProto capmode_proto =
 {
 	'r',
 	XMTU,

