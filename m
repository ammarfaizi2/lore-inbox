Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932140AbWDJWSE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932140AbWDJWSE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Apr 2006 18:18:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932144AbWDJWSD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Apr 2006 18:18:03 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:19218 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932140AbWDJWSB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Apr 2006 18:18:01 -0400
Date: Tue, 11 Apr 2006 00:18:01 +0200
From: Adrian Bunk <bunk@stusta.de>
To: perex@suse.cz
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] sound/core/pcm.c: make snd_pcm_format_name() static
Message-ID: <20060410221801.GK2408@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes the needlessly global snd_pcm_format_name() static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 include/sound/pcm.h |    1 -
 sound/core/pcm.c    |    2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

--- linux-2.6.17-rc1-mm2-full/include/sound/pcm.h.old	2006-04-10 23:34:28.000000000 +0200
+++ linux-2.6.17-rc1-mm2-full/include/sound/pcm.h	2006-04-10 23:34:38.000000000 +0200
@@ -898,7 +898,6 @@
 const unsigned char *snd_pcm_format_silence_64(snd_pcm_format_t format);
 int snd_pcm_format_set_silence(snd_pcm_format_t format, void *buf, unsigned int frames);
 snd_pcm_format_t snd_pcm_build_linear_format(int width, int unsignd, int big_endian);
-const char *snd_pcm_format_name(snd_pcm_format_t format);
 
 void snd_pcm_set_ops(struct snd_pcm * pcm, int direction, struct snd_pcm_ops *ops);
 void snd_pcm_set_sync(struct snd_pcm_substream *substream);
--- linux-2.6.17-rc1-mm2-full/sound/core/pcm.c.old	2006-04-10 23:32:17.000000000 +0200
+++ linux-2.6.17-rc1-mm2-full/sound/core/pcm.c	2006-04-10 23:32:42.000000000 +0200
@@ -196,7 +196,7 @@
 	FORMAT(U18_3BE),
 };
 
-const char *snd_pcm_format_name(snd_pcm_format_t format)
+static const char *snd_pcm_format_name(snd_pcm_format_t format)
 {
 	return snd_pcm_format_names[format];
 }

