Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264705AbSLII4O>; Mon, 9 Dec 2002 03:56:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264715AbSLIIzp>; Mon, 9 Dec 2002 03:55:45 -0500
Received: from TYO202.gate.nec.co.jp ([202.32.8.202]:52380 "EHLO
	TYO202.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id <S264705AbSLIIyo>; Mon, 9 Dec 2002 03:54:44 -0500
To: Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH]  Make net/socket.c only include <linux/wireless.h> once
Cc: linux-kernel@vger.kernel.org
Reply-To: Miles Bader <miles@gnu.org>
Message-Id: <20021209090212.E78A53707@mcspd15.ucom.lsi.nec.co.jp>
Date: Mon,  9 Dec 2002 18:02:12 +0900 (JST)
From: miles@lsi.nec.co.jp (Miles Bader)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Currently it includes it twice, once unconditionally and once conditionally.
Removing the unconditional include doesn't seem to cause any problems, so
this patch does that.

diff -ruN -X../cludes ../orig/linux-2.5.50-uc0/net/socket.c net/socket.c
--- ../orig/linux-2.5.50-uc0/net/socket.c	2002-11-25 10:30:11.000000000 +0900
+++ net/socket.c	2002-11-28 14:35:39.000000000 +0900
@@ -75,7 +75,6 @@
 #include <linux/cache.h>
 #include <linux/module.h>
 #include <linux/highmem.h>
-#include <linux/wireless.h>
 #include <linux/divert.h>
 #include <linux/mount.h>
 
