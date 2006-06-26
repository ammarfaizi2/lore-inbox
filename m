Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964813AbWFZGZi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964813AbWFZGZi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 02:25:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964827AbWFZGZi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 02:25:38 -0400
Received: from crystal.sipsolutions.net ([195.210.38.204]:8124 "EHLO
	sipsolutions.net") by vger.kernel.org with ESMTP id S964813AbWFZGZh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 02:25:37 -0400
Subject: [PATCH] fix build failure due to snd-aoa
From: Johannes Berg <johannes@sipsolutions.net>
To: Takashi Iwai <tiwai@suse.de>
Cc: ALSA development <alsa-devel@alsa-project.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Mon, 26 Jun 2006 08:25:34 +0200
Message-Id: <1151303134.7608.86.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When snd-aoa is not built or built as modules, but CONFIG_SND is yes,
kernel build fails due to a bug I introduced when adding snd-aoa. This
patch fixes it.

From: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Johannes Berg <johannes@sipsolutions.net>

--- a/sound/Makefile    Fri Jun 23 15:18:41 2006 +0200
+++ b/sound/Makefile    Fri Jun 23 16:49:15 2006 +0200
@@ -4,7 +4,8 @@ obj-$(CONFIG_SOUND) += soundcore.o
 obj-$(CONFIG_SOUND) += soundcore.o
 obj-$(CONFIG_SOUND_PRIME) += oss/
 obj-$(CONFIG_DMASOUND) += oss/
-obj-$(CONFIG_SND) += core/ i2c/ drivers/ isa/ pci/ ppc/ arm/ synth/ usb/ sparc/ parisc/ pcmcia/ mips/ aoa/
+obj-$(CONFIG_SND) += core/ i2c/ drivers/ isa/ pci/ ppc/ arm/ synth/ usb/ sparc/ parisc/ pcmcia/ mips/
+obj-$(CONFIG_SND_AOA) += aoa/
 
 ifeq ($(CONFIG_SND),y)
   obj-y += last.o


