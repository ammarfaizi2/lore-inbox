Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261883AbVAHIvX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261883AbVAHIvX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 03:51:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261884AbVAHIuL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 03:50:11 -0500
Received: from mail.kroah.org ([69.55.234.183]:54405 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261883AbVAHFs1 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 00:48:27 -0500
Subject: Re: [PATCH] I2C patches for 2.6.10
In-Reply-To: <11051627751088@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 7 Jan 2005 21:39:35 -0800
Message-Id: <11051627751125@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1938.445.5, 2004/12/15 11:43:29-08:00, domen@coderock.org

[PATCH] it87: /proc/ioports fix

When request_region is called name is set to "", use module name.

Signed-off-by: Domen Puncer <domen@coderock.org>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/i2c/chips/it87.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)


diff -Nru a/drivers/i2c/chips/it87.c b/drivers/i2c/chips/it87.c
--- a/drivers/i2c/chips/it87.c	2005-01-07 14:55:51 -08:00
+++ b/drivers/i2c/chips/it87.c	2005-01-07 14:55:51 -08:00
@@ -624,7 +624,7 @@
 
 	/* Reserve the ISA region */
 	if (is_isa)
-		if (!request_region(address, IT87_EXTENT, name))
+		if (!request_region(address, IT87_EXTENT, it87_driver.name))
 			goto ERROR0;
 
 	/* Probe whether there is anything available on this address. Already

