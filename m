Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261423AbSJAAjL>; Mon, 30 Sep 2002 20:39:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261427AbSJAAjK>; Mon, 30 Sep 2002 20:39:10 -0400
Received: from mxall.mxgrp.airmail.net ([209.196.77.108]:49935 "EHLO
	mx11.airmail.net") by vger.kernel.org with ESMTP id <S261423AbSJAAjI>;
	Mon, 30 Sep 2002 20:39:08 -0400
Date: Mon, 30 Sep 2002 19:44:32 -0500
From: Art Haas <ahaas@neosoft.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] vmalloc.c patch for 2.4.20-pre8-ac3
Message-ID: <20021001004432.GA4230@debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

It looks like the small vmalloc.c patch didn't make it into
2.4.20-pre8-ac3. The patch is needed because the wrong variable
is passed to kfree().

Art Haas

--- linux-2.4.20-pre8-ac3/mm/vmalloc.c.ac3	2002-09-30 18:27:42.000000000 -0500
+++ linux-2.4.20-pre8-ac3/mm/vmalloc.c	2002-09-30 13:59:30.000000000 -0500
@@ -179,7 +179,7 @@
 
 	size += PAGE_SIZE;
 	if (!size) {
-		kfree (addr);
+		kfree (area);
 		return NULL;
 	}
 
-- 
They that can give up essential liberty to obtain a little temporary safety
deserve neither liberty nor safety.
 -- Benjamin Franklin, Historical Review of Pennsylvania, 1759
