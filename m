Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267453AbSKQEFi>; Sat, 16 Nov 2002 23:05:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267454AbSKQEFh>; Sat, 16 Nov 2002 23:05:37 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:44554 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S267453AbSKQEFg>;
	Sat, 16 Nov 2002 23:05:36 -0500
Date: Sun, 17 Nov 2002 04:12:35 +0000
From: Matthew Wilcox <willy@debian.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org,
       Janitors <kernel-janitor-discuss@lists.sourceforge.net>
Subject: [PATCH] remove sched.h from ftape.h
Message-ID: <20021117041235.D20070@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ftape.h really wants interrupt.h, not sched.h

diff -urpNX dontdiff linux-2.5.47/include/linux/ftape.h linux-2.5.47-pci/include/linux/ftape.h
--- linux-2.5.47/include/linux/ftape.h	2002-10-01 03:07:12.000000000 -0400
+++ linux-2.5.47-pci/include/linux/ftape.h	2002-11-16 22:27:05.000000000 -0500
@@ -34,7 +34,7 @@
 #define KERNEL_VER(major,minor,sublvl) (((major)<<16)+((minor)<<8)+(sublvl))
 
 #ifdef __KERNEL__
-#include <linux/sched.h>
+#include <linux/interrupt.h>
 #include <linux/mm.h>
 #endif
 #include <linux/types.h>

-- 
Revolutions do not require corporate support.
