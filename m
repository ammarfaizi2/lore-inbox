Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279922AbRKNBJV>; Tue, 13 Nov 2001 20:09:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279926AbRKNBJN>; Tue, 13 Nov 2001 20:09:13 -0500
Received: from gordon.ukservers.net ([217.10.138.217]:51972 "HELO
	gordon.ukservers.net") by vger.kernel.org with SMTP
	id <S279922AbRKNBI5>; Tue, 13 Nov 2001 20:08:57 -0500
Date: Wed, 14 Nov 2001 01:10:18 +0000
From: Mark Hymers <markh@linuxfromscratch.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: chaffee@cs.berkeley.edu
Subject: MODULE_LICENSE tags for nls
Message-ID: <20011114011018.A981@markcomp.blaydon.hymers.org.uk>
Mail-Followup-To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	chaffee@cs.berkeley.edu
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There appear to be a set of module tags missing in >=2.4.15-pre4
resulting in the kernel being tainted incorrectly (as far as I can see).
The following .c files in fs/nls appear to be affected:

nls_big5.c
nls_cp932.c
nls_cp936.c
nls_cp949.c
nls_cp950.c
nls_euc-jp.c
nls_euc-kr.c
nls_gb2312.c
nls_iso8859-1.c
nls_iso8859-13.c
nls_iso8859-14.c
nls_iso8859-15.c
nls_iso8859-2.c
nls_iso8859-3.c
nls_iso8859-4.c
nls_iso8859-5.c
nls_iso8859-6.c
nls_iso8859-7.c
nls_iso8859-8.c
nls_iso8859-9.c
nls_koi8-r.c
nls_koi8-ru.c
nls_koi8-u.c
nls_sjis.c
nls_tis-620.c
nls_utf8.c

All of the other nls files are described with the line:
MODULE_LICENSE("BSD without advertising clause");

If this is the correct tag, I've attached a patch below which adds this
to all of the above files hopefully solving the problem.  This is my
first mail to LKML so please be gentle ;-)

Mark

PS - I hope this was CC'd to the right maintainer.

-- 
Mark Hymers					 BLFS Editor
markh@linuxfromscratch.org


diff -Naur linux-2.4.15-pre4-orig/fs/nls/nls_big5.c linux-2.4.15-pre4-new/fs/nls/nls_big5.c
--- linux-2.4.15-pre4-orig/fs/nls/nls_big5.c	Mon Oct 16 20:58:51 2000
+++ linux-2.4.15-pre4-new/fs/nls/nls_big5.c	Wed Nov 14 01:00:19 2001
@@ -42,7 +42,7 @@
 
 module_init(init_nls_big5)
 module_exit(exit_nls_big5)
