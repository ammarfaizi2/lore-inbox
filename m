Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264610AbUENXrg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264610AbUENXrg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 May 2004 19:47:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264601AbUENXrM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 May 2004 19:47:12 -0400
Received: from mail.kroah.org ([65.200.24.183]:23269 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S264610AbUENX34 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 May 2004 19:29:56 -0400
Subject: Re: [PATCH] I2C update for 2.6.6
In-Reply-To: <10845773573392@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 14 May 2004 16:29:17 -0700
Message-Id: <10845773573133@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1587.15.12, 2004/05/11 13:43:55-07:00, khali@linux-fr.org

[PATCH] I2C: kill duplicate includes in i2c bus drivers

Following a suggestion of Arthur Othieno, here is a trivial patch that
kills duplicate inclusions of config.h in four i2c bus drivers.

At first I was thinking of also removing inclusions of config.h wherever
it doesn't seem to be necessary but Eugene doesn't seem to think it's a
good idea. So I may give it a try later (in 2.7), but for now this
simple patch will be enough.


 drivers/i2c/busses/i2c-keywest.c |    1 -
 drivers/i2c/busses/i2c-piix4.c   |    1 -
 drivers/i2c/busses/scx200_acb.c  |    1 -
 drivers/i2c/busses/scx200_i2c.c  |    1 -
 4 files changed, 4 deletions(-)


diff -Nru a/drivers/i2c/busses/i2c-keywest.c b/drivers/i2c/busses/i2c-keywest.c
--- a/drivers/i2c/busses/i2c-keywest.c	Fri May 14 16:19:27 2004
+++ b/drivers/i2c/busses/i2c-keywest.c	Fri May 14 16:19:27 2004
@@ -48,7 +48,6 @@
 
 #include <linux/config.h>
 #include <linux/module.h>
-#include <linux/config.h>
 #include <linux/kernel.h>
 #include <linux/ioport.h>
 #include <linux/pci.h>
diff -Nru a/drivers/i2c/busses/i2c-piix4.c b/drivers/i2c/busses/i2c-piix4.c
--- a/drivers/i2c/busses/i2c-piix4.c	Fri May 14 16:19:27 2004
+++ b/drivers/i2c/busses/i2c-piix4.c	Fri May 14 16:19:27 2004
@@ -31,7 +31,6 @@
 #include <linux/config.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
-#include <linux/config.h>
 #include <linux/pci.h>
 #include <linux/kernel.h>
 #include <linux/stddef.h>
diff -Nru a/drivers/i2c/busses/scx200_acb.c b/drivers/i2c/busses/scx200_acb.c
--- a/drivers/i2c/busses/scx200_acb.c	Fri May 14 16:19:27 2004
+++ b/drivers/i2c/busses/scx200_acb.c	Fri May 14 16:19:27 2004
@@ -25,7 +25,6 @@
 */
 
 #include <linux/config.h>
-#include <linux/config.h>
 #include <linux/module.h>
 #include <linux/errno.h>
 #include <linux/kernel.h>
diff -Nru a/drivers/i2c/busses/scx200_i2c.c b/drivers/i2c/busses/scx200_i2c.c
--- a/drivers/i2c/busses/scx200_i2c.c	Fri May 14 16:19:27 2004
+++ b/drivers/i2c/busses/scx200_i2c.c	Fri May 14 16:19:27 2004
@@ -22,7 +22,6 @@
 */
 
 #include <linux/config.h>
-#include <linux/config.h>
 #include <linux/module.h>
 #include <linux/errno.h>
 #include <linux/kernel.h>

