Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269394AbUJLAlV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269394AbUJLAlV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 20:41:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269380AbUJLAVp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 20:21:45 -0400
Received: from host157-148.pool8289.interbusiness.it ([82.89.148.157]:24451
	"EHLO zion.localdomain") by vger.kernel.org with ESMTP
	id S269395AbUJLATD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 20:19:03 -0400
Subject: [patch 02/10] uml: force using /bin/bash for building
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net, blaisorblade_spam@yahoo.it
From: blaisorblade_spam@yahoo.it
Date: Tue, 12 Oct 2004 02:17:47 +0200
Message-Id: <20041012001747.64A76868B@zion.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This forces make to use bash rather than whatever /bin/sh is linked to.
Without this, since there are some bash extensions used in the build and when
/bin/sh isn't bash, then the build fails without a clear error message.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>
---

 linux-2.6.9-current-paolo/arch/um/Makefile |    2 ++
 1 files changed, 2 insertions(+)

diff -puN arch/um/Makefile~uml-force-bash arch/um/Makefile
--- linux-2.6.9-current/arch/um/Makefile~uml-force-bash	2004-10-12 01:06:02.860053432 +0200
+++ linux-2.6.9-current-paolo/arch/um/Makefile	2004-10-12 01:06:02.863052976 +0200
@@ -5,6 +5,8 @@
 
 ARCH_DIR = arch/um
 OS := $(shell uname -s)
+#We require it or things break.
+SHELL := /bin/bash
 
 # Recalculate MODLIB to reflect the EXTRAVERSION changes (via KERNELRELEASE)
 # The way the toplevel Makefile is written EXTRAVERSION is not supposed
_
