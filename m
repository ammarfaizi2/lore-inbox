Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265925AbUBBUgg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Feb 2004 15:36:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265924AbUBBUgO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Feb 2004 15:36:14 -0500
Received: from mailr-1.tiscali.it ([212.123.84.81]:13699 "EHLO
	mailr-1.tiscali.it") by vger.kernel.org with ESMTP id S266014AbUBBUDJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Feb 2004 15:03:09 -0500
X-BrightmailFiltered: true
Date: Mon, 2 Feb 2004 21:03:07 +0100
From: Kronos <kronos@kronoz.cjb.net>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-kernel@vger.kernel.org
Subject: [Compile Regression in 2.4.25-pre8][PATCH 35/42]
Message-ID: <20040202200307.GI6785@dreamland.darkstar.lan>
Reply-To: kronos@kronoz.cjb.net
References: <20040130204956.GA21643@dreamland.darkstar.lan> <Pine.LNX.4.58L.0401301855410.3140@logos.cnet> <20040202180940.GA6367@dreamland.darkstar.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040202180940.GA6367@dreamland.darkstar.lan>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


radeon_mem.c:135: warning: `print_heap' defined but not used

Remove unused function.
 
diff -Nru -X dontdiff linux-2.4-vanilla/drivers/char/drm/radeon_mem.c linux-2.4/drivers/char/drm/radeon_mem.c
--- linux-2.4-vanilla/drivers/char/drm/radeon_mem.c	Tue Nov 11 17:51:38 2003
+++ linux-2.4/drivers/char/drm/radeon_mem.c	Sat Jan 31 19:00:49 2004
@@ -131,16 +131,6 @@
 	}
 }
 
-static void print_heap( struct mem_block *heap )
-{
-	struct mem_block *p;
-
-	for (p = heap->next ; p != heap ; p = p->next) 
-		DRM_DEBUG("0x%x..0x%x (0x%x) -- owner %d\n",
-			  p->start, p->start + p->size,
-			  p->size, p->pid);
-}
-
 /* Initialize.  How to check for an uninitialized heap?
  */
 static int init_heap(struct mem_block **heap, int start, int size)

-- 
Reply-To: kronos@kronoz.cjb.net
Home: http://kronoz.cjb.net
Non sempre quello che viene dopo e` progresso.
Alessandro Manzoni
