Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266011AbUGOAcl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266011AbUGOAcl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jul 2004 20:32:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266010AbUGOAcK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jul 2004 20:32:10 -0400
Received: from mail.kroah.org ([69.55.234.183]:61931 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S266011AbUGOAJQ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jul 2004 20:09:16 -0400
Subject: Re: [PATCH] I2C update for 2.6.8-rc1
In-Reply-To: <10898500313698@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Wed, 14 Jul 2004 17:07:12 -0700
Message-Id: <10898500322333@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1784.13.11, 2004/07/09 15:08:41-07:00, alex@alexdalton.org

[PATCH] I2C: small ADM1030 fix

Please find an incremental patch that applies on top of the previous one
(the one from the first message of the thread) and that adds parenthesis
to the macro as pointed out by Mark.


Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/i2c/chips/adm1031.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)


diff -Nru a/drivers/i2c/chips/adm1031.c b/drivers/i2c/chips/adm1031.c
--- a/drivers/i2c/chips/adm1031.c	2004-07-14 16:59:22 -07:00
+++ b/drivers/i2c/chips/adm1031.c	2004-07-14 16:59:22 -07:00
@@ -162,8 +162,8 @@
 	(AUTO_TEMP_MIN_FROM_REG(reg) - 5000)
 
 #define AUTO_TEMP_MAX_FROM_REG(reg)		\
-	AUTO_TEMP_RANGE_FROM_REG(reg) +		\
-	AUTO_TEMP_MIN_FROM_REG(reg)
+	(AUTO_TEMP_RANGE_FROM_REG(reg) +	\
+	AUTO_TEMP_MIN_FROM_REG(reg))
 
 static int AUTO_TEMP_MAX_TO_REG(int val, int reg, int pwm)
 {

