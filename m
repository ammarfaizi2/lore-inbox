Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261685AbUCFQcm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Mar 2004 11:32:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261687AbUCFQcm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Mar 2004 11:32:42 -0500
Received: from ns.suse.de ([195.135.220.2]:10719 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261685AbUCFQcl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Mar 2004 11:32:41 -0500
Date: Thu, 11 Mar 2004 21:13:41 +0100
From: Andi Kleen <ak@suse.de>
To: jsimmons@infradead.org, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] i810 fb and x86-64
Message-Id: <20040311211341.412abdd5.ak@suse.de>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


i810fb most likely is needed on x86-64 too because there are Intel chipsets
for it now.  So far it only linked on i386, fix this.

-Andi

diff -u linux-2.6.4rc2-amd64/drivers/video/i810/i810_main.h-o linux-2.6.4rc2-amd64/drivers/video/i810/i810_main.h
--- linux-2.6.4rc2-amd64/drivers/video/i810/i810_main.h-o	2004-03-05 18:28:00.000000000 +0100
+++ linux-2.6.4rc2-amd64/drivers/video/i810/i810_main.h	2004-03-11 21:08:26.000000000 +0100
@@ -84,7 +84,7 @@
 extern void i810fb_load_front     (u32 offset, struct fb_info *info);
 
 /* Conditionals */
-#if defined(__i386__)
+#ifdef CONFIG_X86
 inline void flush_cache(void)
 {
 	asm volatile ("wbinvd":::"memory");
