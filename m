Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314496AbSEYMCV>; Sat, 25 May 2002 08:02:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314499AbSEYMCU>; Sat, 25 May 2002 08:02:20 -0400
Received: from loewe.cosy.sbg.ac.at ([141.201.2.12]:9915 "EHLO
	loewe.cosy.sbg.ac.at") by vger.kernel.org with ESMTP
	id <S314496AbSEYMCT>; Sat, 25 May 2002 08:02:19 -0400
Date: Sat, 25 May 2002 14:02:16 +0200 (MET DST)
From: "Thomas 'Dent' Mirlacher" <dent@cosy.sbg.ac.at>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: [PATCH] neofb.c
Message-ID: <Pine.GSO.4.05.10205251400470.7328-100000@mausmaki.cosy.sbg.ac.at>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

gcc 3.1 seems to be unhappy:
neofb.c:2321: initialized causes a section type conflict

the simple patch for this would be:
===== neofb.c 1.8 vs edited =====
--- 1.8/drivers/video/neofb.c   Thu May  2 00:56:02 2002
+++ edited/neofb.c      Sat May 25 18:50:14 2002
@@ -2318,10 +2318,10 @@
   return 0;
 }
 
-static int __init initialized = 0;
-
 int __init neofb_init(void)
 {
+  static int initialized = 0;
+
   DBG("neofb_init");
 
   if (disabled)


-- 
in some way i do, and in some way i don't.

