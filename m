Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262489AbVFVHhN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262489AbVFVHhN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 03:37:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262864AbVFVHfW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 03:35:22 -0400
Received: from mail.kroah.org ([69.55.234.183]:55451 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262766AbVFVFVt convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 01:21:49 -0400
Cc: gregkh@suse.de
Subject: [PATCH] I2C: fix up ds1374.c driver so it will build.
In-Reply-To: <1119417468829@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Tue, 21 Jun 2005 22:17:48 -0700
Message-Id: <1119417468520@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] I2C: fix up ds1374.c driver so it will build.

Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit a45cfe2cd7450e56b4f44802b34faaf2a78a6cdb
tree ca6f26f57cb96ff6ab4b9f1830f3f29f1185166d
parent bdca3f0aedde85552099aa95ab1449bf81e4f6f5
author Greg KH <gregkh@suse.de> Thu, 09 Jun 2005 17:39:09 +0200
committer Greg Kroah-Hartman <gregkh@suse.de> Tue, 21 Jun 2005 21:52:06 -0700

 drivers/i2c/chips/ds1374.c |    4 ----
 1 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/chips/ds1374.c b/drivers/i2c/chips/ds1374.c
--- a/drivers/i2c/chips/ds1374.c
+++ b/drivers/i2c/chips/ds1374.c
@@ -27,7 +27,6 @@
 #include <linux/rtc.h>
 #include <linux/bcd.h>
 
-#include <asm/time.h>
 #include <asm/rtc.h>
 
 #define DS1374_REG_TOD0		0x00
@@ -54,11 +53,8 @@ static unsigned short normal_addr[] = { 
 
 static struct i2c_client_address_data addr_data = {
 	.normal_i2c = normal_addr,
-	.normal_i2c_range = ignore,
 	.probe = ignore,
-	.probe_range = ignore,
 	.ignore = ignore,
-	.ignore_range = ignore,
 	.force = ignore,
 };
 

