Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266595AbUGKNtA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266595AbUGKNtA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jul 2004 09:49:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266596AbUGKNtA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jul 2004 09:49:00 -0400
Received: from ozlabs.org ([203.10.76.45]:5286 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S266595AbUGKNs4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jul 2004 09:48:56 -0400
Date: Sun, 11 Jul 2004 20:23:17 +1000
From: Anton Blanchard <anton@samba.org>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: B.Zolnierkiewicz@elka.pw.edu.pl, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gcc 3.5 fixes
Message-ID: <20040711102317.GG5232@krispykreme>
References: <20040704065811.GA4923@krispykreme> <20040704070144.GB4923@krispykreme> <200407041224.47578.bzolnier@elka.pw.edu.pl> <20040704110443.GI4923@krispykreme> <20040706082842.50dde08f.rddunlap@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040706082842.50dde08f.rddunlap@osdl.org>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
> Just kill it.

OK here we go.

--

Remove unused IKCONFIG_VERSION.

Signed-off-by: Anton Blanchard <anton@samba.org>

===== kernel/configs.c 1.9 vs edited =====
--- 1.9/kernel/configs.c	Mon Jul  5 20:34:16 2004
+++ edited/kernel/configs.c	Sat Jul 10 09:51:56 2004
@@ -55,11 +55,6 @@
 
 #ifdef CONFIG_IKCONFIG_PROC
 
-/**************************************************/
-/* globals and useful constants                   */
-
-static const char IKCONFIG_VERSION[] __attribute_used__ __initdata = "0.7";
-
 static ssize_t
 ikconfig_read_current(struct file *file, char __user *buf,
 		      size_t len, loff_t * offset)
