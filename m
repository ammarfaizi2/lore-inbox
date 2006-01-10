Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751177AbWAJEGJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751177AbWAJEGJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 23:06:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751178AbWAJEGI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 23:06:08 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:8718 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751177AbWAJEGH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 23:06:07 -0500
Date: Tue, 10 Jan 2006 05:06:05 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Ricardo Cerqueira <v4l@cerqueira.org>
Cc: mchehab@brturbo.com.br, video4linux-list@redhat.com,
       linux-kernel@vger.kernel.org
Subject: [2.6 patch] VIDEO_SAA7134_ALSA shouldn't select SND_PCM_OSS
Message-ID: <20060110040605.GA3911@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There's no reason for an ALSA driver to select an OSS legacy userspace 
interface.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.15-mm2/drivers/media/video/saa7134/Kconfig.old	2006-01-10 02:59:30.000000000 +0100
+++ linux-2.6.15-mm2/drivers/media/video/saa7134/Kconfig	2006-01-10 03:02:57.000000000 +0100
@@ -15,7 +15,7 @@
 config VIDEO_SAA7134_ALSA
 	tristate "Philips SAA7134 DMA audio support"
 	depends on VIDEO_SAA7134 && SND
-	select SND_PCM_OSS
+	select SND_PCM
 	---help---
 	  This is a video4linux driver for direct (DMA) audio in
 	  Philips SAA713x based TV cards using ALSA

