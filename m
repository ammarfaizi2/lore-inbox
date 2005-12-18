Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965221AbVLRQw1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965221AbVLRQw1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Dec 2005 11:52:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965222AbVLRQwI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Dec 2005 11:52:08 -0500
Received: from host229-46.pool8259.interbusiness.it ([82.59.46.229]:56792 "EHLO
	zion.home.lan") by vger.kernel.org with ESMTP id S965221AbVLRQwG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Dec 2005 11:52:06 -0500
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Subject: [PATCH 1/4] uml: arch/um/scripts/Makefile.rules - remove duplicated code
Date: Sun, 18 Dec 2005 17:50:32 +0100
To: Linus Torvalds <torvalds@osdl.org>
Cc: Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
Message-Id: <20051218165031.441.4674.stgit@zion.home.lan>
In-Reply-To: <20051218164916.441.69564.stgit@zion.home.lan>
References: <20051218164916.441.69564.stgit@zion.home.lan>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

Duplicated code - the patch adding it was probably applied twice without enough
care.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 arch/um/scripts/Makefile.rules |    5 -----
 1 files changed, 0 insertions(+), 5 deletions(-)

diff --git a/arch/um/scripts/Makefile.rules b/arch/um/scripts/Makefile.rules
index b3fbf12..2e41cab 100644
--- a/arch/um/scripts/Makefile.rules
+++ b/arch/um/scripts/Makefile.rules
@@ -21,11 +21,6 @@ define unprofile
 endef
 
 
-# The stubs and unmap.o can't try to call mcount or update basic block data
-define unprofile
-	$(patsubst -pg,,$(patsubst -fprofile-arcs -ftest-coverage,,$(1)))
-endef
-
 # cmd_make_link checks to see if the $(foo-dir) variable starts with a /.  If
 # so, it's considered to be a path relative to $(srcdir) rather than
 # $(srcdir)/arch/$(SUBARCH).  This is because x86_64 wants to get ldt.c from

