Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932707AbWAMDwM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932707AbWAMDwM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 22:52:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932711AbWAMDwL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 22:52:11 -0500
Received: from [218.25.172.144] ([218.25.172.144]:34318 "HELO mail.fc-cn.com")
	by vger.kernel.org with SMTP id S932707AbWAMDwK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 22:52:10 -0500
Date: Fri, 13 Jan 2006 11:51:56 +0800
From: Coywolf Qi Hunt <qiyong@fc-cn.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: abandon gcc 295x main.c tidy
Message-ID: <20060113035156.GA5665@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

After abandon-gcc-295x.patch, this relocates the
error-out-early comment.

Signed-off-by: Coywolf Qi Hunt <qiyong@fc-cn.com>
---

diff --git a/init/main.c b/init/main.c
index e092b19..22c4ff5 100644
--- a/init/main.c
+++ b/init/main.c
@@ -54,15 +54,15 @@
 #include <asm/sections.h>
 #include <asm/cacheflush.h>
 
+#ifdef CONFIG_X86_LOCAL_APIC
+#include <asm/smp.h>
+#endif
+
 /*
  * This is one of the first .c files built. Error out early
  * if we have compiler trouble..
  */
 
-#ifdef CONFIG_X86_LOCAL_APIC
-#include <asm/smp.h>
-#endif
-
 /*
  * Versions of gcc older than that listed below may actually compile
  * and link okay, but the end product can have subtle run time bugs.

-- 
Coywolf Qi Hunt
