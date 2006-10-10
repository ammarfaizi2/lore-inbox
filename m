Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030534AbWJJVt6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030534AbWJJVt6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 17:49:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030518AbWJJVtb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 17:49:31 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:36283 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1030532AbWJJVt2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 17:49:28 -0400
To: torvalds@osdl.org
Subject: [PATCH] net/sunrpc/auth_gss/svcauth_gss.c endianness regression
Cc: linux-kernel@vger.kernel.org
Message-Id: <E1GXPTb-0007S6-Gu@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Tue, 10 Oct 2006 22:49:27 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 net/sunrpc/auth_gss/svcauth_gss.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/sunrpc/auth_gss/svcauth_gss.c b/net/sunrpc/auth_gss/svcauth_gss.c
index 447d9ae..1f0f079 100644
--- a/net/sunrpc/auth_gss/svcauth_gss.c
+++ b/net/sunrpc/auth_gss/svcauth_gss.c
@@ -1146,10 +1146,11 @@ out:
 	return ret;
 }
 
-u32 *
+static __be32 *
 svcauth_gss_prepare_to_wrap(struct xdr_buf *resbuf, struct gss_svc_data *gsd)
 {
-	u32 *p, verf_len;
+	__be32 *p;
+	u32 verf_len;
 
 	p = gsd->verf_start;
 	gsd->verf_start = NULL;
-- 
1.4.2.GIT


