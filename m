Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272548AbTG1BRm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jul 2003 21:17:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272472AbTG1ADe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jul 2003 20:03:34 -0400
Received: from zeus.kernel.org ([204.152.189.113]:31477 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S272739AbTG0W6q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jul 2003 18:58:46 -0400
Date: Sun, 27 Jul 2003 21:26:59 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200307272026.h6RKQxmr029834@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: PATCH: fix section conflict and typo in ALSA isa
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.6.0-test2/sound/isa/sb/emu8000.c linux-2.6.0-test2-ac1/sound/isa/sb/emu8000.c
--- linux-2.6.0-test2/sound/isa/sb/emu8000.c	2003-07-10 21:07:39.000000000 +0100
+++ linux-2.6.0-test2-ac1/sound/isa/sb/emu8000.c	2003-07-15 18:01:30.000000000 +0100
@@ -659,7 +659,7 @@
 {
 	soundfont_chorus_fx_t rec;
 	if (mode < SNDRV_EMU8000_CHORUS_PREDEFINED || mode >= SNDRV_EMU8000_CHORUS_NUMBERS) {
-		snd_printk(KERN_WARNING "illegal chorus mode %d for uploading\n", mode);
+		snd_printk(KERN_WARNING "invalid chorus mode %d for uploading\n", mode);
 		return -EINVAL;
 	}
 	if (len < (long)sizeof(rec) || copy_from_user(&rec, buf, sizeof(rec)))
@@ -787,7 +787,7 @@
 	soundfont_reverb_fx_t rec;
 
 	if (mode < SNDRV_EMU8000_REVERB_PREDEFINED || mode >= SNDRV_EMU8000_REVERB_NUMBERS) {
-		snd_printk(KERN_WARNING "illegal reverb mode %d for uploading\n", mode);
+		snd_printk(KERN_WARNING "invalid reverb mode %d for uploading\n", mode);
 		return -EINVAL;
 	}
 	if (len < (long)sizeof(rec) || copy_from_user(&rec, buf, sizeof(rec)))
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.6.0-test2/sound/isa/sscape.c linux-2.6.0-test2-ac1/sound/isa/sscape.c
--- linux-2.6.0-test2/sound/isa/sscape.c	2003-07-10 21:05:23.000000000 +0100
+++ linux-2.6.0-test2-ac1/sound/isa/sscape.c	2003-07-23 16:39:21.000000000 +0100
@@ -809,7 +809,7 @@
  */
 static unsigned __devinit get_irq_config(int irq)
 {
-	static const int valid_irq[] __devinitdata = { 9, 5, 7, 10 };
+	const int valid_irq[] __devinitdata = { 9, 5, 7, 10 };
 	unsigned cfg;
 
 	for (cfg = 0; cfg < ARRAY_SIZE(valid_irq); ++cfg) {
