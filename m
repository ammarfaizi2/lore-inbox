Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932212AbVKJWi1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932212AbVKJWi1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 17:38:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932213AbVKJWi0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 17:38:26 -0500
Received: from kirby.webscope.com ([204.141.84.57]:47589 "EHLO
	kirby.webscope.com") by vger.kernel.org with ESMTP id S932212AbVKJWi0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 17:38:26 -0500
Message-ID: <4373CBC6.4080305@linuxtv.org>
Date: Thu, 10 Nov 2005 17:37:58 -0500
From: Mike Krufky <mkrufky@linuxtv.org>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Linux and Kernel Video <video4linux-list@redhat.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Mauro Carvalho Chehab <mauro_chehab@yahoo.com.br>
Subject: [PATCH 21/20] v4l: prevent saa7134 alsa undefined warnings
Content-Type: multipart/mixed;
 boundary="------------050803020006020907040301"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050803020006020907040301
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit



--------------050803020006020907040301
Content-Type: text/x-patch;
 name="prevent-saa7134-alsa-undefined-warnings.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="prevent-saa7134-alsa-undefined-warnings.patch"

Prevent the following build warnings:

*** Warning: "snd_card_free" 
*** Warning: "snd_card_register" 
*** Warning: "snd_device_new" 
*** Warning: "snd_card_new" 
*** Warning: "snd_ctl_add"
*** Warning: "snd_ctl_new1" 
*** Warning: "snd_pcm_set_ops" 
*** Warning: "snd_pcm_new"
*** Warning: "snd_pcm_lib_ioctl" 
*** Warning: "snd_pcm_hw_constraint_integer" 
*** Warning: "snd_pcm_stop" 
*** Warning: "snd_pcm_period_elapsed" 
[drivers/media/video/saa7134/saa7134-alsa.ko] undefined!

Signed-off-by: Michael Krufky <mkrufky@m1k.net>
Acked-by: Mauro Carvalho Chehab <mchehab@brturbo.com.br>

 drivers/media/video/saa7134/Kconfig |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

--- linux.orig/drivers/media/video/saa7134/Kconfig
+++ linux/drivers/media/video/saa7134/Kconfig
@@ -1,6 +1,6 @@
 config VIDEO_SAA7134
 	tristate "Philips SAA7134 support"
-	depends on VIDEO_DEV && PCI && I2C && SOUND
+	depends on VIDEO_DEV && PCI && I2C && SOUND && SND && SND_PCM_OSS
 	select VIDEO_BUF
 	select VIDEO_IR
 	select VIDEO_TUNER

--------------050803020006020907040301--

