Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261824AbULGPCW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261824AbULGPCW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Dec 2004 10:02:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261825AbULGPBn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Dec 2004 10:01:43 -0500
Received: from hirsch.in-berlin.de ([192.109.42.6]:46829 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S261826AbULGPA2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Dec 2004 10:00:28 -0500
X-Envelope-From: kraxel@bytesex.org
Date: Tue, 7 Dec 2004 15:36:43 +0100
From: Gerd Knorr <kraxel@bytesex.org>
To: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       uml devel <user-mode-linux-devel@lists.sourceforge.net>,
       Jeff Dike <jdike@addtoit.com>,
       Blaisorblade <blaisorblade_spam@yahoo.it>
Subject: [patch] uml: symbol export
Message-ID: <20041207143643.GA23597@bytesex>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

export a missing symbol, IIRC xfs needs that one.

Signed-off-by: Gerd Knorr <kraxel@bytesex.org>
---
 arch/um/kernel/um_arch.c |    1 +
 1 files changed, 1 insertion(+)

Index: uml-2.6.9-rc2/arch/um/kernel/um_arch.c
===================================================================
--- uml-2.6.9-rc2.orig/arch/um/kernel/um_arch.c	2004-09-16 16:34:51.777620148 +0200
+++ uml-2.6.9-rc2/arch/um/kernel/um_arch.c	2004-09-16 16:44:39.249193721 +0200
@@ -301,6 +301,7 @@ static void __init uml_postsetup(void)
 /* Set during early boot */
 unsigned long brk_start;
 unsigned long end_iomem;
+EXPORT_SYMBOL(end_iomem);
 
 #define MIN_VMALLOC (32 * 1024 * 1024)
 

-- 
#define printk(args...) fprintf(stderr, ## args)
