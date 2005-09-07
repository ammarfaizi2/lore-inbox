Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932150AbVIGWZV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932150AbVIGWZV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Sep 2005 18:25:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751271AbVIGWZV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Sep 2005 18:25:21 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:51596 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1750781AbVIGWZV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Sep 2005 18:25:21 -0400
Date: Wed, 7 Sep 2005 23:25:15 +0100
From: viro@ZenIV.linux.org.uk
To: Linus Torvalds <torvalds@osdl.org>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] bogus #if (smc91x.h)
Message-ID: <20050907222515.GF13549@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
----
diff -urN RC13-git7-hisax/drivers/net/smc91x.h RC13-git7-smc-undef/drivers/net/smc91x.h
--- RC13-git7-hisax/drivers/net/smc91x.h	2005-08-28 23:09:44.000000000 -0400
+++ RC13-git7-smc-undef/drivers/net/smc91x.h	2005-09-07 13:55:44.000000000 -0400
@@ -986,7 +986,7 @@
 	})
 #endif
 
-#if SMC_CAN_USE_DATACS
+#ifdef SMC_CAN_USE_DATACS
 #define SMC_PUSH_DATA(p, l)						\
 	if ( lp->datacs ) {						\
 		unsigned char *__ptr = (p);				\
