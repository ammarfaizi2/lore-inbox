Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265080AbUFVSBm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265080AbUFVSBm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 14:01:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265082AbUFVSBC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 14:01:02 -0400
Received: from mail.kroah.org ([65.200.24.183]:48309 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265080AbUFVRne convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 13:43:34 -0400
X-Donotread: and you are reading this why?
Subject: Re: [PATCH] Driver Core patches for 2.6.7
In-Reply-To: <108792611192@kroah.com>
X-Patch: quite boring stuff, it's just source code...
Date: Tue, 22 Jun 2004 10:41:52 -0700
Message-Id: <1087926112618@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1722.111.19, 2004/06/09 10:34:09-07:00, akpm@osdl.org

[PATCH] I2C: w83627hf.c build fix

with gcc-2.95:

drivers/i2c/chips/w83627hf.c:482: parse error before `static'
drivers/i2c/chips/w83627hf.c:502: parse error before `static'
drivers/i2c/chips/w83627hf.c: In function `show_regs_fan_1':
drivers/i2c/chips/w83627hf.c:541: warning: implicit declaration of function `show_fan'
drivers/i2c/chips/w83627hf.c: In function `w83627hf_detect':
drivers/i2c/chips/w83627hf.c:1074: `dev_attr_in0_min' undeclared (first use in this function)
drivers/i2c/chips/w83627hf.c:1074: (Each undeclared identifier is reported only once
drivers/i2c/chips/w83627hf.c:1074: for each function it appears in.)
drivers/i2c/chips/w83627hf.c: At top level:
drivers/i2c/chips/w83627hf.c:428: warning: `show_regs_in_min0' defined but not used
drivers/i2c/chips/w83627hf.c:441: warning: `store_regs_in_min0' defined but not used

Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/i2c/chips/w83627hf.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)


diff -Nru a/drivers/i2c/chips/w83627hf.c b/drivers/i2c/chips/w83627hf.c
--- a/drivers/i2c/chips/w83627hf.c	Tue Jun 22 09:47:24 2004
+++ b/drivers/i2c/chips/w83627hf.c	Tue Jun 22 09:47:24 2004
@@ -478,11 +478,11 @@
 	return count;
 }
 
-static DEVICE_ATTR(in0_input, S_IRUGO, show_regs_in_0, NULL)
+static DEVICE_ATTR(in0_input, S_IRUGO, show_regs_in_0, NULL);
 static DEVICE_ATTR(in0_min, S_IRUGO | S_IWUSR,
-	show_regs_in_min0, store_regs_in_min0)
+	show_regs_in_min0, store_regs_in_min0);
 static DEVICE_ATTR(in0_max, S_IRUGO | S_IWUSR,
-	show_regs_in_max0, store_regs_in_max0)
+	show_regs_in_max0, store_regs_in_max0);
 
 #define device_create_file_in(client, offset) \
 do { \

