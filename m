Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262770AbVG3CKr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262770AbVG3CKr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 22:10:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262765AbVG3CI4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 22:08:56 -0400
Received: from mail.kroah.org ([69.55.234.183]:44207 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262766AbVG2TRw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 15:17:52 -0400
Date: Fri, 29 Jul 2005 12:17:11 -0700
From: Greg KH <gregkh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, bunk@stusta.de
Subject: [patch 21/29] USB: drivers/usb/net/: remove two unused multicast_filter_limit variables
Message-ID: <20050729191711.GW5095@kroah.com>
References: <20050729184950.014589000@press.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050729191255.GA5095@kroah.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Bunk <bunk@stusta.de>

The only uses of both variables were recently removed.

Signed-off-by: Adrian Bunk <bunk@stusta.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 drivers/usb/net/pegasus.c |    1 -
 drivers/usb/net/rtl8150.c |    2 --
 2 files changed, 3 deletions(-)

--- gregkh-2.6.orig/drivers/usb/net/pegasus.c	2005-07-29 11:29:48.000000000 -0700
+++ gregkh-2.6/drivers/usb/net/pegasus.c	2005-07-29 11:36:28.000000000 -0700
@@ -59,7 +59,6 @@
 
 static int loopback = 0;
 static int mii_mode = 0;
-static int multicast_filter_limit = 32;
 
 static struct usb_eth_dev usb_dev_id[] = {
 #define	PEGASUS_DEV(pn, vid, pid, flags)	\
--- gregkh-2.6.orig/drivers/usb/net/rtl8150.c	2005-07-29 11:29:48.000000000 -0700
+++ gregkh-2.6/drivers/usb/net/rtl8150.c	2005-07-29 11:36:28.000000000 -0700
@@ -167,8 +167,6 @@
 
 typedef struct rtl8150 rtl8150_t;
 
-static unsigned long multicast_filter_limit = 32;
-
 static void fill_skb_pool(rtl8150_t *);
 static void free_skb_pool(rtl8150_t *);
 static inline struct sk_buff *pull_skb(rtl8150_t *);

--
