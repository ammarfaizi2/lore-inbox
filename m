Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264646AbTCEHUr>; Wed, 5 Mar 2003 02:20:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264654AbTCEHUr>; Wed, 5 Mar 2003 02:20:47 -0500
Received: from TYO201.gate.nec.co.jp ([210.143.35.51]:7407 "EHLO
	TYO201.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id <S264646AbTCEHUq>; Wed, 5 Mar 2003 02:20:46 -0500
To: Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH]  Include <linux/stddef.h> in <linux/list.h>
Cc: linux-kernel@vger.kernel.org
Reply-To: Miles Bader <miles@gnu.org>
Message-Id: <20030305073110.0B2F83732@mcspd15.ucom.lsi.nec.co.jp>
Date: Wed,  5 Mar 2003 16:31:10 +0900 (JST)
From: miles@lsi.nec.co.jp (Miles Bader)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The latter uses `NULL' from the former.

diff -ruN -X../cludes linux-2.5.64-moo.orig/include/linux/list.h linux-2.5.64-moo/include/linux/list.h
--- linux-2.5.64-moo.orig/include/linux/list.h	2003-03-05 13:08:12.000000000 +0900
+++ linux-2.5.64-moo/include/linux/list.h	2003-03-05 14:49:31.000000000 +0900
@@ -3,6 +3,7 @@
 
 #ifdef __KERNEL__
 
+#include <linux/stddef.h>
 #include <linux/prefetch.h>
 #include <asm/system.h>
 
