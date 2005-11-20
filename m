Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750915AbVKTXcd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750915AbVKTXcd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Nov 2005 18:32:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750907AbVKTXcd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Nov 2005 18:32:33 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:48912 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750739AbVKTXcc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Nov 2005 18:32:32 -0500
Date: Mon, 21 Nov 2005 00:32:32 +0100
From: Adrian Bunk <bunk@stusta.de>
To: linux-kernel@vger.kernel.org
Subject: [2.6 patch] kernel/resource.c: __check_region(): remove pointless __deprecated
Message-ID: <20051120233232.GO16060@stusta.de>
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

--- linux-2.6.15-rc1-mm2-full/kernel/resource.c.old	2005-11-20 20:46:17.000000000 +0100
+++ linux-2.6.15-rc1-mm2-full/kernel/resource.c	2005-11-20 20:46:32.000000000 +0100
@@ -466,7 +466,7 @@
 
 EXPORT_SYMBOL(__request_region);
 
-int __deprecated __check_region(struct resource *parent, unsigned long start, unsigned long n)
+int __check_region(struct resource *parent, unsigned long start, unsigned long n)
 {
 	struct resource * res;
 

