Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314962AbSDVXpe>; Mon, 22 Apr 2002 19:45:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314963AbSDVXpd>; Mon, 22 Apr 2002 19:45:33 -0400
Received: from rwcrmhc54.attbi.com ([216.148.227.87]:33526 "EHLO
	rwcrmhc54.attbi.com") by vger.kernel.org with ESMTP
	id <S314962AbSDVXp3>; Mon, 22 Apr 2002 19:45:29 -0400
Message-ID: <3CC4A007.1070307@didntduck.org>
Date: Mon, 22 Apr 2002 19:43:03 -0400
From: Brian Gerst <bgerst@didntduck.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020311
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] setup_per_cpu still broken in 2.5.9
Content-Type: multipart/mixed;
 boundary="------------030904060501020008060905"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030904060501020008060905
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Still broken for UP.  It looks like a patch got applied twice.

-- 

						Brian Gerst

--------------030904060501020008060905
Content-Type: text/plain;
 name="percpu-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="percpu-1"

diff -urN linux-2.5.9/init/main.c linux/init/main.c
--- linux-2.5.9/init/main.c	Mon Apr 22 19:17:23 2002
+++ linux/init/main.c	Mon Apr 22 19:31:04 2002
@@ -271,14 +271,7 @@
 #else
 #define smp_init()	do { } while (0)
 #endif
-static inline void setup_per_cpu_areas(void)
-{
-}
-
-static inline void setup_per_cpu_areas(void)
-{
-}
-
+static inline void setup_per_cpu_areas(void) { }
 #else
 
 #ifdef __GENERIC_PER_CPU

--------------030904060501020008060905--

