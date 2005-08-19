Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965184AbVHSXmU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965184AbVHSXmU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Aug 2005 19:42:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965190AbVHSXmU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Aug 2005 19:42:20 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:11539 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S965184AbVHSXmT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Aug 2005 19:42:19 -0400
Date: Sat, 20 Aug 2005 01:42:17 +0200
From: Adrian Bunk <bunk@stusta.de>
To: reiserfs-dev@namesys.com
Cc: linux-kernel@vger.kernel.org
Subject: [-mm patch] fs/reiser4/plugin/file/funcs.h: "extern inline" doesn't make sense
Message-ID: <20050819234217.GE3615@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"extern inline" doesn't make sense.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.13-rc6-mm1-full/fs/reiser4/plugin/file/funcs.h.old	2005-08-19 23:23:00.000000000 +0200
+++ linux-2.6.13-rc6-mm1-full/fs/reiser4/plugin/file/funcs.h	2005-08-19 23:23:08.000000000 +0200
@@ -18,7 +18,7 @@
 int find_or_create_extent(struct page *);
 write_mode_t how_to_write(uf_coord_t *, const reiser4_key *);
 
-extern inline int
+static inline int
 cbk_errored(int cbk_result)
 {
 	return (cbk_result != CBK_COORD_NOTFOUND && cbk_result != CBK_COORD_FOUND);

