Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932391AbWGYB4L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932391AbWGYB4L (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jul 2006 21:56:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932392AbWGYBzr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jul 2006 21:55:47 -0400
Received: from cantor.suse.de ([195.135.220.2]:6636 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932391AbWGYBzP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jul 2006 21:55:15 -0400
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Tue, 25 Jul 2006 11:54:37 +1000
Message-Id: <1060725015437.21933@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: nfs@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH 003 of 9] knfsd: knfsd: Remove an unused variable from auth_unix_lookup()
References: <20060725114207.21779.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Greg Banks <gnb@melbourne.sgi.com>

Signed-off-by: Greg Banks <gnb@melbourne.sgi.com>
Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./net/sunrpc/svcauth_unix.c |    5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff .prev/net/sunrpc/svcauth_unix.c ./net/sunrpc/svcauth_unix.c
--- .prev/net/sunrpc/svcauth_unix.c	2006-07-24 14:33:40.000000000 +1000
+++ ./net/sunrpc/svcauth_unix.c	2006-07-24 14:33:40.000000000 +1000
@@ -348,12 +348,9 @@ int auth_unix_forget_old(struct auth_dom
 
 struct auth_domain *auth_unix_lookup(struct in_addr addr)
 {
-	struct ip_map key, *ipm;
+	struct ip_map *ipm;
 	struct auth_domain *rv;
 
-	strcpy(key.m_class, "nfsd");
-	key.m_addr = addr;
-
 	ipm = ip_map_lookup("nfsd", addr);
 
 	if (!ipm)
