Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319320AbSILHQO>; Thu, 12 Sep 2002 03:16:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319356AbSILHPV>; Thu, 12 Sep 2002 03:15:21 -0400
Received: from dp.samba.org ([66.70.73.150]:29880 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S319320AbSILHPQ>;
	Thu, 12 Sep 2002 03:15:16 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: torvalds@transmeta.com, Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Generated files destruction
Date: Thu, 12 Sep 2002 17:13:09 +1000
Message-Id: <20020912072006.EBADF2C0C7@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please apply.

	I would like to start migrating all build-generated files to
names matching "generated*" or ".generated*", esp. those which look
like source files.  This is mainly for readability and for simplicity
when diffing built kernel trees.  I'll be encouraging various
maintainers who generate (.c, .h and .s) files which are not meant to
be shipped with the kernel source to migrate, in my copious free
time...

Cheers!
Rusty.

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.34/Makefile working-2.5.34-generated-remove/Makefile
--- linux-2.5.34/Makefile	2002-09-10 09:11:14.000000000 +1000
+++ working-2.5.34-generated-remove/Makefile	2002-09-12 17:09:06.000000000 +1000
@@ -660,6 +660,7 @@ clean:	archclean
 	@echo 'Cleaning up'
 	@find . -name SCCS -prune -o -name BitKeeper -prune -o \
 		\( -name \*.[oas] -o -name core -o -name .\*.cmd -o \
+		-name generated\* -o -name .generated\* -o \
 		-name .\*.tmp -o -name .\*.d \) -type f -print \
 		| grep -v lxdialog/ | xargs rm -f
 	@rm -f $(CLEAN_FILES)

--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
