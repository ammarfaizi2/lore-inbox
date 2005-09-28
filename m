Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751240AbVI1XgM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751240AbVI1XgM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 19:36:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751241AbVI1XgM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 19:36:12 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:46523 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1751240AbVI1XgM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 19:36:12 -0400
Date: Thu, 29 Sep 2005 00:36:10 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org, adaplas@gmail.com
Subject: [PATCH] i810-i2c iomem annotations
Message-ID: <20050928233610.GL7992@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
----
diff -urN RC14-rc2-git6-uml-makefiles/drivers/video/i810/i810-i2c.c RC14-rc2-git6-i810/drivers/video/i810/i810-i2c.c
--- RC14-rc2-git6-uml-makefiles/drivers/video/i810/i810-i2c.c	2005-09-10 15:41:34.000000000 -0400
+++ RC14-rc2-git6-i810/drivers/video/i810/i810-i2c.c	2005-09-28 13:02:17.000000000 -0400
@@ -44,7 +44,7 @@
 {
         struct i810fb_i2c_chan    *chan = (struct i810fb_i2c_chan *)data;
         struct i810fb_par         *par = chan->par;
-	u8                        *mmio = par->mmio_start_virtual;
+	u8                        __iomem *mmio = par->mmio_start_virtual;
 
 	i810_writel(mmio, GPIOB, (state ? SCL_VAL_OUT : 0) | SCL_DIR |
 		    SCL_DIR_MASK | SCL_VAL_MASK);
@@ -55,7 +55,7 @@
 {
         struct i810fb_i2c_chan    *chan = (struct i810fb_i2c_chan *)data;
         struct i810fb_par         *par = chan->par;
-	u8                        *mmio = par->mmio_start_virtual;
+	u8                        __iomem *mmio = par->mmio_start_virtual;
 
  	i810_writel(mmio, GPIOB, (state ? SDA_VAL_OUT : 0) | SDA_DIR |
 		    SDA_DIR_MASK | SDA_VAL_MASK);
@@ -66,7 +66,7 @@
 {
         struct i810fb_i2c_chan    *chan = (struct i810fb_i2c_chan *)data;
         struct i810fb_par         *par = chan->par;
-	u8                        *mmio = par->mmio_start_virtual;
+	u8                        __iomem *mmio = par->mmio_start_virtual;
 
 	i810_writel(mmio, GPIOB, SCL_DIR_MASK);
 	i810_writel(mmio, GPIOB, 0);
@@ -77,7 +77,7 @@
 {
         struct i810fb_i2c_chan    *chan = (struct i810fb_i2c_chan *)data;
         struct i810fb_par         *par = chan->par;
-	u8                        *mmio = par->mmio_start_virtual;
+	u8                        __iomem *mmio = par->mmio_start_virtual;
 
 	i810_writel(mmio, GPIOB, SDA_DIR_MASK);
 	i810_writel(mmio, GPIOB, 0);
@@ -88,7 +88,7 @@
 {
         struct i810fb_i2c_chan    *chan = (struct i810fb_i2c_chan *)data;
         struct i810fb_par       *par = chan->par;
-	u8                      *mmio = par->mmio_start_virtual;
+	u8                      __iomem *mmio = par->mmio_start_virtual;
 
 	i810_writel(mmio, GPIOA, (state ? SCL_VAL_OUT : 0) | SCL_DIR |
 		    SCL_DIR_MASK | SCL_VAL_MASK);
@@ -99,7 +99,7 @@
 {
         struct i810fb_i2c_chan    *chan = (struct i810fb_i2c_chan *)data;
         struct i810fb_par         *par = chan->par;
-	u8                      *mmio = par->mmio_start_virtual;
+	u8                      __iomem *mmio = par->mmio_start_virtual;
 
  	i810_writel(mmio, GPIOA, (state ? SDA_VAL_OUT : 0) | SDA_DIR |
 		    SDA_DIR_MASK | SDA_VAL_MASK);
@@ -110,7 +110,7 @@
 {
         struct i810fb_i2c_chan    *chan = (struct i810fb_i2c_chan *)data;
         struct i810fb_par         *par = chan->par;
-	u8                      *mmio = par->mmio_start_virtual;
+	u8                      __iomem *mmio = par->mmio_start_virtual;
 
 	i810_writel(mmio, GPIOA, SCL_DIR_MASK);
 	i810_writel(mmio, GPIOA, 0);
@@ -121,7 +121,7 @@
 {
         struct i810fb_i2c_chan    *chan = (struct i810fb_i2c_chan *)data;
         struct i810fb_par         *par = chan->par;
-	u8                      *mmio = par->mmio_start_virtual;
+	u8                      __iomem *mmio = par->mmio_start_virtual;
 
 	i810_writel(mmio, GPIOA, SDA_DIR_MASK);
 	i810_writel(mmio, GPIOA, 0);
