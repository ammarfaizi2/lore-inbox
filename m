Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261574AbVBRX7c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261574AbVBRX7c (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Feb 2005 18:59:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261570AbVBRX7b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Feb 2005 18:59:31 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:4371 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261575AbVBRX6w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Feb 2005 18:58:52 -0500
Date: Sat, 19 Feb 2005 00:58:47 +0100
From: Adrian Bunk <bunk@stusta.de>
To: mostrows@speakeasy.net
Cc: jgarzik@pobox.com, linux-net@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/net/pppoe.c: make a struct static
Message-ID: <20050218235847.GG4337@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes a needlessly global struct static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.11-rc3-mm2-full/drivers/net/pppoe.c.old	2005-02-16 18:07:09.000000000 +0100
+++ linux-2.6.11-rc3-mm2-full/drivers/net/pppoe.c	2005-02-16 18:07:23.000000000 +0100
@@ -1059,7 +1059,7 @@
 	read_unlock_bh(&pppoe_hash_lock);
 }
 
-struct seq_operations pppoe_seq_ops = {
+static struct seq_operations pppoe_seq_ops = {
 	.start		= pppoe_seq_start,
 	.next		= pppoe_seq_next,
 	.stop		= pppoe_seq_stop,

