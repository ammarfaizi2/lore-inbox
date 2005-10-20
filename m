Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932462AbVJTQrg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932462AbVJTQrg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Oct 2005 12:47:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932477AbVJTQrg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Oct 2005 12:47:36 -0400
Received: from kirby.webscope.com ([204.141.84.57]:30390 "EHLO
	kirby.webscope.com") by vger.kernel.org with ESMTP id S932462AbVJTQrf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Oct 2005 12:47:35 -0400
Message-ID: <4357C8B6.20002@linuxtv.org>
Date: Thu, 20 Oct 2005 12:41:26 -0400
From: Mike Krufky <mkrufky@linuxtv.org>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Mauro Carvalho Chehab <mchehab@brturbo.com.br>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-dvb-maintainer@linuxtv.org
Subject: [PATCH] Kconfig: saa7134-dvb should not select cx22702
Content-Type: multipart/mixed;
 boundary="------------040503020200040307090100"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040503020200040307090100
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Andrew-

This should go into 2.6.14.

On 2005-05-01, Gerd Knorr sent in a patch to add cx22702 to cx88-dvb:

 [PATCH] dvb: cx22702 frontend driver update
http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=9990d744bea7d28e83c420e2c9d524c7a8a2d136

...but as we can see, the Kconfig portion of his patch was incorrectly 
applied to saa7134-dvb instead of cx88-dvb.

On 2005-06-24, Adrian bunk fixed cx88-dvb:

 [PATCH] VIDEO_CX88_DVB must select DVB_CX22702
http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=d6988588e13616587aa879c2e0bd7cd811705e5d

...but we never removed the original patch from Gerd.

This patch sets things straight:

saa7134-dvb should not select cx22702

Signed-off-by: Michael Krufky <mkrufky@m1k.net>



--------------040503020200040307090100
Content-Type: text/plain;
 name="kconfig-saa7134-dvb-should-not-select-cx22702.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="kconfig-saa7134-dvb-should-not-select-cx22702.patch"

diff -upr linux-2.6.14-rc5/drivers/media/video/Kconfig linux/drivers/media/video/Kconfig
--- linux-2.6.14-rc5/drivers/media/video/Kconfig	2005-10-20 01:23:05.000000000 -0500
+++ linux/drivers/media/video/Kconfig	2005-10-20 10:02:25.659833072 -0500
@@ -262,7 +262,6 @@ config VIDEO_SAA7134_DVB
 	depends on VIDEO_SAA7134 && DVB_CORE
 	select VIDEO_BUF_DVB
 	select DVB_MT352
-	select DVB_CX22702
 	select DVB_TDA1004X
 	---help---
 	  This adds support for DVB cards based on the

--------------040503020200040307090100--

