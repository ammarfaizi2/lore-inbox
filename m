Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264895AbSKDFOG>; Mon, 4 Nov 2002 00:14:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264928AbSKDFOF>; Mon, 4 Nov 2002 00:14:05 -0500
Received: from dp.samba.org ([66.70.73.150]:10185 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S264895AbSKDFOF>;
	Mon, 4 Nov 2002 00:14:05 -0500
Date: Mon, 4 Nov 2002 16:06:56 +1100
From: Anton Blanchard <anton@samba.org>
To: torvalds@transmeta.com
Cc: trivial@rustcorp.com.au, linux-kernel@vger.kernel.org
Subject: [PATCH] missing include in linux/dcache.h
Message-ID: <20021104050656.GA22668@krispykreme>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Now we use ____cacheline_aligned in struct dentry, we must include
linux/cache.h.

Anton

===== include/linux/dcache.h 1.20 vs edited =====
--- 1.20/include/linux/dcache.h	Fri Nov  1 09:48:07 2002
+++ edited/include/linux/dcache.h	Sun Nov  3 11:55:59 2002
@@ -7,6 +7,7 @@
 #include <linux/mount.h>
 #include <linux/list.h>
 #include <linux/spinlock.h>
+#include <linux/cache.h>
 #include <asm/page.h>			/* for BUG() */
 
 /*
