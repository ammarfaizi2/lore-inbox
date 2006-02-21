Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932757AbWBURSv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932757AbWBURSv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 12:18:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932752AbWBURSt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 12:18:49 -0500
Received: from [151.97.230.9] ([151.97.230.9]:8414 "EHLO ssc.unict.it")
	by vger.kernel.org with ESMTP id S932756AbWBURR0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 12:17:26 -0500
X-Antivirus-MYDOMAIN-Mail-From: blaisorblade@yahoo.it via ssc.unict.it
X-Antivirus-MYDOMAIN: 1.25-st-qms (Clear:RC:1(151.97.230.9):. Processed in 0.032173 secs Process 16154)
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Subject: [PATCH 3/6] uml: fix ((unused)) attribute
Date: Tue, 21 Feb 2006 18:16:25 +0100
To: Andrew Morton <akpm@osdl.org>
Cc: Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
Message-Id: <20060221171625.509.73007.stgit@zion.home.lan>
In-Reply-To: <20060221171535.509.28286.stgit@zion.home.lan>
References: <20060221171535.509.28286.stgit@zion.home.lan>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Use __attribute_used__ instead of __attribute__ ((unused)).
This will help with GCC > 3.2.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 arch/um/include/init.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/um/include/init.h b/arch/um/include/init.h
index cbd79a8..d4de7c0 100644
--- a/arch/um/include/init.h
+++ b/arch/um/include/init.h
@@ -122,7 +122,7 @@ extern struct uml_param __uml_setup_star
 
 #define __exitcall(fn) static exitcall_t __exitcall_##fn __exit_call = fn
 
-#define __init_call __attribute__ ((unused,__section__ (".initcall.init")))
+#define __init_call	__attribute_used__ __attribute__ ((__section__ (".initcall.init")))
 
 #endif
 

