Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422662AbWCWTBp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422662AbWCWTBp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 14:01:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030230AbWCWTBo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 14:01:44 -0500
Received: from mail.gmx.de ([213.165.64.20]:24736 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1030227AbWCWTBo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 14:01:44 -0500
X-Authenticated: #704063
Subject: [Patch] unused label in drivers/block/cciss.c
From: Eric Sesterhenn <snakebyte@gmx.de>
To: linux-kernel@vger.kernel.org
Cc: axboe@suse.de
Content-Type: text/plain
Date: Thu, 23 Mar 2006 20:01:41 +0100
Message-Id: <1143140501.17843.9.camel@alice>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

this patch removes a warning about an unused label, by
moving the label into the ifdef.

Signed-off-by: Eric Sesterhenn <snakebyte@gmx.de>

--- linux-2.6.16-git6/drivers/block/cciss.c.orig	2006-03-23 19:36:06.000000000 +0100
+++ linux-2.6.16-git6/drivers/block/cciss.c	2006-03-23 19:36:19.000000000 +0100
@@ -2728,9 +2728,9 @@ static void __devinit cciss_interrupt_mo
                         return;
                 }
         }
+default_int_mode:
 #endif /* CONFIG_PCI_MSI */
 	/* if we get here we're going to use the default interrupt mode */
-default_int_mode:
         c->intr[SIMPLE_MODE_INT] = pdev->irq;
 	return;
 }


