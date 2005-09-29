Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932153AbVI2NlI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932153AbVI2NlI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 09:41:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932156AbVI2NlI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 09:41:08 -0400
Received: from smtp3.brturbo.com.br ([200.199.201.164]:28840 "EHLO
	smtp3.brturbo.com.br") by vger.kernel.org with ESMTP
	id S932153AbVI2NlH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 09:41:07 -0400
Subject: [PATCH 1/1] V4L DViCO FusionHDTV5 Lite GPIO Fix
From: Mauro Carvalho Chehab <mchehab@brturbo.com.br>
To: LKML <linux-kernel@vger.kernel.org>,
       Linux and Kernel Video <video4linux-list@redhat.com>
Content-Type: multipart/mixed; boundary="=-6ujkTUB08OsDJTQLnmWa"
Date: Thu, 29 Sep 2005 10:40:46 -0300
Message-Id: <1128001247.18481.2.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3-10mdk 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-6ujkTUB08OsDJTQLnmWa
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



--=-6ujkTUB08OsDJTQLnmWa
Content-Description: 
Content-Disposition: inline; filename=v4l_trivial_bttv_fix_hdtv5_lite.diff
Content-Type: text/x-patch; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

- GPIO fix for the composite and tv mute states of bt8xx card #135: 
DViCO FusionHDTV5 Lite.
  Without this patch, selecting one of these states could produce 
unexpected behavior.

Signed-off-by: Michael Krufky <mkrufky@linuxtv.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab@brturbo.com.br>

bttv-cards.c |    2 +-
1 files changed, 1 insertion(+), 1 deletion(-)

diff -upr linux-2.6.14-rc2/drivers/media/video/bttv-cards.c linux/drivers/media/video/bttv-cards.c
--- linux-2.6.14-rc2/drivers/media/video/bttv-cards.c	2005-09-28 14:38:13.041707988 -0500
+++ linux/drivers/media/video/bttv-cards.c	2005-09-28 14:41:00.075406784 -0500
@@ -2398,7 +2398,7 @@ struct tvcard bttv_tvcards[] = {
 	.svhs           = 2,
 	.muxsel		= { 2, 3 },
 	.gpiomask       = 0x00e00007,
-	.audiomux       = { 0x00400005, 0, 0, 0, 0, 0 },
+	.audiomux       = { 0x00400005, 0, 0x00000001, 0, 0x00c00007, 0 },
 	.no_msp34xx     = 1,
 	.no_tda9875     = 1,
 	.no_tda7432     = 1,


--=-6ujkTUB08OsDJTQLnmWa--

