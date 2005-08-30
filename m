Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932429AbVH3TsU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932429AbVH3TsU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Aug 2005 15:48:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932428AbVH3TsU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Aug 2005 15:48:20 -0400
Received: from kirby.webscope.com ([204.141.84.57]:12510 "EHLO
	kirby.webscope.com") by vger.kernel.org with ESMTP id S932429AbVH3TsT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Aug 2005 15:48:19 -0400
Message-ID: <4314B7C2.2080705@m1k.net>
Date: Tue, 30 Aug 2005 15:47:14 -0400
From: Michael Krufky <mkrufky@m1k.net>
Reply-To: mkrufky@m1k.net
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: stable@kernel.org
CC: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>,
       Mauro Carvalho Chehab <mchehab@brturbo.com.br>,
       linux-dvb-maintainer@linuxtv.org, torvalds@osdl.org
Subject: [PATCH] Kconfig: saa7134-dvb must select tda1004x
Content-Type: multipart/mixed;
 boundary="------------060806090404040308050205"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060806090404040308050205
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

I wish I had seen this before 2.6.13 was released... I guess this only 
goes to show that there haven't been any testers using saa7134-hybrid 
dvb/v4l boards that depend on the tda1004x module, during the 2.6.13-rc 
series :-(

Please apply this to 2.6.14, and also to 2.6.13.1 -stable.  Without this 
patch, users will have to EXPLICITLY select tda1004x in Kconfig.  This 
SHOULD be done automatically when saa7134-dvb is selected.  This patch 
corrects this problem.

saa7134-dvb must select tda1004x

Signed-off-by: Michael Krufky <mkrufky@m1k.net>



--------------060806090404040308050205
Content-Type: text/plain;
 name="saa7134-dvb-must-select-tda1004x.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="saa7134-dvb-must-select-tda1004x.patch"

 linux/drivers/media/video/Kconfig |    1 +
 1 files changed, 1 insertion(+)

diff -u linux-2.6.13/drivers/media/video/Kconfig linux/drivers/media/video/Kconfig
--- linux-2.6.13/drivers/media/video/Kconfig	2005-08-28 18:41:01.000000000 -0500
+++ linux/drivers/media/video/Kconfig	2005-08-30 14:18:58.116967581 -0500
@@ -254,6 +254,7 @@
 	select VIDEO_BUF_DVB
 	select DVB_MT352
 	select DVB_CX22702
+	select DVB_TDA1004X
 	---help---
 	  This adds support for DVB cards based on the
 	  Philips saa7134 chip.

--------------060806090404040308050205--

