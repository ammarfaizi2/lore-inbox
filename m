Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261746AbVE3U4x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261746AbVE3U4x (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 May 2005 16:56:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261754AbVE3U4x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 May 2005 16:56:53 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:19214 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261746AbVE3U4h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 May 2005 16:56:37 -0400
Date: Mon, 30 May 2005 22:56:34 +0200
From: Adrian Bunk <bunk@stusta.de>
To: jkmaline@cc.hut.fi
Cc: hostap@shmoo.com, jgarzik@pobox.com, netdev@oss.sgi.com,
       linux-kernel@vger.kernel.org
Subject: [-mm patch] net/ieee80211/: remove pci.h #include's
Message-ID: <20050530205634.GQ10441@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I was wondering why editing pci.h triggered the rebuild of three files 
under net/, and as far as I can see, there's no reason for these three 
files to #include pci.h .

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 1 May 2005

 net/ieee80211/ieee80211_module.c |    1 -
 net/ieee80211/ieee80211_rx.c     |    1 -
 net/ieee80211/ieee80211_tx.c     |    1 -
 3 files changed, 3 deletions(-)

--- linux-2.6.12-rc3-mm1-full/net/ieee80211/ieee80211_module.c.old	2005-04-30 23:23:14.000000000 +0200
+++ linux-2.6.12-rc3-mm1-full/net/ieee80211/ieee80211_module.c	2005-04-30 23:23:18.000000000 +0200
@@ -40,7 +40,6 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/netdevice.h>
-#include <linux/pci.h>
 #include <linux/proc_fs.h>
 #include <linux/skbuff.h>
 #include <linux/slab.h>
--- linux-2.6.12-rc3-mm1-full/net/ieee80211/ieee80211_tx.c.old	2005-04-30 23:23:25.000000000 +0200
+++ linux-2.6.12-rc3-mm1-full/net/ieee80211/ieee80211_tx.c	2005-04-30 23:23:32.000000000 +0200
@@ -33,7 +33,6 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/netdevice.h>
-#include <linux/pci.h>
 #include <linux/proc_fs.h>
 #include <linux/skbuff.h>
 #include <linux/slab.h>
--- linux-2.6.12-rc3-mm1-full/net/ieee80211/ieee80211_rx.c.old	2005-04-30 23:23:42.000000000 +0200
+++ linux-2.6.12-rc3-mm1-full/net/ieee80211/ieee80211_rx.c	2005-04-30 23:23:46.000000000 +0200
@@ -23,7 +23,6 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/netdevice.h>
-#include <linux/pci.h>
 #include <linux/proc_fs.h>
 #include <linux/skbuff.h>
 #include <linux/slab.h>

