Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751229AbWJDX0a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751229AbWJDX0a (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 19:26:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751234AbWJDX0a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 19:26:30 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:22401 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1751229AbWJDX03 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 19:26:29 -0400
Message-Id: <20061004232502.696659000@linux-m68k.org>
References: <20061004232414.730831000@linux-m68k.org>
User-Agent: quilt/0.45-1
Date: Thu, 05 Oct 2006 01:24:19 +0200
From: zippel@linux-m68k.org
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] m68k: fix NBPG define
Content-Disposition: inline; filename=nbpg
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The recent header cleanup removed PAGE_SIZE from the exported
information as it depends on the configuration.
BTW This has possibly other consequences, as the core dump code is using
PAGE_SIZE directly, which may need fixing as well.

Signed-off-by: Roman Zippel <zippel@linux-m68k.org>

---

 include/asm-m68k/user.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6/include/asm-m68k/user.h
===================================================================
--- linux-2.6.orig/include/asm-m68k/user.h
+++ linux-2.6/include/asm-m68k/user.h
@@ -81,7 +81,7 @@ struct user{
   unsigned long magic;		/* To uniquely identify a core file */
   char u_comm[32];		/* User command that was responsible */
 };
-#define NBPG PAGE_SIZE
+#define NBPG 4096
 #define UPAGES 1
 #define HOST_TEXT_START_ADDR (u.start_code)
 #define HOST_STACK_END_ADDR (u.start_stack + u.u_ssize * NBPG)

--

