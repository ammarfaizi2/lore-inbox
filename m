Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424283AbWLBRyy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424283AbWLBRyy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Dec 2006 12:54:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424285AbWLBRyy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Dec 2006 12:54:54 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:54789 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1424283AbWLBRyx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Dec 2006 12:54:53 -0500
Date: Sat, 2 Dec 2006 18:54:58 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org, chris@zankel.net
Subject: [-mm patch] fix include/asm-xtensa/unistd.h compilation
Message-ID: <20061202175458.GS11084@stusta.de>
References: <20061128020246.47e481eb.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061128020246.47e481eb.akpm@osdl.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

<--  snip  -->

...
In file included from 
/home/bunk/linux/kernel-2.6/linux-2.6.19-rc6-mm2/include/linux/unistd.h:7,
                 from 
/home/bunk/linux/kernel-2.6/linux-2.6.19-rc6-mm2/init/main.c:46:
include2/asm/unistd.h:235:2: error: #endif without #if
make[2]: *** [init/main.o] Error 1

<--  snip  -->

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.19-rc6-mm2/include/asm-xtensa/unistd.h.old	2006-12-02 18:32:53.000000000 +0100
+++ linux-2.6.19-rc6-mm2/include/asm-xtensa/unistd.h	2006-12-02 18:35:01.000000000 +0100
@@ -218,6 +218,8 @@
 
 #define SYSXTENSA_COUNT		   5	/* count of syscall0 functions*/
 
+#ifdef __KERNEL__
+
 /*
  * "Conditional" syscalls
  *

