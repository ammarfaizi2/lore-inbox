Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264954AbSLaXdk>; Tue, 31 Dec 2002 18:33:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264963AbSLaXdk>; Tue, 31 Dec 2002 18:33:40 -0500
Received: from ns.netrox.net ([64.118.231.130]:48521 "EHLO smtp01.netrox.net")
	by vger.kernel.org with ESMTP id <S264954AbSLaXdj>;
	Tue, 31 Dec 2002 18:33:39 -0500
Subject: Re: [PATCH] __deprecated requires gcc 3.1
From: Robert Love <rml@tech9.net>
To: torvalds@transmeta.com
Cc: James Bottomley <James.Bottomley@steeleye.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <200212312313.gBVNDdM04070@localhost.localdomain>
References: <200212312313.gBVNDdM04070@localhost.localdomain>
Content-Type: text/plain
Organization: 
Message-Id: <1041378241.948.14.camel@icbm>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 
Date: 31 Dec 2002 18:44:03 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-12-31 at 18:13, James Bottomley wrote:

> Oops, mea culpa on that one.  It's missing a trailing `__' on the end of 
> __GNUC_MINOR

Looks like Linus already committed it.

Attached patch is against the updated BK and fixes the omission.  Sorry.

	Robert Love

 include/linux/compiler.h |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)


diff -urN linux-2.5.53/include/linux/compiler.h linux/include/linux/compiler.h
--- linux-2.5.53/include/linux/compiler.h	2002-12-31 18:39:55.000000000 -0500
+++ linux/include/linux/compiler.h	2002-12-31 18:40:10.000000000 -0500
@@ -19,7 +19,7 @@
  * Usage is:
  * 		int __deprecated foo(void)
  */
-#if ( __GNUC__ == 3 && __GNUC_MINOR > 0 ) || __GNUC__ > 3
+#if ( __GNUC__ == 3 && __GNUC_MINOR__ > 0 ) || __GNUC__ > 3
 #define __deprecated	__attribute__((deprecated))
 #else
 #define __deprecated



