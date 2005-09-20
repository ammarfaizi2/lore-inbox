Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965073AbVITSvm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965073AbVITSvm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 14:51:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965072AbVITSvH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 14:51:07 -0400
Received: from ppp-62-11-78-183.dialup.tiscali.it ([62.11.78.183]:20928 "EHLO
	zion.home.lan") by vger.kernel.org with ESMTP id S965085AbVITSvC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 14:51:02 -0400
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Subject: [PATCH 1/3] Kbuild: avoid indexing .git directory for tags/cscope/...
Date: Tue, 20 Sep 2005 20:48:12 +0200
To: akpm@osdl.org
Cc: Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org
Message-Id: <20050920184810.15031.14521.stgit@zion.home.lan>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

It is useless to pass to ctags or cscope the git objects - so skip them.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 Makefile |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
--- a/Makefile
+++ b/Makefile
@@ -371,8 +371,10 @@ export MODVERDIR := $(if $(KBUILD_EXTMOD
 
 # Files to ignore in find ... statements
 
-RCS_FIND_IGNORE := \( -name SCCS -o -name BitKeeper -o -name .svn -o -name CVS -o -name .pc -o -name .hg \) -prune -o
-RCS_TAR_IGNORE := --exclude SCCS --exclude BitKeeper --exclude .svn --exclude CVS --exclude .pc --exclude .hg
+RCS_FIND_IGNORE := \( -name SCCS -o -name BitKeeper -o -name .svn -o -name CVS -o -name .pc -o -name .hg \
+	-o -name .git \) -prune -o
+RCS_TAR_IGNORE := --exclude SCCS --exclude BitKeeper --exclude .svn --exclude CVS --exclude .pc --exclude .hg \
+	--exclude .git
 
 # ===========================================================================
 # Rules shared between *config targets and build targets

