Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262742AbUKLXvE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262742AbUKLXvE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Nov 2004 18:51:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262728AbUKLXsb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Nov 2004 18:48:31 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.105]:21992 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262720AbUKLX0w convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Nov 2004 18:26:52 -0500
Subject: Re: [PATCH] I2C fixes for 2.6.10-rc1
In-Reply-To: <11003020054093@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 12 Nov 2004 15:26:45 -0800
Message-Id: <11003020053782@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2094, 2004/11/12 11:40:22-08:00, greg@kroah.com

I2C: fix up rtc8564 which should not have been changed in my previous cleanups.

This fixes a reported oops.

Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/i2c/chips/rtc8564.c |    3 +++
 1 files changed, 3 insertions(+)


diff -Nru a/drivers/i2c/chips/rtc8564.c b/drivers/i2c/chips/rtc8564.c
--- a/drivers/i2c/chips/rtc8564.c	2004-11-12 15:22:45 -08:00
+++ b/drivers/i2c/chips/rtc8564.c	2004-11-12 15:22:45 -08:00
@@ -66,8 +66,11 @@
 
 static struct i2c_client_address_data addr_data = {
 	.normal_i2c		= normal_addr,
+	.normal_i2c_range	= ignore,
 	.probe			= ignore,
+	.probe_range		= ignore,
 	.ignore			= ignore,
+	.ignore_range		= ignore,
 	.force			= ignore,
 };
 

