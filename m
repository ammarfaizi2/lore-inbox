Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932601AbWG1LnT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932601AbWG1LnT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 07:43:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751182AbWG1LnT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 07:43:19 -0400
Received: from build.arklinux.osuosl.org ([140.211.166.26]:2747 "EHLO
	mail.arklinux.org") by vger.kernel.org with ESMTP id S1751079AbWG1LnS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 07:43:18 -0400
From: Bernhard Rosenkraenzer <bero@arklinux.org>
To: akpm@osdl.org
Subject: [PATCH] 2.6.18-rc2-mm1: unresolved symbol brnf_deferred_hooks in xt_physdev module
Date: Fri, 28 Jul 2006 13:38:21 +0200
User-Agent: KMail/1.9.3
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607281338.22053.bero@arklinux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The (trivial) patch below fixes the unresolved symbol brnf_deferred_hooks in 
the xt_physdev module in 2.6.18-rc2-mm1.

Signed-off-by: Bernhard Rosenkraenzer <bero@arklinux.org>

---
--- linux-2.6.17/net/netfilter/xt_physdev.c.ark	2006-07-28 13:34:31.000000000 
+0200
+++ linux-2.6.17/net/netfilter/xt_physdev.c	2006-07-28 13:34:48.000000000 
+0200
@@ -16,6 +16,8 @@
 #define MATCH   1
 #define NOMATCH 0
 
+extern int brnf_deferred_hooks;
+
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Bart De Schuymer <bdschuym@pandora.be>");
 MODULE_DESCRIPTION("iptables bridge physical device match module");
