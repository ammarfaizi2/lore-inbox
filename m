Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262585AbUFFBaS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262585AbUFFBaS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Jun 2004 21:30:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262605AbUFFBaS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Jun 2004 21:30:18 -0400
Received: from cantor.suse.de ([195.135.220.2]:12419 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262585AbUFFBaP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Jun 2004 21:30:15 -0400
Date: Sun, 6 Jun 2004 03:30:13 +0200
From: Andi Kleen <ak@suse.de>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Disable unnecessary printk in es7000 code
Message-Id: <20040606033013.5b1d0e54.ak@suse.de>
X-Mailer: Sylpheed version 0.9.11 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This printk is printed by genericarch when your machine is no es7000. Most
people don't care about that. Remove it.

diff -u linux/arch/i386/mach-es7000/es7000plat.c-o linux/arch/i386/mach-es7000/es7000plat.c
--- linux/arch/i386/mach-es7000/es7000plat.c-o	2004-06-01 19:20:01.000000000 +0200
+++ linux/arch/i386/mach-es7000/es7000plat.c	2004-06-01 19:25:36.000000000 +0200
@@ -134,7 +134,6 @@
 	}
 
 	if (success < 2) {
-		printk("\nNo ES7000 found.\n");
 		es7000_plat = 0;
 	} else {
 		printk("\nEnabling ES7000 specific features...\n");



