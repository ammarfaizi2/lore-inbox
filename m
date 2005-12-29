Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964951AbVL2Bow@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964951AbVL2Bow (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Dec 2005 20:44:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964953AbVL2Bow
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Dec 2005 20:44:52 -0500
Received: from smtp102.sbc.mail.re2.yahoo.com ([68.142.229.103]:44905 "HELO
	smtp102.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S964951AbVL2Bow (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Dec 2005 20:44:52 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH for 2.6.15] Input: aiptek - fix Y axis setup
Date: Wed, 28 Dec 2005 20:44:48 -0500
User-Agent: KMail/1.9.1
Cc: "LKML, " <linux-kernel@vger.kernel.org>,
       Riccardo Magliocchetti <riccardo@datahost.it>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512282044.48328.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Riccardo Magliocchetti <riccardo@datahost.it>

This patch fixes a typo introduced by conversion to dynamic input_dev
allocation.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/usb/input/aiptek.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

Index: work/drivers/usb/input/aiptek.c
===================================================================
--- work.orig/drivers/usb/input/aiptek.c
+++ work/drivers/usb/input/aiptek.c
@@ -2103,7 +2103,7 @@ aiptek_probe(struct usb_interface *intf,
 	 * values.
 	 */
 	input_set_abs_params(inputdev, ABS_X, 0, 2999, 0, 0);
-	input_set_abs_params(inputdev, ABS_X, 0, 2249, 0, 0);
+	input_set_abs_params(inputdev, ABS_Y, 0, 2249, 0, 0);
 	input_set_abs_params(inputdev, ABS_PRESSURE, 0, 511, 0, 0);
 	input_set_abs_params(inputdev, ABS_TILT_X, AIPTEK_TILT_MIN, AIPTEK_TILT_MAX, 0, 0);
 	input_set_abs_params(inputdev, ABS_TILT_Y, AIPTEK_TILT_MIN, AIPTEK_TILT_MAX, 0, 0);
