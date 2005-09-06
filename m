Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965030AbVIFBCZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965030AbVIFBCZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Sep 2005 21:02:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965032AbVIFBCY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Sep 2005 21:02:24 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:3787 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S965030AbVIFBCY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Sep 2005 21:02:24 -0400
Date: Tue, 6 Sep 2005 02:02:22 +0100
From: viro@ZenIV.linux.org.uk
To: Linus Torvalds <torvalds@osdl.org>
Cc: Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] lost chunk of "uml: build cleanups"
Message-ID: <20050906010222.GR5155@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A piece of the UML stubs patch got lost - it has
    Killed STUBS_CFLAGS - it's not needed and the only remaining use had been
    gratitious - it only polluted CFLAGS
in description and does remove it in arch/um/Makefile-x86_64, but forgets to
do the same in i386 counterpart.  Lost chunk follows:

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
----
diff -urN RC13-git5-uml-user/arch/um/Makefile-i386 RC13-git5-stubs/arch/um/Makefile-i386
--- RC13-git5-uml-user/arch/um/Makefile-i386	2005-08-28 23:09:40.000000000 -0400
+++ RC13-git5-stubs/arch/um/Makefile-i386	2005-09-05 16:40:46.000000000 -0400
@@ -27,7 +27,7 @@
 endif
 endif
 
-CFLAGS += -U__$(SUBARCH)__ -U$(SUBARCH) $(STUB_CFLAGS)
+CFLAGS += -U__$(SUBARCH)__ -U$(SUBARCH)
 
 ifneq ($(CONFIG_GPROF),y)
 ARCH_CFLAGS += -DUM_FASTCALL
