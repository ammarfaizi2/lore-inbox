Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261685AbUDOGLh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Apr 2004 02:11:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263832AbUDOGLh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Apr 2004 02:11:37 -0400
Received: from ozlabs.org ([203.10.76.45]:57557 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261685AbUDOGLY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Apr 2004 02:11:24 -0400
Date: Thu, 15 Apr 2004 16:09:19 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org, trivial@rustcorp.com.au
Subject: [TRIVIAL] RCS_*_IGNORE quilt backup files
Message-ID: <20040415060919.GB25560@zax>
Mail-Followup-To: David Gibson <david@gibson.dropbear.id.au>,
	Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
	trivial@rustcorp.com.au
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please apply.  This patch excludes the .pc directory from the
same things that SCCS/BitKeeper/.svn/CVS files are excluded from.  The
.pc directory is used for backup/reference files by quilt, a patch
mangling system conceptually derived from akpm's patch scripts.

Excluding the .pc directory is handy, because otherwise old versions
of files found in there tend to end up at the front of the TAGS index.

Index: working-2.6/Makefile
===================================================================
--- working-2.6.orig/Makefile	2004-04-14 12:22:48.000000000 +1000
+++ working-2.6/Makefile	2004-04-15 13:59:02.419865672 +1000
@@ -334,8 +334,8 @@
 
 # Files to ignore in find ... statements
 
-RCS_FIND_IGNORE := \( -name SCCS -o -name BitKeeper -o -name .svn -o -name CVS \) -prune -o
-RCS_TAR_IGNORE := --exclude SCCS --exclude BitKeeper --exclude .svn --exclude CVS
+RCS_FIND_IGNORE := \( -name SCCS -o -name BitKeeper -o -name .svn -o -name CVS -o -name .pc \) -prune -o
+RCS_TAR_IGNORE := --exclude SCCS --exclude BitKeeper --exclude .svn --exclude CVS --exclude .pc
 
 # ===========================================================================
 # Rules shared between *config targets and build targets


-- 
David Gibson			| For every complex problem there is a
david AT gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.
http://www.ozlabs.org/people/dgibson
