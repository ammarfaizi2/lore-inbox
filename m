Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750837AbWANTzH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750837AbWANTzH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jan 2006 14:55:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750843AbWANTzH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jan 2006 14:55:07 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:9 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750837AbWANTzG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jan 2006 14:55:06 -0500
Date: Sat, 14 Jan 2006 20:55:05 +0100
From: Adrian Bunk <bunk@stusta.de>
To: mchehab@brturbo.com.br
Cc: video4linux-list@redhat.com, linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/media/video/: make some code static
Message-ID: <20060114195504.GP29663@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes some needlessly global code static.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/media/video/cx25840/cx25840-core.c |    2 +-
 drivers/media/video/cx88/cx88-alsa.c       |    6 +++---
 drivers/media/video/tvp5150.c              |    2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

--- linux-2.6.15-mm4-full/drivers/media/video/cx25840/cx25840-core.c.old	2006-01-14 17:56:39.000000000 +0100
+++ linux-2.6.15-mm4-full/drivers/media/video/cx25840/cx25840-core.c	2006-01-14 17:56:48.000000000 +0100
@@ -43,7 +43,7 @@
 static unsigned short normal_i2c[] = { 0x88 >> 1, I2C_CLIENT_END };
 
 
-int cx25840_debug;
+static int cx25840_debug;
 
 module_param_named(debug,cx25840_debug, int, 0644);
 
--- linux-2.6.15-mm4-full/drivers/media/video/cx88/cx88-alsa.c.old	2006-01-14 17:57:12.000000000 +0100
+++ linux-2.6.15-mm4-full/drivers/media/video/cx88/cx88-alsa.c	2006-01-14 17:57:43.000000000 +0100
@@ -128,7 +128,7 @@
  * BOARD Specific: Sets audio DMA
  */
 
-int _cx88_start_audio_dma(snd_cx88_card_t *chip)
+static int _cx88_start_audio_dma(snd_cx88_card_t *chip)
 {
 	struct cx88_buffer   *buf = chip->buf;
 	struct cx88_core *core=chip->core;
@@ -173,7 +173,7 @@
 /*
  * BOARD Specific: Resets audio DMA
  */
-int _cx88_stop_audio_dma(snd_cx88_card_t *chip)
+static int _cx88_stop_audio_dma(snd_cx88_card_t *chip)
 {
 	struct cx88_core *core=chip->core;
 	dprintk(1, "Stopping audio DMA\n");
@@ -613,7 +613,7 @@
  * Only boards with eeprom and byte 1 at eeprom=1 have it
  */
 
-struct pci_device_id cx88_audio_pci_tbl[] = {
+static struct pci_device_id cx88_audio_pci_tbl[] = {
 	{0x14f1,0x8801,PCI_ANY_ID,PCI_ANY_ID,0,0,0},
 	{0x14f1,0x8811,PCI_ANY_ID,PCI_ANY_ID,0,0,0},
 	{0, }
--- linux-2.6.15-mm4-full/drivers/media/video/tvp5150.c.old	2006-01-14 18:31:39.000000000 +0100
+++ linux-2.6.15-mm4-full/drivers/media/video/tvp5150.c	2006-01-14 18:31:58.000000000 +0100
@@ -634,7 +634,7 @@
 	unsigned char values[26];
 };
 
-struct i2c_vbi_ram_value vbi_ram_default[] =
+static struct i2c_vbi_ram_value vbi_ram_default[] =
 {
 	{0x010, /* WST SECAM 6 */
 		{ 0xaa, 0xaa, 0xff, 0xff , 0xe7, 0x2e, 0x20, 0x26, 0xe6, 0xb4, 0x0e, 0x0, 0x0, 0x0, 0x10, 0x0 }

