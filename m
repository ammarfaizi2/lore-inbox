Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946251AbWJSRHt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946251AbWJSRHt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 13:07:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946248AbWJSRGL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 13:06:11 -0400
Received: from mx2.netapp.com ([216.240.18.37]:6061 "EHLO mx2.netapp.com")
	by vger.kernel.org with ESMTP id S1946239AbWJSRGI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 13:06:08 -0400
X-IronPort-AV: i="4.09,330,1157353200"; 
   d="scan'208"; a="419607078:sNHT153401012"
From: Trond Myklebust <Trond.Myklebust@netapp.com>
Date: Thu, 19 Oct 2006 13:04:32 -0400
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org, nfs@lists.sourceforge.net
Message-Id: <20061019170432.8171.22144.stgit@lade.trondhjem.org>
In-Reply-To: <20061019170432.8171.75076.stgit@lade.trondhjem.org>
References: <20061019170432.8171.75076.stgit@lade.trondhjem.org>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Subject: [PATCH 11/11] SUNRPC: fix a typo
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
X-OriginalArrivalTime: 19 Oct 2006 17:06:07.0073 (UTC) FILETIME=[DDF44D10:01C6F3A0]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chuck Lever <chuck.lever@oracle.com>

Yes, this actually passed tests the way it was.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>
---

 net/sunrpc/xprtsock.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/net/sunrpc/xprtsock.c b/net/sunrpc/xprtsock.c
index 28100e0..757fc91 100644
--- a/net/sunrpc/xprtsock.c
+++ b/net/sunrpc/xprtsock.c
@@ -1366,7 +1366,7 @@ int xs_setup_udp(struct rpc_xprt *xprt, 
 	if (xprt->slot == NULL)
 		return -ENOMEM;
 
-	if (ntohs(addr->sin_port != 0))
+	if (ntohs(addr->sin_port) != 0)
 		xprt_set_bound(xprt);
 	xprt->port = xs_get_random_port();
 
