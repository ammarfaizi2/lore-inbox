Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751602AbWJSNM3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751602AbWJSNM3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 09:12:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751601AbWJSNM3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 09:12:29 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:63752 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751599AbWJSNM2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 09:12:28 -0400
Date: Thu, 19 Oct 2006 15:12:24 +0200
From: Adrian Bunk <bunk@stusta.de>
To: swhiteho@redhat.com
Cc: cluster-devel@redhat.com, linux-kernel@vger.kernel.org
Subject: [2.6 patch] fs/gfs2/dir.c:gfs2_dir_write_data(): remove dead code
Message-ID: <20061019131224.GL3502@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The Coverity checker spotted this obviously dead code.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6/fs/gfs2/dir.c.old	2006-10-19 01:07:42.000000000 +0200
+++ linux-2.6/fs/gfs2/dir.c	2006-10-19 01:07:49.000000000 +0200
@@ -209,14 +209,12 @@ static int gfs2_dir_write_data(struct gf
 		if (error)
 			goto fail;
 
 		gfs2_trans_add_bh(ip->i_gl, bh, 1);
 		memcpy(bh->b_data + o, buf, amount);
 		brelse(bh);
-		if (error)
-			goto fail;
 
 		buf += amount;
 		copied += amount;
 		lblock++;
 		dblock++;
 		extlen--;

