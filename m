Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286594AbRLUVom>; Fri, 21 Dec 2001 16:44:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286595AbRLUVod>; Fri, 21 Dec 2001 16:44:33 -0500
Received: from [217.9.226.246] ([217.9.226.246]:12160 "HELO
	merlin.xternal.fadata.bg") by vger.kernel.org with SMTP
	id <S286594AbRLUVoO>; Fri, 21 Dec 2001 16:44:14 -0500
To: linux-kernel@vger.kernel.org
Cc: marcelo@conectiva.com.br
Subject: [PATCH] Minor touch to filemap.c
From: Momchil Velikov <velco@fadata.bg>
Date: 21 Dec 2001 23:28:48 +0200
Message-ID: <87ello9sa7.fsf@fadata.bg>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As Linus pointed out, we've just checked that page is NULL.

--- 1.5/mm/filemap.c	Fri Dec 21 11:54:14 2001
+++ edited/mm/filemap.c	Fri Dec 21 23:26:07 2001
@@ -941,7 +941,6 @@
 	spin_unlock(&pagecache_lock);
 	if (!page) {
 		struct page *newpage = alloc_page(gfp_mask);
-		page = NULL;
 		if (newpage) {
 			spin_lock(&pagecache_lock);
 			page = __find_lock_page_helper(mapping, index, *hash);

