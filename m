Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262296AbVCBNys@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262296AbVCBNys (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 08:54:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262294AbVCBNyr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 08:54:47 -0500
Received: from [151.97.230.9] ([151.97.230.9]:10251 "HELO ssc.unict.it")
	by vger.kernel.org with SMTP id S262296AbVCBNyp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 08:54:45 -0500
Subject: [patch 1/1] uml: trivial removal of Makefile var
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, blaisorblade@yahoo.it
From: blaisorblade@yahoo.it
Date: Tue, 01 Mar 2005 20:46:58 +0100
Message-Id: <20050301194700.6576A6486@zion>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


That var is used only once, use its value directly.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 linux-2.6.11-paolo/arch/um/drivers/Makefile |    4 +---
 1 files changed, 1 insertion(+), 3 deletions(-)

diff -puN arch/um/drivers/Makefile~uml-kbuild-another-trivial-cleanup arch/um/drivers/Makefile
--- linux-2.6.11/arch/um/drivers/Makefile~uml-kbuild-another-trivial-cleanup	2005-03-01 20:36:31.485689728 +0100
+++ linux-2.6.11-paolo/arch/um/drivers/Makefile	2005-03-01 20:44:49.065046168 +0100
@@ -3,8 +3,6 @@
 # Licensed under the GPL
 #
 
-CHAN_OBJS := chan_kern.o chan_user.o line.o 
-
 # pcap is broken in 2.5 because kbuild doesn't allow pcap.a to be linked
 # in to pcap.o
 
@@ -20,7 +18,7 @@ ubd-objs := ubd_kern.o ubd_user.o
 port-objs := port_kern.o port_user.o
 harddog-objs := harddog_kern.o harddog_user.o
 
-obj-y := stdio_console.o fd.o $(CHAN_OBJS)
+obj-y := stdio_console.o fd.o chan_kern.o chan_user.o line.o
 obj-$(CONFIG_SSL) += ssl.o
 obj-$(CONFIG_STDERR_CONSOLE) += stderr_console.o
 
_
