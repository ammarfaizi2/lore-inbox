Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265725AbVBDUEV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265725AbVBDUEV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 15:04:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266594AbVBDUCz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 15:02:55 -0500
Received: from www.ssc.unict.it ([151.97.230.9]:15876 "HELO ssc.unict.it")
	by vger.kernel.org with SMTP id S266788AbVBDUAe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 15:00:34 -0500
Subject: [patch 8/8] uml: fix x86_64 submode compilation [before 2.6.11]
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, jdike@addtoit.com,
       user-mode-linux-devel@lists.sourceforge.net, blaisorblade@yahoo.it
From: blaisorblade@yahoo.it
Date: Fri, 04 Feb 2005 19:35:58 +0100
Message-Id: <20050204183558.4EB559BCBA@zion>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Jeff Dike <jdike@addtoit.com>

Forgot to use ARCH_USER_CFLAGS after defining it for x86_64.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 linux-2.6.11-paolo/arch/um/Makefile |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -puN arch/um/Makefile~uml-x86_64-fixes arch/um/Makefile
--- linux-2.6.11/arch/um/Makefile~uml-x86_64-fixes	2005-02-04 07:41:07.673156760 +0100
+++ linux-2.6.11-paolo/arch/um/Makefile	2005-02-04 07:41:07.727148552 +0100
@@ -58,7 +58,7 @@ CFLAGS += $(CFLAGS-y) -D__arch_um__ -DSU
 
 USER_CFLAGS := $(patsubst -I%,,$(CFLAGS))
 USER_CFLAGS := $(patsubst -D__KERNEL__,,$(USER_CFLAGS)) $(ARCH_INCLUDE) \
-	$(MODE_INCLUDE)
+	$(MODE_INCLUDE) $(ARCH_USER_CFLAGS)
 CFLAGS += -Derrno=kernel_errno -Dsigprocmask=kernel_sigprocmask
 CFLAGS += $(call cc-option,-fno-unit-at-a-time,)
 
_
