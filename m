Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965129AbWBGPnU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965129AbWBGPnU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 10:43:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965121AbWBGPln
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 10:41:43 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:26050 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751120AbWBGPlX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 10:41:23 -0500
From: mchehab@infradead.org
To: linux-kernel@vger.kernel.org
Cc: linux-dvb-maintainer@linuxtv.org,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 13/16] Makes Some symbols static.
Date: Tue, 07 Feb 2006 13:33:34 -0200
Message-id: <20060207153333.PS83505500013@infradead.org>
In-Reply-To: <20060207153248.PS50860900000@infradead.org>
References: <20060207153248.PS50860900000@infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1-1mdk 
Content-Transfer-Encoding: 7bit
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mauro Carvalho Chehab <mchehab@infradead.org>

Some symbols at cx88-alsa were global. Making those static.

Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

 drivers/media/video/cx88/cx88-alsa.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

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

