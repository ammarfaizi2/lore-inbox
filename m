Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262718AbTI1U1C (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Sep 2003 16:27:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262721AbTI1U1C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Sep 2003 16:27:02 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:5341 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S262718AbTI1U07 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Sep 2003 16:26:59 -0400
Date: Sun, 28 Sep 2003 22:26:51 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-net@vger.kernel.org, jgarzik@pobox.com, sailer@ife.ee.ethz.ch
Subject: [patch] 2.6.0-test6: correct hdlcdrv.h prototypes
Message-ID: <20030928202651.GP15338@fs.tum.de>
References: <Pine.LNX.4.44.0309271822450.6141-100000@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0309271822450.6141-100000@home.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 27, 2003 at 06:27:35PM -0700, Linus Torvalds wrote:
>...
> Summary of changes from v2.6.0-test5 to v2.6.0-test6
> ============================================
>...
> Stephen Hemminger:
>...
>   o (1/4) Update baycom drivers for 2.6
>...

This patch changed two functions but not the corresponding prototypes in 
the header file resulting in some compile warnings.

The patch below updates hdlcdrv.h .

cu
Adrian

--- linux-2.6.0-test6-full/include/linux/hdlcdrv.h.old	2003-09-28 21:52:00.000000000 +0200
+++ linux-2.6.0-test6-full/include/linux/hdlcdrv.h	2003-09-28 22:16:37.000000000 +0200
@@ -359,11 +359,11 @@
 void hdlcdrv_receiver(struct net_device *, struct hdlcdrv_state *);
 void hdlcdrv_transmitter(struct net_device *, struct hdlcdrv_state *);
 void hdlcdrv_arbitrate(struct net_device *, struct hdlcdrv_state *);
-int hdlcdrv_register_hdlcdrv(struct net_device *dev, const struct hdlcdrv_ops *ops,
-			     unsigned int privsize, char *ifname,
+struct net_device *hdlcdrv_register(const struct hdlcdrv_ops *ops,
+			     unsigned int privsize, const char *ifname,
 			     unsigned int baseaddr, unsigned int irq, 
 			     unsigned int dma);
-int hdlcdrv_unregister_hdlcdrv(struct net_device *dev);
+void hdlcdrv_unregister(struct net_device *dev);
 
 /* -------------------------------------------------------------------- */
 
