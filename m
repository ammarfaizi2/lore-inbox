Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261784AbTILSaQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Sep 2003 14:30:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261794AbTILS36
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Sep 2003 14:29:58 -0400
Received: from mail.parknet.co.jp ([210.171.160.6]:56069 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S261784AbTILSZh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Sep 2003 14:25:37 -0400
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] NLS: remove the elisp (2/2)
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Sat, 13 Sep 2003 03:25:21 +0900
Message-ID: <87ekyl3lv2.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This elisp was obsolete on recently emacs's cc-mode. And this should
be personally setting.

Please apply.

 linux-2.6.0-test5-hirofumi/fs/nls/nls_cp1250.c     |   18 ------------------
 linux-2.6.0-test5-hirofumi/fs/nls/nls_cp1251.c     |   16 ----------------
 linux-2.6.0-test5-hirofumi/fs/nls/nls_cp1255.c     |   17 -----------------
 linux-2.6.0-test5-hirofumi/fs/nls/nls_cp437.c      |   16 ----------------
 linux-2.6.0-test5-hirofumi/fs/nls/nls_cp737.c      |   16 ----------------
 linux-2.6.0-test5-hirofumi/fs/nls/nls_cp775.c      |   16 ----------------
 linux-2.6.0-test5-hirofumi/fs/nls/nls_cp850.c      |   16 ----------------
 linux-2.6.0-test5-hirofumi/fs/nls/nls_cp852.c      |   16 ----------------
 linux-2.6.0-test5-hirofumi/fs/nls/nls_cp855.c      |   16 ----------------
 linux-2.6.0-test5-hirofumi/fs/nls/nls_cp857.c      |   16 ----------------
 linux-2.6.0-test5-hirofumi/fs/nls/nls_cp860.c      |   16 ----------------
 linux-2.6.0-test5-hirofumi/fs/nls/nls_cp861.c      |   16 ----------------
 linux-2.6.0-test5-hirofumi/fs/nls/nls_cp862.c      |   16 ----------------
 linux-2.6.0-test5-hirofumi/fs/nls/nls_cp863.c      |   16 ----------------
 linux-2.6.0-test5-hirofumi/fs/nls/nls_cp864.c      |   16 ----------------
 linux-2.6.0-test5-hirofumi/fs/nls/nls_cp865.c      |   16 ----------------
 linux-2.6.0-test5-hirofumi/fs/nls/nls_cp866.c      |   16 ----------------
 linux-2.6.0-test5-hirofumi/fs/nls/nls_cp869.c      |   16 ----------------
 linux-2.6.0-test5-hirofumi/fs/nls/nls_cp874.c      |   17 -----------------
 linux-2.6.0-test5-hirofumi/fs/nls/nls_cp932.c      |   17 -----------------
 linux-2.6.0-test5-hirofumi/fs/nls/nls_cp936.c      |   17 -----------------
 linux-2.6.0-test5-hirofumi/fs/nls/nls_cp949.c      |   17 -----------------
 linux-2.6.0-test5-hirofumi/fs/nls/nls_cp950.c      |   17 -----------------
 linux-2.6.0-test5-hirofumi/fs/nls/nls_euc-jp.c     |   18 +-----------------
 linux-2.6.0-test5-hirofumi/fs/nls/nls_iso8859-1.c  |   18 +-----------------
 linux-2.6.0-test5-hirofumi/fs/nls/nls_iso8859-13.c |   18 +-----------------
 linux-2.6.0-test5-hirofumi/fs/nls/nls_iso8859-14.c |   18 +-----------------
 linux-2.6.0-test5-hirofumi/fs/nls/nls_iso8859-15.c |   18 +-----------------
 linux-2.6.0-test5-hirofumi/fs/nls/nls_iso8859-2.c  |   18 +-----------------
 linux-2.6.0-test5-hirofumi/fs/nls/nls_iso8859-3.c  |   18 +-----------------
 linux-2.6.0-test5-hirofumi/fs/nls/nls_iso8859-4.c  |   18 +-----------------
 linux-2.6.0-test5-hirofumi/fs/nls/nls_iso8859-5.c  |   18 +-----------------
 linux-2.6.0-test5-hirofumi/fs/nls/nls_iso8859-6.c  |   18 +-----------------
 linux-2.6.0-test5-hirofumi/fs/nls/nls_iso8859-7.c  |   18 +-----------------
 linux-2.6.0-test5-hirofumi/fs/nls/nls_iso8859-9.c  |   18 +-----------------
 linux-2.6.0-test5-hirofumi/fs/nls/nls_koi8-r.c     |   18 +-----------------
 linux-2.6.0-test5-hirofumi/fs/nls/nls_koi8-ru.c    |   18 +-----------------
 linux-2.6.0-test5-hirofumi/fs/nls/nls_koi8-u.c     |   18 +-----------------
 38 files changed, 15 insertions(+), 631 deletions(-)

diff -puN fs/nls/nls_cp1250.c~nls-cleanup fs/nls/nls_cp1250.c
--- linux-2.6.0-test5/fs/nls/nls_cp1250.c~nls-cleanup	2003-09-13 03:22:41.000000000 +0900
+++ linux-2.6.0-test5-hirofumi/fs/nls/nls_cp1250.c	2003-09-13 03:22:42.000000000 +0900
@@ -345,21 +345,3 @@ module_init(init_nls_cp1250)
 module_exit(exit_nls_cp1250)
 
 MODULE_LICENSE("Dual BSD/GPL");
-
-/*
- * Overrides for Emacs so that we follow Linus's tabbing style.
- * Emacs will notice this stuff at the end of the file and automatically
- * adjust the settings for this buffer only.  This must remain at the end
- * of the file.
- * ---------------------------------------------------------------------------
- * Local variables:
- * c-indent-level: 8
- * c-brace-imaginary-offset: 0
- * c-brace-offset: -8
- * c-argdecl-indent: 8
- * c-label-offset: -8
- * c-continued-statement-offset: 8
- * c-continued-brace-offset: 0
- * End:
- */
-
diff -puN fs/nls/nls_cp1251.c~nls-cleanup fs/nls/nls_cp1251.c
--- linux-2.6.0-test5/fs/nls/nls_cp1251.c~nls-cleanup	2003-09-13 03:22:41.000000000 +0900
+++ linux-2.6.0-test5-hirofumi/fs/nls/nls_cp1251.c	2003-09-13 03:22:42.000000000 +0900
@@ -299,20 +299,4 @@ static void __exit exit_nls_cp1251(void)
 module_init(init_nls_cp1251)
 module_exit(exit_nls_cp1251)
 
