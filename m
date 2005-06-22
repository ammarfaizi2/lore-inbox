Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262783AbVFVG5H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262783AbVFVG5H (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 02:57:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262847AbVFVGyk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 02:54:40 -0400
Received: from mail.kroah.org ([69.55.234.183]:14236 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262787AbVFVFV7 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 01:21:59 -0400
Cc: grant_lkml@dodo.com.au
Subject: [PATCH] I2C: remove <linux/delay.h> from via686a
In-Reply-To: <11194174642050@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Tue, 21 Jun 2005 22:17:44 -0700
Message-Id: <11194174643068@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] I2C: remove <linux/delay.h> from via686a

In my cross-reference checking of sysfs names, the via686a needs
special case treatment as it the only driver expands S_IWUSR to
00200 with gcc -E.  (00200 is the correct value for S_IWUSR).

This is caused by the driver including <linux/delay.h>, it compiles
fine without that header but I am unable to test drive the change.

Signed-off-by: Grant Coady <gcoady@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit b9826b3ee8faa468a26782e3bf37716a73d96730
tree e714c037b2862cf8c592311c09958ffba818259d
parent 815f55f280fb2781ba1c2a350516b73e55119c60
author Grant Coady <grant_lkml@dodo.com.au> Fri, 06 May 2005 17:40:51 +1000
committer Greg Kroah-Hartman <gregkh@suse.de> Tue, 21 Jun 2005 21:51:56 -0700

 drivers/i2c/chips/via686a.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/drivers/i2c/chips/via686a.c b/drivers/i2c/chips/via686a.c
--- a/drivers/i2c/chips/via686a.c
+++ b/drivers/i2c/chips/via686a.c
@@ -33,7 +33,6 @@
 #include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/pci.h>
-#include <linux/delay.h>
 #include <linux/jiffies.h>
 #include <linux/i2c.h>
 #include <linux/i2c-sensor.h>

