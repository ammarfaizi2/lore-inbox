Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261929AbUKVFuH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261929AbUKVFuH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 00:50:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261938AbUKVFuH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 00:50:07 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:65028 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261929AbUKVFuB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 00:50:01 -0500
Date: Mon, 22 Nov 2004 06:49:59 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Subject: [2.6 patch] Use -ffreestanding? (fwd)
Message-ID: <20041122054959.GI3007@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

for the kernel, it would be logical to use -ffreestanding. The kernel is 
not a hosted environment with a standard C library.

Linus agreed that it would make sense.

The gcc option -ffreestanding is supported by both gcc 2.95 and 3.4, 
which covers the whole range of currently supported compilers.

Could you add the patch below to the next -mm to see whether there are 
any problems I didn't find?

TIA
Adrian



Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc1-mm4-full-ffreestanding/Makefile.old	2004-11-09 22:27:06.000000000 +0100
+++ linux-2.6.10-rc1-mm4-full-ffreestanding/Makefile	2004-11-09 22:27:47.000000000 +0100
@@ -349,7 +349,8 @@
 CPPFLAGS        := -D__KERNEL__ $(LINUXINCLUDE)
 
 CFLAGS 		:= -Wall -Wstrict-prototypes -Wno-trigraphs \
-	  	   -fno-strict-aliasing -fno-common
+	  	   -fno-strict-aliasing -fno-common \
+		   -ffreestanding
 AFLAGS		:= -D__ASSEMBLY__
 
 export	VERSION PATCHLEVEL SUBLEVEL EXTRAVERSION LOCALVERSION KERNELRELEASE \



