Return-Path: <linux-kernel-owner+w=401wt.eu-S1753671AbWLRJuv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753671AbWLRJuv (ORCPT <rfc822;w@1wt.eu>);
	Mon, 18 Dec 2006 04:50:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753672AbWLRJuv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Dec 2006 04:50:51 -0500
Received: from mx1.redhat.com ([66.187.233.31]:44938 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753658AbWLRJuu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Dec 2006 04:50:50 -0500
Subject: [DLM] Fix compile warning [1/2]
From: Steven Whitehouse <swhiteho@redhat.com>
To: linux-kernel@vger.kernel.org, cluster-devel@redhat.com
Cc: Patrick Caulfield <pcaulfie@redhat.com>
Content-Type: text/plain
Organization: Red Hat (UK) Ltd
Date: Mon, 18 Dec 2006 09:54:10 +0000
Message-Id: <1166435650.3752.1263.camel@quoit.chygwyn.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From c80e7c83d56866a735236b45441f024b589f9e88 Mon Sep 17 00:00:00 2001
From: Patrick Caulfield <pcaulfie@redhat.com>
Date: Fri, 8 Dec 2006 14:31:12 -0500
Subject: [PATCH] [DLM] fix compile warning

This patch fixes a compile warning in lowcomms-tcp.c indicating that
kmem_cache_t is deprecated.

Signed-Off-By: Patrick Caulfield <pcaulfie@redhat.com>
Signed-off-by: Steven Whitehouse <swhiteho@redhat.com>
---
 fs/dlm/lowcomms-tcp.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/fs/dlm/lowcomms-tcp.c b/fs/dlm/lowcomms-tcp.c
index 8f2791f..9be3a44 100644
--- a/fs/dlm/lowcomms-tcp.c
+++ b/fs/dlm/lowcomms-tcp.c
@@ -143,7 +143,7 @@ static DECLARE_WAIT_QUEUE_HEAD(lowcomms_
 /* An array of pointers to connections, indexed by NODEID */
 static struct connection **connections;
 static DECLARE_MUTEX(connections_lock);
-static kmem_cache_t *con_cache;
+static struct kmem_cache *con_cache;
 static int conn_array_size;
 
 /* List of sockets that have reads pending */
-- 
1.4.1



