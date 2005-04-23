Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261399AbVDWANF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261399AbVDWANF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Apr 2005 20:13:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261376AbVDWALB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Apr 2005 20:11:01 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:28945 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261368AbVDWAKm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Apr 2005 20:10:42 -0400
Date: Sat, 23 Apr 2005 02:10:40 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [-mm patch] fs/isofs/rock.c: make a function static
Message-ID: <20050423001040.GP4355@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes a needlesly global function static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.12-rc2-mm3-full/fs/isofs/rock.c.old	2005-04-20 23:19:47.000000000 +0200
+++ linux-2.6.12-rc2-mm3-full/fs/isofs/rock.c	2005-04-20 23:19:56.000000000 +0200
@@ -84,7 +84,7 @@
  * Returns 0 if the caller should continue scanning, 1 if the scan must end
  * and -ve on error.
  */
-int rock_continue(struct rock_state *rs)
+static int rock_continue(struct rock_state *rs)
 {
 	int ret = 1;
 	int blocksize = 1 << rs->inode->i_blkbits;

