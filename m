Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267442AbSKQDQJ>; Sat, 16 Nov 2002 22:16:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267443AbSKQDQJ>; Sat, 16 Nov 2002 22:16:09 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:41992 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S267442AbSKQDQI>;
	Sat, 16 Nov 2002 22:16:08 -0500
Date: Sun, 17 Nov 2002 03:23:04 +0000
From: Matthew Wilcox <willy@debian.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org,
       Janitors <kernel-janitor-discuss@lists.sourceforge.net>
Subject: [PATCH] remove sched.h from nfsd/cache.h
Message-ID: <20021117032304.X20070@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


nfsd/cache.h doesn't need sched.h, just sockaddr_in and iovec

diff -urpNX dontdiff linux-2.5.47/include/linux/nfsd/cache.h linux-2.5.47-pci/include/linux/nfsd/cache.h
--- linux-2.5.47/include/linux/nfsd/cache.h	2002-10-31 11:23:26.000000000 -0500
+++ linux-2.5.47-pci/include/linux/nfsd/cache.h	2002-11-16 21:42:15.000000000 -0500
@@ -11,7 +11,8 @@
 #define NFSCACHE_H
 
 #ifdef __KERNEL__
-#include <linux/sched.h>
+#include <linux/in.h>
+#include <linux/uio.h>
 
 /*
  * Representation of a reply cache entry. The first two members *must*

-- 
Revolutions do not require corporate support.
