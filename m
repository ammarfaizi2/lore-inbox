Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267756AbUHRVLn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267756AbUHRVLn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Aug 2004 17:11:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267760AbUHRVJZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Aug 2004 17:09:25 -0400
Received: from pfepc.post.tele.dk ([195.41.46.237]:28533 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S267764AbUHRVHW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Aug 2004 17:07:22 -0400
Date: Thu, 19 Aug 2004 01:07:33 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: linux-kernel@vger.kernel.org
Subject: kbuild: Remove last occurrence of HEAD
Message-ID: <20040818230733.GE23495@mars.ravnborg.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20040818230252.GA23495@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040818230252.GA23495@mars.ravnborg.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/08/18 23:09:23+02:00 coywolf@greatcn.org 
#   kbuild: remove obsolete HEAD in kbuild
#   
#   Makefile: remove obsolete HEAD
#   arch/cris/Makefile: replace HEAD with assignment to head-y
#   
#   
#   Signed-off-by: Coywolf Qi Hunt <coywolf@greatcn.org>
#   Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
# 
# arch/cris/Makefile
#   2004/08/18 04:48:40+02:00 coywolf@greatcn.org +1 -1
#   kbuild: remove obsolete HEAD in kbuild
# 
# Makefile
#   2004/08/15 11:46:41+02:00 coywolf@greatcn.org +0 -1
#   kbuild: remove obsolete HEAD in kbuild
# 
diff -Nru a/Makefile b/Makefile
--- a/Makefile	2004-08-19 01:07:24 +02:00
+++ b/Makefile	2004-08-19 01:07:24 +02:00
@@ -510,7 +510,6 @@
 #       normal descending-into-subdirs phase, since at that time
 #       we cannot yet know if we will need to relink vmlinux.
 #	So we descend into init/ inside the rule for vmlinux again.
-head-y += $(HEAD)
 vmlinux-objs := $(head-y) $(init-y) $(core-y) $(libs-y) $(drivers-y) $(net-y)
 
 quiet_cmd_vmlinux__ = LD      $@
diff -Nru a/arch/cris/Makefile b/arch/cris/Makefile
--- a/arch/cris/Makefile	2004-08-19 01:07:24 +02:00
+++ b/arch/cris/Makefile	2004-08-19 01:07:24 +02:00
@@ -39,7 +39,7 @@
 CFLAGS += -fno-omit-frame-pointer
 endif
 
-HEAD := arch/$(ARCH)/$(SARCH)/kernel/head.o
+head-y := arch/$(ARCH)/$(SARCH)/kernel/head.o
 
 LIBGCC = $(shell $(CC) $(CFLAGS) -print-file-name=libgcc.a)
 
