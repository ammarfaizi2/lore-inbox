Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267444AbSKQDOO>; Sat, 16 Nov 2002 22:14:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267445AbSKQDOO>; Sat, 16 Nov 2002 22:14:14 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:39944 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S267444AbSKQDOM>;
	Sat, 16 Nov 2002 22:14:12 -0500
Date: Sun, 17 Nov 2002 03:21:09 +0000
From: Matthew Wilcox <willy@debian.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org,
       Janitors <kernel-janitor-discuss@lists.sourceforge.net>
Subject: [PATCH] remove sched.h from input.h
Message-ID: <20021117032109.W20070@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


input.h wants fs.h and timer.h, not sched.h

diff -urpNX dontdiff linux-2.5.47/include/linux/input.h linux-2.5.47-pci/include/linux/input.h
--- linux-2.5.47/include/linux/input.h	2002-10-15 09:32:41.000000000 -0400
+++ linux-2.5.47-pci/include/linux/input.h	2002-11-16 21:59:01.000000000 -0500
@@ -734,8 +734,9 @@ struct ff_effect {
  * In-kernel definitions.
  */
 
-#include <linux/sched.h>
 #include <linux/devfs_fs_kernel.h>
+#include <linux/fs.h>
+#include <linux/timer.h>
 
 #define NBITS(x) ((((x)-1)/BITS_PER_LONG)+1)
 #define BIT(x)	(1UL<<((x)%BITS_PER_LONG))

-- 
Revolutions do not require corporate support.
