Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262104AbULLUGW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262104AbULLUGW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Dec 2004 15:06:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262113AbULLUFQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Dec 2004 15:05:16 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:44562 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262104AbULLUDu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Dec 2004 15:03:50 -0500
Date: Sun, 12 Dec 2004 21:03:40 +0100
From: Adrian Bunk <bunk@stusta.de>
To: linux-kernel@vger.kernel.org, Rik van Riel <riel@redhat.com>
Subject: [2.6 patch] mm/thrash.c: make a variable static
Message-ID: <20041212200339.GR22324@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below makes a needlessly global variable static.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc2-mm4-full/mm/thrash.c.old	2004-12-12 04:00:18.000000000 +0100
+++ linux-2.6.10-rc2-mm4-full/mm/thrash.c	2004-12-12 04:00:25.000000000 +0100
@@ -15,7 +15,7 @@
 
 static DEFINE_SPINLOCK(swap_token_lock);
 static unsigned long swap_token_timeout;
-unsigned long swap_token_check;
+static unsigned long swap_token_check;
 struct mm_struct * swap_token_mm = &init_mm;
 
 #define SWAP_TOKEN_CHECK_INTERVAL (HZ * 2)

