Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1164353AbWLHBOp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1164353AbWLHBOp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 20:14:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1164322AbWLHBOi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 20:14:38 -0500
Received: from mail.suse.de ([195.135.220.2]:58487 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1164338AbWLHBOC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 20:14:02 -0500
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Fri, 8 Dec 2006 12:14:13 +1100
Message-Id: <1061208011413.30677@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: nfs@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH 010 of 18] knfsd: nfsd4: remove spurious replay_owner check
References: <20061208120939.30428.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: J.Bruce Fields <bfields@fieldses.org>

OK, this is embarassing--I've even looked back at the history, and cannot
for the life of me figure out why I added this check.

Signed-off-by: J. Bruce Fields <bfields@citi.umich.edu>
Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./fs/nfsd/nfs4proc.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff .prev/fs/nfsd/nfs4proc.c ./fs/nfsd/nfs4proc.c
--- .prev/fs/nfsd/nfs4proc.c	2006-12-08 12:09:27.000000000 +1100
+++ ./fs/nfsd/nfs4proc.c	2006-12-08 12:09:27.000000000 +1100
@@ -1008,7 +1008,7 @@ encode_op:
 			nfsd4_encode_operation(resp, op);
 			status = op->status;
 		}
-		if (replay_owner && (replay_owner != (void *)(-1))) {
+		if (replay_owner) {
 			nfs4_put_stateowner(replay_owner);
 			replay_owner = NULL;
 		}