-/*
- * Overrides for Emacs so that we follow Linus's tabbing style.
- * Emacs will notice this stuff at the end of the file and automatically
- * adjust the settings for this buffer only.  This must remain at the end
- * of the file.
- * ---------------------------------------------------------------------------
- * Local variables:
- * c-indent-level: 8
- * c-brace-imaginary-offset: 0
- * c-brace-offset: -8
- * c-argdecl-indent: 8
- * c-label-offset: -8
- * c-continued-statement-offset: 8
- * c-continued-brace-offset: 0
- * End:
- */
 MODULE_LICENSE("Dual BSD/GPL");
diff -puN fs/nls/nls_cp1255.c~nls-cleanup fs/nls/nls_cp1255.c
--- linux-2.6.0-test5/fs/nls/nls_cp1255.c~nls-cleanup	2003-09-13 03:22:42.000000000 +0900
+++ linux-2.6.0-test5-hirofumi/fs/nls/nls_cp1255.c	2003-09-13 03:22:42.000000000 +0900
@@ -383,20 +383,3 @@ module_exit(exit_nls_cp1255)
 
 MODULE_LICENSE("Dual BSD/GPL");
 MODULE_ALIAS_NLS(iso8859-8);
-
-/*
- * Overrides for Emacs so that we follow Linus's tabbing style.
- * Emacs will notice this stuff at the end of the file and automatically
- * adjust the settings for this buffer only.  This must remain at the end
- * of the file.
- * ---------------------------------------------------------------------------
- * Local variables:
- * c-indent-level: 8
- * c-brace-imaginary-offset: 0
- * c-brace-offset: -8
- * c-argdecl-indent: 8
- * c-label-offset: -8
- * c-continued-statement-offset: 8
- * c-continued-brace-offset: 0
- * End:
- */
diff -puN fs/nls/nls_cp437.c~nls-cleanup fs/nls/nls_cp437.c
--- linux-2.6.0-test5/fs/nls/nls_cp437.c~nls-cleanup	2003-09-13 03:22:42.000000000 +0900
+++ linux-2.6.0-test5-hirofumi/fs/nls/nls_cp437.c	2003-09-13 03:22:42.000000000 +0900
@@ -385,20 +385,4 @@ static void __exit exit_nls_cp437(void)
 module_init(init_nls_cp437)
 module_exit(exit_nls_cp437)
 
-/*
- * Overrides for Emacs so that we follow Linus's tabbing style.
- * Emacs will notice this stuff at the end of the file and automatically
- * adjust the settings for this buffer only.  This must remain at the end
- * of the file.
- * ---------------------------------------------------------------------------
- * Local variables:
- * c-indent-level: 8
- * c-brace-imaginary-offset: 0
- * c-brace-offset: -8
- * c-argdecl-indent: 8
- * c-label-offset: -8
- * c-continued-statement-offset: 8
- * c-continued-brace-offset: 0
- * End:
- */
 MODULE_LICENSE("Dual BSD/GPL");
diff -puN fs/nls/nls_cp737.c~nls-cleanup fs/nls/nls_cp737.c
--- linux-2.6.0-test5/fs/nls/nls_cp737.c~nls-cleanup	2003-09-13 03:22:42.000000000 +0900
+++ linux-2.6.0-test5-hirofumi/fs/nls/nls_cp737.c	2003-09-13 03:22:42.000000000 +0900
@@ -348,20 +348,4 @@ static void __exit exit_nls_cp737(void)
 module_init(init_nls_cp737)
 module_exit(exit_nls_cp737)
 
-/*
- * Overrides for Emacs so that we follow Linus's tabbing style.
- * Emacs will notice this stuff at the end of the file and automatically
- * adjust the settings for this buffer only.  This must remain at the end
- * of the file.
- * ---------------------------------------------------------------------------
- * Local variables:
- * c-indent-level: 8
- * c-brace-imaginary-offset: 0
- * c-brace-offset: -8
- * c-argdecl-indent: 8
- * c-label-offset: -8
- * c-continued-statement-offset: 8
- * c-continued-brace-offset: 0
- * End:
- */
 MODULE_LICENSE("Dual BSD/GPL");
diff -puN fs/nls/nls_cp775.c~nls-cleanup fs/nls/nls_cp775.c
--- linux-2.6.0-test5/fs/nls/nls_cp775.c~nls-cleanup	2003-09-13 03:22:42.000000000 +0900
+++ linux-2.6.0-test5-hirofumi/fs/nls/nls_cp775.c	2003-09-13 03:22:42.000000000 +0900
@@ -317,20 +317,4 @@ static void __exit exit_nls_cp775(void)
 module_init(init_nls_cp775)
 module_exit(exit_nls_cp775)
 
-/*
- * Overrides for Emacs so that we follow Linus's tabbing style.
- * Emacs will notice this stuff at the end of the file and automatically
- * adjust the settings for this buffer only.  This must remain at the end
- * of the file.
- * ---------------------------------------------------------------------------
- * Local variables:
- * c-indent-level: 8
- * c-brace-imaginary-offset: 0
- * c-brace-offset: -8
- * c-argdecl-indent: 8
- * c-label-offset: -8
- * c-continued-statement-offset: 8
- * c-continued-brace-offset: 0
- * End:
- */
 MODULE_LICENSE("Dual BSD/GPL");
diff -puN fs/nls/nls_cp850.c~nls-cleanup fs/nls/nls_cp850.c
--- linux-2.6.0-test5/fs/nls/nls_cp850.c~nls-cleanup	2003-09-13 03:22:42.000000000 +0900
+++ linux-2.6.0-test5-hirofumi/fs/nls/nls_cp850.c	2003-09-13 03:22:42.000000000 +0900
@@ -313,20 +313,4 @@ static void __exit exit_nls_cp850(void)
 module_init(init_nls_cp850)
 module_exit(exit_nls_cp850)
 
