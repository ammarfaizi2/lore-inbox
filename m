Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932390AbWGYB4K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932390AbWGYB4K (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jul 2006 21:56:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932391AbWGYBzs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jul 2006 21:55:48 -0400
Received: from mx1.suse.de ([195.135.220.2]:5100 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932390AbWGYBzK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jul 2006 21:55:10 -0400
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Tue, 25 Jul 2006 11:54:32 +1000
Message-Id: <1060725015432.21921@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: nfs@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH 002 of 9] knfsd: knfsd: Remove an unused variable from e_show().
References: <20060725114207.21779.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Greg Banks <gnb@melbourne.sgi.com>

Signed-off-by: Greg Banks <gnb@melbourne.sgi.com>
Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./fs/nfsd/export.c |    2 --
 1 file changed, 2 deletions(-)

diff .prev/fs/nfsd/export.c ./fs/nfsd/export.c
--- .prev/fs/nfsd/export.c	2006-07-24 14:33:06.000000000 +1000
+++ ./fs/nfsd/export.c	2006-07-24 14:33:26.000000000 +1000
@@ -1178,7 +1178,6 @@ static int e_show(struct seq_file *m, vo
 {
 	struct cache_head *cp = p;
 	struct svc_export *exp = container_of(cp, struct svc_export, h);
-	svc_client *clp;
 
 	if (p == (void *)1) {
 		seq_puts(m, "# Version 1.1\n");
@@ -1186,7 +1185,6 @@ static int e_show(struct seq_file *m, vo
 		return 0;
 	}
 
-	clp = exp->ex_client;
 	cache_get(&exp->h);
 	if (cache_check(&svc_export_cache, &exp->h, NULL))
 		return 0;
