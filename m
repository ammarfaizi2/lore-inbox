Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262121AbVCaXll@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262121AbVCaXll (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 18:41:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262116AbVCaXkx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 18:40:53 -0500
Received: from mail.kroah.org ([69.55.234.183]:38880 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262121AbVCaXYM convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 18:24:12 -0500
Cc: frank.beesley@aeroflex.com
Subject: [PATCH] I2C: Clean up of i2c-elektor.c build
In-Reply-To: <11123113914006@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Thu, 31 Mar 2005 15:23:12 -0800
Message-Id: <11123113922923@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2333, 2005/03/31 14:08:41-08:00, frank.beesley@aeroflex.com

[PATCH] I2C: Clean up of i2c-elektor.c build

This patch changes the flags variable type from long to unsigned long in
one function. This removes a couple of warnings from the compile
messages for elektor i2c bus driver.

Signed-off-by: Frank Beesley <frank.beesley@aeroflex.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>


 drivers/i2c/busses/i2c-elektor.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)


diff -Nru a/drivers/i2c/busses/i2c-elektor.c b/drivers/i2c/busses/i2c-elektor.c
--- a/drivers/i2c/busses/i2c-elektor.c	2005-03-31 15:18:01 -08:00
+++ b/drivers/i2c/busses/i2c-elektor.c	2005-03-31 15:18:01 -08:00
@@ -112,7 +112,7 @@
 static void pcf_isa_waitforpin(void) {
 	DEFINE_WAIT(wait);
 	int timeout = 2;
-	long flags;
+	unsigned long flags;
 
 	if (irq > 0) {
 		spin_lock_irqsave(&lock, flags);

