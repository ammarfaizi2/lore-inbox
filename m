Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262390AbVGLUk1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262390AbVGLUk1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 16:40:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262394AbVGLUjz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 16:39:55 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:20232 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262390AbVGLU1o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 16:27:44 -0400
Date: Tue, 12 Jul 2005 22:27:40 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: jgarzik@pobox.com, jkmaline@cc.hut.fi, hostap@shmoo.com,
       netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: [-mm patch] net/ieee80211/: remove pci.h #include's
Message-ID: <20050712202740.GL4034@stusta.de>
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
- 3 Jul 2005
- 30 May 2005
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

