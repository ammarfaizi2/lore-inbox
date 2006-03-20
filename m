Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965004AbWCTPdd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965004AbWCTPdd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 10:33:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965274AbWCTP0v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 10:26:51 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:37304 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S965295AbWCTP0Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 10:26:24 -0500
From: mchehab@infradead.org
To: linux-kernel@vger.kernel.org
Cc: linux-dvb-maintainer@linuxtv.org,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 069/141] V4L/DVB (3318a): Makes Some symbols static.
Date: Mon, 20 Mar 2006 12:08:48 -0300
Message-id: <20060320150848.PS495332000069@infradead.org>
In-Reply-To: <20060320150819.PS760228000000@infradead.org>
References: <20060320150819.PS760228000000@infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1-3mdk 
Content-Transfer-Encoding: 7bit
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mauro Carvalho Chehab <mchehab@infradead.org>
Date: 1139302154 -0200

Some symbols at cx88-alsa were global. Making those static.

Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

diff --git a/drivers/media/video/cx88/cx88-alsa.c b/drivers/media/video/cx88/cx88-alsa.c
diff --git a/drivers/media/video/cx88/cx88-alsa.c b/drivers/media/video/cx88/cx88-alsa.c
index a2e36a1..2acccd6 100644
--- a/drivers/media/video/cx88/cx88-alsa.c
+++ b/drivers/media/video/cx88/cx88-alsa.c
@@ -128,7 +128,7 @@ MODULE_PARM_DESC(debug,"enable debug mes
  * BOARD Specific: Sets audio DMA
  */
 
-int _cx88_start_audio_dma(snd_cx88_card_t *chip)
+static int _cx88_start_audio_dma(snd_cx88_card_t *chip)
 {
 	struct cx88_buffer   *buf = chip->buf;
 	struct cx88_core *core=chip->core;
@@ -173,7 +173,7 @@ int _cx88_start_audio_dma(snd_cx88_card_
 /*
  * BOARD Specific: Resets audio DMA
  */
-int _cx88_stop_audio_dma(snd_cx88_card_t *chip)
+static int _cx88_stop_audio_dma(snd_cx88_card_t *chip)
 {
 	struct cx88_core *core=chip->core;
 	dprintk(1, "Stopping audio DMA\n");
@@ -613,7 +613,7 @@ static snd_kcontrol_new_t snd_cx88_captu
  * Only boards with eeprom and byte 1 at eeprom=1 have it
  */
 
-struct pci_device_id cx88_audio_pci_tbl[] = {
+static struct pci_device_id cx88_audio_pci_tbl[] = {
 	{0x14f1,0x8801,PCI_ANY_ID,PCI_ANY_ID,0,0,0},
 	{0x14f1,0x8811,PCI_ANY_ID,PCI_ANY_ID,0,0,0},
 	{0, }

