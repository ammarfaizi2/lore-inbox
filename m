Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262873AbUCPASr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 19:18:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262968AbUCPAHJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 19:07:09 -0500
Received: from mail.kroah.org ([65.200.24.183]:10671 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262887AbUCPACI convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 19:02:08 -0500
Subject: Re: [PATCH] i2c driver fixes for 2.6.4
In-Reply-To: <10793913921004@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 15 Mar 2004 14:56:32 -0800
Message-Id: <10793913922046@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1597.1.8, 2004/02/23 17:23:15-08:00, greg@kroah.com

I2C: fix compiler warnings in 2 drivers.


 drivers/i2c/busses/i2c-elv.c      |    2 +-
 drivers/i2c/busses/i2c-velleman.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)


diff -Nru a/drivers/i2c/busses/i2c-elv.c b/drivers/i2c/busses/i2c-elv.c
--- a/drivers/i2c/busses/i2c-elv.c	Mon Mar 15 14:35:57 2004
+++ b/drivers/i2c/busses/i2c-elv.c	Mon Mar 15 14:35:57 2004
@@ -152,7 +152,7 @@
 			return -ENODEV;
 		}
 	}
-	pr_debug("i2c-elv: found device at %#x.\n",base);
+	pr_debug("i2c-elv: found device at %p.\n", (void *)base);
 	return 0;
 }
 
diff -Nru a/drivers/i2c/busses/i2c-velleman.c b/drivers/i2c/busses/i2c-velleman.c
--- a/drivers/i2c/busses/i2c-velleman.c	Mon Mar 15 14:35:57 2004
+++ b/drivers/i2c/busses/i2c-velleman.c	Mon Mar 15 14:35:57 2004
@@ -138,7 +138,7 @@
 			return -ENODEV;
 		}
 	}
-	pr_debug("i2c-velleman: found device at %#x.\n",base);
+	pr_debug("i2c-velleman: found device at %p.\n",(void *)base);
 	return 0;
 }
 