-
+MODULE_LICENSE("BSD without advertising clause");
 /*
  * Overrides for Emacs so that we follow Linus's tabbing style.
  * Emacs will notice this stuff at the end of the file and automatically
diff -Naur linux-2.4.15-pre4-orig/fs/nls/nls_cp932.c linux-2.4.15-pre4-new/fs/nls/nls_cp932.c
--- linux-2.4.15-pre4-orig/fs/nls/nls_cp932.c	Fri Apr  6 18:51:19 2001
+++ linux-2.4.15-pre4-new/fs/nls/nls_cp932.c	Wed Nov 14 01:00:43 2001
@@ -7904,6 +7904,7 @@
 
 module_init(init_nls_cp932)
 module_exit(exit_nls_cp932)
+MODULE_LICENSE("BSD without advertising clause");
 
 /*
  * Overrides for Emacs so that we follow Linus's tabbing style.
diff -Naur linux-2.4.15-pre4-orig/fs/nls/nls_cp936.c linux-2.4.15-pre4-new/fs/nls/nls_cp936.c
--- linux-2.4.15-pre4-orig/fs/nls/nls_cp936.c	Fri Jul 21 23:19:51 2000
+++ linux-2.4.15-pre4-new/fs/nls/nls_cp936.c	Wed Nov 14 01:00:51 2001
@@ -11024,6 +11024,7 @@
 
 module_init(init_nls_cp936)
 module_exit(exit_nls_cp936)
+MODULE_LICENSE("BSD without advertising clause");
 
 /*
  * Overrides for Emacs so that we follow Linus's tabbing style.
diff -Naur linux-2.4.15-pre4-orig/fs/nls/nls_cp949.c linux-2.4.15-pre4-new/fs/nls/nls_cp949.c
--- linux-2.4.15-pre4-orig/fs/nls/nls_cp949.c	Fri Jul 21 23:19:51 2000
+++ linux-2.4.15-pre4-new/fs/nls/nls_cp949.c	Wed Nov 14 01:00:57 2001
@@ -13941,6 +13941,7 @@
 
 module_init(init_nls_cp949)
 module_exit(exit_nls_cp949)
+MODULE_LICENSE("BSD without advertising clause");
 
 /*
  * Overrides for Emacs so that we follow Linus's tabbing style.
diff -Naur linux-2.4.15-pre4-orig/fs/nls/nls_cp950.c linux-2.4.15-pre4-new/fs/nls/nls_cp950.c
--- linux-2.4.15-pre4-orig/fs/nls/nls_cp950.c	Fri Jul 21 23:19:51 2000
+++ linux-2.4.15-pre4-new/fs/nls/nls_cp950.c	Wed Nov 14 01:01:04 2001
@@ -9480,6 +9480,7 @@
 
 module_init(init_nls_cp950)
 module_exit(exit_nls_cp950)
+MODULE_LICENSE("BSD without advertising clause");
 
 /*
  * Overrides for Emacs so that we follow Linus's tabbing style.
diff -Naur linux-2.4.15-pre4-orig/fs/nls/nls_euc-jp.c linux-2.4.15-pre4-new/fs/nls/nls_euc-jp.c
--- linux-2.4.15-pre4-orig/fs/nls/nls_euc-jp.c	Fri Apr  6 18:51:19 2001
+++ linux-2.4.15-pre4-new/fs/nls/nls_euc-jp.c	Wed Nov 14 01:01:13 2001
@@ -581,6 +581,7 @@
 
 module_init(init_nls_euc_jp)
 module_exit(exit_nls_euc_jp)
+MODULE_LICENSE("BSD without advertising clause");
 
 /*
  * Overrides for Emacs so that we follow Linus's tabbing style.
diff -Naur linux-2.4.15-pre4-orig/fs/nls/nls_euc-kr.c linux-2.4.15-pre4-new/fs/nls/nls_euc-kr.c
--- linux-2.4.15-pre4-orig/fs/nls/nls_euc-kr.c	Mon Oct 16 20:58:51 2000
+++ linux-2.4.15-pre4-new/fs/nls/nls_euc-kr.c	Wed Nov 14 01:01:20 2001
@@ -42,6 +42,7 @@
 
 module_init(init_nls_euc_kr)
 module_exit(exit_nls_euc_kr)
+MODULE_LICENSE("BSD without advertising clause");
 
 /*
  * Overrides for Emacs so that we follow Linus's tabbing style.
diff -Naur linux-2.4.15-pre4-orig/fs/nls/nls_gb2312.c linux-2.4.15-pre4-new/fs/nls/nls_gb2312.c
--- linux-2.4.15-pre4-orig/fs/nls/nls_gb2312.c	Mon Oct 16 20:58:51 2000
+++ linux-2.4.15-pre4-new/fs/nls/nls_gb2312.c	Wed Nov 14 01:01:27 2001
@@ -42,6 +42,7 @@
 
 module_init(init_nls_gb2312)
 module_exit(exit_nls_gb2312)
+MODULE_LICENSE("BSD without advertising clause");
 
 /*
  * Overrides for Emacs so that we follow Linus's tabbing style.
diff -Naur linux-2.4.15-pre4-orig/fs/nls/nls_iso8859-1.c linux-2.4.15-pre4-new/fs/nls/nls_iso8859-1.c
--- linux-2.4.15-pre4-orig/fs/nls/nls_iso8859-1.c	Wed Jul 19 06:48:33 2000
+++ linux-2.4.15-pre4-new/fs/nls/nls_iso8859-1.c	Wed Nov 14 01:01:34 2001
@@ -254,6 +254,7 @@
 
 module_init(init_nls_iso8859_1)
 module_exit(exit_nls_iso8859_1)
+MODULE_LICENSE("BSD without advertising clause");
 
 /*
  * Overrides for Emacs so that we follow Linus's tabbing style.
diff -Naur linux-2.4.15-pre4-orig/fs/nls/nls_iso8859-13.c linux-2.4.15-pre4-new/fs/nls/nls_iso8859-13.c
--- linux-2.4.15-pre4-orig/fs/nls/nls_iso8859-13.c	Sun May 20 01:47:55 2001
+++ linux-2.4.15-pre4-new/fs/nls/nls_iso8859-13.c	Wed Nov 14 01:01:40 2001
@@ -282,6 +282,7 @@
 
 module_init(init_nls_iso8859_13)
 module_exit(exit_nls_iso8859_13)
+MODULE_LICENSE("BSD without advertising clause");
 
 /*
  * Overrides for Emacs so that we follow Linus's tabbing style.
diff -Naur linux-2.4.15-pre4-orig/fs/nls/nls_iso8859-14.c linux-2.4.15-pre4-new/fs/nls/nls_iso8859-14.c
--- linux-2.4.15-pre4-orig/fs/nls/nls_iso8859-14.c	Wed Jul 19 06:48:33 2000
+++ linux-2.4.15-pre4-new/fs/nls/nls_iso8859-14.c	Wed Nov 14 01:01:46 2001
@@ -338,6 +338,7 @@
 
 module_init(init_nls_iso8859_14)
 module_exit(exit_nls_iso8859_14)
+MODULE_LICENSE("BSD without advertising clause");
 
 /*
  * Overrides for Emacs so that we follow Linus's tabbing style.
diff -Naur linux-2.4.15-pre4-orig/fs/nls/nls_iso8859-15.c linux-2.4.15-pre4-new/fs/nls/nls_iso8859-15.c
--- linux-2.4.15-pre4-orig/fs/nls/nls_iso8859-15.c	Fri Jul 21 23:19:51 2000
+++ linux-2.4.15-pre4-new/fs/nls/nls_iso8859-15.c	Wed Nov 14 01:01:52 2001
@@ -304,6 +304,7 @@
 
 module_init(init_nls_iso8859_15)
 module_exit(exit_nls_iso8859_15)
+MODULE_LICENSE("BSD without advertising clause");
 
 /*
  * Overrides for Emacs so that we follow Linus's tabbing style.
diff -Naur linux-2.4.15-pre4-orig/fs/nls/nls_iso8859-2.c linux-2.4.15-pre4-new/fs/nls/nls_iso8859-2.c
--- linux-2.4.15-pre4-orig/fs/nls/nls_iso8859-2.c	Fri Jul 21 23:19:51 2000
+++ linux-2.4.15-pre4-new/fs/nls/nls_iso8859-2.c	Wed Nov 14 01:01:58 2001
@@ -305,6 +305,7 @@
 
 module_init(init_nls_iso8859_2)
 module_exit(exit_nls_iso8859_2)
+MODULE_LICENSE("BSD without advertising clause");
 
 /*
  * Overrides for Emacs so that we follow Linus's tabbing style.
diff -Naur linux-2.4.15-pre4-orig/fs/nls/nls_iso8859-3.c linux-2.4.15-pre4-new/fs/nls/nls_iso8859-3.c
--- linux-2.4.15-pre4-orig/fs/nls/nls_iso8859-3.c	Fri Jul 21 23:19:51 2000
+++ linux-2.4.15-pre4-new/fs/nls/nls_iso8859-3.c	Wed Nov 14 01:02:04 2001
@@ -305,6 +305,7 @@
 
 module_init(init_nls_iso8859_3)
 module_exit(exit_nls_iso8859_3)
+MODULE_LICENSE("BSD without advertising clause");
 
 /*
  * Overrides for Emacs so that we follow Linus's tabbing style.
diff -Naur linux-2.4.15-pre4-orig/fs/nls/nls_iso8859-4.c linux-2.4.15-pre4-new/fs/nls/nls_iso8859-4.c
--- linux-2.4.15-pre4-orig/fs/nls/nls_iso8859-4.c	Fri Jul 21 23:19:51 2000
+++ linux-2.4.15-pre4-new/fs/nls/nls_iso8859-4.c	Wed Nov 14 01:02:10 2001
@@ -305,6 +305,7 @@
 
 module_init(init_nls_iso8859_4)
 module_exit(exit_nls_iso8859_4)
+MODULE_LICENSE("BSD without advertising clause");
 
 /*
  * Overrides for Emacs so that we follow Linus's tabbing style.
diff -Naur linux-2.4.15-pre4-orig/fs/nls/nls_iso8859-5.c linux-2.4.15-pre4-new/fs/nls/nls_iso8859-5.c
--- linux-2.4.15-pre4-orig/fs/nls/nls_iso8859-5.c	Fri Jul 21 23:19:51 2000
+++ linux-2.4.15-pre4-new/fs/nls/nls_iso8859-5.c	Wed Nov 14 01:02:16 2001
@@ -269,6 +269,7 @@
 
 module_init(init_nls_iso8859_5)
 module_exit(exit_nls_iso8859_5)
+MODULE_LICENSE("BSD without advertising clause");
 
 /*
  * Overrides for Emacs so that we follow Linus's tabbing style.
diff -Naur linux-2.4.15-pre4-orig/fs/nls/nls_iso8859-6.c linux-2.4.15-pre4-new/fs/nls/nls_iso8859-6.c
--- linux-2.4.15-pre4-orig/fs/nls/nls_iso8859-6.c	Fri Jul 21 23:19:51 2000
+++ linux-2.4.15-pre4-new/fs/nls/nls_iso8859-6.c	Wed Nov 14 01:02:21 2001
@@ -260,6 +260,7 @@
 
 module_init(init_nls_iso8859_6)
 module_exit(exit_nls_iso8859_6)
+MODULE_LICENSE("BSD without advertising clause");
 
 /*
  * Overrides for Emacs so that we follow Linus's tabbing style.
diff -Naur linux-2.4.15-pre4-orig/fs/nls/nls_iso8859-7.c linux-2.4.15-pre4-new/fs/nls/nls_iso8859-7.c
--- linux-2.4.15-pre4-orig/fs/nls/nls_iso8859-7.c	Fri Jul 21 23:19:51 2000
+++ linux-2.4.15-pre4-new/fs/nls/nls_iso8859-7.c	Wed Nov 14 01:02:29 2001
@@ -314,6 +314,7 @@
 
 module_init(init_nls_iso8859_7)
 module_exit(exit_nls_iso8859_7)
+MODULE_LICENSE("BSD without advertising clause");
 
 /*
  * Overrides for Emacs so that we follow Linus's tabbing style.
diff -Naur linux-2.4.15-pre4-orig/fs/nls/nls_iso8859-8.c linux-2.4.15-pre4-new/fs/nls/nls_iso8859-8.c
--- linux-2.4.15-pre4-orig/fs/nls/nls_iso8859-8.c	Fri Apr  6 18:51:19 2001
+++ linux-2.4.15-pre4-new/fs/nls/nls_iso8859-8.c	Wed Nov 14 01:02:34 2001
@@ -42,6 +42,7 @@
 
 module_init(init_nls_iso8859_8)
 module_exit(exit_nls_iso8859_8)
+MODULE_LICENSE("BSD without advertising clause");
 
 /*
  * Overrides for Emacs so that we follow Linus's tabbing style.
diff -Naur linux-2.4.15-pre4-orig/fs/nls/nls_iso8859-9.c linux-2.4.15-pre4-new/fs/nls/nls_iso8859-9.c
--- linux-2.4.15-pre4-orig/fs/nls/nls_iso8859-9.c	Fri Jul 21 23:19:51 2000
+++ linux-2.4.15-pre4-new/fs/nls/nls_iso8859-9.c	Wed Nov 14 01:02:40 2001
@@ -269,6 +269,7 @@
 
 module_init(init_nls_iso8859_9)
 module_exit(exit_nls_iso8859_9)
+MODULE_LICENSE("BSD without advertising clause");
 
 /*
  * Overrides for Emacs so that we follow Linus's tabbing style.
diff -Naur linux-2.4.15-pre4-orig/fs/nls/nls_koi8-r.c linux-2.4.15-pre4-new/fs/nls/nls_koi8-r.c
--- linux-2.4.15-pre4-orig/fs/nls/nls_koi8-r.c	Fri Jul 21 23:19:51 2000
+++ linux-2.4.15-pre4-new/fs/nls/nls_koi8-r.c	Wed Nov 14 01:02:47 2001
@@ -320,6 +320,7 @@
 
 module_init(init_nls_koi8_r)
 module_exit(exit_nls_koi8_r)
+MODULE_LICENSE("BSD without advertising clause");
 
 /*
  * Overrides for Emacs so that we follow Linus's tabbing style.
diff -Naur linux-2.4.15-pre4-orig/fs/nls/nls_koi8-ru.c linux-2.4.15-pre4-new/fs/nls/nls_koi8-ru.c
--- linux-2.4.15-pre4-orig/fs/nls/nls_koi8-ru.c	Sun May 20 01:47:55 2001
+++ linux-2.4.15-pre4-new/fs/nls/nls_koi8-ru.c	Wed Nov 14 01:02:52 2001
@@ -80,6 +80,7 @@
 
 module_init(init_nls_koi8_ru)
 module_exit(exit_nls_koi8_ru)
+MODULE_LICENSE("BSD without advertising clause");
 
 /*
  * Overrides for Emacs so that we follow Linus's tabbing style.
diff -Naur linux-2.4.15-pre4-orig/fs/nls/nls_koi8-u.c linux-2.4.15-pre4-new/fs/nls/nls_koi8-u.c
--- linux-2.4.15-pre4-orig/fs/nls/nls_koi8-u.c	Sun May 20 01:47:55 2001
+++ linux-2.4.15-pre4-new/fs/nls/nls_koi8-u.c	Wed Nov 14 01:02:57 2001
@@ -327,6 +327,7 @@
 
 module_init(init_nls_koi8_u)
 module_exit(exit_nls_koi8_u)
+MODULE_LICENSE("BSD without advertising clause");
 
 /*
  * Overrides for Emacs so that we follow Linus's tabbing style.
diff -Naur linux-2.4.15-pre4-orig/fs/nls/nls_sjis.c linux-2.4.15-pre4-new/fs/nls/nls_sjis.c
--- linux-2.4.15-pre4-orig/fs/nls/nls_sjis.c	Mon Oct 16 20:58:51 2000
+++ linux-2.4.15-pre4-new/fs/nls/nls_sjis.c	Wed Nov 14 01:03:04 2001
@@ -42,6 +42,7 @@
 
 module_init(init_nls_sjis)
 module_exit(exit_nls_sjis)
+MODULE_LICENSE("BSD without advertising clause");
 
 /*
  * Overrides for Emacs so that we follow Linus's tabbing style.
diff -Naur linux-2.4.15-pre4-orig/fs/nls/nls_tis-620.c linux-2.4.15-pre4-new/fs/nls/nls_tis-620.c
--- linux-2.4.15-pre4-orig/fs/nls/nls_tis-620.c	Fri Apr  6 18:51:19 2001
+++ linux-2.4.15-pre4-new/fs/nls/nls_tis-620.c	Wed Nov 14 01:03:10 2001
@@ -42,6 +42,7 @@
 
 module_init(init_nls_tis_620)
 module_exit(exit_nls_tis_620)
+MODULE_LICENSE("BSD without advertising clause");
 
 /*
  * Overrides for Emacs so that we follow Linus's tabbing style.
diff -Naur linux-2.4.15-pre4-orig/fs/nls/nls_utf8.c linux-2.4.15-pre4-new/fs/nls/nls_utf8.c
--- linux-2.4.15-pre4-orig/fs/nls/nls_utf8.c	Wed Jul 19 06:48:33 2000
+++ linux-2.4.15-pre4-new/fs/nls/nls_utf8.c	Wed Nov 14 01:03:17 2001
@@ -58,3 +58,4 @@
 
 module_init(init_nls_utf8)
 module_exit(exit_nls_utf8)
+MODULE_LICENSE("BSD without advertising clause");
