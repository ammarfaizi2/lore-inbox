Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261617AbUK2C3i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261617AbUK2C3i (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Nov 2004 21:29:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261621AbUK2C3i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Nov 2004 21:29:38 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:33293 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261617AbUK2C3f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Nov 2004 21:29:35 -0500
Date: Mon, 29 Nov 2004 03:29:32 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: rmk@arm.linux.org.uk, linux-kernel@vger.kernel.org
Subject: [2.6 patch] fs/adfs: remove an unused function (fwd)
Message-ID: <20041129022932.GO4390@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The patch forwarded below still applies and compiles against 
2.6.10-rc2-mm3.

Please apply.


----- Forwarded message from Adrian Bunk <bunk@stusta.de> -----

Date:	Fri, 29 Oct 2004 02:11:40 +0200
From: Adrian Bunk <bunk@stusta.de>
To: rmk@arm.linux.org.uk
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] fs/adfs: remove an unused function

[ this time without the problems due to a signature... ]

The patch below removes an unsed fubnction from fs/adfs/dir_f.c


diffstat output:
 fs/adfs/dir_f.c |   17 -----------------
 1 files changed, 17 deletions(-)


Signed-off-by: Adrian Bunk <bunk@stusta.de>

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
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

----- End forwarded message -----

