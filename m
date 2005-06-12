Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261235AbVFLVp2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261235AbVFLVp2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Jun 2005 17:45:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261242AbVFLVp1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Jun 2005 17:45:27 -0400
Received: from mail.dif.dk ([193.138.115.101]:59826 "EHLO saerimmer.dif.dk")
	by vger.kernel.org with ESMTP id S261235AbVFLVoO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Jun 2005 17:44:14 -0400
Date: Sun, 12 Jun 2005 23:49:30 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Documentation: update sparse.txt to list actual location
Message-ID: <Pine.LNX.4.62.0506122346250.16521@dragon.hyggekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The information on where to get sparse is outdated. It is now maintained 
in a git tree and I was unable to find anywhere to download tarballs. This 
patch updates Documentation/sparse.txt to match current reality.

Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>
---

 Documentation/sparse.txt |   15 +++++++++++----
 1 files changed, 11 insertions(+), 4 deletions(-)

--- linux-2.6.12-rc6-mm1-orig/Documentation/sparse.txt	2005-03-02 08:37:53.000000000 +0100
+++ linux-2.6.12-rc6-mm1/Documentation/sparse.txt	2005-06-12 23:44:43.000000000 +0200
@@ -51,13 +51,20 @@ or you don't get any checking at all.
 Where to get sparse
 ~~~~~~~~~~~~~~~~~~~
 
-With BK, you can just get it from
+With git, you can get it from
 
-        bk://sparse.bkbits.net/sparse
+	rsync://rsync.kernel.org/pub/scm/linux/kernel/git/torvalds/sparse.git/
 
-and DaveJ has tar-balls at
+like this:
 
-	http://www.codemonkey.org.uk/projects/bitkeeper/sparse/
+	$ mkdir -p sparse/.git
+	$ cd sparse
+	$ rsync -a --delete --verbose --stats --progress \
+	  rsync://rsync.kernel.org/pub/scm/linux/kernel/git/torvalds/sparse.git/ \
+	  .git
+	$ git-pull-script \
+	  rsync://rsync.kernel.org/pub/scm/linux/kernel/git/torvalds/sparse.git
+	$ git-read-tree -m HEAD && git-checkout-cache -q -f -u -a
 
 
 Once you have it, just do



