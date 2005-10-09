Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932272AbVJITp7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932272AbVJITp7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Oct 2005 15:45:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750974AbVJITmf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Oct 2005 15:42:35 -0400
Received: from ppp-62-11-74-46.dialup.tiscali.it ([62.11.74.46]:24472 "EHLO
	zion.home.lan") by vger.kernel.org with ESMTP id S1750968AbVJITmZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Oct 2005 15:42:25 -0400
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Subject: [PATCH 6/6] uml: cleanup whitespace for COW driver
Date: Sun, 09 Oct 2005 21:37:53 +0200
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
Message-Id: <20051009193753.26019.59186.stgit@zion.home.lan>
In-Reply-To: <200510092118.21032.blaisorblade@yahoo.it>
References: <200510092118.21032.blaisorblade@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

Fix whitespace - I split this off the previous patch for easier review.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 arch/um/drivers/cow.h |   18 +++++++++---------
 1 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/um/drivers/cow.h b/arch/um/drivers/cow.h
--- a/arch/um/drivers/cow.h
+++ b/arch/um/drivers/cow.h
@@ -23,15 +23,15 @@
 #include <netinet/in.h>
 #if defined(__BYTE_ORDER)
 
-#if __BYTE_ORDER == __BIG_ENDIAN
-# define ntohll(x) (x)
-# define htonll(x) (x)
-#elif __BYTE_ORDER == __LITTLE_ENDIAN
-# define ntohll(x)  bswap_64(x)
-# define htonll(x)  bswap_64(x)
-#else
-# error "Could not determine byte order: __BYTE_ORDER uncorrectly defined"
-#endif
+#  if __BYTE_ORDER == __BIG_ENDIAN
+#	define ntohll(x) (x)
+#	define htonll(x) (x)
+#  elif __BYTE_ORDER == __LITTLE_ENDIAN
+#	define ntohll(x)  bswap_64(x)
+#	define htonll(x)  bswap_64(x)
+#  else
+#	error "Could not determine byte order: __BYTE_ORDER uncorrectly defined"
+#  endif
 
 #else  /* ! defined(__BYTE_ORDER) */
 #	error "Could not determine byte order: __BYTE_ORDER not defined"

