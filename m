Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965298AbWCTPZx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965298AbWCTPZx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 10:25:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965297AbWCTPZX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 10:25:23 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:17080 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S965274AbWCTPYV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 10:24:21 -0500
From: mchehab@infradead.org
To: linux-kernel@vger.kernel.org
Cc: linux-dvb-maintainer@linuxtv.org, Michael Krufky <mkrufky@linuxtv.org>,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 063/141] V4L/DVB (3310): Use MT352 parallel transport
	function for all Bluebird FusionHDTV DVB-T boxes.
Date: Mon, 20 Mar 2006 12:08:47 -0300
Message-id: <20060320150847.PS490479000063@infradead.org>
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

From: Michael Krufky <mkrufky@linuxtv.org>
Date: 1139302152 -0200

Use the parallel transport function of the MT352 demodulator in
TH7579 and LGZ201 -based FusionHDTV Bluebird usb boxes.

Signed-off-by: Michael Krufky <mkrufky@linuxtv.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

diff --git a/drivers/media/dvb/dvb-usb/cxusb.c b/drivers/media/dvb/dvb-usb/cxusb.c
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

