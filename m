Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261284AbVAaRhK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261284AbVAaRhK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 12:37:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261286AbVAaRhK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 12:37:10 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:52235 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261284AbVAaRfO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 12:35:14 -0500
Date: Mon, 31 Jan 2005 18:35:08 +0100
From: Adrian Bunk <bunk@stusta.de>
To: stelian@popies.net
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/char/sonypi.c: make 3 structs static
Message-ID: <20050131173508.GS18316@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes three needlessly global structs static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/char/sonypi.c |   76 +++++++++++++++++++++++++++++++++++++++++-
 drivers/char/sonypi.h |   74 ----------------------------------------
 2 files changed, 75 insertions(+), 75 deletions(-)

--- linux-2.6.11-rc2-mm2-full/drivers/char/sonypi.h.old	2005-01-31 15:34:19.000000000 +0100
+++ linux-2.6.11-rc2-mm2-full/drivers/char/sonypi.h	2005-01-31 15:37:10.000000000 +0100
@@ -304,86 +304,12 @@
 	{ 0, 0 }
 };
 
-struct sonypi_eventtypes {
-	int			model;
-	u8			data;
-	unsigned long		mask;
-	struct sonypi_event *	events;
-} sonypi_eventtypes[] = {
-	{ SONYPI_DEVICE_MODEL_TYPE1, 0, 0xffffffff, sonypi_releaseev },
-	{ SONYPI_DEVICE_MODEL_TYPE1, 0x70, SONYPI_MEYE_MASK, sonypi_meyeev },
-	{ SONYPI_DEVICE_MODEL_TYPE1, 0x30, SONYPI_LID_MASK, sonypi_lidev },
-	{ SONYPI_DEVICE_MODEL_TYPE1, 0x60, SONYPI_CAPTURE_MASK, sonypi_captureev },
-	{ SONYPI_DEVICE_MODEL_TYPE1, 0x10, SONYPI_JOGGER_MASK, sonypi_joggerev },
-	{ SONYPI_DEVICE_MODEL_TYPE1, 0x20, SONYPI_FNKEY_MASK, sonypi_fnkeyev },
-	{ SONYPI_DEVICE_MODEL_TYPE1, 0x30, SONYPI_BLUETOOTH_MASK, sonypi_blueev },
-	{ SONYPI_DEVICE_MODEL_TYPE1, 0x40, SONYPI_PKEY_MASK, sonypi_pkeyev },
-	{ SONYPI_DEVICE_MODEL_TYPE1, 0x30, SONYPI_MEMORYSTICK_MASK, sonypi_memorystickev },
-	{ SONYPI_DEVICE_MODEL_TYPE1, 0x40, SONYPI_BATTERY_MASK, sonypi_batteryev },
-
-	{ SONYPI_DEVICE_MODEL_TYPE2, 0, 0xffffffff, sonypi_releaseev },
-	{ SONYPI_DEVICE_MODEL_TYPE2, 0x38, SONYPI_LID_MASK, sonypi_lidev },
-	{ SONYPI_DEVICE_MODEL_TYPE2, 0x11, SONYPI_JOGGER_MASK, sonypi_joggerev },
-	{ SONYPI_DEVICE_MODEL_TYPE2, 0x61, SONYPI_CAPTURE_MASK, sonypi_captureev },
-	{ SONYPI_DEVICE_MODEL_TYPE2, 0x21, SONYPI_FNKEY_MASK, sonypi_fnkeyev },
-	{ SONYPI_DEVICE_MODEL_TYPE2, 0x31, SONYPI_BLUETOOTH_MASK, sonypi_blueev },
-	{ SONYPI_DEVICE_MODEL_TYPE2, 0x08, SONYPI_PKEY_MASK, sonypi_pkeyev },
-	{ SONYPI_DEVICE_MODEL_TYPE2, 0x11, SONYPI_BACK_MASK, sonypi_backev },
-	{ SONYPI_DEVICE_MODEL_TYPE2, 0x08, SONYPI_HELP_MASK, sonypi_helpev },
-	{ SONYPI_DEVICE_MODEL_TYPE2, 0x21, SONYPI_ZOOM_MASK, sonypi_zoomev },
-	{ SONYPI_DEVICE_MODEL_TYPE2, 0x20, SONYPI_THUMBPHRASE_MASK, sonypi_thumbphraseev },
-	{ SONYPI_DEVICE_MODEL_TYPE2, 0x31, SONYPI_MEMORYSTICK_MASK, sonypi_memorystickev },
-	{ SONYPI_DEVICE_MODEL_TYPE2, 0x41, SONYPI_BATTERY_MASK, sonypi_batteryev },
-	{ SONYPI_DEVICE_MODEL_TYPE2, 0x31, SONYPI_PKEY_MASK, sonypi_pkeyev },
-
-	{ 0 }
-};
-
 #define SONYPI_BUF_SIZE	128
 
 /* The name of the devices for the input device drivers */
 #define SONYPI_JOG_INPUTNAME	"Sony Vaio Jogdial"
 #define SONYPI_KEY_INPUTNAME	"Sony Vaio Keys"
 
