Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267689AbUIJSvU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267689AbUIJSvU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 14:51:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267708AbUIJSvT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 14:51:19 -0400
Received: from mail-relay-4.tiscali.it ([213.205.33.44]:46759 "EHLO
	mail-relay-4.tiscali.it") by vger.kernel.org with ESMTP
	id S267689AbUIJSvR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 14:51:17 -0400
Subject: [patch 2/2] uml-remove-CONFIG_UML_SMP
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net, blaisorblade_spam@yahoo.it
From: blaisorblade_spam@yahoo.it
Date: Fri, 10 Sep 2004 19:15:43 +0200
Message-Id: <20040910171543.76299C753@zion.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Using CONFIG_UML_SMP and then making CONFIG_SMP = CONFIG_UML_SMP is useless
(there was a reason in 2.4, to have different help texts, but not now).

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>
---

 uml-linux-2.6.8.1-paolo/arch/um/Kconfig |    7 ++-----
 1 files changed, 2 insertions(+), 5 deletions(-)

diff -puN arch/um/Kconfig~uml-remove-CONFIG_UML_SMP arch/um/Kconfig
--- uml-linux-2.6.8.1/arch/um/Kconfig~uml-remove-CONFIG_UML_SMP	2004-08-29 14:40:57.198516280 +0200
+++ uml-linux-2.6.8.1-paolo/arch/um/Kconfig	2004-08-29 14:40:57.201515824 +0200
@@ -154,8 +154,9 @@ config MAGIC_SYSRQ
 config HOST_2G_2G
 	bool "2G/2G host address space split"
 
-config UML_SMP
+config SMP
 	bool "Symmetric multi-processing support"
+	default n
 	help
         This option enables UML SMP support.  UML implements virtual SMP by
         allowing as many processes to run simultaneously on the host as
@@ -167,10 +168,6 @@ config UML_SMP
         CONFIG_SMP will be set to whatever this option is set to.
         It is safe to leave this unchanged.
 
-config SMP
-	bool
-	default UML_SMP
-
 config NR_CPUS
 	int "Maximum number of CPUs (2-32)"
 	range 2 32
_
