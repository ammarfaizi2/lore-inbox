Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263963AbTLTLwj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Dec 2003 06:52:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263983AbTLTLwj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Dec 2003 06:52:39 -0500
Received: from dns.toxicfilms.tv ([150.254.37.24]:3519 "EHLO dns.toxicfilms.tv")
	by vger.kernel.org with ESMTP id S263963AbTLTLvy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Dec 2003 06:51:54 -0500
Message-ID: <003f01c3c6ef$9e419f50$0e25fe0a@southpark.ae.poznan.pl>
From: "Maciej Soltysiak" <solt@dns.toxicfilms.tv>
To: <linux-kernel@vger.kernel.org>
Cc: <perex@suse.cz>
Subject: [PATCH BEAVER] Some outstanding C99 initializers in linux/sound
Date: Sat, 20 Dec 2003 12:51:28 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.3790.0
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.3790.0
X-Spam-Rating: 0 1.6.2 0/1000/N
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Here is another batch of my C99 initializers for linux/sound for 2.6.0

# diffstat patch-2.6.0-c99.diff
 dmasound/tas3001c.c        |    2
 dmasound/tas3001c_tables.c |  332
++++++++++++++++++++++----------------------- 
 dmasound/tas3004_tables.c  |  240 ++++++++++++++++----------------
 dmasound/trans_16.c        |   44 ++---
 sb_card.h                  |  100 ++++++-------
 5 files changed, 359 insertions(+), 359 deletions(-)

It is here:

http://soltysiak.com/patches/2.6/2.6.0/c99/patch-2.6.0-c99.diff

and in the body of this email.
Please apply.

Best Regards,
Maciej

--- linux/sound/oss/dmasound/trans_16.c~2003-12-19 22:55:46.503819448 +0100
+++ linux/sound/oss/dmasound/trans_16.c2003-12-19 22:55:46.503819448 +0100
@@ -573,34 +573,34 @@
 }

 TRANS transAwacsNormal = {
-ct_ulaw:pmac_ct_law,
-ct_alaw:pmac_ct_law,
-ct_s8:pmac_ct_s8,
-ct_u8:pmac_ct_u8,
-ct_s16be:pmac_ct_s16,
-ct_u16be:pmac_ct_u16,
-ct_s16le:pmac_ct_s16,
-ct_u16le:pmac_ct_u16,
+.ct_ulaw= pmac_ct_law,
+.ct_alaw= pmac_ct_law,
+.ct_s8= pmac_ct_s8,
+.ct_u8= pmac_ct_u8,
+.ct_s16be= pmac_ct_s16,
+.ct_u16be= pmac_ct_u16,
+.ct_s16le= pmac_ct_s16,
+.ct_u16le= pmac_ct_u16,
 };

 TRANS transAwacsExpand = {
-ct_ulaw:pmac_ctx_law,
-ct_alaw:pmac_ctx_law,
-ct_s8:pmac_ctx_s8,
-ct_u8:pmac_ctx_u8,
-ct_s16be:pmac_ctx_s16,
-ct_u16be:pmac_ctx_u16,
-ct_s16le:pmac_ctx_s16,
-ct_u16le:pmac_ctx_u16,
+.ct_ulaw= pmac_ctx_law,
+.ct_alaw= pmac_ctx_law,
+.ct_s8= pmac_ctx_s8,
+.ct_u8= pmac_ctx_u8,
+.ct_s16be= pmac_ctx_s16,
+.ct_u16be= pmac_ctx_u16,
+.ct_s16le= pmac_ctx_s16,
+.ct_u16le= pmac_ctx_u16,
 };

 TRANS transAwacsNormalRead = {
-ct_s8:pmac_ct_s8_read,
-ct_u8:pmac_ct_u8_read,
-ct_s16be:pmac_ct_s16_read,
-ct_u16be:pmac_ct_u16_read,
-ct_s16le:pmac_ct_s16_read,
-ct_u16le:pmac_ct_u16_read,
+.ct_s8= pmac_ct_s8_read,
+.ct_u8= pmac_ct_u8_read,
+.ct_s16be= pmac_ct_s16_read,
+.ct_u16be= pmac_ct_u16_read,
+.ct_s16le= pmac_ct_s16_read,
+.ct_u16le= pmac_ct_u16_read,
 };

 /* translation tables */
