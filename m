Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262843AbVGKWJJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262843AbVGKWJJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 18:09:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262847AbVGKWGe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 18:06:34 -0400
Received: from mail.kroah.org ([69.55.234.183]:1245 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262896AbVGKWDz convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 18:03:55 -0400
Cc: david-b@pacbell.net
Subject: [PATCH] I2C: minor I2C doc cleanups
In-Reply-To: <1121119377583@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 11 Jul 2005 15:02:57 -0700
Message-Id: <11211193771521@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] I2C: minor I2C doc cleanups

The I2C stack has long had "id" fields, of rather dubious utility, in
many data structures.  This removes mention of one of them from the
documentation about how to write an I2C driver, so that only drivers
that really need to use them (probably old/legacy code) will have any
reason to use this field.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 61f5809d3ebce9d5433b8696048e91405b681023
tree bcb41c29d36b3b6f84d34c7bac05b38855e90742
parent 2db32767874fe53faff4f80de878ca19927efc1f
author david-b@pacbell.net <david-b@pacbell.net> Wed, 29 Jun 2005 07:14:06 -0700
committer Greg Kroah-Hartman <gregkh@suse.de> Mon, 11 Jul 2005 14:10:37 -0700

 Documentation/i2c/writing-clients |    7 -------
 1 files changed, 0 insertions(+), 7 deletions(-)

diff --git a/Documentation/i2c/writing-clients b/Documentation/i2c/writing-clients
--- a/Documentation/i2c/writing-clients
+++ b/Documentation/i2c/writing-clients
@@ -27,7 +27,6 @@ address.
 static struct i2c_driver foo_driver = {
 	.owner		= THIS_MODULE,
 	.name		= "Foo version 2.3 driver",
-	.id		= I2C_DRIVERID_FOO, /* from i2c-id.h, optional */
 	.flags		= I2C_DF_NOTIFY,
 	.attach_adapter	= &foo_attach_adapter,
 	.detach_client	= &foo_detach_client,
@@ -37,12 +36,6 @@ static struct i2c_driver foo_driver = {
 The name can be chosen freely, and may be upto 40 characters long. Please
 use something descriptive here.
 
-If used, the id should be a unique ID. The range 0xf000 to 0xffff is
-reserved for local use, and you can use one of those until you start
-distributing the driver, at which time you should contact the i2c authors
-to get your own ID(s). Note that most of the time you don't need an ID
-at all so you can just omit it.
-
 Don't worry about the flags field; just put I2C_DF_NOTIFY into it. This
 means that your driver will be notified when new adapters are found.
 This is almost always what you want.

