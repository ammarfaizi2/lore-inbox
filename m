Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269395AbUJLAXY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269395AbUJLAXY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 20:23:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269377AbUJLAWf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 20:22:35 -0400
Received: from host157-148.pool8289.interbusiness.it ([82.89.148.157]:25987
	"EHLO zion.localdomain") by vger.kernel.org with ESMTP
	id S269401AbUJLATI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 20:19:08 -0400
Subject: [patch 06/10] uml: update makefile to new kbuild API names
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net, blaisorblade_spam@yahoo.it
From: blaisorblade_spam@yahoo.it
Date: Tue, 12 Oct 2004 02:17:56 +0200
Message-Id: <20041012001756.D46958693@zion.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Drop the usage of check_gcc and host-progs, and use their new names. A
must-have :-).

Oh, and it will create lots of serious problems - it will give me your root
account! Yes, you don't see the code in the patch, but it happens! :-)))

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>
---

 linux-2.6.9-current-paolo/arch/um/Makefile                  |    2 +-
 linux-2.6.9-current-paolo/arch/um/kernel/skas/util/Makefile |    4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff -puN arch/um/Makefile~uml-kbuild-renamings arch/um/Makefile
--- linux-2.6.9-current/arch/um/Makefile~uml-kbuild-renamings	2004-09-19 20:31:38.624115320 +0200
+++ linux-2.6.9-current-paolo/arch/um/Makefile	2004-09-19 20:31:38.628114712 +0200
@@ -46,7 +46,7 @@ CFLAGS += $(CFLAGS-y) -D__arch_um__ -DSU
 	-D_LARGEFILE64_SOURCE $(ARCH_INCLUDE) -Derrno=kernel_errno \
 	-Dsigprocmask=kernel_sigprocmask $(MODE_INCLUDE)
 
-CFLAGS += $(call check_gcc,-fno-unit-at-a-time,)
+CFLAGS += $(call cc-option,-fno-unit-at-a-time,)
 
 LINK_WRAPS = -Wl,--wrap,malloc -Wl,--wrap,free -Wl,--wrap,calloc
 
diff -puN arch/um/kernel/skas/util/Makefile~uml-kbuild-renamings arch/um/kernel/skas/util/Makefile
--- linux-2.6.9-current/arch/um/kernel/skas/util/Makefile~uml-kbuild-renamings	2004-09-19 20:31:38.625115168 +0200
+++ linux-2.6.9-current-paolo/arch/um/kernel/skas/util/Makefile	2004-09-19 20:32:05.746992016 +0200
@@ -1,2 +1,2 @@
-host-progs		:= mk_ptregs
-always			:= $(host-progs)
+hostprogs-y		:= mk_ptregs
+always			:= $(hostprogs-y)
_
