Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263104AbVCDWRS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263104AbVCDWRS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 17:17:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263144AbVCDWNu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 17:13:50 -0500
Received: from mail.kroah.org ([69.55.234.183]:49569 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263139AbVCDUyV convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 15:54:21 -0500
Cc: khali@linux-fr.org
Subject: [PATCH] I2C: Kill i2c_client.id (4/5)
In-Reply-To: <11099685933363@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 4 Mar 2005 12:36:34 -0800
Message-Id: <11099685942662@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2086, 2005/03/02 11:52:48-08:00, khali@linux-fr.org

[PATCH] I2C: Kill i2c_client.id (4/5)

> (4/5) Deprecate i2c_client.id.

Now that i2c_client.id has no more users in the kernel (none that I
could find at least) we could remove that struct member. I however think
that it's better to only deprecate it at the moment, in case I missed
users or any of the other patches are delayed for some reason. We could
then delete the id member definitely in a month or so.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 include/linux/i2c.h |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)


diff -Nru a/include/linux/i2c.h b/include/linux/i2c.h
--- a/include/linux/i2c.h	2005-03-04 12:26:05 -08:00
+++ b/include/linux/i2c.h	2005-03-04 12:26:05 -08:00
@@ -144,7 +144,7 @@
  * function is mainly used for lookup & other admin. functions.
  */
 struct i2c_client {
-	int id;
+	__attribute__ ((deprecated)) int id;
 	unsigned int flags;		/* div., see below		*/
 	unsigned int addr;		/* chip address - NOTE: 7bit 	*/
 					/* addresses are stored in the	*/

