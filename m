Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131246AbRCHAoV>; Wed, 7 Mar 2001 19:44:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131242AbRCHAoL>; Wed, 7 Mar 2001 19:44:11 -0500
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:15335 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id <S131241AbRCHAoB>; Wed, 7 Mar 2001 19:44:01 -0500
Date: Thu, 08 Mar 2001 09:43:31 +0900
Message-ID: <r909um30.wl@frostrubin.open.nm.fujitsu.co.jp>
From: Tachino Nobuhiro <tachino@open.nm.fujitsu.co.jp>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Re: Linux 2.4.2ac14
In-Reply-To: <E14an7j-0001rZ-00@the-village.bc.nu>
In-Reply-To: <E14an7j-0001rZ-00@the-village.bc.nu>
User-Agent: Wanderlust/2.4.0 (Rio) EMY/1.13.9 (Art is long, life is short) SLIM/1.14.3 () APEL/10.2 MULE XEmacs/21.2 (beta38) (Peisino) (i386-kondara-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,

2.4.2ac14 compilation fails when CONFIG_DEBUG_BUGVERBOSE is not enabled.
Here is my small patch.


diff -r -u linux-2.4.2-ac14.org/include/asm-i386/page.h linux-2.4.2-ac14/include/asm-i386/page.h
--- linux-2.4.2-ac14.org/include/asm-i386/page.h	Thu Mar  8 09:31:45 2001
+++ linux-2.4.2-ac14/include/asm-i386/page.h	Thu Mar  8 09:21:43 2001
@@ -87,8 +87,8 @@
  * see^H^H^Hhear bugs in early bootup as well!
  */
 
-#ifdef CONFIG_DEBUG_BUGVERBOSE
 extern void do_BUG(const char *file, int line);
+#ifdef CONFIG_DEBUG_BUGVERBOSE
 #define BUG() do {					\
 	do_BUG(__FILE__, __LINE__);			\
 	__asm__ __volatile__(".byte 0x0f,0x0b");	\
