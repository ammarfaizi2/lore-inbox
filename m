Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267414AbUHWTXF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267414AbUHWTXF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 15:23:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267248AbUHWTWe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 15:22:34 -0400
Received: from mail.kroah.org ([69.55.234.183]:64963 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S267190AbUHWSgp convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 14:36:45 -0400
X-Fake: the user-agent is fake
Subject: Re: [PATCH] PCI and I2C fixes for 2.6.8
User-Agent: Mutt/1.5.6i
In-Reply-To: <1093286083209@kroah.com>
Date: Mon, 23 Aug 2004 11:34:43 -0700
Message-Id: <10932860833383@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1807.54.3, 2004/08/02 16:09:18-07:00, nacc@us.ibm.com

[PATCH] I2C: i2c-ite: replace schedule_timeout() with msleep()

Remove iic_ite_sleep() and replace invocations with msleep().

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/i2c/busses/i2c-ite.c |    8 --------
 1 files changed, 8 deletions(-)


diff -Nru a/drivers/i2c/busses/i2c-ite.c b/drivers/i2c/busses/i2c-ite.c
--- a/drivers/i2c/busses/i2c-ite.c	2004-08-23 11:07:31 -07:00
+++ b/drivers/i2c/busses/i2c-ite.c	2004-08-23 11:07:31 -07:00
@@ -102,14 +102,6 @@
 }
 
 
-#if 0
-static void iic_ite_sleep(unsigned long timeout)
-{
-	schedule_timeout( timeout * HZ);
-}
-#endif
-
-
 /* Put this process to sleep.  We will wake up when the
  * IIC controller interrupts.
  */