-/*
- * Overrides for Emacs so that we follow Linus's tabbing style.
- * Emacs will notice this stuff at the end of the file and automatically
- * adjust the settings for this buffer only.  This must remain at the end
- * of the file.
- * ---------------------------------------------------------------------------
- * Local variables:
- * c-indent-level: 8
- * c-brace-imaginary-offset: 0
- * c-brace-offset: -8
- * c-argdecl-indent: 8
- * c-label-offset: -8
- * c-continued-statement-offset: 8
- * c-continued-brace-offset: 0
- * End:
- */
 MODULE_LICENSE("Dual BSD/GPL");
diff -puN fs/nls/nls_cp852.c~nls-cleanup fs/nls/nls_cp852.c
--- linux-2.6.0-test5/fs/nls/nls_cp852.c~nls-cleanup	2003-09-13 03:22:42.000000000 +0900
+++ linux-2.6.0-test5-hirofumi/fs/nls/nls_cp852.c	2003-09-13 03:22:42.000000000 +0900
@@ -335,20 +335,4 @@ static void __exit exit_nls_cp852(void)
 module_init(init_nls_cp852)
 module_exit(exit_nls_cp852)
 
-/*
- * Overrides for Emacs so that we follow Linus's tabbing style.
- * Emacs will notice this stuff at the end of the file and automatically
- * adjust the settings for this buffer only.  This must remain at the end
- * of the file.
- * ---------------------------------------------------------------------------
- * Local variables:
- * c-indent-level: 8
- * c-brace-imaginary-offset: 0
- * c-brace-offset: -8
- * c-argdecl-indent: 8
- * c-label-offset: -8
- * c-continued-statement-offset: 8
- * c-continued-brace-offset: 0
- * End:
- */
 MODULE_LICENSE("Dual BSD/GPL");
diff -puN fs/nls/nls_cp855.c~nls-cleanup fs/nls/nls_cp855.c
--- linux-2.6.0-test5/fs/nls/nls_cp855.c~nls-cleanup	2003-09-13 03:22:42.000000000 +0900
+++ linux-2.6.0-test5-hirofumi/fs/nls/nls_cp855.c	2003-09-13 03:22:42.000000000 +0900
@@ -297,20 +297,4 @@ static void __exit exit_nls_cp855(void)
 module_init(init_nls_cp855)
 module_exit(exit_nls_cp855)
 
-/*
- * Overrides for Emacs so that we follow Linus's tabbing style.
- * Emacs will notice this stuff at the end of the file and automatically
- * adjust the settings for this buffer only.  This must remain at the end
- * of the file.
- * ---------------------------------------------------------------------------
- * Local variables:
- * c-indent-level: 8
- * c-brace-imaginary-offset: 0
- * c-brace-offset: -8
- * c-argdecl-indent: 8
- * c-label-offset: -8
- * c-continued-statement-offset: 8
- * c-continued-brace-offset: 0
- * End:
- */
 MODULE_LICENSE("Dual BSD/GPL");
diff -puN fs/nls/nls_cp857.c~nls-cleanup fs/nls/nls_cp857.c
--- linux-2.6.0-test5/fs/nls/nls_cp857.c~nls-cleanup	2003-09-13 03:22:42.000000000 +0900
+++ linux-2.6.0-test5-hirofumi/fs/nls/nls_cp857.c	2003-09-13 03:22:42.000000000 +0900
@@ -299,20 +299,4 @@ static void __exit exit_nls_cp857(void)
 module_init(init_nls_cp857)
 module_exit(exit_nls_cp857)
 
-/*
- * Overrides for Emacs so that we follow Linus's tabbing style.
- * Emacs will notice this stuff at the end of the file and automatically
- * adjust the settings for this buffer only.  This must remain at the end
- * of the file.
- * ---------------------------------------------------------------------------
- * Local variables:
- * c-indent-level: 8
- * c-brace-imaginary-offset: 0
- * c-brace-offset: -8
- * c-argdecl-indent: 8
- * c-label-offset: -8
- * c-continued-statement-offset: 8
- * c-continued-brace-offset: 0
- * End:
- */
 MODULE_LICENSE("Dual BSD/GPL");
diff -puN fs/nls/nls_cp860.c~nls-cleanup fs/nls/nls_cp860.c
--- linux-2.6.0-test5/fs/nls/nls_cp860.c~nls-cleanup	2003-09-13 03:22:42.000000000 +0900
+++ linux-2.6.0-test5-hirofumi/fs/nls/nls_cp860.c	2003-09-13 03:22:42.000000000 +0900
@@ -362,20 +362,4 @@ static void __exit exit_nls_cp860(void)
 module_init(init_nls_cp860)
 module_exit(exit_nls_cp860)
 
-/*
- * Overrides for Emacs so that we follow Linus's tabbing style.
- * Emacs will notice this stuff at the end of the file and automatically
- * adjust the settings for this buffer only.  This must remain at the end
- * of the file.
- * ---------------------------------------------------------------------------
- * Local variables:
- * c-indent-level: 8
- * c-brace-imaginary-offset: 0
- * c-brace-offset: -8
- * c-argdecl-indent: 8
- * c-label-offset: -8
- * c-continued-statement-offset: 8
- * c-continued-brace-offset: 0
- * End:
- */
 MODULE_LICENSE("Dual BSD/GPL");
diff -puN fs/nls/nls_cp861.c~nls-cleanup fs/nls/nls_cp861.c
--- linux-2.6.0-test5/fs/nls/nls_cp861.c~nls-cleanup	2003-09-13 03:22:42.000000000 +0900
+++ linux-2.6.0-test5-hirofumi/fs/nls/nls_cp861.c	2003-09-13 03:22:42.000000000 +0900
@@ -385,20 +385,4 @@ static void __exit exit_nls_cp861(void)
 module_init(init_nls_cp861)
 module_exit(exit_nls_cp861)
 
-/*
- * Overrides for Emacs so that we follow Linus's tabbing style.
- * Emacs will notice this stuff at the end of the file and automatically
- * adjust the settings for this buffer only.  This must remain at the end
- * of the file.
- * ---------------------------------------------------------------------------
- * Local variables:
- * c-indent-level: 8
- * c-brace-imaginary-offset: 0
- * c-brace-offset: -8
- * c-argdecl-indent: 8
- * c-label-offset: -8
- * c-continued-statement-offset: 8
- * c-continued-brace-offset: 0
- * End:
- */
 MODULE_LICENSE("Dual BSD/GPL");
