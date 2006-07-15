Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945938AbWGOAfz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945938AbWGOAfz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jul 2006 20:35:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945940AbWGOAfr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jul 2006 20:35:47 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:30729 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1945938AbWGOAfi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jul 2006 20:35:38 -0400
Date: Sat, 15 Jul 2006 02:35:36 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, Jim Cromie <jim.cromie@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: [RFC: -mm patch] drivers/char/scx200_gpio.c: make code static
Message-ID: <20060715003536.GH3633@stusta.de>
References: <20060713224800.6cbdbf5d.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060713224800.6cbdbf5d.akpm@osdl.org>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes needlessly global code static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/char/scx200_gpio.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

--- linux-2.6.18-rc1-mm2-full/drivers/char/scx200_gpio.c.old	2006-07-14 22:31:22.000000000 +0200
+++ linux-2.6.18-rc1-mm2-full/drivers/char/scx200_gpio.c	2006-07-14 22:31:44.000000000 +0200
@@ -35,7 +35,7 @@
 
 #define MAX_PINS 32		/* 64 later, when known ok */
 
-struct nsc_gpio_ops scx200_gpio_ops = {
+static struct nsc_gpio_ops scx200_gpio_ops = {
 	.owner		= THIS_MODULE,
 	.gpio_config	= scx200_gpio_configure,
 	.gpio_dump	= nsc_gpio_dump,
@@ -44,7 +44,6 @@
 	.gpio_change	= scx200_gpio_change,
 	.gpio_current	= scx200_gpio_current
 };
-EXPORT_SYMBOL(scx200_gpio_ops);
 
 static int scx200_gpio_open(struct inode *inode, struct file *file)
 {
@@ -69,7 +68,7 @@
 	.release = scx200_gpio_release,
 };
 
-struct cdev scx200_gpio_cdev;  /* use 1 cdev for all pins */
+static struct cdev scx200_gpio_cdev;  /* use 1 cdev for all pins */
 
 static int __init scx200_gpio_init(void)
 {

