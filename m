Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266495AbUHWTEX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266495AbUHWTEX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 15:04:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267401AbUHWTBd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 15:01:33 -0400
Received: from mail.kroah.org ([69.55.234.183]:10692 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S267302AbUHWShB convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 14:37:01 -0400
X-Fake: the user-agent is fake
Subject: Re: [PATCH] PCI and I2C fixes for 2.6.8
User-Agent: Mutt/1.5.6i
In-Reply-To: <1093286083141@kroah.com>
Date: Mon, 23 Aug 2004 11:34:43 -0700
Message-Id: <1093286083209@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1807.54.2, 2004/08/02 16:07:56-07:00, nacc@us.ibm.com

[PATCH] I2C: i2c-algo-pcf: replace schedule_timeout() with msleep()

Remove pcf_sleep() and replace invocations with msleep().

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/i2c/algos/i2c-algo-pcf.c |    6 ------
 1 files changed, 6 deletions(-)


diff -Nru a/drivers/i2c/algos/i2c-algo-pcf.c b/drivers/i2c/algos/i2c-algo-pcf.c
--- a/drivers/i2c/algos/i2c-algo-pcf.c	2004-08-23 11:07:37 -07:00
+++ b/drivers/i2c/algos/i2c-algo-pcf.c	2004-08-23 11:07:37 -07:00
@@ -101,12 +101,6 @@
 }
 
 
-static inline void pcf_sleep(unsigned long timeout)
-{
-	schedule_timeout( timeout * HZ);
-}
-
-
 static int wait_for_pin(struct i2c_algo_pcf_data *adap, int *status) {
 
 	int timeout = DEF_TIMEOUT;

