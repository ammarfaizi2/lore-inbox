Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750706AbWHKHuv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750706AbWHKHuv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Aug 2006 03:50:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750753AbWHKHuv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Aug 2006 03:50:51 -0400
Received: from crystal.sipsolutions.net ([195.210.38.204]:15588 "EHLO
	sipsolutions.net") by vger.kernel.org with ESMTP id S1750706AbWHKHuv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Aug 2006 03:50:51 -0400
Message-ID: <44DC36CA.4010908@sipsolutions.net>
Date: Fri, 11 Aug 2006 09:50:34 +0200
From: Johannes Berg <johannes@sipsolutions.net>
User-Agent: Thunderbird 1.5.0.5 (Windows/20060719)
MIME-Version: 1.0
To: Linux Kernel list <linux-kernel@vger.kernel.org>
CC: rpurdie@rpsys.net
Subject: [PATCH] make leds.h include relevant headers
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-sips-origin: submit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's something I noticed recently when writing a small led trigger...
Richard, does this look OK to you? If so, can you send it on? I don't
know through what path these things should go in.
Hopefully thunderbird doesn't mangle it...

---

This patch makes it possible to include linux/leds.h without first
including list.h and spinlock.h.


Signed-off-by: Johannes Berg <johannes@sipsolutions.net>

--- wireless-dev.orig/include/linux/leds.h	2006-08-10 19:59:13.419652863 +0200
+++ wireless-dev/include/linux/leds.h	2006-08-10 20:02:14.979652863 +0200
@@ -12,6 +12,9 @@
 #ifndef __LINUX_LEDS_H_INCLUDED
 #define __LINUX_LEDS_H_INCLUDED
 
+#include <linux/list.h>
+#include <linux/spinlock.h>
+
 struct device;
 struct class_device;
 /*


