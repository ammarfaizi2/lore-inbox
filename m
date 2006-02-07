Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751112AbWBGPkN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751112AbWBGPkN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 10:40:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751124AbWBGPkN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 10:40:13 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:44700 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751122AbWBGPkM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 10:40:12 -0500
From: mchehab@infradead.org
To: linux-kernel@vger.kernel.org
Cc: linux-dvb-maintainer@linuxtv.org, Michael Krufky <mkrufky@linuxtv.org>,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 10/16] Use MT352 parallel transport function for all
	Bluebird FusionHDTV DVB-T boxes.
Date: Tue, 07 Feb 2006 13:33:32 -0200
Message-id: <20060207153332.PS77010600010@infradead.org>
In-Reply-To: <20060207153248.PS50860900000@infradead.org>
References: <20060207153248.PS50860900000@infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1-1mdk 
Content-Transfer-Encoding: 7bit
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Krufky <mkrufky@linuxtv.org>

Use the parallel transport function of the MT352 demodulator in
TH7579 and LGZ201 -based FusionHDTV Bluebird usb boxes.

Signed-off-by: Michael Krufky <mkrufky@linuxtv.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

 drivers/media/dvb/dvb-usb/cxusb.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/media/dvb/dvb-usb/cxusb.c b/drivers/media/dvb/dvb-usb/cxusb.c
index 650536a..f327fac 100644
--- a/drivers/media/dvb/dvb-usb/cxusb.c
+++ b/drivers/media/dvb/dvb-usb/cxusb.c
@@ -255,7 +255,7 @@ static int cxusb_dee1601_demod_init(stru
 
 static int cxusb_mt352_demod_init(struct dvb_frontend* fe)
 {	/* used in both lgz201 and th7579 */
-	static u8 clock_config []  = { CLOCK_CTL,  0x38, 0x39 };
+	static u8 clock_config []  = { CLOCK_CTL,  0x38, 0x29 };
 	static u8 reset []         = { RESET,      0x80 };
 	static u8 adc_ctl_1_cfg [] = { ADC_CTL_1,  0x40 };
 	static u8 agc_cfg []       = { AGC_TARGET, 0x24, 0x20 };

