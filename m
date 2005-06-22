Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262789AbVFVG5I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262789AbVFVG5I (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 02:57:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262822AbVFVGyx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 02:54:53 -0400
Received: from mail.kroah.org ([69.55.234.183]:13468 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262785AbVFVFV6 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 01:21:58 -0400
Cc: dominik@hackl.dhs.org
Subject: [PATCH] I2C: include of jiffies.h for some i2c drivers
In-Reply-To: <11194174641411@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Tue, 21 Jun 2005 22:17:45 -0700
Message-Id: <1119417464710@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] I2C: include of jiffies.h for some i2c drivers

This patch includes jiffies.h in two i2c drivers.
(jiffies.h is needed for the time_after function.)

Signed-off-by: Dominik Hackl <dominik@hackl.dhs.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit ff3240946d6a3d9f2ecf273f7330e09eec5484eb
tree 2bb70f76eb190a9301a7f30f264306f82363c12a
parent 8e8f9289cc5b781d583d5aed935abf060207bbd3
author Dominik Hackl <dominik@hackl.dhs.org> Mon, 16 May 2005 18:12:18 +0200
committer Greg Kroah-Hartman <gregkh@suse.de> Tue, 21 Jun 2005 21:51:57 -0700

 drivers/i2c/chips/asb100.c  |    1 +
 drivers/i2c/chips/sis5595.c |    1 +
 2 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/i2c/chips/asb100.c b/drivers/i2c/chips/asb100.c
--- a/drivers/i2c/chips/asb100.c
+++ b/drivers/i2c/chips/asb100.c
@@ -42,6 +42,7 @@
 #include <linux/i2c-sensor.h>
 #include <linux/i2c-vid.h>
 #include <linux/init.h>
+#include <linux/jiffies.h>
 #include "lm75.h"
 
 /*
diff --git a/drivers/i2c/chips/sis5595.c b/drivers/i2c/chips/sis5595.c
--- a/drivers/i2c/chips/sis5595.c
+++ b/drivers/i2c/chips/sis5595.c
@@ -57,6 +57,7 @@
 #include <linux/i2c.h>
 #include <linux/i2c-sensor.h>
 #include <linux/init.h>
+#include <linux/jiffies.h>
 #include <asm/io.h>
 
 

