Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262745AbVAQIXq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262745AbVAQIXq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jan 2005 03:23:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262728AbVAQISD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jan 2005 03:18:03 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:29709 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262727AbVAQIN5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jan 2005 03:13:57 -0500
Date: Mon, 17 Jan 2005 09:13:52 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Rik van Riel <riel@redhat.com>
Subject: [2.6 patch] mm/thrash.c: make a variable static
Message-ID: <20050117081352.GC4274@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes a needlessly global variable static.
It was already ACK'ed by Rik van Riel.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 12 Dec 2004

--- linux-2.6.10-rc2-mm4-full/mm/thrash.c.old	2004-12-12 04:00:18.000000000 +0100
+++ linux-2.6.10-rc2-mm4-full/mm/thrash.c	2004-12-12 04:00:25.000000000 +0100
@@ -15,7 +15,7 @@
 
 static DEFINE_SPINLOCK(swap_token_lock);
 static unsigned long swap_token_timeout;
-unsigned long swap_token_check;
+static unsigned long swap_token_check;
 struct mm_struct * swap_token_mm = &init_mm;
 
 #define SWAP_TOKEN_CHECK_INTERVAL (HZ * 2)

