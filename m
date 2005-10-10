Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750736AbVJJQC3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750736AbVJJQC3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Oct 2005 12:02:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750811AbVJJQC3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Oct 2005 12:02:29 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:24023 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S1750736AbVJJQC3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Oct 2005 12:02:29 -0400
Date: Mon, 10 Oct 2005 09:02:28 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, Sam Ravnborg <sam@ravnborg.org>,
       Kai Germaschewski <kai@germaschewski.name>
Subject: [PATCH 2.6.14-rc3] Export RCS_TAR_IGNORE for rpm targets
Message-ID: <20051010160228.GN3478@smtp.west.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The variable RCS_TAR_IGNORE is used in scripts/packaging/Makefile, but
not exported from the main Makefile, so it's never used.

This results in the rpm targets being very unhappy in quilted trees.

Signed-off-by: Tom Rini <trini@kernel.crashing.org>

diff --git a/Makefile b/Makefile
--- a/Makefile
+++ b/Makefile
@@ -372,7 +372,7 @@ export MODVERDIR := $(if $(KBUILD_EXTMOD
 # Files to ignore in find ... statements
 
 RCS_FIND_IGNORE := \( -name SCCS -o -name BitKeeper -o -name .svn -o -name CVS -o -name .pc -o -name .hg \) -prune -o
-RCS_TAR_IGNORE := --exclude SCCS --exclude BitKeeper --exclude .svn --exclude CVS --exclude .pc --exclude .hg
+export RCS_TAR_IGNORE := --exclude SCCS --exclude BitKeeper --exclude .svn --exclude CVS --exclude .pc --exclude .hg
 
 # ===========================================================================
 # Rules shared between *config targets and build targets

-- 
Tom Rini
http://gate.crashing.org/~trini/
