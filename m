Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263590AbTEIXqy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 May 2003 19:46:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263591AbTEIXm4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 May 2003 19:42:56 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:36551 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S263590AbTEIXmH convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 May 2003 19:42:07 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10525245942470@kroah.com>
Subject: Re: [PATCH] More i2c driver changes for 2.5.69
In-Reply-To: <10525245932907@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 9 May 2003 16:56:34 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1083.2.2, 2003/05/09 13:58:10-07:00, mark@alpha.dyndns.org

[PATCH] I2C: add more classes

Add I2C classes for analog and digital cameras, and fix a typo.


 include/linux/i2c.h |   10 ++++++----
 1 files changed, 6 insertions(+), 4 deletions(-)


diff -Nru a/include/linux/i2c.h b/include/linux/i2c.h
--- a/include/linux/i2c.h	Fri May  9 16:48:20 2003
+++ b/include/linux/i2c.h	Fri May  9 16:48:20 2003
@@ -281,10 +281,12 @@
 						/* Must equal I2C_M_TEN below */
 
 /* i2c adapter classes (bitmask) */
-#define I2C_ADAP_CLASS_SMBUS      (1<<0)        /* lm_sensors, ... */
-#define I2C_ADAP_CLASS_TV_ANALOG  (1<<1)        /* bttv + friends */
-#define I2C_ADAP_CLASS_TV_DIGINAL (1<<2)        /* dbv cards */
-#define I2C_ADAP_CLASS_DDC        (1<<3)        /* i2c-matroxfb ? */
+#define I2C_ADAP_CLASS_SMBUS		(1<<0)	/* lm_sensors, ... */
+#define I2C_ADAP_CLASS_TV_ANALOG	(1<<1)	/* bttv + friends */
+#define I2C_ADAP_CLASS_TV_DIGITAL	(1<<2)	/* dbv cards */
+#define I2C_ADAP_CLASS_DDC		(1<<3)	/* i2c-matroxfb ? */
+#define I2C_ADAP_CLASS_CAM_ANALOG	(1<<4)	/* camera with analog CCD */
+#define I2C_ADAP_CLASS_CAM_DIGITAL	(1<<5)	/* most webcams */
 
 /* i2c_client_address_data is the struct for holding default client
  * addresses for a driver and for the parameters supplied on the

