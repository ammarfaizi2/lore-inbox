Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932765AbVJ3AF2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932765AbVJ3AF2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Oct 2005 20:05:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932769AbVJ3AF1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Oct 2005 20:05:27 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:62473 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932765AbVJ3AF1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Oct 2005 20:05:27 -0400
Date: Sun, 30 Oct 2005 02:05:26 +0200
From: Adrian Bunk <bunk@stusta.de>
To: ralf@linux-mips.org
Cc: linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] OSS MIPS drivers: "extern inline" -> "static inline"
Message-ID: <20051030000526.GP4180@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"extern inline" doesn't make much sense.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 sound/oss/au1000.c      |    6 +++---
 sound/oss/nec_vrc5477.c |    6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

--- linux-2.6.14-rc5-mm1-full/sound/oss/au1000.c.old	2005-10-30 02:03:31.000000000 +0200
+++ linux-2.6.14-rc5-mm1-full/sound/oss/au1000.c	2005-10-30 02:03:38.000000000 +0200
@@ -563,7 +563,7 @@
 #define DMABUF_DEFAULTORDER (17-PAGE_SHIFT)
 #define DMABUF_MINORDER 1
 
-extern inline void dealloc_dmabuf(struct au1000_state *s, struct dmabuf *db)
+static inline void dealloc_dmabuf(struct au1000_state *s, struct dmabuf *db)
 {
 	struct page    *page, *pend;
 
@@ -667,14 +667,14 @@
 	return 0;
 }
 
-extern inline int prog_dmabuf_adc(struct au1000_state *s)
+static inline int prog_dmabuf_adc(struct au1000_state *s)
 {
 	stop_adc(s);
 	return prog_dmabuf(s, &s->dma_adc);
 
 }
 
-extern inline int prog_dmabuf_dac(struct au1000_state *s)
+static inline int prog_dmabuf_dac(struct au1000_state *s)
 {
 	stop_dac(s);
 	return prog_dmabuf(s, &s->dma_dac);
--- linux-2.6.14-rc5-mm1-full/sound/oss/nec_vrc5477.c.old	2005-10-30 02:03:46.000000000 +0200
+++ linux-2.6.14-rc5-mm1-full/sound/oss/nec_vrc5477.c	2005-10-30 02:03:56.000000000 +0200
@@ -435,7 +435,7 @@
 
 /* --------------------------------------------------------------------- */
 
-extern inline void
+static inline void
 stop_dac(struct vrc5477_ac97_state *s)
 {
 	struct dmabuf* db = &s->dma_dac;
@@ -553,7 +553,7 @@
 	spin_unlock_irqrestore(&s->lock, flags);
 }	
 
-extern inline void stop_adc(struct vrc5477_ac97_state *s)
+static inline void stop_adc(struct vrc5477_ac97_state *s)
 {
 	struct dmabuf* db = &s->dma_adc;
 	unsigned long flags;
@@ -652,7 +652,7 @@
 #define DMABUF_DEFAULTORDER (16-PAGE_SHIFT)
 #define DMABUF_MINORDER 1
 
-extern inline void dealloc_dmabuf(struct vrc5477_ac97_state *s,
+static inline void dealloc_dmabuf(struct vrc5477_ac97_state *s,
 				  struct dmabuf *db)
 {
 	if (db->lbuf) {

