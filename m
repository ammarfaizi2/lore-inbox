Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267971AbUIAXV4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267971AbUIAXV4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 19:21:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268028AbUIAXTC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 19:19:02 -0400
Received: from baikonur.stro.at ([213.239.196.228]:33420 "EHLO
	baikonur.stro.at") by vger.kernel.org with ESMTP id S268026AbUIAXQR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 19:16:17 -0400
Subject: [patch 07/14]  radio/radio-maxiradio: replace 	schedule_timeout() with msleep()
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, janitor@sternwelten.at
From: janitor@sternwelten.at
Date: Thu, 02 Sep 2004 01:16:17 +0200
Message-ID: <E1C2eKv-0002oP-E2@sputnik>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org







I would appreciate any comments from the janitor@sternweltens list.

Thanks,
Nish



Description: Replaced sleep_125ms() with msleep(125) and replaced the
replaced function's definition.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
Signed-off-by: Maximilian Attems <janitor@sternwelten.at>



---

 linux-2.6.9-rc1-bk7-max/drivers/media/radio/radio-maxiradio.c |    9 +--------
 1 files changed, 1 insertion(+), 8 deletions(-)

diff -puN drivers/media/radio/radio-maxiradio.c~msleep-drivers_media_radio-maxiradio drivers/media/radio/radio-maxiradio.c
--- linux-2.6.9-rc1-bk7/drivers/media/radio/radio-maxiradio.c~msleep-drivers_media_radio-maxiradio	2004-09-01 19:35:12.000000000 +0200
+++ linux-2.6.9-rc1-bk7-max/drivers/media/radio/radio-maxiradio.c	2004-09-01 19:35:12.000000000 +0200
@@ -104,13 +104,6 @@ static struct radio_device
 } radio_unit = {0, 0, 0, 0, };
 
 
-static void sleep_125ms(void)
-{
-	current->state = TASK_INTERRUPTIBLE;
-	schedule_timeout(HZ >> 3);
-}
-
-
 static void outbit(unsigned long bit, __u16 io)
 {
 	if(bit != 0)
@@ -228,7 +221,7 @@ inline static int radio_function(struct 
 				return -EINVAL;
 			card->freq = *freq;
 			set_freq(card->io, FREQ2BITS(card->freq));
-			sleep_125ms();
+			msleep(125);
 			return 0;
 		}
 		case VIDIOCGAUDIO: {	

_
