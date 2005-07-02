Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261298AbVGBWA6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261298AbVGBWA6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Jul 2005 18:00:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261302AbVGBWA6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Jul 2005 18:00:58 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:9226 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261298AbVGBVyc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Jul 2005 17:54:32 -0400
Date: Sat, 2 Jul 2005 23:54:31 +0200
From: Adrian Bunk <bunk@stusta.de>
To: petkan@users.sourceforge.net
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/usb/net/: remove two unused multicast_filter_limit variables
Message-ID: <20050702215431.GG5346@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The only uses of both variables were recently removed.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/usb/net/pegasus.c |    1 -
 drivers/usb/net/rtl8150.c |    2 --
 2 files changed, 3 deletions(-)

--- linux-2.6.13-rc1-mm1-full/drivers/usb/net/pegasus.c.old	2005-07-02 22:44:10.000000000 +0200
+++ linux-2.6.13-rc1-mm1-full/drivers/usb/net/pegasus.c	2005-07-02 22:44:19.000000000 +0200
@@ -59,7 +59,6 @@
 
 static int loopback = 0;
 static int mii_mode = 0;
-static int multicast_filter_limit = 32;
 
 static struct usb_eth_dev usb_dev_id[] = {
 #define	PEGASUS_DEV(pn, vid, pid, flags)	\
--- linux-2.6.13-rc1-mm1-full/drivers/usb/net/rtl8150.c.old	2005-07-02 22:44:31.000000000 +0200
+++ linux-2.6.13-rc1-mm1-full/drivers/usb/net/rtl8150.c	2005-07-02 22:44:35.000000000 +0200
@@ -167,8 +167,6 @@
 
 typedef struct rtl8150 rtl8150_t;
 
-static unsigned long multicast_filter_limit = 32;
-
 static void fill_skb_pool(rtl8150_t *);
 static void free_skb_pool(rtl8150_t *);
 static inline struct sk_buff *pull_skb(rtl8150_t *);

