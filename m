Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750759AbVKKP0G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750759AbVKKP0G (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 10:26:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750809AbVKKP0G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 10:26:06 -0500
Received: from kirby.webscope.com ([204.141.84.57]:57010 "EHLO
	kirby.webscope.com") by vger.kernel.org with ESMTP id S1750759AbVKKP0E
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 10:26:04 -0500
Message-ID: <4374B7EB.4000107@linuxtv.org>
Date: Fri, 11 Nov 2005 10:25:31 -0500
From: Michael Krufky <mkrufky@linuxtv.org>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051011)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Takashi Iwai <tiwai@suse.de>
CC: Andrew Morton <akpm@osdl.org>,
       Linux and Kernel Video <video4linux-list@redhat.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Mauro Carvalho Chehab <mauro_chehab@yahoo.com.br>
Subject: Re: [PATCH 21/20] v4l: prevent saa7134 alsa undefined warnings
References: <4373CBC6.4080305@linuxtv.org> <s5hslu3z44q.wl%tiwai@suse.de>
In-Reply-To: <s5hslu3z44q.wl%tiwai@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Takashi Iwai wrote:
> At Thu, 10 Nov 2005 17:37:58 -0500,
> Mike Krufky wrote:
> 
>>Prevent the following build warnings:
>>
>>*** Warning: "snd_card_free" 
>>*** Warning: "snd_card_register" 
>>*** Warning: "snd_device_new" 
>>*** Warning: "snd_card_new" 
>>*** Warning: "snd_ctl_add"
>>*** Warning: "snd_ctl_new1" 
>>*** Warning: "snd_pcm_set_ops" 
>>*** Warning: "snd_pcm_new"
>>*** Warning: "snd_pcm_lib_ioctl" 
>>*** Warning: "snd_pcm_hw_constraint_integer" 
>>*** Warning: "snd_pcm_stop" 
>>*** Warning: "snd_pcm_period_elapsed" 
>>[drivers/media/video/saa7134/saa7134-alsa.ko] undefined!
>>
>>Signed-off-by: Michael Krufky <mkrufky@m1k.net>
>>Acked-by: Mauro Carvalho Chehab <mchehab@brturbo.com.br>
>>
>> drivers/media/video/saa7134/Kconfig |    2 +-
>> 1 files changed, 1 insertion(+), 1 deletion(-)
>>
>>--- linux.orig/drivers/media/video/saa7134/Kconfig
>>+++ linux/drivers/media/video/saa7134/Kconfig
>>@@ -1,6 +1,6 @@
>> config VIDEO_SAA7134
>> 	tristate "Philips SAA7134 support"
>>-	depends on VIDEO_DEV && PCI && I2C && SOUND
>>+	depends on VIDEO_DEV && PCI && I2C && SOUND && SND && SND_PCM_OSS
> 
> 
> No, this driver should select SND_PCM_OSS, instead.
> 
> 
> Takashi

Yes, I realized that after Andrew applied the patch.  We will send a 
correction in our next patchset.

-Michael Krufky
