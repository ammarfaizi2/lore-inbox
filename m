Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261574AbUKDCu4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261574AbUKDCu4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 21:50:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262056AbUKDCDw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 21:03:52 -0500
Received: from host157-148.pool8289.interbusiness.it ([82.89.148.157]:2708
	"EHLO zion.localdomain") by vger.kernel.org with ESMTP
	id S262055AbUKDBzv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 20:55:51 -0500
Subject: [patch 01/20] Uml - some comments about forcing /bin/bash
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net, cw@f00f.org,
       blaisorblade_spam@yahoo.it
From: blaisorblade_spam@yahoo.it
Date: Thu, 04 Nov 2004 00:17:15 +0100
Message-Id: <20041103231716.ABAFA3636F@zion.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Changes a comment about forcing /bin/bash as shell for the UML Makefile.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>
---

 vanilla-linux-2.6.9-paolo/arch/um/Makefile |    3 ++-
 1 files changed, 2 insertions(+), 1 deletion(-)

diff -puN arch/um/Makefile~uml-need-bash arch/um/Makefile
--- vanilla-linux-2.6.9/arch/um/Makefile~uml-need-bash	2004-11-03 23:44:35.055230912 +0100
+++ vanilla-linux-2.6.9-paolo/arch/um/Makefile	2004-11-03 23:44:35.057230608 +0100
@@ -5,7 +5,8 @@
 
 ARCH_DIR = arch/um
 OS := $(shell uname -s)
-#We require it or things break.
+# We require bash because the vmlinux link and loader script cpp use bash
+# features.
 SHELL := /bin/bash
 
 filechk_gen_header = $<
_
