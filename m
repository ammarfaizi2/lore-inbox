Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964965AbWANQBg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964965AbWANQBg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jan 2006 11:01:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932307AbWANQBS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jan 2006 11:01:18 -0500
Received: from smtp105.sbc.mail.re2.yahoo.com ([68.142.229.100]:9916 "HELO
	smtp105.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S932322AbWANQBK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jan 2006 11:01:10 -0500
Message-Id: <20060114154833.114845000.dtor_core@ameritech.net>
References: <20060114151645.035957000.dtor_core@ameritech.net>
Date: Sat, 14 Jan 2006 10:16:50 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Linus Torvalds <torvalds@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Vojtech Pavlik <vojtech@suse.cz>
Subject: [git pull 5/7] HID: add more simulation usages
Content-Disposition: inline; filename=hid-more-simulation-usages.patch
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Input: HID - add more simulation usages

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/usb/input/hid-input.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletion(-)

Index: work/drivers/usb/input/hid-input.c
===================================================================
--- work.orig/drivers/usb/input/hid-input.c
+++ work/drivers/usb/input/hid-input.c
@@ -135,8 +135,11 @@ static void hidinput_configure_usage(str
 		case HID_UP_SIMULATION:
 
 			switch (usage->hid & 0xffff) {
-				case 0xba: map_abs(ABS_RUDDER); break;
+				case 0xba: map_abs(ABS_RUDDER);   break;
 				case 0xbb: map_abs(ABS_THROTTLE); break;
+				case 0xc4: map_abs(ABS_GAS);      break;
+				case 0xc5: map_abs(ABS_BRAKE);    break;
+				case 0xc8: map_abs(ABS_WHEEL);    break;
 				default:   goto ignore;
 			}
 			break;

