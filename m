Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261801AbTDPWai (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Apr 2003 18:30:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261823AbTDPWai
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Apr 2003 18:30:38 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:61456 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261801AbTDPWah (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Apr 2003 18:30:37 -0400
Date: Wed, 16 Apr 2003 23:42:27 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: [PATCH] 1/3: Remove USR 56K voice modem specific PCI table entry.
Message-ID: <20030416234227.B17775@flint.arm.linux.org.uk>
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
X-Message-Flag: Your copy of Microsoft Outlook is vurnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jordan Breeding confirms that our serial PCI detection algorithms
now correctly determine this device, and doesn't require a specific
entry.

diff -Nru a/drivers/serial/8250_pci.c b/drivers/serial/8250_pci.c
--- a/drivers/serial/8250_pci.c	Wed Apr 16 23:12:27 2003
+++ b/drivers/serial/8250_pci.c	Wed Apr 16 23:12:27 2003
@@ -1802,13 +1802,6 @@
 		pbn_b1_1_115200 },
 
 	/*
-	 * 3Com US Robotics 56k Voice Internal PCI model 5610
-	 */
-	{	PCI_VENDOR_ID_USR, 0x1008,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_b0_1_115200 },
-
-	/*
 	 * Titan Electronic cards
 	 *  The 400L and 800L have a custom setup quirk.
 	 */

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

