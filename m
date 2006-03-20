Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965501AbWCTPsN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965501AbWCTPsN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 10:48:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965188AbWCTPsM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 10:48:12 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:38882 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S966751AbWCTPUk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 10:20:40 -0500
From: mchehab@infradead.org
To: linux-kernel@vger.kernel.org
Cc: linux-dvb-maintainer@linuxtv.org, Chris Pascoe <c.pascoe@itee.uq.edu.au>,
       Michael Krufky <mkrufky@linuxtv.org>,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 062/141] V4L/DVB (3308): Use parallel transport for
	FusionHDTV Dual Digital USB
Date: Mon, 20 Mar 2006 12:08:47 -0300
Message-id: <20060320150847.PS324425000062@infradead.org>
In-Reply-To: <20060320150819.PS760228000000@infradead.org>
References: <20060320150819.PS760228000000@infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1-3mdk 
Content-Transfer-Encoding: 7bit
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chris Pascoe <c.pascoe@itee.uq.edu.au>
Date: 1139302151 -0200

Use the parallel transport function of the MT352 in USB demodulator of the
Dual Digital board.

Signed-off-by: Chris Pascoe <c.pascoe@itee.uq.edu.au>
Signed-off-by: Michael Krufky <mkrufky@linuxtv.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

diff --git a/drivers/media/dvb/dvb-usb/cxusb.c b/drivers/media/dvb/dvb-usb/cxusb.c
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

