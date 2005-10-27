Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751440AbVJ0SrL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751440AbVJ0SrL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Oct 2005 14:47:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751443AbVJ0SrK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Oct 2005 14:47:10 -0400
Received: from pat.uio.no ([129.240.130.16]:33773 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S1751440AbVJ0SrJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Oct 2005 14:47:09 -0400
Subject: [PATCH] Ensure that 'make distclean' does not delete files in
	'.git'
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Thu, 27 Oct 2005 14:46:53 -0400
Message-Id: <1130438813.8792.38.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.716, required 12,
	autolearn=disabled, AWL 1.28, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 Currently, 'make distclean' causes stgit to barf since it may
 delete files in .git/patches. We really shouldn't allow
 'make distclean' anywhere near .git...

 Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>
---

 Makefile |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 4a7000e..527998d 100644
--- a/Makefile
+++ b/Makefile
@@ -371,8 +371,8 @@ export MODVERDIR := $(if $(KBUILD_EXTMOD
 
 # Files to ignore in find ... statements
 
-RCS_FIND_IGNORE := \( -name SCCS -o -name BitKeeper -o -name .svn -o -name CVS -o -name .pc -o -name .hg \) -prune -o
-export RCS_TAR_IGNORE := --exclude SCCS --exclude BitKeeper --exclude .svn --exclude CVS --exclude .pc --exclude .hg
+RCS_FIND_IGNORE := \( -name SCCS -o -name BitKeeper -o -name .svn -o -name CVS -o -name .pc -o -name .hg -o -name .git \) -prune -o
+export RCS_TAR_IGNORE := --exclude SCCS --exclude BitKeeper --exclude .svn --exclude CVS --exclude .pc --exclude .hg --exclude .git
 
 # ===========================================================================
 # Rules shared between *config targets and build targets


