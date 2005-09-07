Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750768AbVIGW2g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750768AbVIGW2g (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Sep 2005 18:28:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751308AbVIGW2g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Sep 2005 18:28:36 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:3211 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1750768AbVIGW2f
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Sep 2005 18:28:35 -0400
Date: Wed, 7 Sep 2005 23:28:32 +0100
From: viro@ZenIV.linux.org.uk
To: Linus Torvalds <torvalds@osdl.org>
Cc: linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] CHECKFLAGS on ppc64 got broken
Message-ID: <20050907222832.GH13549@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Now that asm-powerpc/* is using ifdefs on __powerpc64__ we need to add it
to CHECKFLAGS on ppc64.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
----
diff -urN RC13-git7-simserial/arch/ppc64/Makefile RC13-git7-ppc64-sparse/arch/ppc64/Makefile
--- RC13-git7-simserial/arch/ppc64/Makefile	2005-09-05 07:05:14.000000000 -0400
+++ RC13-git7-ppc64-sparse/arch/ppc64/Makefile	2005-09-07 13:55:41.000000000 -0400
@@ -49,7 +49,7 @@
 
 endif
 
-CHECKFLAGS	+= -m64 -D__powerpc__
+CHECKFLAGS	+= -m64 -D__powerpc__ -D__powerpc64__
 
 LDFLAGS		:= -m elf64ppc
 LDFLAGS_vmlinux	:= -Bstatic -e $(KERNELLOAD) -Ttext $(KERNELLOAD)
