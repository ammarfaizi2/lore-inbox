Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261293AbVAaSP1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261293AbVAaSP1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 13:15:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261295AbVAaSP1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 13:15:27 -0500
Received: from relay1.tiscali.de ([62.26.116.129]:24500 "EHLO
	webmail.tiscali.de") by vger.kernel.org with ESMTP id S261293AbVAaSPX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 13:15:23 -0500
Message-ID: <41FE83C6.1030602@tiscali.de>
Date: Mon, 31 Jan 2005 20:15:18 +0100
From: Matthias-Christian Ott <matthias.christian@tiscali.de>
User-Agent: Mozilla Thunderbird 1.0 (X11/20050108)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Takashi Iwai <tiwai@suse.de>, trivial@rustcorp.com.au
Subject: [2.6 PATCH] sound/usb/usx2y/usbusx2yaudio.c: remove unused ep
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The pointer ep was not used.

Signed-off-by: Matthias-Christian Ott <matthias.christian@tiscali.de>

diff -Nrup linux-2.6.11-rc2/sound/usb/usx2y/usbusx2yaudio.c 
linux-2.6.11-rc2-ott/sound/usb/usx2y/usbusx2yaudio.c
--- linux-2.6.11-rc2/sound/usb/usx2y/usbusx2yaudio.c    2005-01-26 
22:27:37.000000000 +0100
+++ linux-2.6.11-rc2-ott/sound/usb/usx2y/usbusx2yaudio.c    2005-01-31 
19:56:57.000000000 +0100
@@ -415,7 +415,6 @@ static int usX2Y_urbs_allocate(snd_usX2Y
     unsigned int pipe;
     int is_playback = subs == subs->usX2Y->subs[SNDRV_PCM_STREAM_PLAYBACK];
     struct usb_device *dev = subs->usX2Y->chip.dev;
-    struct usb_host_endpoint *ep;
 
     pipe = is_playback ? usb_sndisocpipe(dev, subs->endpoint) :
             usb_rcvisocpipe(dev, subs->endpoint);

