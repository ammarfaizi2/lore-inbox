Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316533AbSFBWEc>; Sun, 2 Jun 2002 18:04:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316535AbSFBWEb>; Sun, 2 Jun 2002 18:04:31 -0400
Received: from holomorphy.com ([66.224.33.161]:29090 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S316533AbSFBWEa>;
	Sun, 2 Jun 2002 18:04:30 -0400
Date: Sun, 2 Jun 2002 15:03:54 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org
Cc: trivial@rustcorp.com.au
Subject: remove antiquated comment from page_alloc.c
Message-ID: <20020602220354.GK14918@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org, trivial@rustcorp.com.au
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This comment, describing how to optimize for gcc-2.2.2, is so outdated
it should be removed. It's also quite doubtful it should ever have been
placed in this file at all (perhaps something under Documentation/ ?).
This patch removes it.

Against 2.5.19.


Cheers,
Bill


===== mm/page_alloc.c 1.65 vs edited =====
--- 1.65/mm/page_alloc.c	Sun Jun  2 14:58:50 2002
+++ edited/mm/page_alloc.c	Sun Jun  2 15:00:30 2002
@@ -43,18 +43,6 @@
 static int zone_balance_min[MAX_NR_ZONES] __initdata = { 20 , 20, 20, };
 static int zone_balance_max[MAX_NR_ZONES] __initdata = { 255 , 255, 255, };
 
-/*
- * Free_page() adds the page to the free lists. This is optimized for
- * fast normal cases (no error jumps taken normally).
- *
- * The way to optimize jumps for gcc-2.2.2 is to:
- *  - select the "normal" case and put it inside the if () { XXX }
- *  - no else-statements if you can avoid them
- *
- * With the above two rules, you get a straight-line execution path
- * for the normal case, giving better asm-code.
- */
-
 #define memlist_init(x) INIT_LIST_HEAD(x)
 #define memlist_add_head list_add
 #define memlist_add_tail list_add_tail
