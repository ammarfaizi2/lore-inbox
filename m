Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261488AbVCVR4m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261488AbVCVR4m (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 12:56:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261504AbVCVR4l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 12:56:41 -0500
Received: from mail-relay-2.tiscali.it ([213.205.33.42]:3462 "EHLO
	mail-relay-2.tiscali.it") by vger.kernel.org with ESMTP
	id S261488AbVCVR4Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 12:56:24 -0500
Subject: [patch 1/1] kconfig: trivial cleanup
To: torvalds@osdl.org
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, blaisorblade@yahoo.it,
       zippel@linux-m68k.org, kbuild-devel@lists.sourceforge.net
From: blaisorblade@yahoo.it
Date: Tue, 22 Mar 2005 17:36:39 +0100
Message-Id: <20050322163639.17AD1E7BB6@zion>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


CC: Roman Zippel <zippel@linux-m68k.org>, <kbuild-devel@lists.sourceforge.net>

Replace a menu_add_prop mimicking menu_add_prompt with the latter.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 linux-2.6.11-paolo/scripts/kconfig/zconf.y |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -puN scripts/kconfig/zconf.y~kbuild-cleanup scripts/kconfig/zconf.y
--- linux-2.6.11/scripts/kconfig/zconf.y~kbuild-cleanup	2005-03-22 17:34:36.000000000 +0100
+++ linux-2.6.11-paolo/scripts/kconfig/zconf.y	2005-03-22 17:35:14.000000000 +0100
@@ -443,7 +443,7 @@ prompt_stmt_opt:
 	  /* empty */
 	| prompt if_expr
 {
-	menu_add_prop(P_PROMPT, $1, NULL, $2);
+	menu_add_prompt(P_PROMPT, $1, $2);
 };
 
 prompt:	  T_WORD
_
