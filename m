Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932077AbVIGWTn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932077AbVIGWTn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Sep 2005 18:19:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932091AbVIGWTn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Sep 2005 18:19:43 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:18652 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S932077AbVIGWTn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Sep 2005 18:19:43 -0400
Date: Wed, 7 Sep 2005 23:19:41 +0100
From: viro@ZenIV.linux.org.uk
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] -Wundef fixes (hisax)
Message-ID: <20050907221941.GC13549@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

CARD_... in hisax are all used with #if; CARD_FN_ENTERNOW_PCI lacks define
to 0 if corresponding config option is not set.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
----
diff -urN RC13-git7-uml-mem/drivers/isdn/hisax/hisax.h RC13-git7-hisax/drivers/isdn/hisax/hisax.h
--- RC13-git7-uml-mem/drivers/isdn/hisax/hisax.h	2005-09-07 13:55:17.000000000 -0400
+++ RC13-git7-hisax/drivers/isdn/hisax/hisax.h	2005-09-07 13:55:43.000000000 -0400
@@ -1241,6 +1241,8 @@
 
 #ifdef CONFIG_HISAX_ENTERNOW_PCI
 #define CARD_FN_ENTERNOW_PCI 1
+#else
+#define CARD_FN_ENTERNOW_PCI 0
 #endif
 
 #define TEI_PER_CARD 1
