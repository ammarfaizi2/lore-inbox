Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932729AbVJ3A6d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932729AbVJ3A6d (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Oct 2005 20:58:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932730AbVJ3A6d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Oct 2005 20:58:33 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:20234 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932729AbVJ3A6c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Oct 2005 20:58:32 -0400
Date: Sun, 30 Oct 2005 02:58:30 +0200
From: Adrian Bunk <bunk@stusta.de>
To: linux-kernel@vger.kernel.org
Subject: [2.6 patch] arch/i386/mm/init.c: small cleanups
Message-ID: <20051030005830.GS4180@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch contains the following cleanups:
- make a needlessly global function static
- every file should include the headers containing the prototypes for
  it's global functions


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 arch/i386/mm/init.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- linux-2.6.14-rc5-mm1-full/arch/i386/mm/init.c.old	2005-10-30 02:20:25.000000000 +0200
+++ linux-2.6.14-rc5-mm1-full/arch/i386/mm/init.c	2005-10-30 02:23:55.000000000 +0200
@@ -28,6 +28,7 @@
 #include <linux/proc_fs.h>
 #include <linux/efi.h>
 #include <linux/memory_hotplug.h>
+#include <linux/initrd.h>
 
 #include <asm/processor.h>
 #include <asm/system.h>
@@ -267,7 +268,7 @@
 	pkmap_page_table = pte;	
 }
 
-void __devinit free_new_highpage(struct page *page)
+static void __devinit free_new_highpage(struct page *page)
 {
 	set_page_count(page, 1);
 	__free_page(page);

