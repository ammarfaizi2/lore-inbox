Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262994AbTDVIPe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Apr 2003 04:15:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263012AbTDVIPe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Apr 2003 04:15:34 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:19884 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S262994AbTDVIPd
	(ORCPT <rfc822;Linux-Kernel@Vger.Kernel.ORG>);
	Tue, 22 Apr 2003 04:15:33 -0400
From: Nikita Danilov <Nikita@Namesys.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16036.64756.25228.181408@laputa.namesys.com>
Date: Tue, 22 Apr 2003 12:27:32 +0400
X-PGP-Fingerprint: 43CE 9384 5A1D CD75 5087  A876 A1AA 84D0 CCAA AC92
X-PGP-Key-ID: CCAAAC92
X-PGP-Key-At: http://wwwkeys.pgp.net:11371/pks/lookup?op=get&search=0xCCAAAC92
To: Linux Kernel Mailing List <Linux-Kernel@Vger.Kernel.ORG>
Cc: Linus Torvalds <Torvalds@Transmeta.COM>, Andrew Morton <AKPM@Digeo.COM>
Subject: [PATCH] (one line): use #ifdef with CONFIG_*
X-Mailer: VM 7.07 under 21.5  (beta11) "cabbage" XEmacs Lucid
X-Tom-Swifty: "My terminal is completely screwed up," Tom cursed.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

===== include/asm-i386/kmap_types.h 1.13 vs edited =====
--- 1.13/include/asm-i386/kmap_types.h	Mon Feb  3 10:34:59 2003
+++ edited/include/asm-i386/kmap_types.h	Tue Apr 22 11:58:17 2003
@@ -3,7 +3,7 @@
 
 #include <linux/config.h>
 
-#if CONFIG_DEBUG_HIGHMEM
+#ifdef CONFIG_DEBUG_HIGHMEM
 # define D(n) __KM_FENCE_##n ,
 #else
 # define D(n)
