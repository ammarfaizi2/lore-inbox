Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751255AbWIWPp5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751255AbWIWPp5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Sep 2006 11:45:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751257AbWIWPp4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Sep 2006 11:45:56 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:39124 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1751255AbWIWPp4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Sep 2006 11:45:56 -0400
Date: Sat, 23 Sep 2006 16:45:55 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
Subject: [PATCH] #elif that should've been #elif defined
Message-ID: <20060923154555.GJ29920@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 #elif CONFIG_44x
in ibm4xx.h should've been
 #elif defined(CONFIG_44x)

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 include/asm-ppc/ibm4xx.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/include/asm-ppc/ibm4xx.h b/include/asm-ppc/ibm4xx.h
index cf62b69..499c146 100644
--- a/include/asm-ppc/ibm4xx.h
+++ b/include/asm-ppc/ibm4xx.h
@@ -86,7 +86,7 @@ #define _ISA_MEM_BASE	0
 #define PCI_DRAM_OFFSET	0
 #endif
 
-#elif CONFIG_44x
+#elif defined(CONFIG_44x)
 
 #if defined(CONFIG_BAMBOO)
 #include <platforms/4xx/bamboo.h>
-- 
1.4.2.GIT