diff -puN fs/nls/nls_cp862.c~nls-cleanup fs/nls/nls_cp862.c
--- linux-2.6.0-test5/fs/nls/nls_cp862.c~nls-cleanup	2003-09-13 03:22:42.000000000 +0900
+++ linux-2.6.0-test5-hirofumi/fs/nls/nls_cp862.c	2003-09-13 03:22:42.000000000 +0900
@@ -419,20 +419,4 @@ static void __exit exit_nls_cp862(void)
 module_init(init_nls_cp862)
 module_exit(exit_nls_cp862)
 
-/*
- * Overrides for Emacs so that we follow Linus's tabbing style.
- * Emacs will notice this stuff at the end of the file and automatically
- * adjust the settings for this buffer only.  This must remain at the end
- * of the file.
- * ---------------------------------------------------------------------------
- * Local variables:
- * c-indent-level: 8
- * c-brace-imaginary-offset: 0
- * c-brace-offset: -8
- * c-argdecl-indent: 8
- * c-label-offset: -8
- * c-continued-statement-offset: 8
- * c-continued-brace-offset: 0
- * End:
- */
 MODULE_LICENSE("Dual BSD/GPL");
diff -puN fs/nls/nls_cp863.c~nls-cleanup fs/nls/nls_cp863.c
--- linux-2.6.0-test5/fs/nls/nls_cp863.c~nls-cleanup	2003-09-13 03:22:42.000000000 +0900
+++ linux-2.6.0-test5-hirofumi/fs/nls/nls_cp863.c	2003-09-13 03:22:42.000000000 +0900
@@ -379,20 +379,4 @@ static void __exit exit_nls_cp863(void)
 module_init(init_nls_cp863)
 module_exit(exit_nls_cp863)
 
-/*
- * Overrides for Emacs so that we follow Linus's tabbing style.
- * Emacs will notice this stuff at the end of the file and automatically
- * adjust the settings for this buffer only.  This must remain at the end
- * of the file.
- * ---------------------------------------------------------------------------
- * Local variables:
- * c-indent-level: 8
- * c-brace-imaginary-offset: 0
- * c-brace-offset: -8
- * c-argdecl-indent: 8
- * c-label-offset: -8
- * c-continued-statement-offset: 8
- * c-continued-brace-offset: 0
- * End:
- */
 MODULE_LICENSE("Dual BSD/GPL");
diff -puN fs/nls/nls_cp864.c~nls-cleanup fs/nls/nls_cp864.c
--- linux-2.6.0-test5/fs/nls/nls_cp864.c~nls-cleanup	2003-09-13 03:22:42.000000000 +0900
+++ linux-2.6.0-test5-hirofumi/fs/nls/nls_cp864.c	2003-09-13 03:22:42.000000000 +0900
@@ -405,20 +405,4 @@ static void __exit exit_nls_cp864(void)
 module_init(init_nls_cp864)
 module_exit(exit_nls_cp864)
 
-/*
- * Overrides for Emacs so that we follow Linus's tabbing style.
- * Emacs will notice this stuff at the end of the file and automatically
- * adjust the settings for this buffer only.  This must remain at the end
- * of the file.
- * ---------------------------------------------------------------------------
- * Local variables:
- * c-indent-level: 8
- * c-brace-imaginary-offset: 0
- * c-brace-offset: -8
- * c-argdecl-indent: 8
- * c-label-offset: -8
- * c-continued-statement-offset: 8
- * c-continued-brace-offset: 0
- * End:
- */
 MODULE_LICENSE("Dual BSD/GPL");
diff -puN fs/nls/nls_cp865.c~nls-cleanup fs/nls/nls_cp865.c
--- linux-2.6.0-test5/fs/nls/nls_cp865.c~nls-cleanup	2003-09-13 03:22:42.000000000 +0900
+++ linux-2.6.0-test5-hirofumi/fs/nls/nls_cp865.c	2003-09-13 03:22:42.000000000 +0900
@@ -385,20 +385,4 @@ static void __exit exit_nls_cp865(void)
 module_init(init_nls_cp865)
 module_exit(exit_nls_cp865)
 
-/*
- * Overrides for Emacs so that we follow Linus's tabbing style.
- * Emacs will notice this stuff at the end of the file and automatically
- * adjust the settings for this buffer only.  This must remain at the end
- * of the file.
- * ---------------------------------------------------------------------------
- * Local variables:
- * c-indent-level: 8
- * c-brace-imaginary-offset: 0
- * c-brace-offset: -8
- * c-argdecl-indent: 8
- * c-label-offset: -8
- * c-continued-statement-offset: 8
- * c-continued-brace-offset: 0
- * End:
- */
 MODULE_LICENSE("Dual BSD/GPL");
diff -puN fs/nls/nls_cp866.c~nls-cleanup fs/nls/nls_cp866.c
--- linux-2.6.0-test5/fs/nls/nls_cp866.c~nls-cleanup	2003-09-13 03:22:42.000000000 +0900
+++ linux-2.6.0-test5-hirofumi/fs/nls/nls_cp866.c	2003-09-13 03:22:42.000000000 +0900
@@ -303,20 +303,4 @@ static void __exit exit_nls_cp866(void)
 module_init(init_nls_cp866)
 module_exit(exit_nls_cp866)
 
-/*
- * Overrides for Emacs so that we follow Linus's tabbing style.
- * Emacs will notice this stuff at the end of the file and automatically
- * adjust the settings for this buffer only.  This must remain at the end
- * of the file.
- * ---------------------------------------------------------------------------
- * Local variables:
- * c-indent-level: 8
- * c-brace-imaginary-offset: 0
- * c-brace-offset: -8
- * c-argdecl-indent: 8
- * c-label-offset: -8
- * c-continued-statement-offset: 8
- * c-continued-brace-offset: 0
- * End:
- */
 MODULE_LICENSE("Dual BSD/GPL");
diff -puN fs/nls/nls_cp869.c~nls-cleanup fs/nls/nls_cp869.c
--- linux-2.6.0-test5/fs/nls/nls_cp869.c~nls-cleanup	2003-09-13 03:22:42.000000000 +0900
+++ linux-2.6.0-test5-hirofumi/fs/nls/nls_cp869.c	2003-09-13 03:22:42.000000000 +0900
@@ -313,20 +313,4 @@ static void __exit exit_nls_cp869(void)
 module_init(init_nls_cp869)
 module_exit(exit_nls_cp869)
 
