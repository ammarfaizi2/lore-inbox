Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272161AbTHIA6o (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Aug 2003 20:58:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272153AbTHIA51
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Aug 2003 20:57:27 -0400
Received: from mail.kroah.org ([65.200.24.183]:52415 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S272152AbTHIAcI convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Aug 2003 20:32:08 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10603869391598@kroah.com>
Subject: Re: [PATCH] More i2c driver changes 2.6.0-test2
In-Reply-To: <106038693850@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 8 Aug 2003 16:55:39 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1126, 2003/08/08 16:33:00-07:00, wodecki@gmx.de

[PATCH] I2C: i2c sysfs rant

On Wed, Aug 06, 2003 at 04:22:44PM -0700, Greg KH wrote:
> On Wed, Aug 06, 2003 at 09:11:45PM +0200, Wiktor Wodecki wrote:
> > Hello folks,
> >
> > I just saw that I2C provides "/sys/bus/i2c/drivers/dev\ driver" in
> > 2.6.0-test2. It would be nice if you'd consider renaming this to
> > dev_driver, to avoid un-neccessary quoting in scripts.
> >
> > Thank You :-)
>
> Patches are always gladly accepted :)

here you go


 drivers/i2c/i2c-dev.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)


diff -Nru a/drivers/i2c/i2c-dev.c b/drivers/i2c/i2c-dev.c
--- a/drivers/i2c/i2c-dev.c	Fri Aug  8 16:47:15 2003
+++ b/drivers/i2c/i2c-dev.c	Fri Aug  8 16:47:15 2003
@@ -474,7 +474,7 @@
 
 static struct i2c_driver i2cdev_driver = {
 	.owner		= THIS_MODULE,
-	.name		= "dev driver",
+	.name		= "dev_driver",
 	.id		= I2C_DRIVERID_I2CDEV,
 	.flags		= I2C_DF_NOTIFY,
 	.attach_adapter	= i2cdev_attach_adapter,

