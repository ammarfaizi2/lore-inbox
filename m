Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267840AbUJTAhC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267840AbUJTAhC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 20:37:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267739AbUJTAde
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 20:33:34 -0400
Received: from mail.kroah.org ([69.55.234.183]:11700 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S267856AbUJTATc convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 20:19:32 -0400
Subject: [PATCH] I2C update for 2.6.9
In-Reply-To: <20041020001603.GA11393@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Tue, 19 Oct 2004 17:18:23 -0700
Message-Id: <10982315033970@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1832.73.1, 2004/09/08 12:33:40-07:00, nacc@us.ibm.com

[PATCH] i2c-algo-ite: remove iic_sleep()

Removes unused function iic_sleep().

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/i2c/algos/i2c-algo-ite.c |    8 --------
 1 files changed, 8 deletions(-)


diff -Nru a/drivers/i2c/algos/i2c-algo-ite.c b/drivers/i2c/algos/i2c-algo-ite.c
--- a/drivers/i2c/algos/i2c-algo-ite.c	2004-10-19 16:56:02 -07:00
+++ b/drivers/i2c/algos/i2c-algo-ite.c	2004-10-19 16:56:02 -07:00
@@ -107,14 +107,6 @@
 	return(timeout<=0);
 }
 
-/*
- * Puts this process to sleep for a period equal to timeout 
- */
-static inline void iic_sleep(unsigned long timeout)
-{
-	schedule_timeout( timeout * HZ);
-}
-
 /* After we issue a transaction on the IIC bus, this function
  * is called.  It puts this process to sleep until we get an interrupt from
  * from the controller telling us that the transaction we requested in complete.

