Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316519AbSGYVk5>; Thu, 25 Jul 2002 17:40:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316538AbSGYVk5>; Thu, 25 Jul 2002 17:40:57 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:29446 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S316519AbSGYVk4>;
	Thu, 25 Jul 2002 17:40:56 -0400
Date: Thu, 25 Jul 2002 23:51:29 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Remove docgen + gen-all-syms targets
Message-ID: <20020725235129.A10868@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a left-over form the docbook makefile cleanup.
The removal of docgen and gen-all-syms results in an error
when make is executed on a fresh kernel.
Remove dependencies on the above files.

Applies to Linus's BK-Latest.

	Sam


# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.470   -> 1.471  
#	    scripts/Makefile	1.10    -> 1.11   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/07/25	sam@mars.ravnborg.org	1.471
# [PATCH] Removed unused targets to CHMOD_FILES in scripts
# This allow a fresh kernel to start the build process without
# bailing about docgen.
# --------------------------------------------
#
diff -Nru a/scripts/Makefile b/scripts/Makefile
--- a/scripts/Makefile	Thu Jul 25 23:47:40 2002
+++ b/scripts/Makefile	Thu Jul 25 23:47:40 2002
@@ -5,7 +5,7 @@
 # The following temporary rule will make sure that people's
 # trees get updated to the right permissions, since patch(1)
 # can't do it
-CHMOD_FILES := docgen gen-all-syms kernel-doc mkcompile_h makelst
+CHMOD_FILES := kernel-doc mkcompile_h makelst
 
 all: fixdep split-include docproc $(CHMOD_FILES)
 
