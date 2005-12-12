Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751011AbVLLBfy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751011AbVLLBfy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Dec 2005 20:35:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750923AbVLLBft
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Dec 2005 20:35:49 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:16656 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751004AbVLLBfp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Dec 2005 20:35:45 -0500
Date: Mon, 12 Dec 2005 02:35:45 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: bfennema@falcon.csc.calpoly.edu, linux_udf@hpesjro.fc.hp.com,
       linux-kernel@vger.kernel.org
Subject: [2.6 patch] fs/udf/balloc.c: "extern inline" -> "static inline"
Message-ID: <20051212013545.GJ23349@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"extern inline" doesn't make much sense.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 19 Nov 2005

--- linux-2.6.15-rc1-mm2-full/fs/udf/balloc.c.old	2005-11-19 02:32:13.000000000 +0100
+++ linux-2.6.15-rc1-mm2-full/fs/udf/balloc.c	2005-11-19 02:32:20.000000000 +0100
@@ -46,7 +46,7 @@
 #define uint(x) xuint(x)
 #define xuint(x) __le ## x
 
-extern inline int find_next_one_bit (void * addr, int size, int offset)
+static inline int find_next_one_bit (void * addr, int size, int offset)
 {
 	uintBPL_t * p = ((uintBPL_t *) addr) + (offset / BITS_PER_LONG);
 	int result = offset & ~(BITS_PER_LONG-1);

