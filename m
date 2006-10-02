Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965275AbWJBS0q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965275AbWJBS0q (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 14:26:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965261AbWJBS0q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 14:26:46 -0400
Received: from mail.fieldses.org ([66.93.2.214]:3200 "EHLO pickle.fieldses.org")
	by vger.kernel.org with ESMTP id S965275AbWJBS0o (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 14:26:44 -0400
Date: Mon, 2 Oct 2006 14:26:41 -0400
To: Andrew Morton <akpm@osdl.org>
Cc: NeilBrown <neilb@suse.de>, nfs@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: [PATCH 3 of 3] nfsd4: fslocs: remove spurious NULL check
Message-ID: <20061002182641.GE8084@fieldses.org>
References: <20060929130518.23919.patches@notabene> <1060929030913.24108@suse.de> <20060928234540.fd74f1e1.akpm@osdl.org> <20061002182327.GB8084@fieldses.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061002182327.GB8084@fieldses.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
From: "J. Bruce Fields" <bfields@fieldses.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It's obvious that the two callers of this function never call it with NULL.

Signed-off-by: J. Bruce Fields <bfields@citi.umich.edu>
---
 fs/nfsd/export.c |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/fs/nfsd/export.c b/fs/nfsd/export.c
index ee7b03a..4a11092 100644
--- a/fs/nfsd/export.c
+++ b/fs/nfsd/export.c
@@ -323,9 +323,6 @@ static void nfsd4_fslocs_free(struct nfs
 {
 	int i;
 
-	if (fsloc == NULL)
-		return;
-
 	for (i = 0; i < fsloc->locations_count; i++) {
 		kfree(fsloc->locations[i].path);
 		kfree(fsloc->locations[i].hosts);
-- 
1.4.2.g55c3

