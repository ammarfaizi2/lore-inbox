Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751452AbVICNZr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751452AbVICNZr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Sep 2005 09:25:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751448AbVICNZr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Sep 2005 09:25:47 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:32018 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751418AbVICNZq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Sep 2005 09:25:46 -0400
Date: Sat, 3 Sep 2005 15:25:31 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Matt Mackall <mpm@selenic.com>
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] lib/sort.c: small cleanups
Message-ID: <20050903132531.GO3657@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch contains the following small cleanups:
- make two needlessly global functions static
- every file should #include the header files containing the prototypes 
  of it's global functions


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.13-mm1-full/lib/sort.c.old	2005-09-03 14:02:17.000000000 +0200
+++ linux-2.6.13-mm1-full/lib/sort.c	2005-09-03 14:03:02.000000000 +0200
@@ -6,15 +6,16 @@
 
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/sort.h>
 
-void u32_swap(void *a, void *b, int size)
+static void u32_swap(void *a, void *b, int size)
 {
 	u32 t = *(u32 *)a;
 	*(u32 *)a = *(u32 *)b;
 	*(u32 *)b = t;
 }
 
-void generic_swap(void *a, void *b, int size)
+static void generic_swap(void *a, void *b, int size)
 {
 	char t;
 

