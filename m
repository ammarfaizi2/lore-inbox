Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932289AbWAPJ26@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932289AbWAPJ26 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jan 2006 04:28:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932281AbWAPJXM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jan 2006 04:23:12 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:38635 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932266AbWAPJXH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jan 2006 04:23:07 -0500
From: mchehab@infradead.org
To: linux-kernel@vger.kernel.org
Cc: linux-dvb-maintainer@linuxtv.org, video4linux-list@redhat.com,
       akpm@osdl.org, Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 13/25] cx88 Kconfig fixes for cx88-alsa
Date: Mon, 16 Jan 2006 07:11:22 -0200
Message-id: <20060116091122.PS42877600013@infradead.org>
In-Reply-To: <20060116091105.PS83611600000@infradead.org>
References: <20060116091105.PS83611600000@infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1-1mdk 
Content-Transfer-Encoding: 7bit
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Mauro Carvalho Chehab <mchehab@infradead.org>

- Cx88 alsa is experimental.
- Removed need of PCM OSS for an ALSA module.

Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

 drivers/media/video/cx88/Kconfig |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/drivers/media/video/cx88/Kconfig b/drivers/media/video/cx88/Kconfig
index 76fcb4e..5330891 100644
--- a/drivers/media/video/cx88/Kconfig
+++ b/drivers/media/video/cx88/Kconfig
@@ -31,8 +31,7 @@ config VIDEO_CX88_DVB
 
 config VIDEO_CX88_ALSA
 	tristate "ALSA DMA audio support"
-	depends on VIDEO_CX88 && SND
-	select SND_PCM_OSS
+	depends on VIDEO_CX88 && SND && EXPERIMENTAL
 	---help---
 	  This is a video4linux driver for direct (DMA) audio on
 	  Conexant 2388x based TV cards.

