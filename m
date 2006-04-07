Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964960AbWDGVQ3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964960AbWDGVQ3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Apr 2006 17:16:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964961AbWDGVQ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Apr 2006 17:16:28 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:6416 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S964960AbWDGVQ2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Apr 2006 17:16:28 -0400
Date: Fri, 7 Apr 2006 23:16:26 +0200
From: Adrian Bunk <bunk@stusta.de>
To: linux-kernel@vger.kernel.org
Subject: [2.6 patch] mm/migrate.c: don't export a static function
Message-ID: <20060407211626.GN7118@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

EXPORT_SYMBOL'ing of a static function is not a good idea.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.17-rc1-mm1-full/mm/migrate.c.old	2006-04-07 14:03:21.000000000 +0200
+++ linux-2.6.17-rc1-mm1-full/mm/migrate.c	2006-04-07 14:03:31.000000000 +0200
@@ -176,7 +176,6 @@
 retry:
 	return -EAGAIN;
 }
-EXPORT_SYMBOL(swap_page);
 
 /*
  * Remove references for a page and establish the new page with the correct

