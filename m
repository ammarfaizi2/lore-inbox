Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264426AbTEPM0o (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 May 2003 08:26:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264427AbTEPM0o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 May 2003 08:26:44 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:55963 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S264426AbTEPM0k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 May 2003 08:26:40 -0400
Date: Fri, 16 May 2003 14:39:14 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: alan@lxorguk.ukuu.org.uk, marcelo@conectiva.com.br, torvalds@transmeta.com,
       linux-kernel@vger.kernel.org
Subject: [patch] Fix incorrect enablebits for all AMD IDE chips, 2.4 and 2.5
Message-ID: <20030516143914.A17611@ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="YiEDa0DAkWCtVeE4"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--YiEDa0DAkWCtVeE4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

For ages the enable bits for primary and secondary devices of AMD IDE
chips were swapped. This fixes that.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR

--YiEDa0DAkWCtVeE4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="amd74xx-2.4.diff"

ChangeSet@1.1212, 2003-05-16 14:36:08+02:00, vojtech@suse.cz
  Fix incorrect enablebits for all AMD IDE chips.


 amd74xx.h |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)


diff -Nru a/drivers/ide/pci/amd74xx.h b/drivers/ide/pci/amd74xx.h
--- a/drivers/ide/pci/amd74xx.h	Fri May 16 14:36:27 2003
+++ b/drivers/ide/pci/amd74xx.h	Fri May 16 14:36:27 2003
@@ -40,7 +40,7 @@
 		.init_dma	= init_dma_amd74xx,
 		.channels	= 2,
 		.autodma	= AUTODMA,
-		.enablebits	= {{0x40,0x01,0x01}, {0x40,0x02,0x02}},
+		.enablebits	= {{0x40,0x02,0x02}, {0x40,0x01,0x01}},
 		.bootable	= ON_BOARD,
 		.extra		= 0
 	},{	/* 1 */
@@ -53,7 +53,7 @@
 		.init_dma	= init_dma_amd74xx,
 		.channels	= 2,
 		.autodma	= AUTODMA,
-		.enablebits	= {{0x40,0x01,0x01}, {0x40,0x02,0x02}},
+		.enablebits	= {{0x40,0x02,0x02}, {0x40,0x01,0x01}},
 		.bootable	= ON_BOARD,
 		.extra		= 0
 	},{	/* 2 */
@@ -66,7 +66,7 @@
 		.init_dma	= init_dma_amd74xx,
 		.channels	= 2,
 		.autodma	= AUTODMA,
-		.enablebits	= {{0x40,0x01,0x01}, {0x40,0x02,0x02}},
+		.enablebits	= {{0x40,0x02,0x02}, {0x40,0x01,0x01}},
 		.bootable	= ON_BOARD,
 		.extra		= 0
 	},{	/* 3 */
@@ -79,7 +79,7 @@
 		.init_dma	= init_dma_amd74xx,
 		.channels	= 2,
 		.autodma	= AUTODMA,
-		.enablebits	= {{0x40,0x01,0x01}, {0x40,0x02,0x02}},
+		.enablebits	= {{0x40,0x02,0x02}, {0x40,0x01,0x01}},
 		.bootable	= ON_BOARD,
 		.extra		= 0
 	},{	/* 4 */
@@ -92,7 +92,7 @@
 		.init_dma	= init_dma_amd74xx,
 		.autodma	= AUTODMA,
 		.channels	= 2,
-		.enablebits	= {{0x40,0x01,0x01}, {0x40,0x02,0x02}},
+		.enablebits	= {{0x40,0x02,0x02}, {0x40,0x01,0x01}},
 		.bootable	= ON_BOARD,
 		.extra		= 0
 	},
@@ -106,7 +106,7 @@
 		.init_dma	= init_dma_amd74xx,
 		.channels	= 2,
 		.autodma	= AUTODMA,
-		.enablebits	= {{0x50,0x01,0x01}, {0x50,0x02,0x02}},
+		.enablebits	= {{0x50,0x02,0x02}, {0x50,0x01,0x01}},
 		.bootable	= ON_BOARD,
 		.extra		= 0,
 	},
