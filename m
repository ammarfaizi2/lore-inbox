Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261949AbVAKUgB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261949AbVAKUgB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 15:36:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262117AbVAKUgA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 15:36:00 -0500
Received: from mail1.fw-sj.sony.com ([160.33.82.68]:59832 "EHLO
	mail1.fw-sj.sony.com") by vger.kernel.org with ESMTP
	id S261949AbVAKUfv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 15:35:51 -0500
Message-ID: <41E43899.3080301@am.sony.com>
Date: Tue, 11 Jan 2005 12:35:37 -0800
From: Geoff Levand <geoffrey.levand@am.sony.com>
User-Agent: Mozilla Thunderbird 0.8 (X11/20041020)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: mporter@mvista.com
CC: linux-kernel@vger.kernel.org
Subject: [PATCH][PPC32] Fix ebony build warnings
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ebony-fix-warnings-05.01.11.patch:

This patch fixes some 'makes pointer from integer without a cast' build 
warnings for ebony.

Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com> for CELF
---

 ebony.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.10.orig/arch/ppc/platforms/4xx/ebony.c	2004-12-24 13:35:40.000000000 -0800
+++ fixed/arch/ppc/platforms/4xx/ebony.c	2005-01-11 12:27:13.253449121 -0800
@@ -179,7 +179,7 @@
 }
 
 #define PCIX_WRITEL(value, offset) \
-	(writel(value, (u32)pcix_reg_base+offset))
+	(writel(value, (void*)((u32)pcix_reg_base+offset)))
 
 /*
  * FIXME: This is only here to "make it work".  This will move

