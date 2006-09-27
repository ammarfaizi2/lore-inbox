Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965162AbWI0Wqi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965162AbWI0Wqi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 18:46:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965163AbWI0Wqi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 18:46:38 -0400
Received: from mail.gmx.net ([213.165.64.20]:7901 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S965162AbWI0Wqh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 18:46:37 -0400
X-Authenticated: #704063
Subject: [Patch] Remove unnecessary check in
	drivers/video/intelfb/intelfbhw.c
From: Eric Sesterhenn <snakebyte@gmx.de>
To: linux-kernel@vger.kernel.org
Cc: sylvain.meyer@worldonline.fr
Content-Type: text/plain
Date: Thu, 28 Sep 2006 00:46:14 +0200
Message-Id: <1159397174.14069.2.camel@alice>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

all callers and the function itself dereference dinfo,
so we can remove the check. (coverity id #1371)

Signed-off-by: Eric Sesterhenn <snakebyte@gmx.de>

--- linux-2.6.18-git7/drivers/video/intelfb/intelfbhw.c.orig	2006-09-27 21:47:46.000000000 +0200
+++ linux-2.6.18-git7/drivers/video/intelfb/intelfbhw.c	2006-09-27 21:48:04.000000000 +0200
@@ -648,7 +648,7 @@ intelfbhw_print_hw_state(struct intelfb_
 	int index = dinfo->pll_index;
 	DBG_MSG("intelfbhw_print_hw_state\n");
 
-	if (!hw || !dinfo)
+	if (!hw)
 		return;
 	/* Read in as much of the HW state as possible. */
 	printk("hw state dump start\n");


