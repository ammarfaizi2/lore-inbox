Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750735AbVKTGrf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750735AbVKTGrf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Nov 2005 01:47:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750756AbVKTGrS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Nov 2005 01:47:18 -0500
Received: from smtp112.sbc.mail.re2.yahoo.com ([68.142.229.93]:44986 "HELO
	smtp112.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1750735AbVKTGrM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Nov 2005 01:47:12 -0500
Message-Id: <20051120064420.389911000.dtor_core@ameritech.net>
References: <20051120063611.269343000.dtor_core@ameritech.net>
Date: Sun, 20 Nov 2005 01:36:20 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Vojtech Pavlik <vojtech@suse.cz>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [git pull 09/14] Uinput: add UI_SET_SWBIT ioctl
Content-Disposition: inline; filename=uinput-add-sw-ioctl.patch
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Input: uinput - add UI_SET_SWBIT ioctl

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/input/misc/uinput.c |    4 ++++
 include/linux/uinput.h      |    1 +
 2 files changed, 5 insertions(+)

Index: work/drivers/input/misc/uinput.c
===================================================================
--- work.orig/drivers/input/misc/uinput.c
+++ work/drivers/input/misc/uinput.c
@@ -495,6 +495,10 @@ static long uinput_ioctl(struct file *fi
 			retval = uinput_set_bit(arg, ffbit, FF_MAX);
 			break;
 
+		case UI_SET_SWBIT:
+			retval = uinput_set_bit(arg, swbit, SW_MAX);
+			break;
+
 		case UI_SET_PHYS:
 			if (udev->state == UIST_CREATED) {
 				retval = -EINVAL;
Index: work/include/linux/uinput.h
===================================================================
--- work.orig/include/linux/uinput.h
+++ work/include/linux/uinput.h
@@ -91,6 +91,7 @@ struct uinput_ff_erase {
 #define UI_SET_SNDBIT		_IOW(UINPUT_IOCTL_BASE, 106, int)
 #define UI_SET_FFBIT		_IOW(UINPUT_IOCTL_BASE, 107, int)
 #define UI_SET_PHYS		_IOW(UINPUT_IOCTL_BASE, 108, char*)
+#define UI_SET_SWBIT		_IOW(UINPUT_IOCTL_BASE, 109, int)
 
 #define UI_BEGIN_FF_UPLOAD	_IOWR(UINPUT_IOCTL_BASE, 200, struct uinput_ff_upload)
 #define UI_END_FF_UPLOAD	_IOW(UINPUT_IOCTL_BASE, 201, struct uinput_ff_upload)

