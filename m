Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261363AbVCTXKn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261363AbVCTXKn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Mar 2005 18:10:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261350AbVCTXH4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Mar 2005 18:07:56 -0500
Received: from ns3.dataphone.se ([212.37.0.170]:32467 "EHLO
	mail-slave.dataphone.se") by vger.kernel.org with ESMTP
	id S261335AbVCTXGW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Mar 2005 18:06:22 -0500
From: Magnus Damm <damm@opensource.se>
To: linux-kernel@vger.kernel.org
Cc: Magnus Damm <damm@opensource.se>
Message-Id: <20050320223829.25305.84393.38777@clementine.local>
In-Reply-To: <20050320223814.25305.52695.65404@clementine.local>
References: <20050320223814.25305.52695.65404@clementine.local>
Subject: [PATCH 3/5] autoparam: af_unix workaround
Date: Mon, 21 Mar 2005 00:06:21 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a quick fix that removes the "KBUILD_MODNAME -> unix -> 1" conflict.

Signed-off-by: Magnus Damm <damm@opensource.se>

diff -urN linux-2.6.12-rc1/net/unix/af_unix.c linux-2.6.12-rc1-autoparam/net/unix/af_unix.c
--- linux-2.6.12-rc1/net/unix/af_unix.c	2005-03-20 18:20:18.000000000 +0100
+++ linux-2.6.12-rc1-autoparam/net/unix/af_unix.c	2005-03-20 22:21:24.180328224 +0100
@@ -2080,6 +2080,8 @@
 	kmem_cache_destroy(unix_sk_cachep);
 }
 
+#undef unix
+
 module_init(af_unix_init);
 module_exit(af_unix_exit);
 
