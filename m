Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263213AbVCEGSR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263213AbVCEGSR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Mar 2005 01:18:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263195AbVCEGRs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Mar 2005 01:17:48 -0500
Received: from fire.osdl.org ([65.172.181.4]:24460 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S263058AbVCEGKo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Mar 2005 01:10:44 -0500
Date: Fri, 4 Mar 2005 21:57:52 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: linux-sound@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>
Cc: torvalds <torvalds@osdl.org>, akpm <akpm@osdl.org>
Subject: [PATCH] oss/pss: fix section references
Message-Id: <20050304215752.64b6a481.rddunlap@osdl.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


oss/pss: fix initdata reference used in exit:

Error: ./sound/oss/pss.o .exit.text refers to 000000000000003f R_X86_64_PC32     .init.data+0x0000000000000003

Signed-off-by: Randy Dunlap <rddunlap@osdl.org>

diffstat:=
 sound/oss/pss.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -Naurp ./sound/oss/pss.c~oss_pss_sections ./sound/oss/pss.c
--- ./sound/oss/pss.c~oss_pss_sections	2005-03-01 23:38:33.000000000 -0800
+++ ./sound/oss/pss.c	2005-03-04 21:29:26.000000000 -0800
@@ -1149,7 +1149,7 @@ static int mss_irq __initdata	= -1;
 static int mss_dma __initdata	= -1;
 static int mpu_io __initdata	= -1;
 static int mpu_irq __initdata	= -1;
-static int pss_no_sound __initdata = 0;	/* Just configure non-sound components */
+static int pss_no_sound = 0;	/* Just configure non-sound components */
 static int pss_keep_settings  = 1;	/* Keep hardware settings at module exit */
 static char *pss_firmware = "/etc/sound/pss_synth";
 


---