-/* Correspondance table between sonypi events and input layer events */
-struct {
-	int sonypiev;
-	int inputev;
-} sonypi_inputkeys[] = {
-	{ SONYPI_EVENT_CAPTURE_PRESSED,	 	KEY_CAMERA },
-	{ SONYPI_EVENT_FNKEY_ONLY, 		KEY_FN },
-	{ SONYPI_EVENT_FNKEY_ESC, 		KEY_FN_ESC },
-	{ SONYPI_EVENT_FNKEY_F1, 		KEY_FN_F1 },
-	{ SONYPI_EVENT_FNKEY_F2, 		KEY_FN_F2 },
-	{ SONYPI_EVENT_FNKEY_F3, 		KEY_FN_F3 },
-	{ SONYPI_EVENT_FNKEY_F4, 		KEY_FN_F4 },
-	{ SONYPI_EVENT_FNKEY_F5, 		KEY_FN_F5 },
-	{ SONYPI_EVENT_FNKEY_F6, 		KEY_FN_F6 },
-	{ SONYPI_EVENT_FNKEY_F7, 		KEY_FN_F7 },
-	{ SONYPI_EVENT_FNKEY_F8, 		KEY_FN_F8 },
-	{ SONYPI_EVENT_FNKEY_F9,		KEY_FN_F9 },
-	{ SONYPI_EVENT_FNKEY_F10,		KEY_FN_F10 },
-	{ SONYPI_EVENT_FNKEY_F11, 		KEY_FN_F11 },
-	{ SONYPI_EVENT_FNKEY_F12,		KEY_FN_F12 },
-	{ SONYPI_EVENT_FNKEY_1, 		KEY_FN_1 },
-	{ SONYPI_EVENT_FNKEY_2, 		KEY_FN_2 },
-	{ SONYPI_EVENT_FNKEY_D,			KEY_FN_D },
-	{ SONYPI_EVENT_FNKEY_E,			KEY_FN_E },
-	{ SONYPI_EVENT_FNKEY_F,			KEY_FN_F },
-	{ SONYPI_EVENT_FNKEY_S,			KEY_FN_S },
-	{ SONYPI_EVENT_FNKEY_B,			KEY_FN_B },
-	{ SONYPI_EVENT_BLUETOOTH_PRESSED, 	KEY_BLUE },
-	{ SONYPI_EVENT_BLUETOOTH_ON, 		KEY_BLUE },
-	{ SONYPI_EVENT_PKEY_P1, 		KEY_PROG1 },
-	{ SONYPI_EVENT_PKEY_P2, 		KEY_PROG2 },
-	{ SONYPI_EVENT_PKEY_P3, 		KEY_PROG3 },
-	{ SONYPI_EVENT_BACK_PRESSED, 		KEY_BACK },
-	{ SONYPI_EVENT_HELP_PRESSED, 		KEY_HELP },
-	{ SONYPI_EVENT_ZOOM_PRESSED, 		KEY_ZOOM },
-	{ SONYPI_EVENT_THUMBPHRASE_PRESSED, 	BTN_THUMB },
-	{ 0, 0 },
-};
-
 struct sonypi_device {
 	struct pci_dev *dev;
 	struct platform_device *pdev;
--- linux-2.6.11-rc2-mm2-full/drivers/char/sonypi.c.old	2005-01-31 15:34:30.000000000 +0100
+++ linux-2.6.11-rc2-mm2-full/drivers/char/sonypi.c	2005-01-31 15:37:35.000000000 +0100
@@ -53,6 +53,80 @@
 #include "sonypi.h"
 #include <linux/sonypi.h>
 
+static struct sonypi_eventtypes {
+	int			model;
+	u8			data;
+	unsigned long		mask;
+	struct sonypi_event *	events;
+} sonypi_eventtypes[] = {
+	{ SONYPI_DEVICE_MODEL_TYPE1, 0, 0xffffffff, sonypi_releaseev },
+	{ SONYPI_DEVICE_MODEL_TYPE1, 0x70, SONYPI_MEYE_MASK, sonypi_meyeev },
+	{ SONYPI_DEVICE_MODEL_TYPE1, 0x30, SONYPI_LID_MASK, sonypi_lidev },
+	{ SONYPI_DEVICE_MODEL_TYPE1, 0x60, SONYPI_CAPTURE_MASK, sonypi_captureev },
+	{ SONYPI_DEVICE_MODEL_TYPE1, 0x10, SONYPI_JOGGER_MASK, sonypi_joggerev },
+	{ SONYPI_DEVICE_MODEL_TYPE1, 0x20, SONYPI_FNKEY_MASK, sonypi_fnkeyev },
+	{ SONYPI_DEVICE_MODEL_TYPE1, 0x30, SONYPI_BLUETOOTH_MASK, sonypi_blueev },
+	{ SONYPI_DEVICE_MODEL_TYPE1, 0x40, SONYPI_PKEY_MASK, sonypi_pkeyev },
+	{ SONYPI_DEVICE_MODEL_TYPE1, 0x30, SONYPI_MEMORYSTICK_MASK, sonypi_memorystickev },
+	{ SONYPI_DEVICE_MODEL_TYPE1, 0x40, SONYPI_BATTERY_MASK, sonypi_batteryev },
+
+	{ SONYPI_DEVICE_MODEL_TYPE2, 0, 0xffffffff, sonypi_releaseev },
+	{ SONYPI_DEVICE_MODEL_TYPE2, 0x38, SONYPI_LID_MASK, sonypi_lidev },
+	{ SONYPI_DEVICE_MODEL_TYPE2, 0x11, SONYPI_JOGGER_MASK, sonypi_joggerev },
+	{ SONYPI_DEVICE_MODEL_TYPE2, 0x61, SONYPI_CAPTURE_MASK, sonypi_captureev },
+	{ SONYPI_DEVICE_MODEL_TYPE2, 0x21, SONYPI_FNKEY_MASK, sonypi_fnkeyev },
+	{ SONYPI_DEVICE_MODEL_TYPE2, 0x31, SONYPI_BLUETOOTH_MASK, sonypi_blueev },
+	{ SONYPI_DEVICE_MODEL_TYPE2, 0x08, SONYPI_PKEY_MASK, sonypi_pkeyev },
+	{ SONYPI_DEVICE_MODEL_TYPE2, 0x11, SONYPI_BACK_MASK, sonypi_backev },
+	{ SONYPI_DEVICE_MODEL_TYPE2, 0x08, SONYPI_HELP_MASK, sonypi_helpev },
+	{ SONYPI_DEVICE_MODEL_TYPE2, 0x21, SONYPI_ZOOM_MASK, sonypi_zoomev },
+	{ SONYPI_DEVICE_MODEL_TYPE2, 0x20, SONYPI_THUMBPHRASE_MASK, sonypi_thumbphraseev },
+	{ SONYPI_DEVICE_MODEL_TYPE2, 0x31, SONYPI_MEMORYSTICK_MASK, sonypi_memorystickev },
+	{ SONYPI_DEVICE_MODEL_TYPE2, 0x41, SONYPI_BATTERY_MASK, sonypi_batteryev },
+	{ SONYPI_DEVICE_MODEL_TYPE2, 0x31, SONYPI_PKEY_MASK, sonypi_pkeyev },
+
+	{ 0 }
+};
+
+/* Correspondance table between sonypi events and input layer events */
+static struct {
+	int sonypiev;
+	int inputev;
+} sonypi_inputkeys[] = {
+	{ SONYPI_EVENT_CAPTURE_PRESSED,	 	KEY_CAMERA },
+	{ SONYPI_EVENT_FNKEY_ONLY, 		KEY_FN },
+	{ SONYPI_EVENT_FNKEY_ESC, 		KEY_FN_ESC },
+	{ SONYPI_EVENT_FNKEY_F1, 		KEY_FN_F1 },
+	{ SONYPI_EVENT_FNKEY_F2, 		KEY_FN_F2 },
+	{ SONYPI_EVENT_FNKEY_F3, 		KEY_FN_F3 },
+	{ SONYPI_EVENT_FNKEY_F4, 		KEY_FN_F4 },
+	{ SONYPI_EVENT_FNKEY_F5, 		KEY_FN_F5 },
+	{ SONYPI_EVENT_FNKEY_F6, 		KEY_FN_F6 },
+	{ SONYPI_EVENT_FNKEY_F7, 		KEY_FN_F7 },
+	{ SONYPI_EVENT_FNKEY_F8, 		KEY_FN_F8 },
+	{ SONYPI_EVENT_FNKEY_F9,		KEY_FN_F9 },
+	{ SONYPI_EVENT_FNKEY_F10,		KEY_FN_F10 },
+	{ SONYPI_EVENT_FNKEY_F11, 		KEY_FN_F11 },
+	{ SONYPI_EVENT_FNKEY_F12,		KEY_FN_F12 },
+	{ SONYPI_EVENT_FNKEY_1, 		KEY_FN_1 },
+	{ SONYPI_EVENT_FNKEY_2, 		KEY_FN_2 },
+	{ SONYPI_EVENT_FNKEY_D,			KEY_FN_D },
+	{ SONYPI_EVENT_FNKEY_E,			KEY_FN_E },
+	{ SONYPI_EVENT_FNKEY_F,			KEY_FN_F },
+	{ SONYPI_EVENT_FNKEY_S,			KEY_FN_S },
+	{ SONYPI_EVENT_FNKEY_B,			KEY_FN_B },
+	{ SONYPI_EVENT_BLUETOOTH_PRESSED, 	KEY_BLUE },
+	{ SONYPI_EVENT_BLUETOOTH_ON, 		KEY_BLUE },
+	{ SONYPI_EVENT_PKEY_P1, 		KEY_PROG1 },
+	{ SONYPI_EVENT_PKEY_P2, 		KEY_PROG2 },
+	{ SONYPI_EVENT_PKEY_P3, 		KEY_PROG3 },
+	{ SONYPI_EVENT_BACK_PRESSED, 		KEY_BACK },
+	{ SONYPI_EVENT_HELP_PRESSED, 		KEY_HELP },
+	{ SONYPI_EVENT_ZOOM_PRESSED, 		KEY_ZOOM },
+	{ SONYPI_EVENT_THUMBPHRASE_PRESSED, 	BTN_THUMB },
+	{ 0, 0 },
+};
+
 MODULE_AUTHOR("Stelian Pop <stelian@popies.net>");
 MODULE_DESCRIPTION("Sony Programmable I/O Control Device driver");
 MODULE_LICENSE("GPL");
@@ -648,7 +722,7 @@
 	.ioctl		= sonypi_misc_ioctl,
 };
 
-struct miscdevice sonypi_misc_device = {
+static struct miscdevice sonypi_misc_device = {
 	.minor		= -1,
 	.name		= "sonypi",
 	.fops		= &sonypi_misc_fops,

