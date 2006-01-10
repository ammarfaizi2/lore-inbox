Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932116AbWAJN0r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932116AbWAJN0r (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 08:26:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932195AbWAJN0r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 08:26:47 -0500
Received: from xproxy.gmail.com ([66.249.82.205]:48164 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932138AbWAJN0r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 08:26:47 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=jaU7gSfSYXiULggRU5GC+VKi9kjMwkzLzzBMd6+DurtvD/pE00Y2zJUqCMYFrCgZ2Ocv6+8G/X5t0qRhckDL+EpjWNSCNuwDnhPkCSt3MmuSxDUvpw7gJ7d+iiWQ/sVXzE20z6XBEtfAHuUrd6ubZxelt4Yd2o55Ya8tWEXQc0Q=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Linux List <linux-kernel@vger.kernel.org>
Subject: [PATCH] remove unused out_pio label in i810_audio
Date: Tue, 10 Jan 2006 14:26:43 +0100
User-Agent: KMail/1.9
Cc: Alan Cox <alan@redhat.com>, Jaroslav Kysela <perex@suse.cz>,
       Thomas Sailer <sailer@ife.ee.ethz.ch>, Zach Brown <zab@redhat.com>,
       dwmw2@infradead.org, Andrew Morton <akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601101426.44023.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jesper Juhl <jesper.juhl@gmail.com>

When the patch titled "i810_audio: request_irq() fix" went in, the "out_pio"
label became unused, leading to this compiler warning :
  sound/oss/i810_audio.c:3431: warning: label `out_pio' defined but not used
The following patch removes the now unused label.

Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com
---
 sound/oss/i810_audio.c |    1 -
 1 files changed, 1 deletion(-)
--- linux-2.6.15-mm2-orig/sound/oss/i810_audio.c	2006-01-07 14:46:33.000000000 +0100
+++ linux-2.6.15-mm2/sound/oss/i810_audio.c	2006-01-10 14:22:56.000000000 +0100
@@ -3428,7 +3428,6 @@ out_iospace:
 		release_mem_region(card->ac97base_mmio_phys, 512);
 		release_mem_region(card->iobase_mmio_phys, 256);
 	}
-out_pio:	
 	release_region(card->ac97base, 256);
 out_region2:
 	release_region(card->iobase, 64);

