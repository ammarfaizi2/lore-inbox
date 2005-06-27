Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262037AbVF0OcX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262037AbVF0OcX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 10:32:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262117AbVF0Nbj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 09:31:39 -0400
Received: from ipx10786.ipxserver.de ([80.190.251.108]:24549 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S262075AbVF0MQu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 08:16:50 -0400
Message-Id: <20050627121419.201856000@abc>
References: <20050627120600.739151000@abc>
Date: Mon, 27 Jun 2005 14:06:48 +0200
From: Johannes Stezenbach <js@linuxtv.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Michael Paxton <packo@tpg.com.au>,
       Patrick Boettcher <pb@linuxtv.org>
Content-Disposition: inline; filename=dvb-usb-twinhan-vp7045-rc.patch
X-SA-Exim-Connect-IP: 84.189.248.249
Subject: [DVB patch 48/51] usb: add vp7045 IR keymap
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Patrick Boettcher <pb@linuxtv.org>

Add keymap for Twinhan vp7045 remote control.

Signed-off-by: Michael Paxton <packo@tpg.com.au>
Signed-off-by: Patrick Boettcher <pb@linuxtv.org>
Signed-off-by: Johannes Stezenbach <js@linuxtv.org>

 Documentation/dvb/README.dvb-usb   |    4 ++-
 drivers/media/dvb/dvb-usb/vp7045.c |   39 ++++++++++++++++++++++++++++++-------
 2 files changed, 35 insertions(+), 8 deletions(-)

Index: linux-2.6.12-git8/Documentation/dvb/README.dvb-usb
===================================================================
--- linux-2.6.12-git8.orig/Documentation/dvb/README.dvb-usb	2005-06-27 13:26:18.000000000 +0200
+++ linux-2.6.12-git8/Documentation/dvb/README.dvb-usb	2005-06-27 13:27:07.000000000 +0200
@@ -226,7 +226,9 @@ Patches, comments and suggestions are ve
    Jennifer Chen, Jeff and Jack from Twinhan for kindly supporting by
 	writing the vp7045-driver.
 
-   Some guys on the linux-dvb mailing list for encouraging me
+   Michael Paxton for submitting remote control keymaps.
+
+   Some guys on the linux-dvb mailing list for encouraging me.
 
    Peter Schildmann >peter.schildmann-nospam-at-web.de< for his
     user-level firmware loader, which saves a lot of time
Index: linux-2.6.12-git8/drivers/media/dvb/dvb-usb/vp7045.c
===================================================================
--- linux-2.6.12-git8.orig/drivers/media/dvb/dvb-usb/vp7045.c	2005-06-27 13:18:22.000000000 +0200
+++ linux-2.6.12-git8/drivers/media/dvb/dvb-usb/vp7045.c	2005-06-27 13:27:07.000000000 +0200
@@ -94,13 +94,38 @@ static int vp7045_power_ctrl(struct dvb_
 /* The keymapping struct. Somehow this should be loaded to the driver, but
  * currently it is hardcoded. */
 static struct dvb_usb_rc_key vp7045_rc_keys[] = {
-	/* insert the keys like this. to make the raw keys visible, enable
-	 * debug=0x04 when loading dvb-usb-vp7045. */
-
-	/* these keys are probably wrong. I don't have a working IR-receiver on my
-	 * vp7045, so I can't test it.  Patches are welcome. */
-	{ 0x00, 0x01, KEY_1 },
-	{ 0x00, 0x02, KEY_2 },
+	{ 0x00, 0x16, KEY_POWER },
+	{ 0x00, 0x10, KEY_MUTE },
+	{ 0x00, 0x03, KEY_1 },
+	{ 0x00, 0x01, KEY_2 },
+	{ 0x00, 0x06, KEY_3 },
+	{ 0x00, 0x09, KEY_4 },
+	{ 0x00, 0x1d, KEY_5 },
+	{ 0x00, 0x1f, KEY_6 },
+	{ 0x00, 0x0d, KEY_7 },
+	{ 0x00, 0x19, KEY_8 },
+	{ 0x00, 0x1b, KEY_9 },
+	{ 0x00, 0x15, KEY_0 },
+	{ 0x00, 0x05, KEY_CHANNELUP },
+	{ 0x00, 0x02, KEY_CHANNELDOWN },
+	{ 0x00, 0x1e, KEY_VOLUMEUP },
+	{ 0x00, 0x0a, KEY_VOLUMEDOWN },
+	{ 0x00, 0x11, KEY_RECORD },
+	{ 0x00, 0x17, KEY_FAVORITES }, /* Heart symbol - Channel list. */
+	{ 0x00, 0x14, KEY_PLAY },
+	{ 0x00, 0x1a, KEY_STOP },
+	{ 0x00, 0x40, KEY_REWIND },
+	{ 0x00, 0x12, KEY_FASTFORWARD },
+	{ 0x00, 0x0e, KEY_PREVIOUS }, /* Recall - Previous channel. */
+	{ 0x00, 0x4c, KEY_PAUSE },
+	{ 0x00, 0x4d, KEY_SCREEN }, /* Full screen mode. */
+	{ 0x00, 0x54, KEY_AUDIO }, /* MTS - Switch to secondary audio. */
+	{ 0x00, 0xa1, KEY_CANCEL }, /* Cancel */
+	{ 0x00, 0x1c, KEY_EPG }, /* EPG */
+	{ 0x00, 0x40, KEY_TAB }, /* Tab */
+	{ 0x00, 0x48, KEY_INFO }, /* Preview */
+	{ 0x00, 0x04, KEY_LIST }, /* RecordList */
+	{ 0x00, 0x0f, KEY_TEXT } /* Teletext */
 };
 
 static int vp7045_rc_query(struct dvb_usb_device *d, u32 *key_buf, int *state)

--

