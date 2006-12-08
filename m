Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1164319AbWLHBNO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1164319AbWLHBNO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 20:13:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1164322AbWLHBNO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 20:13:14 -0500
Received: from ns1.suse.de ([195.135.220.2]:58418 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1164319AbWLHBNN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 20:13:13 -0500
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Fri, 8 Dec 2006 12:13:25 +1100
Message-Id: <1061208011325.30567@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: nfs@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH 001 of 18] knfsd: nfsd4: remove a dprink from nfsd4_lock
References: <20061208120939.30428.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: J.Bruce Fields <bfields@fieldses.org>

This dprintk is printing the wrong error now, but it's probably an
unnecessary dprintk anyway; just remove it.

Signed-off-by: J. Bruce Fields <bfields@citi.umich.edu>
Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./fs/nfsd/nfs4state.c |    1 -
 1 file changed, 1 deletion(-)

diff .prev/fs/nfsd/nfs4state.c ./fs/nfsd/nfs4state.c
--- .prev/fs/nfsd/nfs4state.c	2006-12-08 12:07:29.000000000 +1100
+++ ./fs/nfsd/nfs4state.c	2006-12-08 12:07:57.000000000 +1100
@@ -2760,7 +2760,6 @@ nfsd4_lock(struct svc_rqst *rqstp, struc
 	conflock.fl_ops = NULL;
 	conflock.fl_lmops = NULL;
 	err = posix_lock_file_conf(filp, &file_lock, &conflock);
-	dprintk("NFSD: nfsd4_lock: posix_lock_file_conf status %d\n",status);
 	switch (-err) {
 	case 0: /* success! */
 		update_stateid(&lock_stp->st_stateid);
