Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030490AbVKIBEl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030490AbVKIBEl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 20:04:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030493AbVKIBEl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 20:04:41 -0500
Received: from outmx019.isp.belgacom.be ([195.238.2.200]:9198 "EHLO
	outmx019.isp.belgacom.be") by vger.kernel.org with ESMTP
	id S1030490AbVKIBEl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 20:04:41 -0500
To: linux-kernel@vger.kernel.org
Subject: [PATCH] fs/relayfs: Replace kcalloc(1, with kzalloc.
Cc: zanussi@us.ibm.com, karim@opersys.com
Message-Id: <20051109010353.D066920A1A@localhost.localdomain>
Date: Wed,  9 Nov 2005 02:03:53 +0100 (CET)
From: takis@issaris.org (Panagiotis Issaris)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, 

This patch replaces two occurrences of kcalloc(1, with kzallocs.

Signed-off-by: Panagiotis Issaris <takis@issaris.org>

---

 fs/relayfs/buffers.c |    2 +-
 fs/relayfs/relay.c   |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

applies-to: 7d508394035f9dd2079f486bc2d0beb4cb25b491
5dac836e6db3c123fde60e00ec1b1040850289b2
diff --git a/fs/relayfs/buffers.c b/fs/relayfs/buffers.c
index 84e21ff..ce65964 100644
--- a/fs/relayfs/buffers.c
+++ b/fs/relayfs/buffers.c
@@ -133,7 +133,7 @@ depopulate:
  */
 struct rchan_buf *relay_create_buf(struct rchan *chan)
 {
-	struct rchan_buf *buf = kcalloc(1, sizeof(struct rchan_buf), GFP_KERNEL);
+	struct rchan_buf *buf = kzalloc(sizeof(struct rchan_buf), GFP_KERNEL);
 	if (!buf)
 		return NULL;
 
diff --git a/fs/relayfs/relay.c b/fs/relayfs/relay.c
index 16446a1..d599295 100644
--- a/fs/relayfs/relay.c
+++ b/fs/relayfs/relay.c
@@ -248,7 +248,7 @@ struct rchan *relay_open(const char *bas
 	if (!(subbuf_size && n_subbufs))
 		return NULL;
 
-	chan = kcalloc(1, sizeof(struct rchan), GFP_KERNEL);
+	chan = kzalloc(sizeof(struct rchan), GFP_KERNEL);
 	if (!chan)
 		return NULL;
 
---
0.99.9.GIT
