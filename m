Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130962AbRCMHGc>; Tue, 13 Mar 2001 02:06:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130969AbRCMHGW>; Tue, 13 Mar 2001 02:06:22 -0500
Received: from mailout02.sul.t-online.com ([194.25.134.17]:21520 "EHLO
	mailout02.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S130962AbRCMHGI>; Tue, 13 Mar 2001 02:06:08 -0500
Message-Id: <200103130705.IAA27185@fire.malware.de>
Date: Tue, 13 Mar 2001 08:05:05 +0100
From: malware@t-online.de (Michael Mueller)
X-Mailer: Mozilla 4.61 [en] (X11; U; Linux 2.4.0-ac1 i586)
X-Accept-Language: de, en
MIME-Version: 1.0
To: alan@redhat.com, linux-kernel@vger.kernel.org
Subject: [PATCH] Using I2O modules with I2O core in kernel (follow up)
In-Reply-To: <md5:F2C348ACDB4A9C6721416F044158B4AC>
Content-Type: multipart/mixed;
 boundary="------------B926FB299FBD6D5D90036743"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------B926FB299FBD6D5D90036743
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hi Alan and folks,

I wrote: 
> the EXPORT_SYMBOL within the original source module. This was only done
> for the case it would have been compiled as kernel module. The patch is
> appended.

And again the mysterous lklm problem appeared and I forgot to append the
actual patch. Btw. the problem does exists through all the current
version of the 2.2 and 2.4 kernel line. The patch should apply cleanly
to all but the ac series where the sources were moved within the tree.


Michael
--------------B926FB299FBD6D5D90036743
Content-Type: text/plain; charset=us-ascii;
 name="i2o-2.4.2.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="i2o-2.4.2.patch"

--- linux-2.4.2/drivers/i2o/i2o_core.c.orig	Thu Feb 22 18:09:49 2001
+++ linux/drivers/i2o/i2o_core.c	Tue Mar 13 07:41:04 2001
@@ -3113,8 +3113,6 @@
 }
 
 
-#ifdef MODULE
-
 EXPORT_SYMBOL(i2o_controller_chain);
 EXPORT_SYMBOL(i2o_num_controllers);
 EXPORT_SYMBOL(i2o_find_controller);
@@ -3146,6 +3144,8 @@
 EXPORT_SYMBOL(i2o_dump_message);
 
 EXPORT_SYMBOL(i2o_get_class_name);
+
+#ifdef MODULE
 
 MODULE_AUTHOR("Red Hat Software");
 MODULE_DESCRIPTION("I2O Core");

--------------B926FB299FBD6D5D90036743--

