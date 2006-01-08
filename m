Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752637AbWAHPcM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752637AbWAHPcM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jan 2006 10:32:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752639AbWAHPcM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jan 2006 10:32:12 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:54283 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1752637AbWAHPcK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jan 2006 10:32:10 -0500
Date: Sun, 8 Jan 2006 16:32:09 +0100
From: Adrian Bunk <bunk@stusta.de>
To: ralf@linux-mips.org, schwidefsky@de.ibm.com, linux390@de.ibm.com
Cc: linux-390@vm.marist.edu, linux-mips@linux-mips.org,
       linux-kernel@vger.kernel.org
Subject: [2.6 patch] mips/s390: remove -finline-limit=10000{,0}
Message-ID: <20060108153209.GM3774@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-finline-limit might have been required for older compilers, but 
nowadays it does no longer make sense.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 arch/mips/Makefile |    1 -
 arch/s390/Makefile |    1 -
 2 files changed, 2 deletions(-)

--- linux-2.6.15-mm2-full/arch/mips/Makefile.old	2006-01-08 16:25:35.000000000 +0100
+++ linux-2.6.15-mm2-full/arch/mips/Makefile	2006-01-08 16:25:46.000000000 +0100
@@ -93,7 +93,6 @@
 #
 cflags-y			+= -I $(TOPDIR)/include/asm/gcc
 cflags-y			+= -G 0 -mno-abicalls -fno-pic -pipe
-cflags-y			+= $(call cc-option, -finline-limit=100000)
 LDFLAGS_vmlinux			+= -G 0 -static -n -nostdlib
 MODFLAGS			+= -mlong-calls
 
--- linux-2.6.15-mm2-full/arch/s390/Makefile.old	2006-01-08 16:25:53.000000000 +0100
+++ linux-2.6.15-mm2-full/arch/s390/Makefile	2006-01-08 16:25:59.000000000 +0100
@@ -67,7 +67,6 @@
 endif
 
 CFLAGS		+= -mbackchain -msoft-float $(cflags-y)
-CFLAGS		+= $(call cc-option,-finline-limit=10000)
 CFLAGS 		+= -pipe -fno-strength-reduce -Wno-sign-compare 
 AFLAGS		+= $(aflags-y)
 

