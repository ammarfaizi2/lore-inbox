Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262401AbVC3S5J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262401AbVC3S5J (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 13:57:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262400AbVC3S45
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 13:56:57 -0500
Received: from mail-relay-2.tiscali.it ([213.205.33.42]:33233 "EHLO
	mail-relay-2.tiscali.it") by vger.kernel.org with ESMTP
	id S262401AbVC3Svl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 13:51:41 -0500
Subject: [patch 2/8] uml: gprof depends on !TT
To: torvalds@osdl.org
Cc: akpm@osdl.org, jdike@addtoit.com, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net, blaisorblade@yahoo.it
From: blaisorblade@yahoo.it
Date: Wed, 30 Mar 2005 19:33:43 +0200
Message-Id: <20050330173343.DBE8EEFED5@zion>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


CONFIG_GPROF depends on the fact that TT mode is disabled. I just verified
this, and this dependency already exists in UML/2.4.

Depends on "uml-add-kconfig-debug-deps" in -mm.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 linux-2.6.11-paolo/arch/um/Kconfig.debug |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -puN arch/um/Kconfig.debug~uml-gprof-depends-on-not-tt arch/um/Kconfig.debug
--- linux-2.6.11/arch/um/Kconfig.debug~uml-gprof-depends-on-not-tt	2005-03-24 11:37:54.000000000 +0100
+++ linux-2.6.11-paolo/arch/um/Kconfig.debug	2005-03-24 11:37:54.000000000 +0100
@@ -16,7 +16,7 @@ config PT_PROXY
 
 config GPROF
 	bool "Enable gprof support"
-	depends on DEBUG_INFO && MODE_SKAS
+	depends on DEBUG_INFO && MODE_SKAS && !MODE_TT
 	help
         This allows profiling of a User-Mode Linux kernel with the gprof
         utility.
_
