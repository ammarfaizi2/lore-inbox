Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267441AbSKQDNN>; Sat, 16 Nov 2002 22:13:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267442AbSKQDNM>; Sat, 16 Nov 2002 22:13:12 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:36616 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S267441AbSKQDNJ>;
	Sat, 16 Nov 2002 22:13:09 -0500
Date: Sun, 17 Nov 2002 03:20:07 +0000
From: Matthew Wilcox <willy@debian.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org,
       Janitors <kernel-janitor-discuss@lists.sourceforge.net>
Subject: [PATCH] remove sched.h from atmdev.h
Message-ID: <20021117032007.V20070@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


atmdev.h only wants wait.h, not sched.h

diff -urpNX dontdiff linux-2.5.47/include/linux/atmdev.h linux-2.5.47-pci/include/linux/atmdev.h
--- linux-2.5.47/include/linux/atmdev.h	2002-10-01 03:06:27.000000000 -0400
+++ linux-2.5.47-pci/include/linux/atmdev.h	2002-11-16 21:47:04.000000000 -0500
@@ -205,7 +205,7 @@ struct atm_cirange {
 #undef __AAL_STAT_ITEMS
 #else
 
-#include <linux/sched.h> /* wait_queue_head_t */
+#include <linux/wait.h> /* wait_queue_head_t */
 #include <linux/time.h> /* struct timeval */
 #include <linux/net.h>
 #include <linux/skbuff.h> /* struct sk_buff */

-- 
Revolutions do not require corporate support.
