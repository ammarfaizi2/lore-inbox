Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263291AbUCPC0N (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 21:26:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263301AbUCPBX6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 20:23:58 -0500
Received: from mail.kroah.org ([65.200.24.183]:43183 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262867AbUCPACy convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 19:02:54 -0500
Subject: Re: [PATCH] i2c driver fixes for 2.6.4
In-Reply-To: <10793913903814@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 15 Mar 2004 14:56:30 -0800
Message-Id: <1079391390517@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1557.61.2, 2004/02/17 14:40:59-08:00, khali@linux-fr.org

[PATCH] I2C: Enable debugging in fscher

I just noticed that I forgot to enable debugging in the new fscher
driver. Sorry for that. Here is a patch that fixes this.


 drivers/i2c/chips/fscher.c |    5 +++++
 1 files changed, 5 insertions(+)


diff -Nru a/drivers/i2c/chips/fscher.c b/drivers/i2c/chips/fscher.c
--- a/drivers/i2c/chips/fscher.c	Mon Mar 15 14:37:50 2004
+++ b/drivers/i2c/chips/fscher.c	Mon Mar 15 14:37:50 2004
@@ -26,6 +26,11 @@
  *  and Philip Edelbrock <phil@netroedge.com>
  */
 
+#include <linux/config.h>
+#ifdef CONFIG_I2C_DEBUG_CHIP
+#define DEBUG	1
+#endif
+
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/slab.h>

