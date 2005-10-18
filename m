Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751445AbVJRGvu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751445AbVJRGvu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Oct 2005 02:51:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751446AbVJRGvt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Oct 2005 02:51:49 -0400
Received: from smtp101.sbc.mail.re2.yahoo.com ([68.142.229.104]:32404 "HELO
	smtp101.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1751445AbVJRGvt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Oct 2005 02:51:49 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Vojtech Pavlik <vojtech@suse.cz>
Subject: [PATCH] Input: evdev - allow querying EV_SW from compat_ioctl
Date: Tue, 18 Oct 2005 01:51:46 -0500
User-Agent: KMail/1.8.2
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510180151.47195.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Input: evdev - allow querying EV_SW bits from compat_ioctl

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/input/evdev.c |    1 +
 1 files changed, 1 insertion(+)

Index: work/drivers/input/evdev.c
===================================================================
--- work.orig/drivers/input/evdev.c
+++ work/drivers/input/evdev.c
@@ -566,6 +566,7 @@ static long evdev_ioctl_compat(struct fi
 						case EV_LED: bits = dev->ledbit; max = LED_MAX; break;
 						case EV_SND: bits = dev->sndbit; max = SND_MAX; break;
 						case EV_FF:  bits = dev->ffbit;  max = FF_MAX;  break;
+						case EV_SW:  bits = dev->swbit;  max = SW_MAX;  break;
 						default: return -EINVAL;
 					}
 					bit_to_user(bits, max);
