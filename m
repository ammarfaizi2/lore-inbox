Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261274AbVCFBlX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261274AbVCFBlX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Mar 2005 20:41:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261276AbVCFBlX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Mar 2005 20:41:23 -0500
Received: from abo-131-24-69.mtz.modulonet.fr ([85.69.24.131]:2479 "EHLO
	gw.reolight.net") by vger.kernel.org with ESMTP id S261274AbVCFBlV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Mar 2005 20:41:21 -0500
Message-ID: <422A5FBE.8020700@reolight.net>
Date: Sun, 06 Mar 2005 02:41:18 +0100
From: Auzanneau Gregory <greg@reolight.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.7.5) Gecko/20050105 Debian/1.7.5-1
X-Accept-Language: fr, fr-fr, en, en-gb, en-us
MIME-Version: 1.0
To: Gerd Knorr <kraxel@bytesex.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] driver/media/video/saa7134/saa7134-dvd.c fix videobuf_dvb_register()
 on 2.6.11
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Fix parameters of videobuf_dvb_register

Signed-off-by: Gregory Auzanneau <greg@reolight.net>

 drivers/media/video/saa7134/saa7134-dvb.c |   2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

--- drivers/media/video/saa7134/saa7134-dvb.c.old       2005-03-02
08:38:12.000000000 +0100
+++ drivers/media/video/saa7134/saa7134-dvb.c   2005-03-06
02:20:39.243386096 +0100
@@ -53,7 +53,7 @@ static int dvb_init(struct saa7134_dev *
                return -1;

        /* register everything else */
-       return videobuf_dvb_register(&dev->dvb);
+       return videobuf_dvb_register(&dev->dvb, THIS_MODULE, dev);
 }

 static int dvb_fini(struct saa7134_dev *dev)

-- 
Auzanneau Grégory
GPG 0x99137BEE
