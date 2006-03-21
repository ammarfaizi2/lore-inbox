Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030443AbWCUQaS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030443AbWCUQaS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 11:30:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030432AbWCUQaQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 11:30:16 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:30732 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1030361AbWCUQVO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 11:21:14 -0500
Cc: Martin Michlmayr <tbm@cyrius.com>, Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH 07/46] kbuild: Accept various mips sub-types in SUBARCH
In-Reply-To: <114295805457-git-send-email-sam@ravnborg.org>
X-Mailer: git-send-email
Date: Tue, 21 Mar 2006 17:20:54 +0100
Message-Id: <11429580542554-git-send-email-sam@ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Sam Ravnborg <sam@ravnborg.org>
To: lkml <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 7BIT
From: Sam Ravnborg <sam@ravnborg.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

uname -m on MIPS can give a number of results, such as mips64.  We
need to add another substitution to the sed call for SUBARCH in the
main Makefile.

Signed-off-by: Martin Michlmayr <tbm@cyrius.com>
Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

---

 Makefile |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

8999257c292cb757828ae3def9f5e9d894a24741
diff --git a/Makefile b/Makefile
index 639d8a4..1db819e 100644
--- a/Makefile
+++ b/Makefile
@@ -151,7 +151,7 @@ export srctree objtree VPATH TOPDIR
 SUBARCH := $(shell uname -m | sed -e s/i.86/i386/ -e s/sun4u/sparc64/ \
 				  -e s/arm.*/arm/ -e s/sa110/arm/ \
 				  -e s/s390x/s390/ -e s/parisc64/parisc/ \
-				  -e s/ppc.*/powerpc/ )
+				  -e s/ppc.*/powerpc/ -e s/mips.*/mips/ )
 
 # Cross compiling and selecting different set of gcc/bin-utils
 # ---------------------------------------------------------------------------
-- 
1.0.GIT


