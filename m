Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932162AbVIIP4J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932162AbVIIP4J (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 11:56:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932569AbVIIP4J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 11:56:09 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:58835 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S932162AbVIIP4I
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 11:56:08 -0400
Date: Fri, 9 Sep 2005 16:56:05 +0100
From: viro@ZenIV.linux.org.uk
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org, schwidefsky@de.ibm.com
Subject: [PATCH] missing CHECKFLAGS on s390
Message-ID: <20050909155605.GG9623@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
----
diff -urN RC13-git8-base/arch/s390/Makefile current/arch/s390/Makefile
--- RC13-git8-base/arch/s390/Makefile	2005-06-17 15:48:29.000000000 -0400
+++ current/arch/s390/Makefile	2005-09-08 23:53:33.000000000 -0400
@@ -19,6 +19,7 @@
 AFLAGS		+= -m31
 UTS_MACHINE	:= s390
 STACK_SIZE	:= 8192
+CHECKFLAGS	+= -D__s390__
 endif
 
 ifdef CONFIG_ARCH_S390X
@@ -28,6 +29,7 @@
 AFLAGS		+= -m64
 UTS_MACHINE	:= s390x
 STACK_SIZE	:= 16384
+CHECKFLAGS	+= -D__s390__ -D__s390x__
 endif
 
 cflags-$(CONFIG_MARCH_G5)   += $(call cc-option,-march=g5)
