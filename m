Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270250AbRHMPb0>; Mon, 13 Aug 2001 11:31:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270252AbRHMPbP>; Mon, 13 Aug 2001 11:31:15 -0400
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:63362
	"EHLO opus.bloom.county") by vger.kernel.org with ESMTP
	id <S270250AbRHMPbG>; Mon, 13 Aug 2001 11:31:06 -0400
Date: Mon, 13 Aug 2001 08:31:00 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Fix compile of drivers/pci/pci.c in 2.4.9-pre2
Message-ID: <20010813083100.C9133@cpe-24-221-152-185.az.sprintbbd.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.  2.4.9-pre2 introduced the mandatory PM transition delays for PCI
devices.  However, it currently doesn't compile, at least on PPC, since
drivers/pci/pci.c doesn't include <asm/delay.h> to get the definition of
udelay.  Please apply this to the next release.  Thanks.

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

===== drivers/pci/pci.c 1.17 vs edited =====
--- 1.17/drivers/pci/pci.c	Sun Aug 12 23:55:22 2001
+++ edited/drivers/pci/pci.c	Mon Aug 13 08:25:35 2001
@@ -25,6 +25,7 @@
 
 #include <asm/page.h>
 #include <asm/dma.h>	/* isa_dma_bridge_buggy */
+#include <asm/delay.h>	/* for udelay */
 
 #undef DEBUG
 
