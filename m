Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265037AbTBOUAI>; Sat, 15 Feb 2003 15:00:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265051AbTBOUAI>; Sat, 15 Feb 2003 15:00:08 -0500
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:51981
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S265037AbTBOUAH>; Sat, 15 Feb 2003 15:00:07 -0500
Subject: [patch] trivial: unused var in sunrpc
From: Robert Love <rml@tech9.net>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: 
Message-Id: <1045339802.5926.3.camel@phantasy>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.3.0.99 (Preview Release)
Date: 15 Feb 2003 15:10:02 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There is an unused variable, `int maxlen', in net/sunrpc/clnt.c ::
rpc_setup_pipedir().

Attached patch, against 2.5.61, removes it.  Please, apply.

	Robert Love

 net/sunrpc/clnt.c |    1 -
 1 files changed, 1 deletion(-)

diff -urN linux-2.5.61/net/sunrpc/clnt.c linux/net/sunrpc/clnt.c
--- linux-2.5.61/net/sunrpc/clnt.c	2003-02-14 18:51:30.000000000 -0500
+++ linux/net/sunrpc/clnt.c	2003-02-15 15:05:01.810157736 -0500
@@ -67,7 +67,6 @@
 rpc_setup_pipedir(struct rpc_clnt *clnt, char *dir_name)
 {
 	static uint32_t clntid;
-	int maxlen = sizeof(clnt->cl_pathname);
 	int error;
 
 	if (dir_name == NULL)



