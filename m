Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262762AbVFVFhs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262762AbVFVFhs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 01:37:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262828AbVFVFg6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 01:36:58 -0400
Received: from mail.kroah.org ([69.55.234.183]:57756 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262823AbVFVFWV convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 01:22:21 -0400
Cc: akpm@osdl.org
Subject: [PATCH] I2C: fix ds1374 build
In-Reply-To: <11194174683171@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Tue, 21 Jun 2005 22:17:48 -0700
Message-Id: <11194174684006@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] I2C: fix ds1374 build

Not all architectures implement asm/rtc.h

Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 0087e5ef577d0d6e664be7ab4be513b6a482e7ec
tree deeb3f4a6aca34359e20d926bc28165f1f3e84f0
parent 7c7a530463ced6011789937b24dc2bfba43c706b
author Andrew Morton <akpm@osdl.org> Mon, 20 Jun 2005 14:25:45 -0700
committer Greg Kroah-Hartman <gregkh@suse.de> Tue, 21 Jun 2005 21:55:00 -0700

 drivers/i2c/chips/ds1374.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/chips/ds1374.c b/drivers/i2c/chips/ds1374.c
--- a/drivers/i2c/chips/ds1374.c
+++ b/drivers/i2c/chips/ds1374.c
@@ -27,8 +27,6 @@
 #include <linux/rtc.h>
 #include <linux/bcd.h>
 
-#include <asm/rtc.h>
-
 #define DS1374_REG_TOD0		0x00
 #define DS1374_REG_TOD1		0x01
 #define DS1374_REG_TOD2		0x02

