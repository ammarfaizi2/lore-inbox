Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292428AbSCEWfE>; Tue, 5 Mar 2002 17:35:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292536AbSCEWee>; Tue, 5 Mar 2002 17:34:34 -0500
Received: from deimos.hpl.hp.com ([192.6.19.190]:60620 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S292294AbSCEWdu>;
	Tue, 5 Mar 2002 17:33:50 -0500
Date: Tue, 5 Mar 2002 14:33:48 -0800
To: Linus Torvalds <torvalds@transmeta.com>, irda-users@lists.sourceforge.net,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH] : ir256_bus_to_virt.diff
Message-ID: <20020305143348.B1254@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ir256_bus_to_virt.diff :
----------------------
	o [CRITICA] Fix ISA FIR drivers for new DMA API
	<PCI FIR drivers are still broken and need fixing>


diff -u -p linux/net/irda/irda_device.d4.c linux/net/irda/irda_device.c
--- linux/net/irda/irda_device.d4.c	Tue Feb 26 10:41:06 2002
+++ linux/net/irda/irda_device.c	Tue Feb 26 10:41:36 2002
@@ -598,7 +598,7 @@ void setup_dma(int channel, char *buffer
 	disable_dma(channel);
 	clear_dma_ff(channel);
 	set_dma_mode(channel, mode);
-	set_dma_addr(channel, virt_to_bus(buffer));
+	set_dma_addr(channel, isa_virt_to_bus(buffer));
 	set_dma_count(channel, count);
 	enable_dma(channel);
 
