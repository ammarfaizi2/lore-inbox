Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266169AbUJDNVP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266169AbUJDNVP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Oct 2004 09:21:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266117AbUJDNTc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Oct 2004 09:19:32 -0400
Received: from gprs214-62.eurotel.cz ([160.218.214.62]:17792 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S267345AbUJDNTM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Oct 2004 09:19:12 -0400
Date: Mon, 4 Oct 2004 14:01:09 +0200
From: Pavel Machek <pavel@ucw.cz>
To: kernel list <linux-kernel@vger.kernel.org>,
       Rusty trivial patch monkey Russell 
	<trivial@rustcorp.com.au>,
       Andrew Morton <akpm@zip.com.au>
Subject: Too many __s in donauboe.h
Message-ID: <20041004120109.GA25380@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

donauboe.h is kernel code, therefore it does not need __s. Please
apply,

								Pavel

Index: linux/drivers/net/irda/donauboe.h
===================================================================
--- linux.orig/drivers/net/irda/donauboe.h	2004-10-01 12:24:25.000000000 +0200
+++ linux/drivers/net/irda/donauboe.h	2004-08-19 12:21:14.000000000 +0200
@@ -268,12 +268,11 @@
 
 struct OboeSlot
 {
-  __u16 len;                    /*Tweleve bits of packet length */
-  __u8 unused;
-  __u8 control;                 /*Slot control/status see below */
-  __u32 address;                /*Slot buffer address */
-}
-__attribute__ ((packed));
+  u16 len;                    /*Tweleve bits of packet length */
+  u8 unused;
+  u8 control;                 /*Slot control/status see below */
+  u32 address;                /*Slot buffer address */
+} __attribute__ ((packed));
 
 #define OBOE_NTASKS OBOE_TXRING_OFFSET_IN_SLOTS
 
@@ -316,7 +315,7 @@
   chipio_t io;                  /* IrDA controller information */
   struct qos_info qos;          /* QoS capabilities for this device */
 
-  __u32 flags;                  /* Interface flags */
+  u32 flags;                  /* Interface flags */
 
   struct pci_dev *pdev;         /*PCI device */
   int base;                     /*IO base */


-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
