Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280897AbRKLSB3>; Mon, 12 Nov 2001 13:01:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280894AbRKLSBU>; Mon, 12 Nov 2001 13:01:20 -0500
Received: from shimura.Math.Berkeley.EDU ([169.229.58.53]:48257 "EHLO
	shimura.math.berkeley.edu") by vger.kernel.org with ESMTP
	id <S280889AbRKLSBF>; Mon, 12 Nov 2001 13:01:05 -0500
Date: Mon, 12 Nov 2001 10:00:42 -0800 (PST)
From: Wayne Whitney <whitney@math.berkeley.edu>
Reply-To: <whitney@math.berkeley.edu>
To: LKML <linux-kernel@vger.kernel.org>
cc: Andre Hedrick <andre@linux-ide.org>
Subject: [PATCH] Configure.help entry 
Message-ID: <Pine.LNX.4.33.0111120944340.28309-100000@mf1.private>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--- linux-2.4.15-pre3/Documentation/Configure.help	Sun Nov 11 22:11:25 2001
+++ linux-2.4.15-pre3-ide/Documentation/Configure.help	Mon Nov 12 09:56:59 2001
@@ -1112,11 +1112,13 @@
 
 Special UDMA Feature
 CONFIG_PDC202XX_BURST
-  For PDC20246, PDC20262, PDC20265 and PDC20267 Ultra DMA chipsets.
-  Designed originally for PDC20246/Ultra33 that has BIOS setup
-  failures when using 3 or more cards.
+  This option causes the pdc202xx driver to enable UDMA modes on the
+  PDC202xx even when the PDC202xx BIOS has not done so.
 
-  Unknown for PDC20265/PDC20267 Ultra DMA 100.
+  It was originally designed for the PDC20246/Ultra33, whose BIOS will
+  only setup UDMA on the first two PDC20246 cards.  It has also been
+  used succesfully on a PDC20265/Ultra100, allowing use of UDMA modes
+  when the PDC20265 BIOS has been disabled (for faster boot up).
 
   Please read the comments at the top of
   <file:drivers/ide/pdc202xx.c>.

