Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264867AbSL0KfM>; Fri, 27 Dec 2002 05:35:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264877AbSL0KfM>; Fri, 27 Dec 2002 05:35:12 -0500
Received: from dp.samba.org ([66.70.73.150]:53135 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S264867AbSL0KfK>;
	Fri, 27 Dec 2002 05:35:10 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org, rth@twiddle.net
Subject: [PATCH] Trivial patch for param.h: make it const.
Date: Fri, 27 Dec 2002 21:24:40 +1100
Message-Id: <20021227104328.0DFEC2C056@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[ Another trivial RTH patch ]

Name: Param Should be Const
From: Richard Henderson <rth@twiddle.net>
Status: Trivial

D: Add a const declaration to the __module_param_call so __param section
D: gets more correct attributes.

===== include/linux/moduleparam.h 1.1 vs edited =====
--- 1.1/include/linux/moduleparam.h	Mon Dec  2 17:03:16 2002
+++ edited/include/linux/moduleparam.h	Thu Dec 26 12:34:10 2002
@@ -39,7 +39,7 @@
    writable. */
 #define __module_param_call(prefix, name, set, get, arg, perm)		\
 	static char __param_str_##name[] __initdata = prefix #name;	\
-	static struct kernel_param __param_##name			\
+	static struct kernel_param const __param_##name			\
 		 __attribute__ ((unused,__section__ ("__param")))	\
 	= { __param_str_##name, perm, set, get, arg }
 

--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
