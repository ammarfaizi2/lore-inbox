Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263262AbSJGVCl>; Mon, 7 Oct 2002 17:02:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263267AbSJGVCl>; Mon, 7 Oct 2002 17:02:41 -0400
Received: from cabal.xs4all.nl ([213.84.101.140]:4144 "EHLO mx1.wiggy.net")
	by vger.kernel.org with ESMTP id <S263262AbSJGVCk>;
	Mon, 7 Oct 2002 17:02:40 -0400
Date: Mon, 7 Oct 2002 23:08:17 +0200
From: Wichert Akkerman <wichert@wiggy.net>
To: linux-kernel@vger.kernel.org
Cc: David Gibson <hermes@gibson.dropbear.id.au>
Subject: [PATCH] 2.5.41 orinoco_cs.c compile failure
Message-ID: <20021007210817.GD14953@wiggy.net>
Mail-Followup-To: Wichert Akkerman <wichert@wiggy.net>,
	linux-kernel@vger.kernel.org,
	David Gibson <hermes@gibson.dropbear.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Compile fails since orinoco_cs.c tries to use the no longer existing
linux/tqueue.h header. Patch below seems to fix it. 

Wichert.


--- drivers/net/wireless/orinoco_cs.c.orig	2002-10-07 23:03:44.000000000 +0200
+++ drivers/net/wireless/orinoco_cs.c	2002-10-07 23:04:16.000000000 +0200
@@ -32,7 +32,7 @@
 #include <linux/if_arp.h>
 #include <linux/etherdevice.h>
 #include <linux/wireless.h>
-#include <linux/tqueue.h>
+#include <linux/workqueue.h>
 
 #include <pcmcia/version.h>
 #include <pcmcia/cs_types.h>

-- 
  _________________________________________________________________
 /wichert@wiggy.net         This space intentionally left occupied \
| wichert@deephackmode.org                    http://www.wiggy.net/ |
| 1024D/2FA3BC2D 576E 100B 518D 2F16 36B0  2805 3CB8 9250 2FA3 BC2D |
