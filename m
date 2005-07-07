Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261298AbVGGL25@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261298AbVGGL25 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Jul 2005 07:28:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261282AbVGGL1h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Jul 2005 07:27:37 -0400
Received: from coderock.org ([193.77.147.115]:25482 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S261298AbVGGL1B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Jul 2005 07:27:01 -0400
Message-Id: <20050707112636.875741000@homer>
References: <20050707112551.331553000@homer>
Date: Thu, 07 Jul 2005 13:25:55 +0200
From: domen@coderock.org
To: linux-kernel@vger.kernel.org
Cc: damm@opensource.se, domen@coderock.org
Subject: [patch 4/5] autoparam: af_unix workaround
Content-Disposition: inline; filename=autoparam_4-af_unix_workaround
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Magnus Damm <damm@opensource.se>


This is a quick fix that removes the "KBUILD_MODNAME -> unix -> 1" conflict.

Signed-off-by: Magnus Damm <damm@opensource.se>
Signed-off-by: Domen Puncer <domen@coderock.org>

 net/unix/af_unix.c |    2 ++
 1 files changed, 2 insertions(+)

Index: a/net/unix/af_unix.c
===================================================================
--- a.orig/net/unix/af_unix.c
+++ a/net/unix/af_unix.c
@@ -2068,6 +2068,8 @@ static void __exit af_unix_exit(void)
 	proto_unregister(&unix_proto);
 }
 
+#undef unix
+
 module_init(af_unix_init);
 module_exit(af_unix_exit);
 

--
