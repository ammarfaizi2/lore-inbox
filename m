Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314646AbSDTQf3>; Sat, 20 Apr 2002 12:35:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314652AbSDTQf2>; Sat, 20 Apr 2002 12:35:28 -0400
Received: from mailout04.sul.t-online.com ([194.25.134.18]:8362 "EHLO
	mailout04.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S314646AbSDTQf1>; Sat, 20 Apr 2002 12:35:27 -0400
Date: Sat, 20 Apr 2002 18:35:15 +0200
From: Andi Kleen <ak@muc.de>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] autofs fix for x86-64
Message-ID: <20020420183515.A22395@averell>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Minor patch for the x86-64 32bit emulation. Originally proposed by hpa and it 
makes autofs 32bit/64bit clean for x86-64

Patch against 2.5.8

-Andi



diff -X ../../KDIFX -x *-o -x *-RESERVE -burpN ../../v2.5/linux/include/linux/auto_fs.h linux/include/linux/auto_fs.h
--- ../../v2.5/linux/include/linux/auto_fs.h	Mon Feb 11 03:05:39 2002
+++ linux/include/linux/auto_fs.h	Sat Apr 20 15:45:27 2002
@@ -45,7 +45,7 @@
  * If so, 32-bit user-space code should be backwards compatible.
  */
 
-#if defined(__sparc__) || defined(__mips__)
+#if defined(__sparc__) || defined(__mips__) || defined(__x86_64__)
 typedef unsigned int autofs_wqt_t;
 #else
 typedef unsigned long autofs_wqt_t;
