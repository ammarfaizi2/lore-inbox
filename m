Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932389AbWGYBzH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932389AbWGYBzH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jul 2006 21:55:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932390AbWGYBzH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jul 2006 21:55:07 -0400
Received: from ns2.suse.de ([195.135.220.15]:16043 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932389AbWGYBzG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jul 2006 21:55:06 -0400
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Tue, 25 Jul 2006 11:54:27 +1000
Message-Id: <1060725015427.21909@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: nfs@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH 001 of 9] knfsd: knfsd: Add some missing newlines in printks
References: <20060725114207.21779.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Greg Banks <gnb@melbourne.sgi.com>

Signed-off-by: Greg Banks <gnb@melbourne.sgi.com>
Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./fs/nfsd/export.c       |    2 +-
 ./fs/nfsd/nfs4callback.c |    2 +-
 ./fs/nfsd/nfs4proc.c     |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff .prev/fs/nfsd/export.c ./fs/nfsd/export.c
--- .prev/fs/nfsd/export.c	2006-07-24 14:33:06.000000000 +1000
+++ ./fs/nfsd/export.c	2006-07-24 14:33:06.000000000 +1000
@@ -370,7 +370,7 @@ static int check_export(struct inode *in
 	 */
 	if (!(inode->i_sb->s_type->fs_flags & FS_REQUIRES_DEV) &&
 	    !(flags & NFSEXP_FSID)) {
-		dprintk("exp_export: export of non-dev fs without fsid");
+		dprintk("exp_export: export of non-dev fs without fsid\n");
 		return -EINVAL;
 	}
 	if (!inode->i_sb->s_export_op) {

diff .prev/fs/nfsd/nfs4callback.c ./fs/nfsd/nfs4callback.c
--- .prev/fs/nfsd/nfs4callback.c	2006-07-24 14:33:06.000000000 +1000
+++ ./fs/nfsd/nfs4callback.c	2006-07-24 14:33:06.000000000 +1000
@@ -131,7 +131,7 @@ xdr_error:                              
 #define READ_BUF(nbytes)  do { \
 	p = xdr_inline_decode(xdr, nbytes); \
 	if (!p) { \
-		dprintk("NFSD: %s: reply buffer overflowed in line %d.", \
+		dprintk("NFSD: %s: reply buffer overflowed in line %d.\n", \
 			__FUNCTION__, __LINE__); \
 		return -EIO; \
 	} \

diff .prev/fs/nfsd/nfs4proc.c ./fs/nfsd/nfs4proc.c
--- .prev/fs/nfsd/nfs4proc.c	2006-07-24 14:33:06.000000000 +1000
+++ ./fs/nfsd/nfs4proc.c	2006-07-24 14:33:06.000000000 +1000
@@ -600,7 +600,7 @@ nfsd4_setattr(struct svc_rqst *rqstp, st
 			&setattr->sa_stateid, CHECK_FH | WR_STATE, NULL);
 		nfs4_unlock_state();
 		if (status) {
-			dprintk("NFSD: nfsd4_setattr: couldn't process stateid!");
+			dprintk("NFSD: nfsd4_setattr: couldn't process stateid!\n");
 			return status;
 		}
 	}
