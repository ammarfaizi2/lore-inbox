Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291162AbSB0BVb>; Tue, 26 Feb 2002 20:21:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291110AbSB0BVV>; Tue, 26 Feb 2002 20:21:21 -0500
Received: from h55p103-3.delphi.afb.lu.se ([130.235.187.176]:20873 "EHLO gin")
	by vger.kernel.org with ESMTP id <S291148AbSB0BVK>;
	Tue, 26 Feb 2002 20:21:10 -0500
Date: Wed, 27 Feb 2002 02:21:08 +0100
To: linux-kernel@vger.kernel.org
Cc: dag@brattli.net, torvalds@transmeta.com
Subject: [PATCH] fix virt_to_bus compile error in irda.o
Message-ID: <20020227012108.GD23911@h55p111.delphi.afb.lu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.26i
From: andersg@0x63.nu
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

following patch makes irda compile again. This code is only used by
isa-drivers.

-- 

//anders/g


--- linux-2.5.6-pre1/net/irda/irda_device.c	Sat Jan 12 01:20:47 2002
+++ linux-2.5.6-pre1-irda/net/irda/irda_device.c	Wed Feb 27 02:05:22 2002
@@ -598,7 +598,7 @@
 	disable_dma(channel);
 	clear_dma_ff(channel);
 	set_dma_mode(channel, mode);
-	set_dma_addr(channel, virt_to_bus(buffer));
+	set_dma_addr(channel, isa_virt_to_bus(buffer));
 	set_dma_count(channel, count);
 	enable_dma(channel);
 


