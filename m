Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932434AbVJYWHW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932434AbVJYWHW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Oct 2005 18:07:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932437AbVJYWFi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Oct 2005 18:05:38 -0400
Received: from [151.97.230.9] ([151.97.230.9]:62181 "EHLO ssc.unict.it")
	by vger.kernel.org with ESMTP id S932434AbVJYWFc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Oct 2005 18:05:32 -0400
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Subject: [PATCH 11/11] uml: micro fixups to arch Kconfig
Date: Wed, 26 Oct 2005 00:03:03 +0200
To: Jeff Dike <jdike@addtoit.com>
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Message-Id: <20051025220302.20010.67493.stgit@zion.home.lan>
In-Reply-To: <20051025220053.20010.56979.stgit@zion.home.lan>
References: <20051025220053.20010.56979.stgit@zion.home.lan>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

Remove a stone-age comment (UM *does* have a MMU, i.e. the host), and fix a
dependency (introduced in commit 02edeb586ae4cdd17778923674700edb732a4741) to
do what was intended.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 arch/um/Kconfig |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/um/Kconfig b/arch/um/Kconfig
--- a/arch/um/Kconfig
+++ b/arch/um/Kconfig
@@ -7,7 +7,6 @@ config UML
 	bool
 	default y
 
-# XXX: does UM have a mmu/swap?
 config MMU
 	bool
 	default y
@@ -196,7 +195,8 @@ config HOST_2G_2G
 config SMP
 	bool "Symmetric multi-processing support (EXPERIMENTAL)"
 	default n
-	depends on (MODE_TT && EXPERIMENTAL && !SMP_BROKEN) || (BROKEN && SMP_BROKEN)
+	#SMP_BROKEN is for x86_64.
+	depends on MODE_TT && EXPERIMENTAL && (!SMP_BROKEN || (BROKEN && SMP_BROKEN))
 	help
 	This option enables UML SMP support.
 	It is NOT related to having a real SMP box. Not directly, at least.

