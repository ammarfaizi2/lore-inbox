Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264958AbRGADcA>; Sat, 30 Jun 2001 23:32:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264960AbRGADbk>; Sat, 30 Jun 2001 23:31:40 -0400
Received: from adsl-64-175-255-50.dsl.sntc01.pacbell.net ([64.175.255.50]:61571
	"HELO kobayashi.soze.net") by vger.kernel.org with SMTP
	id <S264958AbRGADbb>; Sat, 30 Jun 2001 23:31:31 -0400
Date: Sat, 30 Jun 2001 20:35:12 -0700 (PDT)
From: Justin Guyett <justin@soze.net>
X-X-Sender: <tyme@gw.soze.net>
To: <linux-kernel@vger.kernel.org>
Subject: [PATCH] broken cs46xx in 2.4.6-pre8
Message-ID: <Pine.LNX.4.33.0106302032270.26036-100000@gw.soze.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

prototypes weren't updated.

--- linux/drivers/sound/cs46xx.c.orig	Sat Jun 30 20:16:06 2001
+++ linux/drivers/sound/cs46xx.c	Sat Jun 30 20:26:57 2001
@@ -383,8 +383,8 @@
 static int cs46xx_powerup(struct cs_card *card, unsigned int type);
 static int cs461x_powerdown(struct cs_card *card, unsigned int type, int suspendflag);
 static void cs461x_clear_serial_FIFOs(struct cs_card *card, int type);
-static void cs46xx_suspend_tbl(struct pci_dev *pcidev);
-static void cs46xx_resume_tbl(struct pci_dev *pcidev);
+static int cs46xx_suspend_tbl(struct pci_dev *pcidev, u32 state);
+static int cs46xx_resume_tbl(struct pci_dev *pcidev);

 static inline unsigned ld2(unsigned int x)
 {

