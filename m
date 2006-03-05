Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932314AbWCEAz1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932314AbWCEAz1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Mar 2006 19:55:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932317AbWCEAz1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Mar 2006 19:55:27 -0500
Received: from mta07-winn.ispmail.ntl.com ([81.103.221.47]:15046 "EHLO
	mta07-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S932314AbWCEAz0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Mar 2006 19:55:26 -0500
From: Daniel Drake <dsd@gentoo.org>
To: neilb@cse.unsw.edu.au
Cc: nfs@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Cc: okir@monad.swb.de
Subject: [PATCH] sunrpc svc: be quieter
Message-Id: <20060305005532.5E7A0870504@zog.reactivated.net>
Date: Sun,  5 Mar 2006 00:55:32 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A Gentoo user at http://bugs.gentoo.org/124884 reports that the following
message appears in the logs over 650 times every day:

	svc: unknown version (0)

The system is a NFS server with many active clients.

Given that this #define only controls printk output, does it make sense to
disable it by default?

Signed-off-by: Daniel Drake <dsd@gentoo.org>

--- linux/net/sunrpc/svc.c.orig	2006-03-05 00:51:10.000000000 +0000
+++ linux/net/sunrpc/svc.c	2006-03-05 00:52:40.000000000 +0000
@@ -20,7 +20,7 @@
 #include <linux/sunrpc/clnt.h>
 
 #define RPCDBG_FACILITY	RPCDBG_SVCDSP
-#define RPC_PARANOIA 1
+#undef RPC_PARANOIA
 
 /*
  * Create an RPC service
