Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264129AbUFNUnM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264129AbUFNUnM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jun 2004 16:43:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264255AbUFNUl3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jun 2004 16:41:29 -0400
Received: from pfepc.post.tele.dk ([195.41.46.237]:47232 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S264129AbUFNUiJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jun 2004 16:38:09 -0400
Date: Mon, 14 Jun 2004 22:46:55 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 4/5] kbuild: make clean improved
Message-ID: <20040614204655.GE15243@mars.ravnborg.org>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
References: <20040614204029.GA15243@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040614204029.GA15243@mars.ravnborg.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/06/14 22:09:53+02:00 sam@mars.ravnborg.org 
#   kbuild: make clean deletes a few more unneeded files
#   
#   Make clean shall leave behind only what is needed to build
#   external modules. A few more files can be deleted and modules may still be
#   build successfully.
#   Originally noticed by Andreas Gruenbach
#   
#   Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
# 
# Makefile
#   2004/06/14 22:09:39+02:00 sam@mars.ravnborg.org +2 -2
#   kbuild: make clean deletes a few more unneeded files
#   
#   Make clean shall leave behind only what is needed to build
#   external modules. A few more files can be deleted and modules may still be
#   build successfully.
#   Originally noticed by Andreas Gruenbach
#   
#   Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
# 
diff -Nru a/Makefile b/Makefile
--- a/Makefile	2004-06-14 22:25:31 +02:00
+++ b/Makefile	2004-06-14 22:25:31 +02:00
@@ -796,12 +796,12 @@
 
 # Directories & files removed with 'make clean'
 CLEAN_DIRS  += $(MODVERDIR)
-CLEAN_FILES +=	vmlinux System.map \
+CLEAN_FILES +=	vmlinux System.map .version .config.old \
                 .tmp_kallsyms* .tmp_version .tmp_vmlinux*
 
 # Directories & files removed with 'make mrproper'
 MRPROPER_DIRS  += include/config include2
-MRPROPER_FILES += .config .config.old include/asm .version \
+MRPROPER_FILES += .config include/asm \
                   include/linux/autoconf.h include/linux/version.h \
                   Module.symvers tags TAGS cscope*
 
