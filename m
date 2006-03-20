Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965405AbWCTPn7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965405AbWCTPn7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 10:43:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964879AbWCTPnX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 10:43:23 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:14008 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S965289AbWCTPYF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 10:24:05 -0500
From: mchehab@infradead.org
To: linux-kernel@vger.kernel.org
Cc: linux-dvb-maintainer@linuxtv.org, Thilo Berger <thilo_berger@gmx.net>,
       Oliver Endriss <o.endriss@gmx.de>,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 109/141] V4L/DVB (3377): Support for Satelco EasyWatch
	DVB-S light
Date: Mon, 20 Mar 2006 12:08:55 -0300
Message-id: <20060320150855.PS189336000109@infradead.org>
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

From: Thilo Berger <thilo_berger@gmx.net>
Date: 1141009748 -0300

Support for Satelco EasyWatch DVB-S light.

Signed-off-by: Thilo Berger <thilo_berger@gmx.net>
Signed-off-by: Oliver Endriss <o.endriss@gmx.de>
Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

diff --git a/drivers/media/dvb/ttpci/budget-av.c b/drivers/media/dvb/ttpci/budget-av.c
diff --git a/drivers/media/dvb/ttpci/budget-av.c b/drivers/media/dvb/ttpci/budget-av.c
index 1465c04..9dd4745 100644
--- a/drivers/media/dvb/ttpci/budget-av.c
+++ b/drivers/media/dvb/ttpci/budget-av.c
@@ -1000,6 +1000,7 @@ static u8 read_pwm(struct budget_av *bud
 
 #define SUBID_DVBS_TV_STAR	0x0014
 #define SUBID_DVBS_TV_STAR_CI	0x0016
+#define SUBID_DVBS_EASYWATCH	0x001e
 #define SUBID_DVBC_KNC1		0x0020
 #define SUBID_DVBC_KNC1_PLUS	0x0021
 #define SUBID_DVBC_CINERGY1200	0x1156
@@ -1038,6 +1039,7 @@ static void frontend_init(struct budget_
 	case SUBID_DVBS_TV_STAR:
 	case SUBID_DVBS_TV_STAR_CI:
 	case SUBID_DVBS_CYNERGY1200N:
+	case SUBID_DVBS_EASYWATCH:
 		fe = stv0299_attach(&philips_sd1878_config,
 				&budget_av->budget.i2c_adap);
 		break;
@@ -1285,6 +1287,7 @@ MAKE_BUDGET_INFO(knc1s, "KNC1 DVB-S", BU
 MAKE_BUDGET_INFO(knc1c, "KNC1 DVB-C", BUDGET_KNC1C);
 MAKE_BUDGET_INFO(knc1t, "KNC1 DVB-T", BUDGET_KNC1T);
 MAKE_BUDGET_INFO(kncxs, "KNC TV STAR DVB-S", BUDGET_TVSTAR);
+MAKE_BUDGET_INFO(satewpls, "Satelco EasyWatch DVB-S light", BUDGET_TVSTAR);
 MAKE_BUDGET_INFO(knc1sp, "KNC1 DVB-S Plus", BUDGET_KNC1SP);
 MAKE_BUDGET_INFO(knc1cp, "KNC1 DVB-C Plus", BUDGET_KNC1CP);
 MAKE_BUDGET_INFO(knc1tp, "KNC1 DVB-T Plus", BUDGET_KNC1TP);
@@ -1300,6 +1303,7 @@ static struct pci_device_id pci_tbl[] = 
 	MAKE_EXTENSION_PCI(knc1sp, 0x1131, 0x0011),
 	MAKE_EXTENSION_PCI(kncxs, 0x1894, 0x0014),
 	MAKE_EXTENSION_PCI(kncxs, 0x1894, 0x0016),
+	MAKE_EXTENSION_PCI(satewpls, 0x1894, 0x001e),
 	MAKE_EXTENSION_PCI(knc1c, 0x1894, 0x0020),
 	MAKE_EXTENSION_PCI(knc1cp, 0x1894, 0x0021),
 	MAKE_EXTENSION_PCI(knc1t, 0x1894, 0x0030),

