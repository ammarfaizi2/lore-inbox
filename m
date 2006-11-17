Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753506AbWKQX61@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753506AbWKQX61 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 18:58:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756046AbWKQX61
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 18:58:27 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:35078 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1753506AbWKQX60 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 18:58:26 -0500
Date: Sat, 18 Nov 2006 00:58:25 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>,
       Ashwin Chaugule <ashwin.chaugule@celunite.com>
Cc: linux-kernel@vger.kernel.org, riel@redhat.com
Subject: [-mm patch] make mm/thrash.c:global_faults static
Message-ID: <20061117235825.GM31879@stusta.de>
References: <20061114014125.dd315fff.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061114014125.dd315fff.akpm@osdl.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes the needlessly global "global_faults" static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.19-rc5-mm2/mm/thrash.c.old	2006-11-17 18:47:46.000000000 +0100
+++ linux-2.6.19-rc5-mm2/mm/thrash.c	2006-11-17 18:48:06.000000000 +0100
@@ -24,7 +24,7 @@
 
 static DEFINE_SPINLOCK(swap_token_lock);
 struct mm_struct *swap_token_mm;
-unsigned int global_faults;
+static unsigned int global_faults;
 
 void grab_swap_token(void)
 {

