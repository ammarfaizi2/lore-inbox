Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261929AbSJDSnN>; Fri, 4 Oct 2002 14:43:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261954AbSJDSmB>; Fri, 4 Oct 2002 14:42:01 -0400
Received: from 3512-780200-170.dialup.surnet.ru ([212.57.170.170]:51214 "EHLO
	zzz.zzz") by vger.kernel.org with ESMTP id <S262046AbSJDSls>;
	Fri, 4 Oct 2002 14:41:48 -0400
Date: Fri, 4 Oct 2002 23:00:15 +0600
From: Denis Zaitsev <zzz@cd-club.ru>
To: davej@suse.de
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] [TRIVIAL] 2.5.40 Makefile: a small improvement
Message-ID: <20021004230015.C346@natasha.zzz.zzz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the -fno-ident for CFLAGS.  This flag saves some space
in object files.  It worth nothing for the compressed kernel (even
though vmlinux becomes smth. near 15K less), but it worth somethig for
the modules - each of them becomes for some tens of bytes less.  May
be this can be considered as healthy...


--- Makefile.orig	Thu Oct  3 23:34:54 2002
+++ Makefile	Fri Oct  4 00:21:07 2002
@@ -238,7 +238,7 @@
 CPPFLAGS := -D__KERNEL__ -I$(objtree)/include
 
 CFLAGS := $(CPPFLAGS) -Wall -Wstrict-prototypes -Wno-trigraphs -O2 \
-	  -fomit-frame-pointer -fno-strict-aliasing -fno-common
+	  -fomit-frame-pointer -fno-strict-aliasing -fno-common -fno-ident
 AFLAGS := -D__ASSEMBLY__ $(CPPFLAGS)
 
 ifdef CONFIG_MODULES
