Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932443AbWFYXNq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932443AbWFYXNq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jun 2006 19:13:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932444AbWFYXNp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jun 2006 19:13:45 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:16659 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932442AbWFYXN2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jun 2006 19:13:28 -0400
Date: Mon, 26 Jun 2006 01:13:27 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] make net/core/dev.c:netdev_nit static
Message-ID: <20060625231327.GL23314@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

netdev_nit can now become static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 include/linux/netdevice.h |    1 -
 net/core/dev.c            |    2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

--- linux-2.6.17-mm2-full/include/linux/netdevice.h.old	2006-06-25 23:30:55.000000000 +0200
+++ linux-2.6.17-mm2-full/include/linux/netdevice.h	2006-06-25 23:31:02.000000000 +0200
@@ -699,7 +699,6 @@
 
 extern void		dev_init(void);
 
-extern int		netdev_nit;
 extern int		netdev_budget;
 
 /* Called by rtnetlink.c:rtnl_unlock() */
--- linux-2.6.17-mm2-full/net/core/dev.c.old	2006-06-25 23:31:08.000000000 +0200
+++ linux-2.6.17-mm2-full/net/core/dev.c	2006-06-25 23:31:19.000000000 +0200
@@ -230,7 +230,7 @@
  *	For efficiency
  */
 
-int netdev_nit;
+static int netdev_nit;
 
 /*
  *	Add a protocol ID to the list. Now that the input handler is

