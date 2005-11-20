Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750766AbVKTUCz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750766AbVKTUCz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Nov 2005 15:02:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750779AbVKTUCz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Nov 2005 15:02:55 -0500
Received: from host222-100.pool871.interbusiness.it ([87.1.100.222]:20653 "EHLO
	zion.home.lan") by vger.kernel.org with ESMTP id S1750766AbVKTUCy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Nov 2005 15:02:54 -0500
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Subject: [PATCH 1/2] uml: arch/um/scripts/Makefile.rules - remove duplicated code
Date: Sun, 20 Nov 2005 20:10:19 +0100
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
Message-Id: <20051120191019.4189.22191.stgit@zion.home.lan>
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

