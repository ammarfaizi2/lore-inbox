Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267374AbSKPVid>; Sat, 16 Nov 2002 16:38:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267375AbSKPVid>; Sat, 16 Nov 2002 16:38:33 -0500
Received: from verein.lst.de ([212.34.181.86]:19471 "EHLO verein.lst.de")
	by vger.kernel.org with ESMTP id <S267374AbSKPVia>;
	Sat, 16 Nov 2002 16:38:30 -0500
Date: Sat, 16 Nov 2002 22:45:25 +0100
From: Christoph Hellwig <hch@lst.de>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] don't include mount.h in dcache.h
Message-ID: <20021116224525.C26097@lst.de>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>, torvalds@transmeta.com,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Once again we only need a forward-declaration of struct vfsmount.


--- 1.22/include/linux/dcache.h	Fri Nov 15 18:09:46 2002
+++ edited/include/linux/dcache.h	Sat Nov 16 20:18:12 2002
@@ -4,11 +4,12 @@
 #ifdef __KERNEL__
 
 #include <asm/atomic.h>
-#include <linux/mount.h>
 #include <linux/list.h>
 #include <linux/spinlock.h>
 #include <linux/cache.h>
 #include <asm/page.h>			/* for BUG() */
+
+struct vfsmount;
 
 /*
  * linux/include/linux/dcache.h
