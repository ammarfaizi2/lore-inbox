Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422658AbVLOJTD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422658AbVLOJTD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 04:19:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422651AbVLOJTA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 04:19:00 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:16554 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1422638AbVLOJSa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 04:18:30 -0500
To: torvalds@osdl.org
Subject: [PATCH] Address of void __user * is void __user * *, not void * __user *
Cc: linux-kernel@vger.kernel.org
Message-Id: <E1EmpFu-00080B-2U@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Thu, 15 Dec 2005 09:18:30 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>


---

 net/sctp/socket.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

cd935292cc41f9f45abafb1f0307422f40b28fc1
diff --git a/net/sctp/socket.c b/net/sctp/socket.c
index d890dfa..1f7f244 100644
--- a/net/sctp/socket.c
+++ b/net/sctp/socket.c
@@ -3425,7 +3425,7 @@ static int sctp_copy_laddrs_to_user_old(
 }
 
 static int sctp_copy_laddrs_to_user(struct sock *sk, __u16 port,
-				    void * __user *to, size_t space_left)
+				    void __user **to, size_t space_left)
 {
 	struct list_head *pos;
 	struct sctp_sockaddr_entry *addr;
-- 
0.99.9.GIT

