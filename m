Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261278AbVAWKXy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261278AbVAWKXy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Jan 2005 05:23:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261272AbVAWKWf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Jan 2005 05:22:35 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:65287 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261289AbVAWKRj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Jan 2005 05:17:39 -0500
Date: Sun, 23 Jan 2005 11:17:37 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: rmk@arm.linux.org.uk, linux-kernel@vger.kernel.org
Subject: [2.6 patch] fs/adfs/dir_f.c: remove an unused function
Message-ID: <20050123101737.GL3212@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes an unused function.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 fs/adfs/dir_f.c |   17 -----------------
 1 files changed, 17 deletions(-)

This patch was already sent on:
- 29 Oct 2004
- 29 Nov 2004

--- linux-2.6.10-rc1-mm1-full/fs/adfs/dir_f.c.old	2004-10-28 22:40:09.000000000 +0200
+++ linux-2.6.10-rc1-mm1-full/fs/adfs/dir_f.c	2004-10-28 22:40:20.000000000 +0200
@@ -65,23 +65,6 @@
 	return buf - old_buf;
 }
 
-static inline void adfs_writename(char *to, char *from, int maxlen)
-{
-	int i;
-
-	for (i = 0; i < maxlen; i++) {
-		if (from[i] == '\0')
-			break;
-		if (from[i] == '.')
-			to[i] = '/';
-		else
-			to[i] = from[i];
-	}
-
-	for (; i < maxlen; i++)
-		to[i] = '\0';
-}
-
 #define ror13(v) ((v >> 13) | (v << 19))
 
 #define dir_u8(idx)				\
