Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261685AbULOAo7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261685AbULOAo7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Dec 2004 19:44:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261804AbULOAoP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Dec 2004 19:44:15 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:43020 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261685AbULOAm6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Dec 2004 19:42:58 -0500
Date: Wed, 15 Dec 2004 01:42:54 +0100
From: Adrian Bunk <bunk@stusta.de>
To: netdev@oss.sgi.com
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] net/key/af_key.c: make pfkey_table static
Message-ID: <20041215004254.GG23151@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below makes the needlessly global pfkey_table static.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc3-mm1-full/net/key/af_key.c.old	2004-12-14 20:22:24.000000000 +0100
+++ linux-2.6.10-rc3-mm1-full/net/key/af_key.c	2004-12-14 20:22:31.000000000 +0100
@@ -35,7 +35,7 @@
 
 
 /* List of all pfkey sockets. */
-HLIST_HEAD(pfkey_table);
+static HLIST_HEAD(pfkey_table);
 static DECLARE_WAIT_QUEUE_HEAD(pfkey_table_wait);
 static rwlock_t pfkey_table_lock = RW_LOCK_UNLOCKED;
 static atomic_t pfkey_table_users = ATOMIC_INIT(0);

