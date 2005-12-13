Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932374AbVLMC3Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932374AbVLMC3Z (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Dec 2005 21:29:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932376AbVLMC3Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Dec 2005 21:29:25 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:59909 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932374AbVLMC3X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Dec 2005 21:29:23 -0500
Date: Tue, 13 Dec 2005 03:29:23 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] kernel/resource.c: __check_region(): remove pointless __deprecated
Message-ID: <20051213022923.GC23349@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If a __deprecated is desired it should go to the prototype in the header 
(where it currently isn't).

But at this place it's pointless.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 21 Nov 2005

--- linux-2.6.15-rc1-mm2-full/kernel/resource.c.old	2005-11-20 20:46:17.000000000 +0100
+++ linux-2.6.15-rc1-mm2-full/kernel/resource.c	2005-11-20 20:46:32.000000000 +0100
@@ -466,7 +466,7 @@
 
 EXPORT_SYMBOL(__request_region);
 
-int __deprecated __check_region(struct resource *parent, unsigned long start, unsigned long n)
+int __check_region(struct resource *parent, unsigned long start, unsigned long n)
 {
 	struct resource * res;
 

