Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262077AbVCaXhF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262077AbVCaXhF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 18:37:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262073AbVCaXfp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 18:35:45 -0500
Received: from mail.kroah.org ([69.55.234.183]:28640 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262074AbVCaXYH convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 18:24:07 -0500
Cc: khali@linux-fr.org
Subject: [PATCH] I2C: Recognize new revision of the ADT7463 chip
In-Reply-To: <11123113921804@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Thu, 31 Mar 2005 15:23:13 -0800
Message-Id: <111231139374@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2338, 2005/03/31 14:29:05-08:00, khali@linux-fr.org

[PATCH] I2C: Recognize new revision of the ADT7463 chip

This simple patch to the lm85 driver adds recognition of a new revision
of the ADT7463 chip.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>


 drivers/i2c/chips/lm85.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletion(-)


diff -Nru a/drivers/i2c/chips/lm85.c b/drivers/i2c/chips/lm85.c
--- a/drivers/i2c/chips/lm85.c	2005-03-31 15:17:25 -08:00
+++ b/drivers/i2c/chips/lm85.c	2005-03-31 15:17:25 -08:00
@@ -74,6 +74,7 @@
 #define	LM85_VERSTEP_LM85B		0x62
 #define	LM85_VERSTEP_ADM1027		0x60
 #define	LM85_VERSTEP_ADT7463		0x62
+#define	LM85_VERSTEP_ADT7463C		0x6A
 #define	LM85_VERSTEP_EMC6D100_A0        0x60
 #define	LM85_VERSTEP_EMC6D100_A1        0x61
 
@@ -1089,7 +1090,8 @@
 		    && verstep == LM85_VERSTEP_ADM1027 ) {
 			kind = adm1027 ;
 		} else if( company == LM85_COMPANY_ANALOG_DEV
-		    && verstep == LM85_VERSTEP_ADT7463 ) {
+		    && (verstep == LM85_VERSTEP_ADT7463
+			 || verstep == LM85_VERSTEP_ADT7463C) ) {
 			kind = adt7463 ;
 		} else if( company == LM85_COMPANY_ANALOG_DEV
 		    && (verstep & LM85_VERSTEP_VMASK) == LM85_VERSTEP_GENERIC ) {

