Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266009AbUGOBOF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266009AbUGOBOF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jul 2004 21:14:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266006AbUGOAbq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jul 2004 20:31:46 -0400
Received: from mail.kroah.org ([69.55.234.183]:58859 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S266009AbUGOAJO convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jul 2004 20:09:14 -0400
Subject: Re: [PATCH] I2C update for 2.6.8-rc1
In-Reply-To: <10898500251206@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Wed, 14 Jul 2004 17:07:07 -0700
Message-Id: <1089850026355@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1784.13.3, 2004/07/08 16:06:41-07:00, khali@linux-fr.org

[PATCH] I2C: Class of scx200_acb

This is needed for the scx200_acb to accept hardware monitoring chips.

Signed-off-by: Jean Delvare <khali at linux-fr dot org>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/i2c/busses/scx200_acb.c |    1 +
 1 files changed, 1 insertion(+)


diff -Nru a/drivers/i2c/busses/scx200_acb.c b/drivers/i2c/busses/scx200_acb.c
--- a/drivers/i2c/busses/scx200_acb.c	2004-07-14 17:00:29 -07:00
+++ b/drivers/i2c/busses/scx200_acb.c	2004-07-14 17:00:29 -07:00
@@ -458,6 +458,7 @@
 	adapter->owner = THIS_MODULE;
 	adapter->id = I2C_ALGO_SMBUS;
 	adapter->algo = &scx200_acb_algorithm;
+	adapter->class = I2C_CLASS_HWMON;
 
 	init_MUTEX(&iface->sem);
 

