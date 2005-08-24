Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751084AbVHXPzh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751084AbVHXPzh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Aug 2005 11:55:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751086AbVHXPzh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Aug 2005 11:55:37 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:29445 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751085AbVHXPzg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Aug 2005 11:55:36 -0400
Date: Wed, 24 Aug 2005 17:55:34 +0200
From: Adrian Bunk <bunk@stusta.de>
To: perex@suse.cz
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] include/sound/gus.h: "extern inline" -> "static inline"
Message-ID: <20050824155534.GE4851@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"extern inline" doesn't make much sense.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 include/sound/gus.h |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

--- linux-2.6.13-rc6-mm2-full/include/sound/gus.h.old	2005-08-24 16:53:29.000000000 +0200
+++ linux-2.6.13-rc6-mm2-full/include/sound/gus.h	2005-08-24 16:53:34.000000000 +0200
@@ -512,13 +512,13 @@
 
 extern void snd_gf1_write8(snd_gus_card_t * gus, unsigned char reg, unsigned char data);
 extern unsigned char snd_gf1_look8(snd_gus_card_t * gus, unsigned char reg);
-extern inline unsigned char snd_gf1_read8(snd_gus_card_t * gus, unsigned char reg)
+static inline unsigned char snd_gf1_read8(snd_gus_card_t * gus, unsigned char reg)
 {
 	return snd_gf1_look8(gus, reg | 0x80);
 }
 extern void snd_gf1_write16(snd_gus_card_t * gus, unsigned char reg, unsigned int data);
 extern unsigned short snd_gf1_look16(snd_gus_card_t * gus, unsigned char reg);
-extern inline unsigned short snd_gf1_read16(snd_gus_card_t * gus, unsigned char reg)
+static inline unsigned short snd_gf1_read16(snd_gus_card_t * gus, unsigned char reg)
 {
 	return snd_gf1_look16(gus, reg | 0x80);
 }
@@ -532,12 +532,12 @@
 extern void snd_gf1_i_write8(snd_gus_card_t * gus, unsigned char reg, unsigned char data);
 extern unsigned char snd_gf1_i_look8(snd_gus_card_t * gus, unsigned char reg);
 extern void snd_gf1_i_write16(snd_gus_card_t * gus, unsigned char reg, unsigned int data);
-extern inline unsigned char snd_gf1_i_read8(snd_gus_card_t * gus, unsigned char reg)
+static inline unsigned char snd_gf1_i_read8(snd_gus_card_t * gus, unsigned char reg)
 {
 	return snd_gf1_i_look8(gus, reg | 0x80);
 }
 extern unsigned short snd_gf1_i_look16(snd_gus_card_t * gus, unsigned char reg);
-extern inline unsigned short snd_gf1_i_read16(snd_gus_card_t * gus, unsigned char reg)
+static inline unsigned short snd_gf1_i_read16(snd_gus_card_t * gus, unsigned char reg)
 {
 	return snd_gf1_i_look16(gus, reg | 0x80);
 }

