Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263111AbUJ2ARg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263111AbUJ2ARg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 20:17:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263155AbUJ2ANl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 20:13:41 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:46085 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S263153AbUJ2AMO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 20:12:14 -0400
Date: Fri, 29 Oct 2004 02:11:40 +0200
From: Adrian Bunk <bunk@stusta.de>
To: rmk@arm.linux.org.uk
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] fs/adfs: remove an unused function
Message-ID: <20041029001140.GB29024@stusta.de>
References: <20041028220511.GF3207@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041028220511.GF3207@stusta.de>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

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