-/*
- * Overrides for Emacs so that we follow Linus's tabbing style.
- * Emacs will notice this stuff at the end of the file and automatically
- * adjust the settings for this buffer only.  This must remain at the end
- * of the file.
- * ---------------------------------------------------------------------------
- * Local variables:
- * c-indent-level: 8
- * c-brace-imaginary-offset: 0
- * c-brace-offset: -8
- * c-argdecl-indent: 8
- * c-label-offset: -8
- * c-continued-statement-offset: 8
- * c-continued-brace-offset: 0
- * End:
- */
 MODULE_LICENSE("Dual BSD/GPL");
diff -puN fs/nls/nls_cp874.c~nls-cleanup fs/nls/nls_cp874.c
--- linux-2.6.0-test5/fs/nls/nls_cp874.c~nls-cleanup	2003-09-13 03:22:42.000000000 +0900
+++ linux-2.6.0-test5-hirofumi/fs/nls/nls_cp874.c	2003-09-13 03:22:42.000000000 +0900
@@ -274,20 +274,3 @@ module_exit(exit_nls_cp874)
 
 MODULE_LICENSE("Dual BSD/GPL");
 MODULE_ALIAS_NLS(tis-620);
-
-/*
- * Overrides for Emacs so that we follow Linus's tabbing style.
- * Emacs will notice this stuff at the end of the file and automatically
- * adjust the settings for this buffer only.  This must remain at the end
- * of the file.
- * ---------------------------------------------------------------------------
- * Local variables:
- * c-indent-level: 8
- * c-brace-imaginary-offset: 0
- * c-brace-offset: -8
- * c-argdecl-indent: 8
- * c-label-offset: -8
- * c-continued-statement-offset: 8
- * c-continued-brace-offset: 0
- * End:
- */
diff -puN fs/nls/nls_cp932.c~nls-cleanup fs/nls/nls_cp932.c
--- linux-2.6.0-test5/fs/nls/nls_cp932.c~nls-cleanup	2003-09-13 03:22:42.000000000 +0900
+++ linux-2.6.0-test5-hirofumi/fs/nls/nls_cp932.c	2003-09-13 03:22:42.000000000 +0900
@@ -7908,21 +7908,3 @@ module_exit(exit_nls_cp932)
 
 MODULE_LICENSE("Dual BSD/GPL");
 MODULE_ALIAS_NLS(sjis);
-
-/*
- * Overrides for Emacs so that we follow Linus's tabbing style.
- * Emacs will notice this stuff at the end of the file and automatically
- * adjust the settings for this buffer only.  This must remain at the end
- * of the file.
- *
----------------------------------------------------------------------------
- * Local variables:
- * c-indent-level: 8
- * c-brace-imaginary-offset: 0
- * c-brace-offset: -8
- * c-argdecl-indent: 8
- * c-label-offset: -8
- * c-continued-statement-offset: 8
- * c-continued-brace-offset: 0
- * End:
- */
diff -puN fs/nls/nls_cp936.c~nls-cleanup fs/nls/nls_cp936.c
--- linux-2.6.0-test5/fs/nls/nls_cp936.c~nls-cleanup	2003-09-13 03:22:42.000000000 +0900
+++ linux-2.6.0-test5-hirofumi/fs/nls/nls_cp936.c	2003-09-13 03:22:42.000000000 +0900
@@ -11028,21 +11028,3 @@ module_exit(exit_nls_cp936)
 
 MODULE_LICENSE("Dual BSD/GPL");
 MODULE_ALIAS_NLS(gb2312);
-
-/*
- * Overrides for Emacs so that we follow Linus's tabbing style.
- * Emacs will notice this stuff at the end of the file and automatically
- * adjust the settings for this buffer only.  This must remain at the end
- * of the file.
- *
----------------------------------------------------------------------------
- * Local variables:
- * c-indent-level: 8
- * c-brace-imaginary-offset: 0
- * c-brace-offset: -8
- * c-argdecl-indent: 8
- * c-label-offset: -8
- * c-continued-statement-offset: 8
- * c-continued-brace-offset: 0
- * End:
- */
diff -puN fs/nls/nls_cp949.c~nls-cleanup fs/nls/nls_cp949.c
--- linux-2.6.0-test5/fs/nls/nls_cp949.c~nls-cleanup	2003-09-13 03:22:42.000000000 +0900
+++ linux-2.6.0-test5-hirofumi/fs/nls/nls_cp949.c	2003-09-13 03:22:42.000000000 +0900
@@ -13945,21 +13945,3 @@ module_exit(exit_nls_cp949)
 
 MODULE_LICENSE("Dual BSD/GPL");
 MODULE_ALIAS_NLS(euc-kr);
-
-/*
- * Overrides for Emacs so that we follow Linus's tabbing style.
- * Emacs will notice this stuff at the end of the file and automatically
- * adjust the settings for this buffer only.  This must remain at the end
- * of the file.
- *
----------------------------------------------------------------------------
- * Local variables:
- * c-indent-level: 8
- * c-brace-imaginary-offset: 0
- * c-brace-offset: -8
- * c-argdecl-indent: 8
- * c-label-offset: -8
- * c-continued-statement-offset: 8
- * c-continued-brace-offset: 0
- * End:
- */
diff -puN fs/nls/nls_cp950.c~nls-cleanup fs/nls/nls_cp950.c
--- linux-2.6.0-test5/fs/nls/nls_cp950.c~nls-cleanup	2003-09-13 03:22:42.000000000 +0900
+++ linux-2.6.0-test5-hirofumi/fs/nls/nls_cp950.c	2003-09-13 03:22:42.000000000 +0900
@@ -9484,21 +9484,3 @@ module_exit(exit_nls_cp950)
 
 MODULE_LICENSE("Dual BSD/GPL");
 MODULE_ALIAS_NLS(big5);
-
-/*
- * Overrides for Emacs so that we follow Linus's tabbing style.
- * Emacs will notice this stuff at the end of the file and automatically
- * adjust the settings for this buffer only.  This must remain at the end
- * of the file.
- *
----------------------------------------------------------------------------
- * Local variables:
- * c-indent-level: 8
- * c-brace-imaginary-offset: 0
- * c-brace-offset: -8
- * c-argdecl-indent: 8
- * c-label-offset: -8
- * c-continued-statement-offset: 8
- * c-continued-brace-offset: 0
- * End:
- */
diff -puN fs/nls/nls_euc-jp.c~nls-cleanup fs/nls/nls_euc-jp.c
--- linux-2.6.0-test5/fs/nls/nls_euc-jp.c~nls-cleanup	2003-09-13 03:22:42.000000000 +0900
+++ linux-2.6.0-test5-hirofumi/fs/nls/nls_euc-jp.c	2003-09-13 03:22:42.000000000 +0900
@@ -579,22 +579,5 @@ static void __exit exit_nls_euc_jp(void)
 
 module_init(init_nls_euc_jp)
 module_exit(exit_nls_euc_jp)
