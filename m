Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261699AbVA3ND0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261699AbVA3ND0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jan 2005 08:03:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261700AbVA3ND0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jan 2005 08:03:26 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:19214 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261699AbVA3NDQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jan 2005 08:03:16 -0500
Date: Sun, 30 Jan 2005 14:03:14 +0100
From: Adrian Bunk <bunk@stusta.de>
To: greg@kroah.com, perex@suse.cz
Cc: alsa-devel@alsa-project.org, linux-usb-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: [2.6 patch] usbusx2yaudio.c: remove an unused variable
Message-ID: <20050130130314.GL3185@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In 2.6.11-rc a completely unused variable was added, resulting in the 
following compile warning:

<--  snip  -->

...
  CC      sound/usb/usx2y/usx2yhwdeppcm.o
In file included from sound/usb/usx2y/usx2yhwdeppcm.c:53:
sound/usb/usx2y/usbusx2yaudio.c: In function `usX2Y_urbs_allocate':
sound/usb/usx2y/usbusx2yaudio.c:418: warning: unused variable `ep'
...

<--  snip  -->


This patch removes this unused variable.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.11-rc2-mm2-full/sound/usb/usx2y/usbusx2yaudio.c.old	2005-01-30 12:26:58.000000000 +0100
+++ linux-2.6.11-rc2-mm2-full/sound/usb/usx2y/usbusx2yaudio.c	2005-01-30 12:27:03.000000000 +0100
@@ -415,7 +415,6 @@
 	unsigned int pipe;
 	int is_playback = subs == subs->usX2Y->subs[SNDRV_PCM_STREAM_PLAYBACK];
 	struct usb_device *dev = subs->usX2Y->chip.dev;
-	struct usb_host_endpoint *ep;
 
 	pipe = is_playback ? usb_sndisocpipe(dev, subs->endpoint) :
 			usb_rcvisocpipe(dev, subs->endpoint);

