Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135250AbRD1ViC>; Sat, 28 Apr 2001 17:38:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135653AbRD1Vh7>; Sat, 28 Apr 2001 17:37:59 -0400
Received: from faui02.informatik.uni-erlangen.de ([131.188.30.102]:20677 "EHLO
	faui02.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id <S135250AbRD1Vhl>; Sat, 28 Apr 2001 17:37:41 -0400
Date: Sat, 28 Apr 2001 22:51:23 +0200
From: Richard Zidlicky 
	<Richard.Zidlicky@stud.informatik.uni-erlangen.de>
To: Philip.Blundell@pobox.com, tim@cyberelk.demon.co.uk
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.4.4 parport_pc.c compilation fix when !CONFIG_PCI
Message-ID: <20010428225122.A5080@rz.informatik.uni-erlangen.de>
Mail-Followup-To: Richard Zidlicky <rz>, Philip.Blundell@pobox.com,
	tim@cyberelk.demon.co.uk, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--- linux-2.4.4/drivers/parport/parport_pc.c~	Sat Apr 28 21:43:38 2001
+++ linux-2.4.4/drivers/parport/parport_pc.c	Sat Apr 28 22:37:29 2001
@@ -2576,7 +2576,7 @@
 }
 #else
 static struct pci_driver parport_pc_pci_driver;
-static int __init parport_pc_init_superio(void) {return 0;}
+static int __init parport_pc_init_superio(int autoirq, int autodma) {return 0;}
 #endif /* CONFIG_PCI */
 
 /* This is called by parport_pc_find_nonpci_ports (in asm/parport.h) */
