Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932284AbVIJUdR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932284AbVIJUdR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Sep 2005 16:33:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932285AbVIJUdR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Sep 2005 16:33:17 -0400
Received: from pfepa.post.tele.dk ([195.41.46.235]:61506 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S932284AbVIJUdP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Sep 2005 16:33:15 -0400
Date: Sat, 10 Sep 2005 22:34:53 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH 2/7] kbuild: CF=<arguments> passes arguments to sparse
Message-ID: <20050910203453.GB29334@mars.ravnborg.org>
References: <20050910200347.GA3762@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050910200347.GA3762@mars.ravnborg.org>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Allows to add to sparse arguments without mutilating makefiles - just
pass CF=<arguments> and they will be added to CHECKFLAGS.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

---

 Makefile |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

7b49bb9aff8b14d15da58111d8908c877c0a525e
diff --git a/Makefile b/Makefile
--- a/Makefile
+++ b/Makefile
@@ -334,7 +334,7 @@ KALLSYMS	= scripts/kallsyms
 PERL		= perl
 CHECK		= sparse
 
-CHECKFLAGS     := -D__linux__ -Dlinux -D__STDC__ -Dunix -D__unix__
+CHECKFLAGS     := -D__linux__ -Dlinux -D__STDC__ -Dunix -D__unix__ $(CF)
 MODFLAGS	= -DMODULE
 CFLAGS_MODULE   = $(MODFLAGS)
 AFLAGS_MODULE   = $(MODFLAGS)

