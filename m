Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263044AbVCDWRQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263044AbVCDWRQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 17:17:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263109AbVCDWND
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 17:13:03 -0500
Received: from mail.kroah.org ([69.55.234.183]:50849 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263141AbVCDUyW convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 15:54:22 -0500
Cc: greg@kroah.com
Subject: [PATCH] I2C: just delete the id field, let's not delay it any longer
In-Reply-To: <11099685942488@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 4 Mar 2005 12:36:34 -0800
Message-Id: <11099685944086@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2088, 2005/03/02 11:58:47-08:00, greg@kroah.com

[PATCH] I2C: just delete the id field, let's not delay it any longer

Becides, sparse keeps complaining when it sees this attribute within a structure...

Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 include/linux/i2c.h |    1 -
 1 files changed, 1 deletion(-)


diff -Nru a/include/linux/i2c.h b/include/linux/i2c.h
--- a/include/linux/i2c.h	2005-03-04 12:25:51 -08:00
+++ b/include/linux/i2c.h	2005-03-04 12:25:51 -08:00
@@ -144,7 +144,6 @@
  * function is mainly used for lookup & other admin. functions.
  */
 struct i2c_client {
-	__attribute__ ((deprecated)) int id;
 	unsigned int flags;		/* div., see below		*/
 	unsigned int addr;		/* chip address - NOTE: 7bit 	*/
 					/* addresses are stored in the	*/

