Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263149AbVCDVSm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263149AbVCDVSm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 16:18:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263164AbVCDVN1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 16:13:27 -0500
Received: from mail.kroah.org ([69.55.234.183]:57761 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263148AbVCDUy0 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 15:54:26 -0500
Cc: khali@linux-fr.org
Subject: [PATCH] I2C: Make i2c list terminators explicitely unsigned
In-Reply-To: <11099685962988@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 4 Mar 2005 12:36:36 -0800
Message-Id: <11099685962273@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2107, 2005/03/02 15:02:10-08:00, khali@linux-fr.org

[PATCH] I2C: Make i2c list terminators explicitely unsigned

Shouldn't the i2c list terminators be explicitely declared as unsigned?
I'd hope it to help code analysis tools and possibly avoid false
positives. Coverity's SWAT pointed my attention to these constants.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>


 include/linux/i2c.h |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)


diff -Nru a/include/linux/i2c.h b/include/linux/i2c.h
--- a/include/linux/i2c.h	2005-03-04 12:23:42 -08:00
+++ b/include/linux/i2c.h	2005-03-04 12:23:42 -08:00
@@ -299,8 +299,8 @@
 };
 
 /* Internal numbers to terminate lists */
-#define I2C_CLIENT_END		0xfffe
-#define I2C_CLIENT_ISA_END	0xfffefffe
+#define I2C_CLIENT_END		0xfffeU
+#define I2C_CLIENT_ISA_END	0xfffefffeU
 
 /* The numbers to use to set I2C bus address */
 #define ANY_I2C_BUS		0xffff

