Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263189AbTH0G5W (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Aug 2003 02:57:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263196AbTH0G5W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Aug 2003 02:57:22 -0400
Received: from smtp802.mail.sc5.yahoo.com ([66.163.168.181]:51385 "HELO
	smtp802.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S263189AbTH0G5V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Aug 2003 02:57:21 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 2.6] evdev_ioctl does not report EV_MSC capabilities
Date: Wed, 27 Aug 2003 01:57:16 -0500
User-Agent: KMail/1.5.1
Cc: Vojtech Pavlik <vojtech@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308270157.18075.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

While working on my GPM patches found out that EV_MSC was forgotten...

Dmitry

--- linux-2.6.0-test4/drivers/input/evdev.c.orig	2003-08-26 10:25:48.000000000 -0500
+++ linux-2.6.0-test4/drivers/input/evdev.c	2003-08-26 10:27:38.000000000 -0500
@@ -305,6 +305,7 @@
 					case EV_KEY: bits = dev->keybit; len = KEY_MAX; break;
 					case EV_REL: bits = dev->relbit; len = REL_MAX; break;
 					case EV_ABS: bits = dev->absbit; len = ABS_MAX; break;
+					case EV_MSC: bits = dev->mscbit; len = MSC_MAX; break;
 					case EV_LED: bits = dev->ledbit; len = LED_MAX; break;
 					case EV_SND: bits = dev->sndbit; len = SND_MAX; break;
 					case EV_FF:  bits = dev->ffbit;  len = FF_MAX;  break;