--- linux/sound/oss/dmasound/tas3004_tables.c~2003-12-19 23:11:52.533960544
+0100
+++ linux/sound/oss/dmasound/tas3004_tables.c2003-12-19 23:16:12.864384304
+0100
@@ -2,169 +2,169 @@
 #include "tas_eq_prefs.h"

 static struct tas_drce_t eqp_17_1_0_drce={
-    enable:    1,
-    above:     { val: 3.0 * (1<<8), expand: 0 },
-    below:     { val: 1.0 * (1<<8), expand: 0 },
-    threshold: -19.12  * (1<<8),
-    energy:    2.4     * (1<<12),
-    attack:    0.013   * (1<<12),
-    decay:     0.212   * (1<<12),
+    .enable     = 1,
+    .above      = { .val = 3.0 * (1<<8), .expand = 0 },
+    .below      = { .val = 1.0 * (1<<8), .expand = 0 },
+    .threshold  = -19.12  * (1<<8),
+    .energy     = 2.4     * (1<<12),
+    .attack     = 0.013   * (1<<12),
+    .decay      = 0.212   * (1<<12),
 };

 static struct tas_biquad_ctrl_t eqp_17_1_0_biquads[]={
-  { channel: 0, filter: 0, data: { coeff: { 0x0fd0d4, 0xe05e56, 0x0fd0d4,
0xe05ee1, 0x0fa234 } } },
-  { channel: 0, filter: 1, data: { coeff: { 0x0910d7, 0x088e1a, 0x030651,
0x01dcb1, 0x02c892 } } },
-  { channel: 0, filter: 2, data: { coeff: { 0x0ff895, 0xe0970b, 0x0f7f00,
0xe0970b, 0x0f7795 } } },
-  { channel: 0, filter: 3, data: { coeff: { 0x0fd1c4, 0xe1ac22, 0x0ec8cf,
0xe1ac22, 0x0e9a94 } } },
-  { channel: 0, filter: 4, data: { coeff: { 0x0f7c1c, 0xe3cc03, 0x0df786,
0xe3cc03, 0x0d73a2 } } },
-  { channel: 0, filter: 5, data: { coeff: { 0x11fb92, 0xf5a1a0, 0x073cd2,
0xf5a1a0, 0x093865 } } },
-  { channel: 0, filter: 6, data: { coeff: { 0x0e17a9, 0x068b6c, 0x08a0e5,
0x068b6c, 0x06b88e } } },
-
-  { channel: 1, filter: 0, data: { coeff: { 0x0fd0d4, 0xe05e56, 0x0fd0d4,
0xe05ee1, 0x0fa234 } } },
-  { channel: 1, filter: 1, data: { coeff: { 0x0910d7, 0x088e1a, 0x030651,
0x01dcb1, 0x02c892 } } },
-  { channel: 1, filter: 2, data: { coeff: { 0x0ff895, 0xe0970b, 0x0f7f00,
0xe0970b, 0x0f7795 } } },
-  { channel: 1, filter: 3, data: { coeff: { 0x0fd1c4, 0xe1ac22, 0x0ec8cf,
0xe1ac22, 0x0e9a94 } } },
-  { channel: 1, filter: 4, data: { coeff: { 0x0f7c1c, 0xe3cc03, 0x0df786,
0xe3cc03, 0x0d73a2 } } },
-  { channel: 1, filter: 5, data: { coeff: { 0x11fb92, 0xf5a1a0, 0x073cd2,
0xf5a1a0, 0x093865 } } },
-  { channel: 1, filter: 6, data: { coeff: { 0x0e17a9, 0x068b6c, 0x08a0e5,
0x068b6c, 0x06b88e } } }
+  { .channel = 0, .filter = 0, .data = { .coeff = { 0x0fd0d4, 0xe05e56,
0x0fd0d4, 0xe05ee1, 0x0fa234 } } },
+  { .channel = 0, .filter = 1, .data = { .coeff = { 0x0910d7, 0x088e1a,
0x030651, 0x01dcb1, 0x02c892 } } },
+  { .channel = 0, .filter = 2, .data = { .coeff = { 0x0ff895, 0xe0970b,
0x0f7f00, 0xe0970b, 0x0f7795 } } },
+  { .channel = 0, .filter = 3, .data = { .coeff = { 0x0fd1c4, 0xe1ac22,
0x0ec8cf, 0xe1ac22, 0x0e9a94 } } },
+  { .channel = 0, .filter = 4, .data = { .coeff = { 0x0f7c1c, 0xe3cc03,
0x0df786, 0xe3cc03, 0x0d73a2 } } },
+  { .channel = 0, .filter = 5, .data = { .coeff = { 0x11fb92, 0xf5a1a0,
0x073cd2, 0xf5a1a0, 0x093865 } } },
+  { .channel = 0, .filter = 6, .data = { .coeff = { 0x0e17a9, 0x068b6c,
0x08a0e5, 0x068b6c, 0x06b88e } } },
+
+  { .channel = 1, .filter = 0, .data = { .coeff = { 0x0fd0d4, 0xe05e56,
0x0fd0d4, 0xe05ee1, 0x0fa234 } } },
+  { .channel = 1, .filter = 1, .data = { .coeff = { 0x0910d7, 0x088e1a,
0x030651, 0x01dcb1, 0x02c892 } } },
+  { .channel = 1, .filter = 2, .data = { .coeff = { 0x0ff895, 0xe0970b,
0x0f7f00, 0xe0970b, 0x0f7795 } } },
+  { .channel = 1, .filter = 3, .data = { .coeff = { 0x0fd1c4, 0xe1ac22,
0x0ec8cf, 0xe1ac22, 0x0e9a94 } } },
+  { .channel = 1, .filter = 4, .data = { .coeff = { 0x0f7c1c, 0xe3cc03,
0x0df786, 0xe3cc03, 0x0d73a2 } } },
+  { .channel = 1, .filter = 5, .data = { .coeff = { 0x11fb92, 0xf5a1a0,
0x073cd2, 0xf5a1a0, 0x093865 } } },
+  { .channel = 1, .filter = 6, .data = { .coeff = { 0x0e17a9, 0x068b6c,
0x08a0e5, 0x068b6c, 0x06b88e } } }
 };

 static struct tas_eq_pref_t eqp_17_1_0 = {
-  sample_rate:  44100,
-  device_id:    0x17,
-  output_id:    TAS_OUTPUT_INTERNAL_SPKR,
-  speaker_id:   0x00,
+  .sample_rate   = 44100,
+  .device_id     = 0x17,
+  .output_id     = TAS_OUTPUT_INTERNAL_SPKR,
+  .speaker_id    = 0x00,

-  drce:         &eqp_17_1_0_drce,
+  .drce          = &eqp_17_1_0_drce,

-  filter_count: 14,
-  biquads:      eqp_17_1_0_biquads
+  .filter_count  = 14,
+  .biquads       = eqp_17_1_0_biquads
 };

 /* ========================================================================
*/

 static struct tas_drce_t eqp_18_1_0_drce={
-  enable:    1,
-  above:     { val: 3.0 * (1<<8), expand: 0 },
-  below:     { val: 1.0 * (1<<8), expand: 0 },
-  threshold: -13.14  * (1<<8),
-  energy:    2.4     * (1<<12),
-  attack:    0.013   * (1<<12),
-  decay:     0.212   * (1<<12),
+  .enable     = 1,
+  .above      = { .val = 3.0 * (1<<8), .expand = 0 },
+  .below      = { .val = 1.0 * (1<<8), .expand = 0 },
+  .threshold  = -13.14  * (1<<8),
+  .energy     = 2.4     * (1<<12),
+  .attack     = 0.013   * (1<<12),
+  .decay      = 0.212   * (1<<12),
 };

 static struct tas_biquad_ctrl_t eqp_18_1_0_biquads[]={
-  { channel: 0, filter: 0, data: { coeff: { 0x0f5514, 0xe155d7, 0x0f5514,
0xe15cfa, 0x0eb14b } } },
-  { channel: 0, filter: 1, data: { coeff: { 0x06ec33, 0x02abe3, 0x015eef,
0xf764d9, 0x03922d } } },
-  { channel: 0, filter: 2, data: { coeff: { 0x0ef5f2, 0xe67d1f, 0x0bcf37,
0xe67d1f, 0x0ac529 } } },
-  { channel: 0, filter: 3, data: { coeff: { 0x0db050, 0xe5be4d, 0x0d0c78,
0xe5be4d, 0x0abcc8 } } },
-  { channel: 0, filter: 4, data: { coeff: { 0x0f1298, 0xe64ec6, 0x0cc03e,
0xe64ec6, 0x0bd2d7 } } },
-  { channel: 0, filter: 5, data: { coeff: { 0x0c641a, 0x06537a, 0x08d155,
0x06537a, 0x053570 } } },
-  { channel: 0, filter: 6, data: { coeff: { 0x100000, 0x000000, 0x000000,
0x000000, 0x000000 } } },
-
-  { channel: 1, filter: 0, data: { coeff: { 0x0f5514, 0xe155d7, 0x0f5514,
0xe15cfa, 0x0eb14b } } },
-  { channel: 1, filter: 1, data: { coeff: { 0x06ec33, 0x02abe3, 0x015eef,
0xf764d9, 0x03922d } } },
-  { channel: 1, filter: 2, data: { coeff: { 0x0ef5f2, 0xe67d1f, 0x0bcf37,
0xe67d1f, 0x0ac529 } } },
-  { channel: 1, filter: 3, data: { coeff: { 0x0db050, 0xe5be4d, 0x0d0c78,
0xe5be4d, 0x0abcc8 } } },
-  { channel: 1, filter: 4, data: { coeff: { 0x0f1298, 0xe64ec6, 0x0cc03e,
0xe64ec6, 0x0bd2d7 } } },
-  { channel: 1, filter: 5, data: { coeff: { 0x0c641a, 0x06537a, 0x08d155,
0x06537a, 0x053570 } } },
-  { channel: 1, filter: 6, data: { coeff: { 0x100000, 0x000000, 0x000000,
0x000000, 0x000000 } } }
+  { .channel = 0, .filter = 0, .data = { .coeff = { 0x0f5514, 0xe155d7,
0x0f5514, 0xe15cfa, 0x0eb14b } } },
+  { .channel = 0, .filter = 1, .data = { .coeff = { 0x06ec33, 0x02abe3,
0x015eef, 0xf764d9, 0x03922d } } },
+  { .channel = 0, .filter = 2, .data = { .coeff = { 0x0ef5f2, 0xe67d1f,
0x0bcf37, 0xe67d1f, 0x0ac529 } } },
+  { .channel = 0, .filter = 3, .data = { .coeff = { 0x0db050, 0xe5be4d,
0x0d0c78, 0xe5be4d, 0x0abcc8 } } },
+  { .channel = 0, .filter = 4, .data = { .coeff = { 0x0f1298, 0xe64ec6,
0x0cc03e, 0xe64ec6, 0x0bd2d7 } } },
+  { .channel = 0, .filter = 5, .data = { .coeff = { 0x0c641a, 0x06537a,
0x08d155, 0x06537a, 0x053570 } } },
+  { .channel = 0, .filter = 6, .data = { .coeff = { 0x100000, 0x000000,
0x000000, 0x000000, 0x000000 } } },
+
+  { .channel = 1, .filter = 0, .data = { .coeff = { 0x0f5514, 0xe155d7,
0x0f5514, 0xe15cfa, 0x0eb14b } } },
+  { .channel = 1, .filter = 1, .data = { .coeff = { 0x06ec33, 0x02abe3,
0x015eef, 0xf764d9, 0x03922d } } },
+  { .channel = 1, .filter = 2, .data = { .coeff = { 0x0ef5f2, 0xe67d1f,
0x0bcf37, 0xe67d1f, 0x0ac529 } } },
+  { .channel = 1, .filter = 3, .data = { .coeff = { 0x0db050, 0xe5be4d,
0x0d0c78, 0xe5be4d, 0x0abcc8 } } },
+  { .channel = 1, .filter = 4, .data = { .coeff = { 0x0f1298, 0xe64ec6,
0x0cc03e, 0xe64ec6, 0x0bd2d7 } } },
+  { .channel = 1, .filter = 5, .data = { .coeff = { 0x0c641a, 0x06537a,
0x08d155, 0x06537a, 0x053570 } } },
+  { .channel = 1, .filter = 6, .data = { .coeff = { 0x100000, 0x000000,
0x000000, 0x000000, 0x000000 } } }
 };

 static struct tas_eq_pref_t eqp_18_1_0 = {
-  sample_rate:  44100,
-  device_id:    0x18,
-  output_id:    TAS_OUTPUT_INTERNAL_SPKR,
-  speaker_id:   0x00,
+  .sample_rate   = 44100,
+  .device_id     = 0x18,
+  .output_id     = TAS_OUTPUT_INTERNAL_SPKR,
+  .speaker_id    = 0x00,

-  drce:         &eqp_18_1_0_drce,
+  .drce          = &eqp_18_1_0_drce,

-  filter_count: 14,
-  biquads:      eqp_18_1_0_biquads
+  .filter_count  = 14,
+  .biquads       = eqp_18_1_0_biquads
 };

 /* ========================================================================
*/

 static struct tas_drce_t eqp_1a_1_0_drce={
-  enable:    1,
-  above:     { val: 3.0 * (1<<8), expand: 0 },
-  below:     { val: 1.0 * (1<<8), expand: 0 },
-  threshold: -10.75  * (1<<8),
-  energy:    2.4     * (1<<12),
-  attack:    0.013   * (1<<12),
-  decay:     0.212   * (1<<12),
+  .enable     = 1,
+  .above      = { .val = 3.0 * (1<<8), .expand = 0 },
+  .below      = { .val = 1.0 * (1<<8), .expand = 0 },
+  .threshold  = -10.75  * (1<<8),
+  .energy     = 2.4     * (1<<12),
+  .attack     = 0.013   * (1<<12),
+  .decay      = 0.212   * (1<<12),
 };

 static struct tas_biquad_ctrl_t eqp_1a_1_0_biquads[]={
-  { channel: 0, filter: 0, data: { coeff: { 0x0fb8fd, 0xe08e04, 0x0fb8fd,
0xe08f40, 0x0f7336 } } },
-  { channel: 0, filter: 1, data: { coeff: { 0x06371d, 0x0c6e3a, 0x06371d,
0x05bfd3, 0x031ca2 } } },
-  { channel: 0, filter: 2, data: { coeff: { 0x0fa1c0, 0xe18692, 0x0f030e,
0xe18692, 0x0ea4ce } } },
-  { channel: 0, filter: 3, data: { coeff: { 0x0fe495, 0xe17eff, 0x0f0452,
0xe17eff, 0x0ee8e7 } } },
-  { channel: 0, filter: 4, data: { coeff: { 0x100857, 0xe7e71c, 0x0e9599,
0xe7e71c, 0x0e9df1 } } },
-  { channel: 0, filter: 5, data: { coeff: { 0x0fb26e, 0x06a82c, 0x0db2b4,
0x06a82c, 0x0d6522 } } },
-  { channel: 0, filter: 6, data: { coeff: { 0x11419d, 0xf06cbf, 0x0a4f6e,
0xf06cbf, 0x0b910c } } },
-
-  { channel: 1, filter: 0, data: { coeff: { 0x0fb8fd, 0xe08e04, 0x0fb8fd,
0xe08f40, 0x0f7336 } } },
-  { channel: 1, filter: 1, data: { coeff: { 0x06371d, 0x0c6e3a, 0x06371d,
0x05bfd3, 0x031ca2 } } },
-  { channel: 1, filter: 2, data: { coeff: { 0x0fa1c0, 0xe18692, 0x0f030e,
0xe18692, 0x0ea4ce } } },
-  { channel: 1, filter: 3, data: { coeff: { 0x0fe495, 0xe17eff, 0x0f0452,
0xe17eff, 0x0ee8e7 } } },
-  { channel: 1, filter: 4, data: { coeff: { 0x100857, 0xe7e71c, 0x0e9599,
0xe7e71c, 0x0e9df1 } } },
-  { channel: 1, filter: 5, data: { coeff: { 0x0fb26e, 0x06a82c, 0x0db2b4,
0x06a82c, 0x0d6522 } } },
-  { channel: 1, filter: 6, data: { coeff: { 0x11419d, 0xf06cbf, 0x0a4f6e,
0xf06cbf, 0x0b910c } } }
+  { .channel = 0, .filter = 0, .data = { .coeff = { 0x0fb8fd, 0xe08e04,
0x0fb8fd, 0xe08f40, 0x0f7336 } } },
+  { .channel = 0, .filter = 1, .data = { .coeff = { 0x06371d, 0x0c6e3a,
0x06371d, 0x05bfd3, 0x031ca2 } } },
+  { .channel = 0, .filter = 2, .data = { .coeff = { 0x0fa1c0, 0xe18692,
0x0f030e, 0xe18692, 0x0ea4ce } } },
+  { .channel = 0, .filter = 3, .data = { .coeff = { 0x0fe495, 0xe17eff,
0x0f0452, 0xe17eff, 0x0ee8e7 } } },
+  { .channel = 0, .filter = 4, .data = { .coeff = { 0x100857, 0xe7e71c,
0x0e9599, 0xe7e71c, 0x0e9df1 } } },
+  { .channel = 0, .filter = 5, .data = { .coeff = { 0x0fb26e, 0x06a82c,
0x0db2b4, 0x06a82c, 0x0d6522 } } },
+  { .channel = 0, .filter = 6, .data = { .coeff = { 0x11419d, 0xf06cbf,
0x0a4f6e, 0xf06cbf, 0x0b910c } } },
+
+  { .channel = 1, .filter = 0, .data = { .coeff = { 0x0fb8fd, 0xe08e04,
0x0fb8fd, 0xe08f40, 0x0f7336 } } },
+  { .channel = 1, .filter = 1, .data = { .coeff = { 0x06371d, 0x0c6e3a,
0x06371d, 0x05bfd3, 0x031ca2 } } },
+  { .channel = 1, .filter = 2, .data = { .coeff = { 0x0fa1c0, 0xe18692,
0x0f030e, 0xe18692, 0x0ea4ce } } },
+  { .channel = 1, .filter = 3, .data = { .coeff = { 0x0fe495, 0xe17eff,
0x0f0452, 0xe17eff, 0x0ee8e7 } } },
+  { .channel = 1, .filter = 4, .data = { .coeff = { 0x100857, 0xe7e71c,
0x0e9599, 0xe7e71c, 0x0e9df1 } } },
+  { .channel = 1, .filter = 5, .data = { .coeff = { 0x0fb26e, 0x06a82c,
0x0db2b4, 0x06a82c, 0x0d6522 } } },
+  { .channel = 1, .filter = 6, .data = { .coeff = { 0x11419d, 0xf06cbf,
0x0a4f6e, 0xf06cbf, 0x0b910c } } }
 };

 static struct tas_eq_pref_t eqp_1a_1_0 = {
-  sample_rate:  44100,
-  device_id:    0x1a,
-  output_id:    TAS_OUTPUT_INTERNAL_SPKR,
-  speaker_id:   0x00,
+  .sample_rate   = 44100,
+  .device_id     = 0x1a,
+  .output_id     = TAS_OUTPUT_INTERNAL_SPKR,
+  .speaker_id    = 0x00,

-  drce:         &eqp_1a_1_0_drce,
+  .drce          = &eqp_1a_1_0_drce,

-  filter_count: 14,
-  biquads:      eqp_1a_1_0_biquads
+  .filter_count  = 14,
+  .biquads       = eqp_1a_1_0_biquads
 };

 /* ========================================================================
*/

 static struct tas_drce_t eqp_1c_1_0_drce={
-  enable:    1,
-  above:     { val: 3.0 * (1<<8), expand: 0 },
-  below:     { val: 1.0 * (1<<8), expand: 0 },
-  threshold: -14.34  * (1<<8),
-  energy:    2.4     * (1<<12),
-  attack:    0.013   * (1<<12),
-  decay:     0.212   * (1<<12),
+  .enable     = 1,
+  .above      = { .val = 3.0 * (1<<8), .expand = 0 },
+  .below      = { .val = 1.0 * (1<<8), .expand = 0 },
+  .threshold  = -14.34  * (1<<8),
+  .energy     = 2.4     * (1<<12),
+  .attack     = 0.013   * (1<<12),
+  .decay      = 0.212   * (1<<12),
 };

 static struct tas_biquad_ctrl_t eqp_1c_1_0_biquads[]={
-  { channel: 0, filter: 0, data: { coeff: { 0x0f4f95, 0xe160d4, 0x0f4f95,
0xe1686e, 0x0ea6c5 } } },
-  { channel: 0, filter: 1, data: { coeff: { 0x066b92, 0x0290d4, 0x0148a0,
0xf6853f, 0x03bfc7 } } },
-  { channel: 0, filter: 2, data: { coeff: { 0x0f57dc, 0xe51c91, 0x0dd1cb,
0xe51c91, 0x0d29a8 } } },
-  { channel: 0, filter: 3, data: { coeff: { 0x0df1cb, 0xe4fa84, 0x0d7cdc,
0xe4fa84, 0x0b6ea7 } } },
-  { channel: 0, filter: 4, data: { coeff: { 0x0eba36, 0xe6aa48, 0x0b9f52,
0xe6aa48, 0x0a5989 } } },
-  { channel: 0, filter: 5, data: { coeff: { 0x0caf02, 0x05ef9d, 0x084beb,
0x05ef9d, 0x04faee } } },
-  { channel: 0, filter: 6, data: { coeff: { 0x0fc686, 0xe22947, 0x0e4b5d,
0xe22947, 0x0e11e4 } } },
-
-  { channel: 1, filter: 0, data: { coeff: { 0x0f4f95, 0xe160d4, 0x0f4f95,
0xe1686e, 0x0ea6c5 } } },
-  { channel: 1, filter: 1, data: { coeff: { 0x066b92, 0x0290d4, 0x0148a0,
0xf6853f, 0x03bfc7 } } },
-  { channel: 1, filter: 2, data: { coeff: { 0x0f57dc, 0xe51c91, 0x0dd1cb,
0xe51c91, 0x0d29a8 } } },
-  { channel: 1, filter: 3, data: { coeff: { 0x0df1cb, 0xe4fa84, 0x0d7cdc,
0xe4fa84, 0x0b6ea7 } } },
-  { channel: 1, filter: 4, data: { coeff: { 0x0eba36, 0xe6aa48, 0x0b9f52,
0xe6aa48, 0x0a5989 } } },
-  { channel: 1, filter: 5, data: { coeff: { 0x0caf02, 0x05ef9d, 0x084beb,
0x05ef9d, 0x04faee } } },
-  { channel: 1, filter: 6, data: { coeff: { 0x0fc686, 0xe22947, 0x0e4b5d,
0xe22947, 0x0e11e4 } } }
+  { .channel = 0, .filter = 0, .data = { .coeff = { 0x0f4f95, 0xe160d4,
0x0f4f95, 0xe1686e, 0x0ea6c5 } } },
+  { .channel = 0, .filter = 1, .data = { .coeff = { 0x066b92, 0x0290d4,
0x0148a0, 0xf6853f, 0x03bfc7 } } },
+  { .channel = 0, .filter = 2, .data = { .coeff = { 0x0f57dc, 0xe51c91,
0x0dd1cb, 0xe51c91, 0x0d29a8 } } },
+  { .channel = 0, .filter = 3, .data = { .coeff = { 0x0df1cb, 0xe4fa84,
0x0d7cdc, 0xe4fa84, 0x0b6ea7 } } },
+  { .channel = 0, .filter = 4, .data = { .coeff = { 0x0eba36, 0xe6aa48,
0x0b9f52, 0xe6aa48, 0x0a5989 } } },
+  { .channel = 0, .filter = 5, .data = { .coeff = { 0x0caf02, 0x05ef9d,
0x084beb, 0x05ef9d, 0x04faee } } },
+  { .channel = 0, .filter = 6, .data = { .coeff = { 0x0fc686, 0xe22947,
0x0e4b5d, 0xe22947, 0x0e11e4 } } },
+
+  { .channel = 1, .filter = 0, .data = { .coeff = { 0x0f4f95, 0xe160d4,
0x0f4f95, 0xe1686e, 0x0ea6c5 } } },
+  { .channel = 1, .filter = 1, .data = { .coeff = { 0x066b92, 0x0290d4,
0x0148a0, 0xf6853f, 0x03bfc7 } } },
+  { .channel = 1, .filter = 2, .data = { .coeff = { 0x0f57dc, 0xe51c91,
0x0dd1cb, 0xe51c91, 0x0d29a8 } } },
+  { .channel = 1, .filter = 3, .data = { .coeff = { 0x0df1cb, 0xe4fa84,
0x0d7cdc, 0xe4fa84, 0x0b6ea7 } } },
+  { .channel = 1, .filter = 4, .data = { .coeff = { 0x0eba36, 0xe6aa48,
0x0b9f52, 0xe6aa48, 0x0a5989 } } },
+  { .channel = 1, .filter = 5, .data = { .coeff = { 0x0caf02, 0x05ef9d,
0x084beb, 0x05ef9d, 0x04faee } } },
+  { .channel = 1, .filter = 6, .data = { .coeff = { 0x0fc686, 0xe22947,
0x0e4b5d, 0xe22947, 0x0e11e4 } } }
 };

 static struct tas_eq_pref_t eqp_1c_1_0 = {
-  sample_rate:  44100,
-  device_id:    0x1c,
-  output_id:    TAS_OUTPUT_INTERNAL_SPKR,
-  speaker_id:   0x00,
+  .sample_rate   = 44100,
+  .device_id     = 0x1c,
+  .output_id     = TAS_OUTPUT_INTERNAL_SPKR,
+  .speaker_id    = 0x00,

-  drce:         &eqp_1c_1_0_drce,
+  .drce          = &eqp_1c_1_0_drce,

-  filter_count: 14,
-  biquads:      eqp_1c_1_0_biquads
+  .filter_count  = 14,
+  .biquads       = eqp_1c_1_0_biquads
 };

 /* ========================================================================
*/
@@ -286,10 +286,10 @@
 };

 struct tas_gain_t tas3004_gain={
-  master: tas3004_master_tab,
-  treble: tas3004_treble_tab,
-  bass:   tas3004_bass_tab,
-  mixer:  tas3004_mixer_tab
+  .master  = tas3004_master_tab,
+  .treble  = tas3004_treble_tab,
+  .bass    = tas3004_bass_tab,
+  .mixer   = tas3004_mixer_tab
 };

 struct tas_eq_pref_t *tas3004_eq_prefs[]={
--- linux/sound/oss/dmasound/tas3001c_tables.c~2003-12-19 23:05:53.489543592
+0100
+++ linux/sound/oss/dmasound/tas3001c_tables.c2003-12-19 23:07:53.784256016
+0100
@@ -2,241 +2,241 @@
 #include "tas_eq_prefs.h"

 static struct tas_drce_t eqp_0e_2_1_drce = {
-  enable:    1,
-  above:     { val: 3.0 * (1<<8), expand: 0 },
-  below:     { val: 1.0 * (1<<8), expand: 0 },
-  threshold: -15.33  * (1<<8),
-  energy:    2.4     * (1<<12),
-  attack:    0.013   * (1<<12),
-  decay:     0.212   * (1<<12),
+  .enable     = 1,
+  .above      { .val = 3.0 * (1<<8), .expand = 0 },
+  .below      { .val = 1.0 * (1<<8), .expand = 0 },
+  .threshold  -15.33  * (1<<8),
+  .energy     2.4     * (1<<12),
+  .attack     0.013   * (1<<12),
+  .decay      0.212   * (1<<12),
 };

 static struct tas_biquad_ctrl_t eqp_0e_2_1_biquads[]={
-  { channel: 0, filter: 0, data: { coeff: { 0x0FCAD3, 0xE06A58, 0x0FCAD3,
0xE06B09, 0x0F9657 } } },
-  { channel: 0, filter: 1, data: { coeff: { 0x041731, 0x082E63, 0x041731,
0xFD8D08, 0x02CFBD } } },
-  { channel: 0, filter: 2, data: { coeff: { 0x0FFDC7, 0xE0524C, 0x0FBFAA,
0xE0524C, 0x0FBD72 } } },
-  { channel: 0, filter: 3, data: { coeff: { 0x0F3D35, 0xE228CA, 0x0EC7B2,
0xE228CA, 0x0E04E8 } } },
-  { channel: 0, filter: 4, data: { coeff: { 0x0FCEBF, 0xE181C2, 0x0F2656,
0xE181C2, 0x0EF516 } } },
-  { channel: 0, filter: 5, data: { coeff: { 0x0EC417, 0x073E22, 0x0B0633,
0x073E22, 0x09CA4A } } },
-
-  { channel: 1, filter: 0, data: { coeff: { 0x0FCAD3, 0xE06A58, 0x0FCAD3,
0xE06B09, 0x0F9657 } } },
-  { channel: 1, filter: 1, data: { coeff: { 0x041731, 0x082E63, 0x041731,
0xFD8D08, 0x02CFBD } } },
-  { channel: 1, filter: 2, data: { coeff: { 0x0FFDC7, 0xE0524C, 0x0FBFAA,
0xE0524C, 0x0FBD72 } } },
-  { channel: 1, filter: 3, data: { coeff: { 0x0F3D35, 0xE228CA, 0x0EC7B2,
0xE228CA, 0x0E04E8 } } },
-  { channel: 1, filter: 4, data: { coeff: { 0x0FCEBF, 0xE181C2, 0x0F2656,
0xE181C2, 0x0EF516 } } },
-  { channel: 1, filter: 5, data: { coeff: { 0x0EC417, 0x073E22, 0x0B0633,
0x073E22, 0x09CA4A } } },
+  { .channel = 0, .filter = 0, .data = { .coeff = { 0x0FCAD3, 0xE06A58,
0x0FCAD3, 0xE06B09, 0x0F9657 } } },
+  { .channel = 0, .filter = 1, .data = { .coeff = { 0x041731, 0x082E63,
0x041731, 0xFD8D08, 0x02CFBD } } },
+  { .channel = 0, .filter = 2, .data = { .coeff = { 0x0FFDC7, 0xE0524C,
0x0FBFAA, 0xE0524C, 0x0FBD72 } } },
+  { .channel = 0, .filter = 3, .data = { .coeff = { 0x0F3D35, 0xE228CA,
0x0EC7B2, 0xE228CA, 0x0E04E8 } } },
+  { .channel = 0, .filter = 4, .data = { .coeff = { 0x0FCEBF, 0xE181C2,
0x0F2656, 0xE181C2, 0x0EF516 } } },
+  { .channel = 0, .filter = 5, .data = { .coeff = { 0x0EC417, 0x073E22,
0x0B0633, 0x073E22, 0x09CA4A } } },
+
+  { .channel = 1, .filter = 0, .data = { .coeff = { 0x0FCAD3, 0xE06A58,
0x0FCAD3, 0xE06B09, 0x0F9657 } } },
+  { .channel = 1, .filter = 1, .data = { .coeff = { 0x041731, 0x082E63,
0x041731, 0xFD8D08, 0x02CFBD } } },
+  { .channel = 1, .filter = 2, .data = { .coeff = { 0x0FFDC7, 0xE0524C,
0x0FBFAA, 0xE0524C, 0x0FBD72 } } },
+  { .channel = 1, .filter = 3, .data = { .coeff = { 0x0F3D35, 0xE228CA,
0x0EC7B2, 0xE228CA, 0x0E04E8 } } },
+  { .channel = 1, .filter = 4, .data = { .coeff = { 0x0FCEBF, 0xE181C2,
0x0F2656, 0xE181C2, 0x0EF516 } } },
+  { .channel = 1, .filter = 5, .data = { .coeff = { 0x0EC417, 0x073E22,
0x0B0633, 0x073E22, 0x09CA4A } } },
 };

 static struct tas_eq_pref_t eqp_0e_2_1 = {
-  sample_rate:  44100,
-  device_id:    0x0e,
-  output_id:    TAS_OUTPUT_EXTERNAL_SPKR,
-  speaker_id:   0x01,
+  .sample_rate   = 44100,
+  .device_id     = 0x0e,
+  .output_id     = TAS_OUTPUT_EXTERNAL_SPKR,
+  .speaker_id    = 0x01,

-  drce:         &eqp_0e_2_1_drce,
+  .drce          = &eqp_0e_2_1_drce,

-  filter_count: 12,
-  biquads:      eqp_0e_2_1_biquads
+  .filter_count: 12,
+  .biquads       = eqp_0e_2_1_biquads
 };

 /* ========================================================================
*/

 static struct tas_drce_t eqp_10_1_0_drce={
-  enable:    1,
-  above:     { val: 3.0 * (1<<8), expand: 0 },
-  below:     { val: 1.0 * (1<<8), expand: 0 },
-  threshold: -12.46  * (1<<8),
-  energy:    2.4     * (1<<12),
-  attack:    0.013   * (1<<12),
-  decay:     0.212   * (1<<12),
+  .enable     = 1,
+  .above      = { .val = 3.0 * (1<<8), .expand = 0 },
+  .below      = { .val = 1.0 * (1<<8), .expand = 0 },
+  .threshold  = -12.46  * (1<<8),
+  .energy     = 2.4     * (1<<12),
+  .attack     = 0.013   * (1<<12),
+  .decay      = 0.212   * (1<<12),
 };

 static struct tas_biquad_ctrl_t eqp_10_1_0_biquads[]={
-  { channel: 0, filter: 0, data: { coeff: { 0x0F4A12, 0xE16BDA, 0x0F4A12,
0xE173F0, 0x0E9C3A } } },
-  { channel: 0, filter: 1, data: { coeff: { 0x02DD54, 0x05BAA8, 0x02DD54,
0xF8001D, 0x037532 } } },
-  { channel: 0, filter: 2, data: { coeff: { 0x0E2FC7, 0xE4D5DC, 0x0D7477,
0xE4D5DC, 0x0BA43F } } },
-  { channel: 0, filter: 3, data: { coeff: { 0x0E7899, 0xE67CCA, 0x0D0E93,
0xE67CCA, 0x0B872D } } },
-  { channel: 0, filter: 4, data: { coeff: { 0x100000, 0x000000, 0x000000,
0x000000, 0x000000 } } },
-  { channel: 0, filter: 5, data: { coeff: { 0x100000, 0x000000, 0x000000,
0x000000, 0x000000 } } },
-
-  { channel: 1, filter: 0, data: { coeff: { 0x0F4A12, 0xE16BDA, 0x0F4A12,
0xE173F0, 0x0E9C3A } } },
-  { channel: 1, filter: 1, data: { coeff: { 0x02DD54, 0x05BAA8, 0x02DD54,
0xF8001D, 0x037532 } } },
-  { channel: 1, filter: 2, data: { coeff: { 0x0E2FC7, 0xE4D5DC, 0x0D7477,
0xE4D5DC, 0x0BA43F } } },
-  { channel: 1, filter: 3, data: { coeff: { 0x0E7899, 0xE67CCA, 0x0D0E93,
0xE67CCA, 0x0B872D } } },
-  { channel: 1, filter: 4, data: { coeff: { 0x100000, 0x000000, 0x000000,
0x000000, 0x000000 } } },
-  { channel: 1, filter: 5, data: { coeff: { 0x100000, 0x000000, 0x000000,
0x000000, 0x000000 } } },
+  { .channel = 0, .filter = 0, .data = { .coeff = { 0x0F4A12, 0xE16BDA,
0x0F4A12, 0xE173F0, 0x0E9C3A } } },
+  { .channel = 0, .filter = 1, .data = { .coeff = { 0x02DD54, 0x05BAA8,
0x02DD54, 0xF8001D, 0x037532 } } },
+  { .channel = 0, .filter = 2, .data = { .coeff = { 0x0E2FC7, 0xE4D5DC,
0x0D7477, 0xE4D5DC, 0x0BA43F } } },
+  { .channel = 0, .filter = 3, .data = { .coeff = { 0x0E7899, 0xE67CCA,
0x0D0E93, 0xE67CCA, 0x0B872D } } },
+  { .channel = 0, .filter = 4, .data = { .coeff = { 0x100000, 0x000000,
0x000000, 0x000000, 0x000000 } } },
+  { .channel = 0, .filter = 5, .data = { .coeff = { 0x100000, 0x000000,
0x000000, 0x000000, 0x000000 } } },
+
+  { .channel = 1, .filter = 0, .data = { .coeff = { 0x0F4A12, 0xE16BDA,
0x0F4A12, 0xE173F0, 0x0E9C3A } } },
+  { .channel = 1, .filter = 1, .data = { .coeff = { 0x02DD54, 0x05BAA8,
0x02DD54, 0xF8001D, 0x037532 } } },
+  { .channel = 1, .filter = 2, .data = { .coeff = { 0x0E2FC7, 0xE4D5DC,
0x0D7477, 0xE4D5DC, 0x0BA43F } } },
+  { .channel = 1, .filter = 3, .data = { .coeff = { 0x0E7899, 0xE67CCA,
0x0D0E93, 0xE67CCA, 0x0B872D } } },
+  { .channel = 1, .filter = 4, .data = { .coeff = { 0x100000, 0x000000,
0x000000, 0x000000, 0x000000 } } },
+  { .channel = 1, .filter = 5, .data = { .coeff = { 0x100000, 0x000000,
0x000000, 0x000000, 0x000000 } } },
 };

 static struct tas_eq_pref_t eqp_10_1_0 = {
-  sample_rate:  44100,
-  device_id:    0x10,
-  output_id:    TAS_OUTPUT_INTERNAL_SPKR,
-  speaker_id:   0x00,
+  .sample_rate   = 44100,
+  .device_id     = 0x10,
+  .output_id     = TAS_OUTPUT_INTERNAL_SPKR,
+  .speaker_id    = 0x00,

-  drce:         &eqp_10_1_0_drce,
+  .drce          = &eqp_10_1_0_drce,

-  filter_count: 12,
-  biquads:      eqp_10_1_0_biquads
+  .filter_count  = 12,
+  .biquads       = eqp_10_1_0_biquads
 };

 /* ========================================================================
*/

 static struct tas_drce_t eqp_15_2_1_drce={
-  enable:    1,
-  above:     { val: 3.0 * (1<<8), expand: 0 },
-  below:     { val: 1.0 * (1<<8), expand: 0 },
-  threshold: -15.33  * (1<<8),
-  energy:    2.4     * (1<<12),
-  attack:    0.013   * (1<<12),
-  decay:     0.212   * (1<<12),
+  .enable     = 1,
+  .above      = { .val = 3.0 * (1<<8), .expand = 0 },
+  .below      = { .val = 1.0 * (1<<8), .expand = 0 },
+  .threshold  = -15.33  * (1<<8),
+  .energy     = 2.4     * (1<<12),
+  .attack     = 0.013   * (1<<12),
+  .decay      = 0.212   * (1<<12),
 };

 static struct tas_biquad_ctrl_t eqp_15_2_1_biquads[]={
-  { channel: 0, filter: 0, data: { coeff: { 0x0FE143, 0xE05204, 0x0FCCC5,
0xE05266, 0x0FAE6B } } },
-  { channel: 0, filter: 1, data: { coeff: { 0x102383, 0xE03A03, 0x0FA325,
0xE03A03, 0x0FC6A8 } } },
-  { channel: 0, filter: 2, data: { coeff: { 0x0FF2AB, 0xE06285, 0x0FB20A,
0xE06285, 0x0FA4B5 } } },
-  { channel: 0, filter: 3, data: { coeff: { 0x0F544D, 0xE35971, 0x0D8F3A,
0xE35971, 0x0CE388 } } },
-  { channel: 0, filter: 4, data: { coeff: { 0x13E1D3, 0xF3ECB5, 0x042227,
0xF3ECB5, 0x0803FA } } },
-  { channel: 0, filter: 5, data: { coeff: { 0x0AC119, 0x034181, 0x078AB1,
0x034181, 0x024BCA } } },
-
-  { channel: 1, filter: 0, data: { coeff: { 0x0FE143, 0xE05204, 0x0FCCC5,
0xE05266, 0x0FAE6B } } },
-  { channel: 1, filter: 1, data: { coeff: { 0x102383, 0xE03A03, 0x0FA325,
0xE03A03, 0x0FC6A8 } } },
-  { channel: 1, filter: 2, data: { coeff: { 0x0FF2AB, 0xE06285, 0x0FB20A,
0xE06285, 0x0FA4B5 } } },
-  { channel: 1, filter: 3, data: { coeff: { 0x0F544D, 0xE35971, 0x0D8F3A,
0xE35971, 0x0CE388 } } },
-  { channel: 1, filter: 4, data: { coeff: { 0x13E1D3, 0xF3ECB5, 0x042227,
0xF3ECB5, 0x0803FA } } },
-  { channel: 1, filter: 5, data: { coeff: { 0x0AC119, 0x034181, 0x078AB1,
0x034181, 0x024BCA } } },
+  { .channel = 0, .filter = 0, .data = { .coeff = { 0x0FE143, 0xE05204,
0x0FCCC5, 0xE05266, 0x0FAE6B } } },
+  { .channel = 0, .filter = 1, .data = { .coeff = { 0x102383, 0xE03A03,
0x0FA325, 0xE03A03, 0x0FC6A8 } } },
+  { .channel = 0, .filter = 2, .data = { .coeff = { 0x0FF2AB, 0xE06285,
0x0FB20A, 0xE06285, 0x0FA4B5 } } },
+  { .channel = 0, .filter = 3, .data = { .coeff = { 0x0F544D, 0xE35971,
0x0D8F3A, 0xE35971, 0x0CE388 } } },
+  { .channel = 0, .filter = 4, .data = { .coeff = { 0x13E1D3, 0xF3ECB5,
0x042227, 0xF3ECB5, 0x0803FA } } },
+  { .channel = 0, .filter = 5, .data = { .coeff = { 0x0AC119, 0x034181,
0x078AB1, 0x034181, 0x024BCA } } },
+
+  { .channel = 1, .filter = 0, .data = { .coeff = { 0x0FE143, 0xE05204,
0x0FCCC5, 0xE05266, 0x0FAE6B } } },
+  { .channel = 1, .filter = 1, .data = { .coeff = { 0x102383, 0xE03A03,
0x0FA325, 0xE03A03, 0x0FC6A8 } } },
+  { .channel = 1, .filter = 2, .data = { .coeff = { 0x0FF2AB, 0xE06285,
0x0FB20A, 0xE06285, 0x0FA4B5 } } },
+  { .channel = 1, .filter = 3, .data = { .coeff = { 0x0F544D, 0xE35971,
0x0D8F3A, 0xE35971, 0x0CE388 } } },
+  { .channel = 1, .filter = 4, .data = { .coeff = { 0x13E1D3, 0xF3ECB5,
0x042227, 0xF3ECB5, 0x0803FA } } },
+  { .channel = 1, .filter = 5, .data = { .coeff = { 0x0AC119, 0x034181,
0x078AB1, 0x034181, 0x024BCA } } },
 };

 static struct tas_eq_pref_t eqp_15_2_1 = {
-  sample_rate:  44100,
-  device_id:    0x15,
-  output_id:    TAS_OUTPUT_EXTERNAL_SPKR,
-  speaker_id:   0x01,
+  .sample_rate   = 44100,
+  .device_id     = 0x15,
+  .output_id     = TAS_OUTPUT_EXTERNAL_SPKR,
+  .speaker_id    = 0x01,

-  drce:         &eqp_15_2_1_drce,
+  .drce          = &eqp_15_2_1_drce,

-  filter_count: 12,
-  biquads:      eqp_15_2_1_biquads
+  .filter_count  = 12,
+  .biquads       = eqp_15_2_1_biquads
 };

 /* ========================================================================
*/

 static struct tas_drce_t eqp_15_1_0_drce={
-  enable:    1,
-  above:     { val: 3.0 * (1<<8), expand: 0 },
-  below:     { val: 1.0 * (1<<8), expand: 0 },
-  threshold: 0.0     * (1<<8),
-  energy:    2.4     * (1<<12),
-  attack:    0.013   * (1<<12),
-  decay:     0.212   * (1<<12),
+  .enable     = 1,
+  .above      = { .val = 3.0 * (1<<8), .expand = 0 },
+  .below      = { .val = 1.0 * (1<<8), .expand = 0 },
+  .threshold  = 0.0     * (1<<8),
+  .energy     = 2.4     * (1<<12),
+  .attack     = 0.013   * (1<<12),
+  .decay      = 0.212   * (1<<12),
 };

 static struct tas_biquad_ctrl_t eqp_15_1_0_biquads[]={
-  { channel: 0, filter: 0, data: { coeff: { 0x0FAD08, 0xE0A5EF, 0x0FAD08,
0xE0A79D, 0x0F5BBE } } },
-  { channel: 0, filter: 1, data: { coeff: { 0x04B38D, 0x09671B, 0x04B38D,
0x000F71, 0x02BEC5 } } },
-  { channel: 0, filter: 2, data: { coeff: { 0x0FDD32, 0xE0A56F, 0x0F8A69,
0xE0A56F, 0x0F679C } } },
-  { channel: 0, filter: 3, data: { coeff: { 0x0FD284, 0xE135FB, 0x0F2161,
0xE135FB, 0x0EF3E5 } } },
-  { channel: 0, filter: 4, data: { coeff: { 0x0E81B1, 0xE6283F, 0x0CE49D,
0xE6283F, 0x0B664F } } },
-  { channel: 0, filter: 5, data: { coeff: { 0x0F2D62, 0xE98797, 0x0D1E19,
0xE98797, 0x0C4B7B } } },
-
-  { channel: 1, filter: 0, data: { coeff: { 0x0FAD08, 0xE0A5EF, 0x0FAD08,
0xE0A79D, 0x0F5BBE } } },
-  { channel: 1, filter: 1, data: { coeff: { 0x04B38D, 0x09671B, 0x04B38D,
0x000F71, 0x02BEC5 } } },
-  { channel: 1, filter: 2, data: { coeff: { 0x0FDD32, 0xE0A56F, 0x0F8A69,
0xE0A56F, 0x0F679C } } },
-  { channel: 1, filter: 3, data: { coeff: { 0x0FD284, 0xE135FB, 0x0F2161,
0xE135FB, 0x0EF3E5 } } },
-  { channel: 1, filter: 4, data: { coeff: { 0x0E81B1, 0xE6283F, 0x0CE49D,
0xE6283F, 0x0B664F } } },
-  { channel: 1, filter: 5, data: { coeff: { 0x0F2D62, 0xE98797, 0x0D1E19,
0xE98797, 0x0C4B7B } } },
+  { .channel = 0, .filter = 0, .data = { .coeff = { 0x0FAD08, 0xE0A5EF,
0x0FAD08, 0xE0A79D, 0x0F5BBE } } },
+  { .channel = 0, .filter = 1, .data = { .coeff = { 0x04B38D, 0x09671B,
0x04B38D, 0x000F71, 0x02BEC5 } } },
+  { .channel = 0, .filter = 2, .data = { .coeff = { 0x0FDD32, 0xE0A56F,
0x0F8A69, 0xE0A56F, 0x0F679C } } },
+  { .channel = 0, .filter = 3, .data = { .coeff = { 0x0FD284, 0xE135FB,
0x0F2161, 0xE135FB, 0x0EF3E5 } } },
+  { .channel = 0, .filter = 4, .data = { .coeff = { 0x0E81B1, 0xE6283F,
0x0CE49D, 0xE6283F, 0x0B664F } } },
+  { .channel = 0, .filter = 5, .data = { .coeff = { 0x0F2D62, 0xE98797,
0x0D1E19, 0xE98797, 0x0C4B7B } } },
+
+  { .channel = 1, .filter = 0, .data = { .coeff = { 0x0FAD08, 0xE0A5EF,
0x0FAD08, 0xE0A79D, 0x0F5BBE } } },
+  { .channel = 1, .filter = 1, .data = { .coeff = { 0x04B38D, 0x09671B,
0x04B38D, 0x000F71, 0x02BEC5 } } },
+  { .channel = 1, .filter = 2, .data = { .coeff = { 0x0FDD32, 0xE0A56F,
0x0F8A69, 0xE0A56F, 0x0F679C } } },
+  { .channel = 1, .filter = 3, .data = { .coeff = { 0x0FD284, 0xE135FB,
0x0F2161, 0xE135FB, 0x0EF3E5 } } },
+  { .channel = 1, .filter = 4, .data = { .coeff = { 0x0E81B1, 0xE6283F,
0x0CE49D, 0xE6283F, 0x0B664F } } },
+  { .channel = 1, .filter = 5, .data = { .coeff = { 0x0F2D62, 0xE98797,
0x0D1E19, 0xE98797, 0x0C4B7B } } },
 };

 static struct tas_eq_pref_t eqp_15_1_0 = {
-  sample_rate:  44100,
-  device_id:    0x15,
-  output_id:    TAS_OUTPUT_INTERNAL_SPKR,
-  speaker_id:   0x00,
+  .sample_rate   = 44100,
+  .device_id     = 0x15,
+  .output_id     = TAS_OUTPUT_INTERNAL_SPKR,
+  .speaker_id    = 0x00,

-  drce:         &eqp_15_1_0_drce,
+  .drce          = &eqp_15_1_0_drce,

-  filter_count: 12,
-  biquads:      eqp_15_1_0_biquads
+  .filter_count  = 12,
+  .biquads       = eqp_15_1_0_biquads
 };

 /* ========================================================================
*/

 static struct tas_drce_t eqp_0f_2_1_drce={
-  enable:    1,
-  above:     { val: 3.0 * (1<<8), expand: 0 },
-  below:     { val: 1.0 * (1<<8), expand: 0 },
-  threshold: -15.33  * (1<<8),
-  energy:    2.4     * (1<<12),
-  attack:    0.013   * (1<<12),
-  decay:     0.212   * (1<<12),
+  .enable     = 1,
+  .above      = { .val = 3.0 * (1<<8), .expand = 0 },
+  .below      = { .val = 1.0 * (1<<8), .expand = 0 },
+  .threshold  = -15.33  * (1<<8),
+  .energy     = 2.4     * (1<<12),
+  .attack     = 0.013   * (1<<12),
+  .decay      = 0.212   * (1<<12),
 };

 static struct tas_biquad_ctrl_t eqp_0f_2_1_biquads[]={
-  { channel: 0, filter: 0, data: { coeff: { 0x0FE143, 0xE05204, 0x0FCCC5,
0xE05266, 0x0FAE6B } } },
-  { channel: 0, filter: 1, data: { coeff: { 0x102383, 0xE03A03, 0x0FA325,
0xE03A03, 0x0FC6A8 } } },
-  { channel: 0, filter: 2, data: { coeff: { 0x0FF2AB, 0xE06285, 0x0FB20A,
0xE06285, 0x0FA4B5 } } },
-  { channel: 0, filter: 3, data: { coeff: { 0x0F544D, 0xE35971, 0x0D8F3A,
0xE35971, 0x0CE388 } } },
-  { channel: 0, filter: 4, data: { coeff: { 0x13E1D3, 0xF3ECB5, 0x042227,
0xF3ECB5, 0x0803FA } } },
-  { channel: 0, filter: 5, data: { coeff: { 0x0AC119, 0x034181, 0x078AB1,
0x034181, 0x024BCA } } },
-
-  { channel: 1, filter: 0, data: { coeff: { 0x0FE143, 0xE05204, 0x0FCCC5,
0xE05266, 0x0FAE6B } } },
-  { channel: 1, filter: 1, data: { coeff: { 0x102383, 0xE03A03, 0x0FA325,
0xE03A03, 0x0FC6A8 } } },
-  { channel: 1, filter: 2, data: { coeff: { 0x0FF2AB, 0xE06285, 0x0FB20A,
0xE06285, 0x0FA4B5 } } },
-  { channel: 1, filter: 3, data: { coeff: { 0x0F544D, 0xE35971, 0x0D8F3A,
0xE35971, 0x0CE388 } } },
-  { channel: 1, filter: 4, data: { coeff: { 0x13E1D3, 0xF3ECB5, 0x042227,
0xF3ECB5, 0x0803FA } } },
-  { channel: 1, filter: 5, data: { coeff: { 0x0AC119, 0x034181, 0x078AB1,
0x034181, 0x024BCA } } },
+  { .channel = 0, .filter = 0, .data = { .coeff = { 0x0FE143, 0xE05204,
0x0FCCC5, 0xE05266, 0x0FAE6B } } },
+  { .channel = 0, .filter = 1, .data = { .coeff = { 0x102383, 0xE03A03,
0x0FA325, 0xE03A03, 0x0FC6A8 } } },
+  { .channel = 0, .filter = 2, .data = { .coeff = { 0x0FF2AB, 0xE06285,
0x0FB20A, 0xE06285, 0x0FA4B5 } } },
+  { .channel = 0, .filter = 3, .data = { .coeff = { 0x0F544D, 0xE35971,
0x0D8F3A, 0xE35971, 0x0CE388 } } },
+  { .channel = 0, .filter = 4, .data = { .coeff = { 0x13E1D3, 0xF3ECB5,
0x042227, 0xF3ECB5, 0x0803FA } } },
+  { .channel = 0, .filter = 5, .data = { .coeff = { 0x0AC119, 0x034181,
0x078AB1, 0x034181, 0x024BCA } } },
+
+  { .channel = 1, .filter = 0, .data = { .coeff = { 0x0FE143, 0xE05204,
0x0FCCC5, 0xE05266, 0x0FAE6B } } },
+  { .channel = 1, .filter = 1, .data = { .coeff = { 0x102383, 0xE03A03,
0x0FA325, 0xE03A03, 0x0FC6A8 } } },
+  { .channel = 1, .filter = 2, .data = { .coeff = { 0x0FF2AB, 0xE06285,
0x0FB20A, 0xE06285, 0x0FA4B5 } } },
+  { .channel = 1, .filter = 3, .data = { .coeff = { 0x0F544D, 0xE35971,
0x0D8F3A, 0xE35971, 0x0CE388 } } },
+  { .channel = 1, .filter = 4, .data = { .coeff = { 0x13E1D3, 0xF3ECB5,
0x042227, 0xF3ECB5, 0x0803FA } } },
+  { .channel = 1, .filter = 5, .data = { .coeff = { 0x0AC119, 0x034181,
0x078AB1, 0x034181, 0x024BCA } } },
 };

 static struct tas_eq_pref_t eqp_0f_2_1 = {
-  sample_rate:  44100,
-  device_id:    0x0f,
-  output_id:    TAS_OUTPUT_EXTERNAL_SPKR,
-  speaker_id:   0x01,
+  .sample_rate   = 44100,
+  .device_id     = 0x0f,
+  .output_id     = TAS_OUTPUT_EXTERNAL_SPKR,
+  .speaker_id    = 0x01,

-  drce:         &eqp_0f_2_1_drce,
+  .drce          = &eqp_0f_2_1_drce,

-  filter_count: 12,
-  biquads:      eqp_0f_2_1_biquads
+  .filter_count  = 12,
+  .biquads       = eqp_0f_2_1_biquads
 };

 /* ========================================================================
*/

 static struct tas_drce_t eqp_0f_1_0_drce={
-  enable:    1,
-  above:     { val: 3.0 * (1<<8), expand: 0 },
-  below:     { val: 1.0 * (1<<8), expand: 0 },
-  threshold: -15.33  * (1<<8),
-  energy:    2.4     * (1<<12),
-  attack:    0.013   * (1<<12),
-  decay:     0.212   * (1<<12),
+  .enable     = 1,
+  .above      = { .val = 3.0 * (1<<8), .expand = 0 },
+  .below      = { .val = 1.0 * (1<<8), .expand = 0 },
+  .threshold  = -15.33  * (1<<8),
+  .energy     = 2.4     * (1<<12),
+  .attack     = 0.013   * (1<<12),
+  .decay      = 0.212   * (1<<12),
 };

 static struct tas_biquad_ctrl_t eqp_0f_1_0_biquads[]={
-  { channel: 0, filter: 0, data: { coeff: { 0x0FCAD3, 0xE06A58, 0x0FCAD3,
0xE06B09, 0x0F9657 } } },
-  { channel: 0, filter: 1, data: { coeff: { 0x041731, 0x082E63, 0x041731,
0xFD8D08, 0x02CFBD } } },
-  { channel: 0, filter: 2, data: { coeff: { 0x0FFDC7, 0xE0524C, 0x0FBFAA,
0xE0524C, 0x0FBD72 } } },
-  { channel: 0, filter: 3, data: { coeff: { 0x0F3D35, 0xE228CA, 0x0EC7B2,
0xE228CA, 0x0E04E8 } } },
-  { channel: 0, filter: 4, data: { coeff: { 0x0FCEBF, 0xE181C2, 0x0F2656,
0xE181C2, 0x0EF516 } } },
-  { channel: 0, filter: 5, data: { coeff: { 0x0EC417, 0x073E22, 0x0B0633,
0x073E22, 0x09CA4A } } },
-
-  { channel: 1, filter: 0, data: { coeff: { 0x0FCAD3, 0xE06A58, 0x0FCAD3,
0xE06B09, 0x0F9657 } } },
-  { channel: 1, filter: 1, data: { coeff: { 0x041731, 0x082E63, 0x041731,
0xFD8D08, 0x02CFBD } } },
-  { channel: 1, filter: 2, data: { coeff: { 0x0FFDC7, 0xE0524C, 0x0FBFAA,
0xE0524C, 0x0FBD72 } } },
-  { channel: 1, filter: 3, data: { coeff: { 0x0F3D35, 0xE228CA, 0x0EC7B2,
0xE228CA, 0x0E04E8 } } },
-  { channel: 1, filter: 4, data: { coeff: { 0x0FCEBF, 0xE181C2, 0x0F2656,
0xE181C2, 0x0EF516 } } },
-  { channel: 1, filter: 5, data: { coeff: { 0x0EC417, 0x073E22, 0x0B0633,
0x073E22, 0x09CA4A } } },
+  { .channel = 0, .filter = 0, .data = { .coeff = { 0x0FCAD3, 0xE06A58,
0x0FCAD3, 0xE06B09, 0x0F9657 } } },
+  { .channel = 0, .filter = 1, .data = { .coeff = { 0x041731, 0x082E63,
0x041731, 0xFD8D08, 0x02CFBD } } },
+  { .channel = 0, .filter = 2, .data = { .coeff = { 0x0FFDC7, 0xE0524C,
0x0FBFAA, 0xE0524C, 0x0FBD72 } } },
+  { .channel = 0, .filter = 3, .data = { .coeff = { 0x0F3D35, 0xE228CA,
0x0EC7B2, 0xE228CA, 0x0E04E8 } } },
+  { .channel = 0, .filter = 4, .data = { .coeff = { 0x0FCEBF, 0xE181C2,
0x0F2656, 0xE181C2, 0x0EF516 } } },
+  { .channel = 0, .filter = 5, .data = { .coeff = { 0x0EC417, 0x073E22,
0x0B0633, 0x073E22, 0x09CA4A } } },
+
+  { .channel = 1, .filter = 0, .data = { .coeff = { 0x0FCAD3, 0xE06A58,
0x0FCAD3, 0xE06B09, 0x0F9657 } } },
+  { .channel = 1, .filter = 1, .data = { .coeff = { 0x041731, 0x082E63,
0x041731, 0xFD8D08, 0x02CFBD } } },
+  { .channel = 1, .filter = 2, .data = { .coeff = { 0x0FFDC7, 0xE0524C,
0x0FBFAA, 0xE0524C, 0x0FBD72 } } },
+  { .channel = 1, .filter = 3, .data = { .coeff = { 0x0F3D35, 0xE228CA,
0x0EC7B2, 0xE228CA, 0x0E04E8 } } },
+  { .channel = 1, .filter = 4, .data = { .coeff = { 0x0FCEBF, 0xE181C2,
0x0F2656, 0xE181C2, 0x0EF516 } } },
+  { .channel = 1, .filter = 5, .data = { .coeff = { 0x0EC417, 0x073E22,
0x0B0633, 0x073E22, 0x09CA4A } } },
 };

 static struct tas_eq_pref_t eqp_0f_1_0 = {
-  sample_rate:  44100,
-  device_id:    0x0f,
-  output_id:    TAS_OUTPUT_INTERNAL_SPKR,
-  speaker_id:   0x00,
+  .sample_rate   = 44100,
+  .device_id     = 0x0f,
+  .output_id     = TAS_OUTPUT_INTERNAL_SPKR,
+  .speaker_id    = 0x00,

-  drce:         &eqp_0f_1_0_drce,
+  .drce          = &eqp_0f_1_0_drce,

-  filter_count: 12,
-  biquads:      eqp_0f_1_0_biquads
+  .filter_count  = 12,
+  .biquads       = eqp_0f_1_0_biquads
 };

 /* ========================================================================
*/
@@ -358,10 +358,10 @@
 };

 struct tas_gain_t tas3001c_gain = {
-  master: tas3001c_master_tab,
-  treble: tas3001c_treble_tab,
-  bass:   tas3001c_bass_tab,
-  mixer:  tas3001c_mixer_tab
+  .master  = tas3001c_master_tab,
+  .treble  = tas3001c_treble_tab,
+  .bass    = tas3001c_bass_tab,
+  .mixer   = tas3001c_mixer_tab
 };

 struct tas_eq_pref_t *tas3001c_eq_prefs[]={
--- linux/sound/oss/dmasound/tas3001c.c~2003-12-19 23:10:14.321891048 +0100
+++ linux/sound/oss/dmasound/tas3001c.c2003-12-19 23:10:14.321891048 +0100
@@ -55,7 +55,7 @@

 static const union tas_biquad_t
 tas3001c_eq_unity={
-buf: { 0x100000, 0x000000, 0x000000, 0x000000, 0x000000 }
+.buf = { 0x100000, 0x000000, 0x000000, 0x000000, 0x000000 }
 };


--- linux/sound/oss/sb_card.h~2003-12-19 23:18:15.664715816 +0100
+++ linux/sound/oss/sb_card.h2003-12-19 23:18:15.664715816 +0100
@@ -25,119 +25,119 @@
 /* Card PnP ID Table */
 static struct pnp_card_device_id sb_pnp_card_table[] = {
 /* Sound Blaster 16 */
-{.id = "CTL0024", .driver_data = 0, devs : { {.id="CTL0031"}, } },
+{.id = "CTL0024", .driver_data = 0, .devs = { {.id="CTL0031"}, } },
 /* Sound Blaster 16 */
-{.id = "CTL0025", .driver_data = 0, devs : { {.id="CTL0031"}, } },
+{.id = "CTL0025", .driver_data = 0, .devs = { {.id="CTL0031"}, } },
 /* Sound Blaster 16 */
-{.id = "CTL0026", .driver_data = 0, devs : { {.id="CTL0031"}, } },
+{.id = "CTL0026", .driver_data = 0, .devs = { {.id="CTL0031"}, } },
 /* Sound Blaster 16 */
-{.id = "CTL0027", .driver_data = 0, devs : { {.id="CTL0031"}, } },
+{.id = "CTL0027", .driver_data = 0, .devs = { {.id="CTL0031"}, } },
 /* Sound Blaster 16 */
-{.id = "CTL0028", .driver_data = 0, devs : { {.id="CTL0031"}, } },
+{.id = "CTL0028", .driver_data = 0, .devs = { {.id="CTL0031"}, } },
 /* Sound Blaster 16 */
-{.id = "CTL0029", .driver_data = 0, devs : { {.id="CTL0031"}, } },
+{.id = "CTL0029", .driver_data = 0, .devs = { {.id="CTL0031"}, } },
 /* Sound Blaster 16 */
-{.id = "CTL002a", .driver_data = 0, devs : { {.id="CTL0031"}, } },
+{.id = "CTL002a", .driver_data = 0, .devs = { {.id="CTL0031"}, } },
 /* Sound Blaster 16 */
-{.id = "CTL002b", .driver_data = 0, devs : { {.id="CTL0031"}, } },
+{.id = "CTL002b", .driver_data = 0, .devs = { {.id="CTL0031"}, } },
 /* Sound Blaster 16 */
-{.id = "CTL002c", .driver_data = 0, devs : { {.id="CTL0031"}, } },
+{.id = "CTL002c", .driver_data = 0, .devs = { {.id="CTL0031"}, } },
 /* Sound Blaster 16 */
-{.id = "CTL00ed", .driver_data = 0, devs : { {.id="CTL0041"}, } },
+{.id = "CTL00ed", .driver_data = 0, .devs = { {.id="CTL0041"}, } },
 /* Sound Blaster 16 */
-{.id = "CTL0086", .driver_data = 0, devs : { {.id="CTL0041"}, } },
+{.id = "CTL0086", .driver_data = 0, .devs = { {.id="CTL0041"}, } },
 /* Sound Blaster Vibra16S */
-{.id = "CTL0051", .driver_data = 0, devs : { {.id="CTL0001"}, } },
+{.id = "CTL0051", .driver_data = 0, .devs = { {.id="CTL0001"}, } },
 /* Sound Blaster Vibra16C */
-{.id = "CTL0070", .driver_data = 0, devs : { {.id="CTL0001"}, } },
+{.id = "CTL0070", .driver_data = 0, .devs = { {.id="CTL0001"}, } },
 /* Sound Blaster Vibra16CL */
-{.id = "CTL0080", .driver_data = 0, devs : { {.id="CTL0041"}, } },
+{.id = "CTL0080", .driver_data = 0, .devs = { {.id="CTL0041"}, } },
 /* Sound Blaster Vibra16CL */
-{.id = "CTL00F0", .driver_data = 0, devs : { {.id="CTL0043"}, } },
+{.id = "CTL00F0", .driver_data = 0, .devs = { {.id="CTL0043"}, } },
 /* Sound Blaster AWE 32 */
-{.id = "CTL0039", .driver_data = 0, devs : { {.id="CTL0031"}, } },
+{.id = "CTL0039", .driver_data = 0, .devs = { {.id="CTL0031"}, } },
 /* Sound Blaster AWE 32 */
-{.id = "CTL0042", .driver_data = 0, devs : { {.id="CTL0031"}, } },
+{.id = "CTL0042", .driver_data = 0, .devs = { {.id="CTL0031"}, } },
 /* Sound Blaster AWE 32 */
-{.id = "CTL0043", .driver_data = 0, devs : { {.id="CTL0031"}, } },
+{.id = "CTL0043", .driver_data = 0, .devs = { {.id="CTL0031"}, } },
 /* Sound Blaster AWE 32 */
-{.id = "CTL0044", .driver_data = 0, devs : { {.id="CTL0031"}, } },
+{.id = "CTL0044", .driver_data = 0, .devs = { {.id="CTL0031"}, } },
 /* Sound Blaster AWE 32 */
-{.id = "CTL0045", .driver_data = 0, devs : { {.id="CTL0031"}, } },
+{.id = "CTL0045", .driver_data = 0, .devs = { {.id="CTL0031"}, } },
 /* Sound Blaster AWE 32 */
-{.id = "CTL0046", .driver_data = 0, devs : { {.id="CTL0031"}, } },
+{.id = "CTL0046", .driver_data = 0, .devs = { {.id="CTL0031"}, } },
 /* Sound Blaster AWE 32 */
-{.id = "CTL0047", .driver_data = 0, devs : { {.id="CTL0031"}, } },
+{.id = "CTL0047", .driver_data = 0, .devs = { {.id="CTL0031"}, } },
 /* Sound Blaster AWE 32 */
-{.id = "CTL0048", .driver_data = 0, devs : { {.id="CTL0031"}, } },
+{.id = "CTL0048", .driver_data = 0, .devs = { {.id="CTL0031"}, } },
 /* Sound Blaster AWE 32 */
-{.id = "CTL0054", .driver_data = 0, devs : { {.id="CTL0031"}, } },
+{.id = "CTL0054", .driver_data = 0, .devs = { {.id="CTL0031"}, } },
 /* Sound Blaster AWE 32 */
-{.id = "CTL009C", .driver_data = 0, devs : { {.id="CTL0041"}, } },
+{.id = "CTL009C", .driver_data = 0, .devs = { {.id="CTL0041"}, } },
 /* Createive SB32 PnP */
-{.id = "CTL009F", .driver_data = 0, devs : { {.id="CTL0041"}, } },
+{.id = "CTL009F", .driver_data = 0, .devs = { {.id="CTL0041"}, } },
 /* Sound Blaster AWE 64 */
-{.id = "CTL009D", .driver_data = 0, devs : { {.id="CTL0042"}, } },
+{.id = "CTL009D", .driver_data = 0, .devs = { {.id="CTL0042"}, } },
 /* Sound Blaster AWE 64 Gold */
-{.id = "CTL009E", .driver_data = 0, devs : { {.id="CTL0044"}, } },
+{.id = "CTL009E", .driver_data = 0, .devs = { {.id="CTL0044"}, } },
 /* Sound Blaster AWE 64 Gold */
-{.id = "CTL00B2", .driver_data = 0, devs : { {.id="CTL0044"}, } },
+{.id = "CTL00B2", .driver_data = 0, .devs = { {.id="CTL0044"}, } },
 /* Sound Blaster AWE 64 */
-{.id = "CTL00C1", .driver_data = 0, devs : { {.id="CTL0042"}, } },
+{.id = "CTL00C1", .driver_data = 0, .devs = { {.id="CTL0042"}, } },
 /* Sound Blaster AWE 64 */
-{.id = "CTL00C3", .driver_data = 0, devs : { {.id="CTL0045"}, } },
+{.id = "CTL00C3", .driver_data = 0, .devs = { {.id="CTL0045"}, } },
 /* Sound Blaster AWE 64 */
-{.id = "CTL00C5", .driver_data = 0, devs : { {.id="CTL0045"}, } },
+{.id = "CTL00C5", .driver_data = 0, .devs = { {.id="CTL0045"}, } },
 /* Sound Blaster AWE 64 */
-{.id = "CTL00C7", .driver_data = 0, devs : { {.id="CTL0045"}, } },
+{.id = "CTL00C7", .driver_data = 0, .devs = { {.id="CTL0045"}, } },
 /* Sound Blaster AWE 64 */
-{.id = "CTL00E4", .driver_data = 0, devs : { {.id="CTL0045"}, } },
+{.id = "CTL00E4", .driver_data = 0, .devs = { {.id="CTL0045"}, } },
 /* Sound Blaster AWE 64 */
-{.id = "CTL00E9", .driver_data = 0, devs : { {.id="CTL0045"}, } },
+{.id = "CTL00E9", .driver_data = 0, .devs = { {.id="CTL0045"}, } },
 /* ESS 1868 */
-{.id = "ESS0968", .driver_data = 0, devs : { {.id="ESS0968"}, } },
+{.id = "ESS0968", .driver_data = 0, .devs = { {.id="ESS0968"}, } },
 /* ESS 1868 */
-{.id = "ESS1868", .driver_data = 0, devs : { {.id="ESS1868"}, } },
+{.id = "ESS1868", .driver_data = 0, .devs = { {.id="ESS1868"}, } },
 /* ESS 1868 */
-{.id = "ESS1868", .driver_data = 0, devs : { {.id="ESS8611"}, } },
+{.id = "ESS1868", .driver_data = 0, .devs = { {.id="ESS8611"}, } },
 /* ESS 1869 PnP AudioDrive */
-{.id = "ESS0003", .driver_data = 0, devs : { {.id="ESS1869"}, } },
+{.id = "ESS0003", .driver_data = 0, .devs = { {.id="ESS1869"}, } },
 /* ESS 1869 */
-{.id = "ESS1869", .driver_data = 0, devs : { {.id="ESS1869"}, } },
+{.id = "ESS1869", .driver_data = 0, .devs = { {.id="ESS1869"}, } },
 /* ESS 1878 */
-{.id = "ESS1878", .driver_data = 0, devs : { {.id="ESS1878"}, } },
+{.id = "ESS1878", .driver_data = 0, .devs = { {.id="ESS1878"}, } },
 /* ESS 1879 */
-{.id = "ESS1879", .driver_data = 0, devs : { {.id="ESS1879"}, } },
+{.id = "ESS1879", .driver_data = 0, .devs = { {.id="ESS1879"}, } },
 /* CMI 8330 SoundPRO */
-{.id = "CMI0001", .driver_data = 0, devs : { {.id="@X@0001"},
+{.id = "CMI0001", .driver_data = 0, .devs = { {.id="@X@0001"},
      {.id="@H@0001"},
      {.id="@@@0001"}, } },
 /* Diamond DT0197H */
-{.id = "RWR1688", .driver_data = 0, devs : { {.id="@@@0001"},
+{.id = "RWR1688", .driver_data = 0, .devs = { {.id="@@@0001"},
      {.id="@X@0001"},
      {.id="@H@0001"}, } },
 /* ALS007 */
-{.id = "ALS0007", .driver_data = 0, devs : { {.id="@@@0001"},
+{.id = "ALS0007", .driver_data = 0, .devs = { {.id="@@@0001"},
      {.id="@X@0001"},
      {.id="@H@0001"}, } },
 /* ALS100 */
-{.id = "ALS0001", .driver_data = 0, devs : { {.id="@@@0001"},
+{.id = "ALS0001", .driver_data = 0, .devs = { {.id="@@@0001"},
      {.id="@X@0001"},
      {.id="@H@0001"}, } },
 /* ALS110 */
-{.id = "ALS0110", .driver_data = 0, devs : { {.id="@@@1001"},
+{.id = "ALS0110", .driver_data = 0, .devs = { {.id="@@@1001"},
      {.id="@X@1001"},
      {.id="@H@0001"}, } },
 /* ALS120 */
-{.id = "ALS0120", .driver_data = 0, devs : { {.id="@@@2001"},
+{.id = "ALS0120", .driver_data = 0, .devs = { {.id="@@@2001"},
      {.id="@X@2001"},
      {.id="@H@0001"}, } },
 /* ALS200 */
-{.id = "ALS0200", .driver_data = 0, devs : { {.id="@@@0020"},
+{.id = "ALS0200", .driver_data = 0, .devs = { {.id="@@@0020"},
      {.id="@X@0030"},
      {.id="@H@0001"}, } },
 /* ALS200 */
-{.id = "RTL3000", .driver_data = 0, devs : { {.id="@@@2001"},
+{.id = "RTL3000", .driver_data = 0, .devs = { {.id="@@@2001"},
      {.id="@X@2001"},
      {.id="@H@0001"}, } },
 /* -end- */


