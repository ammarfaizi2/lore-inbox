Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266233AbUHYWxL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266233AbUHYWxL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 18:53:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266316AbUHYWwf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 18:52:35 -0400
Received: from mail.kroah.org ([69.55.234.183]:29851 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S266147AbUHYWg4 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 18:36:56 -0400
X-Donotread: and you are reading this why?
Subject: Re: [PATCH] Driver Core patches for 2.6.9-rc1
In-Reply-To: <10934733881261@kroah.com>
X-Patch: quite boring stuff, it's just source code...
Date: Wed, 25 Aug 2004 15:36:28 -0700
Message-Id: <10934733881970@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1873, 2004/08/25 13:21:22-07:00, khali@linux-fr.org

[PATCH] I2C: keywest class

This is needed for iBook2 owners to be able to use their ADM1030
hardware monitoring chip. Successfully tested by one user.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/i2c/busses/i2c-keywest.c |    2 ++
 1 files changed, 2 insertions(+)


diff -Nru a/drivers/i2c/busses/i2c-keywest.c b/drivers/i2c/busses/i2c-keywest.c
--- a/drivers/i2c/busses/i2c-keywest.c	2004-08-25 14:53:40 -07:00
+++ b/drivers/i2c/busses/i2c-keywest.c	2004-08-25 14:53:40 -07:00
@@ -618,6 +618,8 @@
 		chan->iface = iface;
 		chan->chan_no = i;
 		chan->adapter.id = I2C_ALGO_SMBUS;
+		if (i==1)
+			chan->adapter.class = I2C_CLASS_HWMON;
 		chan->adapter.algo = &keywest_algorithm;
 		chan->adapter.algo_data = NULL;
 		chan->adapter.client_register = NULL;

