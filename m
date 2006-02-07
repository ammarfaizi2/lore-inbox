Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751122AbWBGPkY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751122AbWBGPkY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 10:40:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751124AbWBGPkY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 10:40:24 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:44956 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751122AbWBGPkX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 10:40:23 -0500
From: mchehab@infradead.org
To: linux-kernel@vger.kernel.org
Cc: linux-dvb-maintainer@linuxtv.org, Chris Pascoe <c.pascoe@itee.uq.edu.au>,
       Michael Krufky <mkrufky@linuxtv.org>,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 09/16] Use parallel transport for FusionHDTV Dual Digital
	USB
Date: Tue, 07 Feb 2006 13:33:32 -0200
Message-id: <20060207153332.PS42709500009@infradead.org>
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

From: Chris Pascoe <c.pascoe@itee.uq.edu.au>

Use the parallel transport function of the MT352 in USB demodulator of the
Dual Digital board.

Signed-off-by: Chris Pascoe <c.pascoe@itee.uq.edu.au>
Signed-off-by: Michael Krufky <mkrufky@linuxtv.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

 drivers/media/dvb/dvb-usb/cxusb.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/media/dvb/dvb-usb/cxusb.c b/drivers/media/dvb/dvb-usb/cxusb.c
index f140037..650536a 100644
--- a/drivers/media/dvb/dvb-usb/cxusb.c
+++ b/drivers/media/dvb/dvb-usb/cxusb.c
@@ -234,7 +234,7 @@ static struct dvb_usb_rc_key dvico_mce_r
 
 static int cxusb_dee1601_demod_init(struct dvb_frontend* fe)
 {
-	static u8 clock_config []  = { CLOCK_CTL,  0x38, 0x38 };
+	static u8 clock_config []  = { CLOCK_CTL,  0x38, 0x28 };
 	static u8 reset []         = { RESET,      0x80 };
 	static u8 adc_ctl_1_cfg [] = { ADC_CTL_1,  0x40 };
 	static u8 agc_cfg []       = { AGC_TARGET, 0x28, 0x20 };

