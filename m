Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751453AbWF1Q7U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751453AbWF1Q7U (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 12:59:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751430AbWF1Qyn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 12:54:43 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:32772 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751424AbWF1Qy3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 12:54:29 -0400
Date: Wed, 28 Jun 2006 18:54:28 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, pazke@donpac.ru
Cc: linux-kernel@vger.kernel.org, linux-visws-devel@lists.sourceforge.net
Subject: [-mm patch] arch/i386/mach-visws/setup.c: remove dummy function calls
Message-ID: <20060628165428.GL13915@stusta.de>
References: <20060624061914.202fbfb5.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060624061914.202fbfb5.akpm@osdl.org>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thankfully, these dummy function calls are no longer required to avoid 
warnings - if they weren't eliminated as dead code but accidentially 
executed there would be a guaranteed NULL dereference.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.17-mm2-full/arch/i386/mach-visws/setup.c.old	2006-06-27 00:28:06.000000000 +0200
+++ linux-2.6.17-mm2-full/arch/i386/mach-visws/setup.c	2006-06-27 00:37:50.000000000 +0200
@@ -177,8 +177,4 @@
 	add_memory_region(sgivwfb_mem_phys, sgivwfb_mem_size, E820_RESERVED);
 
 	return "PROM";
-
-	/* Remove gcc warnings */
-	(void) sanitize_e820_map(NULL, NULL);
-	(void) copy_e820_map(NULL, 0);
 }

