Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261613AbULFS5k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261613AbULFS5k (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Dec 2004 13:57:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261607AbULFSy4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Dec 2004 13:54:56 -0500
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:5047 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S261617AbULFSyV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Dec 2004 13:54:21 -0500
Date: Mon, 6 Dec 2004 11:54:16 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Linus Torvalds <torvalds@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linuxppc-dev@ozlabs.org
Cc: Christian Kujau <evil@g-house.de>, Sebastian Heutling <sheutlin@gmx.de>,
       Sven Hartge <hartge@ds9.gnuu.de>, Meelis Roos <mroos@linux.ee>
Subject: [PATCH 2.6.10-rc3][PPC32] Fix Motorola PReP (PowerstackII Utah) PCI IRQ map
Message-ID: <20041206185416.GE7153@smtp.west.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The PCI IRQ map for the old Motorola PowerStackII (Utah) boards was
incorrect, but this breakage wasn't exposed until 2.5, and finally fixed
until recently by Sebastian Heutling <sheutlin@gmx.de>.

Signed-off-by: Christian Kujau <evil@g-house.de>
Signed-off-by: Tom Rini <trini@kernel.crashing.org>

--- 1.32/arch/ppc/platforms/prep_pci.c	2004-10-12 14:29:11 -07:00
+++ edited/arch/ppc/platforms/prep_pci.c	2004-12-06 09:20:52 -07:00
@@ -49,10 +49,10 @@
         0,   /* Slot 1  - unused */
         5,   /* Slot 2  - SCSI - NCR825A  */
         0,   /* Slot 3  - unused */
-        1,   /* Slot 4  - Ethernet - DEC2114x */
+        3,   /* Slot 4  - Ethernet - DEC2114x */
         0,   /* Slot 5  - unused */
-        3,   /* Slot 6  - PCI Card slot #1 */
-        4,   /* Slot 7  - PCI Card slot #2 */
+        2,   /* Slot 6  - PCI Card slot #1 */
+        3,   /* Slot 7  - PCI Card slot #2 */
         5,   /* Slot 8  - PCI Card slot #3 */
         5,   /* Slot 9  - PCI Bridge */
              /* added here in case we ever support PCI bridges */

-- 
Tom Rini
http://gate.crashing.org/~trini/
