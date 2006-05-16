Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751797AbWEPLqr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751797AbWEPLqr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 07:46:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751799AbWEPLqr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 07:46:47 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:6675 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751797AbWEPLqq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 07:46:46 -0400
Date: Tue, 16 May 2006 13:46:44 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, dwmw2@infradead.org
Cc: linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
Subject: [-mm patch] drivers/mtd/devices/docprobe.c: correct #if's
Message-ID: <20060516114644.GN6931@stusta.de>
References: <20060515005637.00b54560.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060515005637.00b54560.akpm@osdl.org>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 15, 2006 at 12:56:37AM -0700, Andrew Morton wrote:
>...
> Changes since 2.6.17-rc3-mm1:
>...
>  git-mtd.patch
>...
>  git trees
>...

If we correct the names of the config options, the code might actually 
work as intended...
 
Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/mtd/devices/docprobe.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- linux-2.6.17-rc4-mm1-full/drivers/mtd/devices/docprobe.c.old	2006-05-16 12:58:49.000000000 +0200
+++ linux-2.6.17-rc4-mm1-full/drivers/mtd/devices/docprobe.c	2006-05-16 12:59:08.000000000 +0200
@@ -231,21 +231,21 @@
 
 static int docfound;
 
-#ifdef CONFIG_DOC2000
+#ifdef CONFIG_MTD_DOC2000
 extern void DoC2k_init(struct mtd_info *);
 #define doc2k_initfunc (&DoC2k_init)
 #else 
 #define doc2k_initfunc NULL
 #endif
 
-#ifdef CONFIG_DOC2001
+#ifdef CONFIG_MTD_DOC2001
 extern void DoCMil_init(struct mtd_info *);
 #define docmil_initfunc (&DoCMil_init)
 #else 
 #define docmil_initfunc NULL
 #endif
 
-#ifdef CONFIG_DOC2001PLUS
+#ifdef CONFIG_MTD_DOC2001PLUS
 extern void DoCMilPlus_init(struct mtd_info *);
 #define docmplus_initfunc (&DoCMilPlus_init)
 #else 