-MODULE_LICENSE("Dual BSD/GPL");
 
-/*
- * Overrides for Emacs so that we follow Linus's tabbing style.
- * Emacs will notice this stuff at the end of the file and automatically
- * adjust the settings for this buffer only.  This must remain at the end
- * of the file.
- *
----------------------------------------------------------------------------
- * Local variables:
- * c-indent-level: 8
- * c-brace-imaginary-offset: 0
- * c-brace-offset: -8
- * c-argdecl-indent: 8
- * c-label-offset: -8
- * c-continued-statement-offset: 8
- * c-continued-brace-offset: 0
- * End:
- */
+MODULE_LICENSE("Dual BSD/GPL");
diff -puN fs/nls/nls_iso8859-1.c~nls-cleanup fs/nls/nls_iso8859-1.c
--- linux-2.6.0-test5/fs/nls/nls_iso8859-1.c~nls-cleanup	2003-09-13 03:22:42.000000000 +0900
+++ linux-2.6.0-test5-hirofumi/fs/nls/nls_iso8859-1.c	2003-09-13 03:22:42.000000000 +0900
@@ -254,21 +254,5 @@ static void __exit exit_nls_iso8859_1(vo
 
 module_init(init_nls_iso8859_1)
 module_exit(exit_nls_iso8859_1)
-MODULE_LICENSE("Dual BSD/GPL");
 
-/*
- * Overrides for Emacs so that we follow Linus's tabbing style.
- * Emacs will notice this stuff at the end of the file and automatically
- * adjust the settings for this buffer only.  This must remain at the end
- * of the file.
- * ---------------------------------------------------------------------------
- * Local variables:
- * c-indent-level: 8
- * c-brace-imaginary-offset: 0
- * c-brace-offset: -8
- * c-argdecl-indent: 8
- * c-label-offset: -8
- * c-continued-statement-offset: 8
- * c-continued-brace-offset: 0
- * End:
- */
+MODULE_LICENSE("Dual BSD/GPL");
diff -puN fs/nls/nls_iso8859-13.c~nls-cleanup fs/nls/nls_iso8859-13.c
--- linux-2.6.0-test5/fs/nls/nls_iso8859-13.c~nls-cleanup	2003-09-13 03:22:42.000000000 +0900
+++ linux-2.6.0-test5-hirofumi/fs/nls/nls_iso8859-13.c	2003-09-13 03:22:42.000000000 +0900
@@ -282,21 +282,5 @@ static void __exit exit_nls_iso8859_13(v
 
 module_init(init_nls_iso8859_13)
 module_exit(exit_nls_iso8859_13)
-MODULE_LICENSE("Dual BSD/GPL");
 
-/*
- * Overrides for Emacs so that we follow Linus's tabbing style.
- * Emacs will notice this stuff at the end of the file and automatically
- * adjust the settings for this buffer only.  This must remain at the end
- * of the file.
- * ---------------------------------------------------------------------------
- * Local variables:
- * c-indent-level: 8
- * c-brace-imaginary-offset: 0
- * c-brace-offset: -8
- * c-argdecl-indent: 8
- * c-label-offset: -8
- * c-continued-statement-offset: 8
- * c-continued-brace-offset: 0
- * End:
- */
+MODULE_LICENSE("Dual BSD/GPL");
diff -puN fs/nls/nls_iso8859-14.c~nls-cleanup fs/nls/nls_iso8859-14.c
--- linux-2.6.0-test5/fs/nls/nls_iso8859-14.c~nls-cleanup	2003-09-13 03:22:42.000000000 +0900
+++ linux-2.6.0-test5-hirofumi/fs/nls/nls_iso8859-14.c	2003-09-13 03:22:42.000000000 +0900
@@ -338,21 +338,5 @@ static void __exit exit_nls_iso8859_14(v
 
 module_init(init_nls_iso8859_14)
 module_exit(exit_nls_iso8859_14)
-MODULE_LICENSE("Dual BSD/GPL");
 
-/*
- * Overrides for Emacs so that we follow Linus's tabbing style.
- * Emacs will notice this stuff at the end of the file and automatically
- * adjust the settings for this buffer only.  This must remain at the end
- * of the file.
- * ---------------------------------------------------------------------------
- * Local variables:
- * c-indent-level: 8
- * c-brace-imaginary-offset: 0
- * c-brace-offset: -8
- * c-argdecl-indent: 8
- * c-label-offset: -8
- * c-continued-statement-offset: 8
- * c-continued-brace-offset: 0
- * End:
- */
+MODULE_LICENSE("Dual BSD/GPL");
diff -puN fs/nls/nls_iso8859-15.c~nls-cleanup fs/nls/nls_iso8859-15.c
--- linux-2.6.0-test5/fs/nls/nls_iso8859-15.c~nls-cleanup	2003-09-13 03:22:42.000000000 +0900
+++ linux-2.6.0-test5-hirofumi/fs/nls/nls_iso8859-15.c	2003-09-13 03:22:42.000000000 +0900
@@ -304,21 +304,5 @@ static void __exit exit_nls_iso8859_15(v
 
 module_init(init_nls_iso8859_15)
 module_exit(exit_nls_iso8859_15)
-MODULE_LICENSE("Dual BSD/GPL");
 
-/*
- * Overrides for Emacs so that we follow Linus's tabbing style.
- * Emacs will notice this stuff at the end of the file and automatically
- * adjust the settings for this buffer only.  This must remain at the end
- * of the file.
- * ---------------------------------------------------------------------------
- * Local variables:
- * c-indent-level: 8
- * c-brace-imaginary-offset: 0
- * c-brace-offset: -8
- * c-argdecl-indent: 8
- * c-label-offset: -8
- * c-continued-statement-offset: 8
- * c-continued-brace-offset: 0
- * End:
- */
+MODULE_LICENSE("Dual BSD/GPL");
diff -puN fs/nls/nls_iso8859-2.c~nls-cleanup fs/nls/nls_iso8859-2.c
--- linux-2.6.0-test5/fs/nls/nls_iso8859-2.c~nls-cleanup	2003-09-13 03:22:42.000000000 +0900
+++ linux-2.6.0-test5-hirofumi/fs/nls/nls_iso8859-2.c	2003-09-13 03:22:42.000000000 +0900
@@ -305,21 +305,5 @@ static void __exit exit_nls_iso8859_2(vo
 
 module_init(init_nls_iso8859_2)
 module_exit(exit_nls_iso8859_2)
-MODULE_LICENSE("Dual BSD/GPL");
 
-/*
- * Overrides for Emacs so that we follow Linus's tabbing style.
- * Emacs will notice this stuff at the end of the file and automatically
- * adjust the settings for this buffer only.  This must remain at the end
- * of the file.
- * ---------------------------------------------------------------------------
- * Local variables:
- * c-indent-level: 8
- * c-brace-imaginary-offset: 0
- * c-brace-offset: -8
- * c-argdecl-indent: 8
- * c-label-offset: -8
- * c-continued-statement-offset: 8
- * c-continued-brace-offset: 0
- * End:
- */
+MODULE_LICENSE("Dual BSD/GPL");
diff -puN fs/nls/nls_iso8859-3.c~nls-cleanup fs/nls/nls_iso8859-3.c
--- linux-2.6.0-test5/fs/nls/nls_iso8859-3.c~nls-cleanup	2003-09-13 03:22:42.000000000 +0900
+++ linux-2.6.0-test5-hirofumi/fs/nls/nls_iso8859-3.c	2003-09-13 03:22:42.000000000 +0900
@@ -305,21 +305,5 @@ static void __exit exit_nls_iso8859_3(vo
 
 module_init(init_nls_iso8859_3)
 module_exit(exit_nls_iso8859_3)
-MODULE_LICENSE("Dual BSD/GPL");
 
-/*
- * Overrides for Emacs so that we follow Linus's tabbing style.
- * Emacs will notice this stuff at the end of the file and automatically
- * adjust the settings for this buffer only.  This must remain at the end
- * of the file.
- * ---------------------------------------------------------------------------
- * Local variables:
- * c-indent-level: 8
- * c-brace-imaginary-offset: 0
- * c-brace-offset: -8
- * c-argdecl-indent: 8
- * c-label-offset: -8
- * c-continued-statement-offset: 8
- * c-continued-brace-offset: 0
- * End:
- */
+MODULE_LICENSE("Dual BSD/GPL");
diff -puN fs/nls/nls_iso8859-4.c~nls-cleanup fs/nls/nls_iso8859-4.c
--- linux-2.6.0-test5/fs/nls/nls_iso8859-4.c~nls-cleanup	2003-09-13 03:22:42.000000000 +0900
+++ linux-2.6.0-test5-hirofumi/fs/nls/nls_iso8859-4.c	2003-09-13 03:22:42.000000000 +0900
@@ -305,21 +305,5 @@ static void __exit exit_nls_iso8859_4(vo
 
 module_init(init_nls_iso8859_4)
 module_exit(exit_nls_iso8859_4)
-MODULE_LICENSE("Dual BSD/GPL");
 
-/*
- * Overrides for Emacs so that we follow Linus's tabbing style.
- * Emacs will notice this stuff at the end of the file and automatically
- * adjust the settings for this buffer only.  This must remain at the end
- * of the file.
- * ---------------------------------------------------------------------------
- * Local variables:
- * c-indent-level: 8
- * c-brace-imaginary-offset: 0
- * c-brace-offset: -8
- * c-argdecl-indent: 8
- * c-label-offset: -8
- * c-continued-statement-offset: 8
- * c-continued-brace-offset: 0
- * End:
- */
+MODULE_LICENSE("Dual BSD/GPL");
diff -puN fs/nls/nls_iso8859-5.c~nls-cleanup fs/nls/nls_iso8859-5.c
--- linux-2.6.0-test5/fs/nls/nls_iso8859-5.c~nls-cleanup	2003-09-13 03:22:42.000000000 +0900
+++ linux-2.6.0-test5-hirofumi/fs/nls/nls_iso8859-5.c	2003-09-13 03:22:42.000000000 +0900
@@ -269,21 +269,5 @@ static void __exit exit_nls_iso8859_5(vo
 
 module_init(init_nls_iso8859_5)
 module_exit(exit_nls_iso8859_5)
-MODULE_LICENSE("Dual BSD/GPL");
 
-/*
- * Overrides for Emacs so that we follow Linus's tabbing style.
- * Emacs will notice this stuff at the end of the file and automatically
- * adjust the settings for this buffer only.  This must remain at the end
- * of the file.
- * ---------------------------------------------------------------------------
- * Local variables:
- * c-indent-level: 8
- * c-brace-imaginary-offset: 0
- * c-brace-offset: -8
- * c-argdecl-indent: 8
- * c-label-offset: -8
- * c-continued-statement-offset: 8
- * c-continued-brace-offset: 0
- * End:
- */
+MODULE_LICENSE("Dual BSD/GPL");
diff -puN fs/nls/nls_iso8859-6.c~nls-cleanup fs/nls/nls_iso8859-6.c
--- linux-2.6.0-test5/fs/nls/nls_iso8859-6.c~nls-cleanup	2003-09-13 03:22:42.000000000 +0900
+++ linux-2.6.0-test5-hirofumi/fs/nls/nls_iso8859-6.c	2003-09-13 03:22:42.000000000 +0900
@@ -260,21 +260,5 @@ static void __exit exit_nls_iso8859_6(vo
 
 module_init(init_nls_iso8859_6)
 module_exit(exit_nls_iso8859_6)
-MODULE_LICENSE("Dual BSD/GPL");
 
-/*
- * Overrides for Emacs so that we follow Linus's tabbing style.
- * Emacs will notice this stuff at the end of the file and automatically
- * adjust the settings for this buffer only.  This must remain at the end
- * of the file.
- * ---------------------------------------------------------------------------
- * Local variables:
- * c-indent-level: 8
- * c-brace-imaginary-offset: 0
- * c-brace-offset: -8
- * c-argdecl-indent: 8
- * c-label-offset: -8
- * c-continued-statement-offset: 8
- * c-continued-brace-offset: 0
- * End:
- */
+MODULE_LICENSE("Dual BSD/GPL");
diff -puN fs/nls/nls_iso8859-7.c~nls-cleanup fs/nls/nls_iso8859-7.c
--- linux-2.6.0-test5/fs/nls/nls_iso8859-7.c~nls-cleanup	2003-09-13 03:22:42.000000000 +0900
+++ linux-2.6.0-test5-hirofumi/fs/nls/nls_iso8859-7.c	2003-09-13 03:22:42.000000000 +0900
@@ -314,21 +314,5 @@ static void __exit exit_nls_iso8859_7(vo
 
 module_init(init_nls_iso8859_7)
 module_exit(exit_nls_iso8859_7)
-MODULE_LICENSE("Dual BSD/GPL");
 
-/*
- * Overrides for Emacs so that we follow Linus's tabbing style.
- * Emacs will notice this stuff at the end of the file and automatically
- * adjust the settings for this buffer only.  This must remain at the end
- * of the file.
- * ---------------------------------------------------------------------------
- * Local variables:
- * c-indent-level: 8
- * c-brace-imaginary-offset: 0
- * c-brace-offset: -8
- * c-argdecl-indent: 8
- * c-label-offset: -8
- * c-continued-statement-offset: 8
- * c-continued-brace-offset: 0
- * End:
- */
+MODULE_LICENSE("Dual BSD/GPL");
diff -puN fs/nls/nls_iso8859-9.c~nls-cleanup fs/nls/nls_iso8859-9.c
--- linux-2.6.0-test5/fs/nls/nls_iso8859-9.c~nls-cleanup	2003-09-13 03:22:42.000000000 +0900
+++ linux-2.6.0-test5-hirofumi/fs/nls/nls_iso8859-9.c	2003-09-13 03:22:42.000000000 +0900
@@ -269,21 +269,5 @@ static void __exit exit_nls_iso8859_9(vo
 
 module_init(init_nls_iso8859_9)
 module_exit(exit_nls_iso8859_9)
-MODULE_LICENSE("Dual BSD/GPL");
 
-/*
- * Overrides for Emacs so that we follow Linus's tabbing style.
- * Emacs will notice this stuff at the end of the file and automatically
- * adjust the settings for this buffer only.  This must remain at the end
- * of the file.
- * ---------------------------------------------------------------------------
- * Local variables:
- * c-indent-level: 8
- * c-brace-imaginary-offset: 0
- * c-brace-offset: -8
- * c-argdecl-indent: 8
- * c-label-offset: -8
- * c-continued-statement-offset: 8
- * c-continued-brace-offset: 0
- * End:
- */
+MODULE_LICENSE("Dual BSD/GPL");
diff -puN fs/nls/nls_koi8-r.c~nls-cleanup fs/nls/nls_koi8-r.c
--- linux-2.6.0-test5/fs/nls/nls_koi8-r.c~nls-cleanup	2003-09-13 03:22:42.000000000 +0900
+++ linux-2.6.0-test5-hirofumi/fs/nls/nls_koi8-r.c	2003-09-13 03:22:42.000000000 +0900
@@ -320,21 +320,5 @@ static void __exit exit_nls_koi8_r(void)
 
 module_init(init_nls_koi8_r)
 module_exit(exit_nls_koi8_r)
-MODULE_LICENSE("Dual BSD/GPL");
 
-/*
- * Overrides for Emacs so that we follow Linus's tabbing style.
- * Emacs will notice this stuff at the end of the file and automatically
- * adjust the settings for this buffer only.  This must remain at the end
- * of the file.
- * ---------------------------------------------------------------------------
- * Local variables:
- * c-indent-level: 8
- * c-brace-imaginary-offset: 0
- * c-brace-offset: -8
- * c-argdecl-indent: 8
- * c-label-offset: -8
- * c-continued-statement-offset: 8
- * c-continued-brace-offset: 0
- * End:
- */
+MODULE_LICENSE("Dual BSD/GPL");
diff -puN fs/nls/nls_koi8-ru.c~nls-cleanup fs/nls/nls_koi8-ru.c
--- linux-2.6.0-test5/fs/nls/nls_koi8-ru.c~nls-cleanup	2003-09-13 03:22:42.000000000 +0900
+++ linux-2.6.0-test5-hirofumi/fs/nls/nls_koi8-ru.c	2003-09-13 03:22:42.000000000 +0900
@@ -79,21 +79,5 @@ static void __exit exit_nls_koi8_ru(void
 
 module_init(init_nls_koi8_ru)
 module_exit(exit_nls_koi8_ru)
-MODULE_LICENSE("Dual BSD/GPL");
 
-/*
- * Overrides for Emacs so that we follow Linus's tabbing style.
- * Emacs will notice this stuff at the end of the file and automatically
- * adjust the settings for this buffer only.  This must remain at the end
- * of the file.
- * ---------------------------------------------------------------------------
- * Local variables:
- * c-indent-level: 8
- * c-brace-imaginary-offset: 0
- * c-brace-offset: -8
- * c-argdecl-indent: 8
- * c-label-offset: -8
- * c-continued-statement-offset: 8
- * c-continued-brace-offset: 0
- * End:
- */
+MODULE_LICENSE("Dual BSD/GPL");
diff -puN fs/nls/nls_koi8-u.c~nls-cleanup fs/nls/nls_koi8-u.c
--- linux-2.6.0-test5/fs/nls/nls_koi8-u.c~nls-cleanup	2003-09-13 03:22:42.000000000 +0900
+++ linux-2.6.0-test5-hirofumi/fs/nls/nls_koi8-u.c	2003-09-13 03:22:42.000000000 +0900
@@ -327,21 +327,5 @@ static void __exit exit_nls_koi8_u(void)
 
 module_init(init_nls_koi8_u)
 module_exit(exit_nls_koi8_u)
-MODULE_LICENSE("Dual BSD/GPL");
 
-/*
- * Overrides for Emacs so that we follow Linus's tabbing style.
- * Emacs will notice this stuff at the end of the file and automatically
- * adjust the settings for this buffer only.  This must remain at the end
- * of the file.
- * ---------------------------------------------------------------------------
- * Local variables:
- * c-indent-level: 8
- * c-brace-imaginary-offset: 0
- * c-brace-offset: -8
- * c-argdecl-indent: 8
- * c-label-offset: -8
- * c-continued-statement-offset: 8
- * c-continued-brace-offset: 0
- * End:
- */
+MODULE_LICENSE("Dual BSD/GPL");

_

-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
