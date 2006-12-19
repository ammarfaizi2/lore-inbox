Return-Path: <linux-kernel-owner+w=401wt.eu-S1753153AbWLSQAd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753153AbWLSQAd (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 11:00:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753172AbWLSQAd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 11:00:33 -0500
Received: from mx0.karneval.cz ([81.27.192.122]:22863 "EHLO av2.karneval.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753153AbWLSQAc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 11:00:32 -0500
Message-id: <1943417861372732424@fi.muni.cz>
Subject: [PATCH 1/1] Char: hid-ff, support yet another wheel
From: Jiri Slaby <jirislaby@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>
Cc: <vojtech@suse.cz>
Cc: <linux-usb-devel@lists.sourceforge.net>
Cc: <johann.deneux@it.uu.se>
Cc: <anssi.hannula@gmail.com>
Date: Tue, 19 Dec 2006 17:00:18 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hid-ff, support yet another wheel

Add support for Logitech Momo racing wheel (046d:ca03) to hid force
feedback.

Signed-off-by: Jiri Slaby <jirislaby@gmail.com>

---
commit c23d599ef1a68c7609c5e437a2cff834c29b8b54
tree a10a3ab34129749abf1bb57ec266cb1dc58d1ef5
parent ab95fdae2db7f8fded639796814079441f04a3e2
author Jiri Slaby <jirislaby@gmail.com> Tue, 19 Dec 2006 16:52:17 +0100
committer Jiri Slaby <jirislaby@gmail.com> Tue, 19 Dec 2006 16:52:17 +0100

 drivers/usb/input/hid-ff.c   |    1 +
 drivers/usb/input/hid-lgff.c |    1 +
 2 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/usb/input/hid-ff.c b/drivers/usb/input/hid-ff.c
index f8f660e..d8d02b4 100644
--- a/drivers/usb/input/hid-ff.c
+++ b/drivers/usb/input/hid-ff.c
@@ -56,6 +56,7 @@ static struct hid_ff_initializer inits[] = {
 	{ 0x46d, 0xc283, hid_lgff_init }, /* Logitech Wingman Force 3d */
 	{ 0x46d, 0xc295, hid_lgff_init }, /* Logitech MOMO force wheel */
 	{ 0x46d, 0xc219, hid_lgff_init }, /* Logitech Cordless rumble pad 2 */
+	{ 0x46d, 0xca03, hid_lgff_init }, /* Logitech MOMO force wheel */
 #endif
 #ifdef CONFIG_THRUSTMASTER_FF
 	{ 0x44f, 0xb304, hid_tmff_init },
diff --git a/drivers/usb/input/hid-lgff.c b/drivers/usb/input/hid-lgff.c
index e474662..645b0d2 100644
--- a/drivers/usb/input/hid-lgff.c
+++ b/drivers/usb/input/hid-lgff.c
@@ -52,6 +52,7 @@ static const struct device_type devices[] = {
 	{ 0x046d, 0xc211, ff_rumble },
 	{ 0x046d, 0xc219, ff_rumble },
 	{ 0x046d, 0xc283, ff_joystick },
+	{ 0x046d, 0xca03, ff_joystick },
 	{ 0x0000, 0x0000, ff_joystick }
 };
 
