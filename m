Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264632AbTGBWBJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jul 2003 18:01:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264810AbTGBWBI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jul 2003 18:01:08 -0400
Received: from x35.xmailserver.org ([208.129.208.51]:23458 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S264632AbTGBWAv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jul 2003 18:00:51 -0400
X-AuthUser: davidel@xmailserver.org
Date: Wed, 2 Jul 2003 15:07:24 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mcafeelabs.com
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
cc: Andrew Morton <akpm@osdl.org>
Subject: [patch] Hardly triggered tests in bootmem.c ...
Message-ID: <Pine.LNX.4.55.0307021503490.4840@bigblue.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I was looking at the bootmem.c source and I found those hardly triggered
tests (unsigned long's).
(Andrew, sending the patch insted of the note)


- Davide




--- linux-2.5.73/mm/bootmem.c.orig	2003-07-02 14:55:47.000000000 -0700
+++ linux-2.5.73/mm/bootmem.c	2003-07-02 14:56:51.000000000 -0700
@@ -84,10 +84,6 @@

 	if (!size) BUG();

-	if (sidx < 0)
-		BUG();
-	if (eidx < 0)
-		BUG();
 	if (sidx >= eidx)
 		BUG();
 	if ((addr >> PAGE_SHIFT) >= bdata->node_low_pfn)