@@ -120,7 +120,7 @@
 		.init_dma	= init_dma_amd74xx,
 		.channels	= 2,
 		.autodma	= AUTODMA,
-		.enablebits	= {{0x50,0x01,0x01}, {0x50,0x02,0x02}},
+		.enablebits	= {{0x50,0x02,0x02}, {0x50,0x01,0x01}},
 		.bootable	= ON_BOARD,
 		.extra		= 0,
 	},

--YiEDa0DAkWCtVeE4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="amd74xx-2.5.diff"

ChangeSet@1.1150, 2003-05-16 14:37:11+02:00, vojtech@suse.cz
  Fix incorrect enablebits for all AMD IDE chips.


 amd74xx.h |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)


diff -Nru a/drivers/ide/pci/amd74xx.h b/drivers/ide/pci/amd74xx.h
--- a/drivers/ide/pci/amd74xx.h	Fri May 16 14:37:41 2003
+++ b/drivers/ide/pci/amd74xx.h	Fri May 16 14:37:41 2003
@@ -40,7 +40,7 @@
 		.init_dma	= init_dma_amd74xx,
 		.channels	= 2,
 		.autodma	= AUTODMA,
-		.enablebits	= {{0x40,0x01,0x01}, {0x40,0x02,0x02}},
+		.enablebits	= {{0x40,0x02,0x02}, {0x40,0x01,0x01}},
 		.bootable	= ON_BOARD,
 		.extra		= 0
 	},{	/* 1 */
@@ -53,7 +53,7 @@
 		.init_dma	= init_dma_amd74xx,
 		.channels	= 2,
 		.autodma	= AUTODMA,
-		.enablebits	= {{0x40,0x01,0x01}, {0x40,0x02,0x02}},
+		.enablebits	= {{0x40,0x02,0x02}, {0x40,0x01,0x01}},
 		.bootable	= ON_BOARD,
 		.extra		= 0
 	},{	/* 2 */
@@ -66,7 +66,7 @@
 		.init_dma	= init_dma_amd74xx,
 		.channels	= 2,
 		.autodma	= AUTODMA,
-		.enablebits	= {{0x40,0x01,0x01}, {0x40,0x02,0x02}},
+		.enablebits	= {{0x40,0x02,0x02}, {0x40,0x01,0x01}},
 		.bootable	= ON_BOARD,
 		.extra		= 0
 	},{	/* 3 */
@@ -79,7 +79,7 @@
 		.init_dma	= init_dma_amd74xx,
 		.channels	= 2,
 		.autodma	= AUTODMA,
-		.enablebits	= {{0x40,0x01,0x01}, {0x40,0x02,0x02}},
+		.enablebits	= {{0x40,0x02,0x02}, {0x40,0x01,0x01}},
 		.bootable	= ON_BOARD,
 		.extra		= 0
 	},{	/* 4 */
@@ -92,7 +92,7 @@
 		.init_dma	= init_dma_amd74xx,
 		.autodma	= AUTODMA,
 		.channels	= 2,
-		.enablebits	= {{0x40,0x01,0x01}, {0x40,0x02,0x02}},
+		.enablebits	= {{0x40,0x02,0x02}, {0x40,0x01,0x01}},
 		.bootable	= ON_BOARD,
 		.extra		= 0
 	},
@@ -106,7 +106,7 @@
 		.init_dma	= init_dma_amd74xx,
 		.channels	= 2,
 		.autodma	= AUTODMA,
-		.enablebits	= {{0x50,0x01,0x01}, {0x50,0x02,0x02}},
+		.enablebits	= {{0x50,0x02,0x02}, {0x50,0x01,0x01}},
 		.bootable	= ON_BOARD,
 		.extra		= 0,
 	},
@@ -120,7 +120,7 @@
 		.init_dma	= init_dma_amd74xx,
 		.channels	= 2,
 		.autodma	= AUTODMA,
-		.enablebits	= {{0x50,0x01,0x01}, {0x50,0x02,0x02}},
+		.enablebits	= {{0x50,0x02,0x02}, {0x50,0x01,0x01}},
 		.bootable	= ON_BOARD,
 		.extra		= 0,
 	},

--YiEDa0DAkWCtVeE4--
