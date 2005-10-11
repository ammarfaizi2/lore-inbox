Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751322AbVJKPxX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751322AbVJKPxX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Oct 2005 11:53:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751393AbVJKPxX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Oct 2005 11:53:23 -0400
Received: from kirby.webscope.com ([204.141.84.57]:14293 "EHLO
	kirby.webscope.com") by vger.kernel.org with ESMTP id S1751322AbVJKPxW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Oct 2005 11:53:22 -0400
Message-ID: <434BDFDB.1090800@linuxtv.org>
Date: Tue, 11 Oct 2005 11:52:59 -0400
From: Mike Krufky <mkrufky@linuxtv.org>
Reply-To: Michael Krufky <mkrufky@linuxtv.org>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: akpm@osdl.org
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] V4L: Enable s-video input on DViCO FusionHDTV5 Lite
References: <43471b1c.4Ogrwj8f6ZKHb7Uq%mchehab@brturbo.com.br>
In-Reply-To: <43471b1c.4Ogrwj8f6ZKHb7Uq%mchehab@brturbo.com.br>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mchehab@brturbo.com.br wrote:

>From: Michael Krufky <mkrufky@linuxtv.org>
>
>    * bttv-cards.c:
>    - Enable S-Video input on DViCO FusionHDTV5 Lite
>
>    Signed-off-by: Michael Krufky <mkrufky@m1k.net>
>    Signed-off-by: Mauro Carvalho Chehab <mchehab@brturbo.com.br>
>
> bttv-cards.c |    4 ++--
> 1 files changed, 2 insertions(+), 2 deletions(-)
>
>------------------
>
>diff -upr linux-2.6.14-rc3-git7/drivers/media/video/bttv-cards.c linux/drivers/media/video/bttv-cards.c
>--- linux-2.6.14-rc3-git7/drivers/media/video/bttv-cards.c	2005-10-07 14:54:38.915668669 -0500
>+++ linux/drivers/media/video/bttv-cards.c	2005-10-07 15:46:58.019236100 -0500
>@@ -2393,10 +2393,10 @@ struct tvcard bttv_tvcards[] = {
> 	.tuner          = 0,
> 	.tuner_type     = TUNER_LG_TDVS_H062F,
> 	.tuner_addr	= ADDR_UNSET,
>-	.video_inputs   = 2,
>+	.video_inputs   = 3,
> 	.audio_inputs   = 1,
> 	.svhs           = 2,
>-	.muxsel		= { 2, 3 },
>+	.muxsel		= { 2, 3, 1 },
> 	.gpiomask       = 0x00e00007,
> 	.audiomux       = { 0x00400005, 0, 0x00000001, 0, 0x00c00007, 0 },
> 	.no_msp34xx     = 1,
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>  
>
Andrew-

I hate to be a nudge... This patch corrects an oversight when I had 
originally programmed this board.  This 2-line change adds support for 
s-video input on this card. Everything works without this patch, except 
for s-video.   It would be silly for this to be missing from 2.6.14.

Please apply this patch and send it over to Linus before he releases 2.6.14.

DVB support for this board is ready now too, but we will send that in 
our 2.6.15 patchset, as it makes some larger changes to dvb-bt8xx.c

Thank you.

Michael Krufky


