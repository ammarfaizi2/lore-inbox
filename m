Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316604AbSEPIHX>; Thu, 16 May 2002 04:07:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316606AbSEPIHW>; Thu, 16 May 2002 04:07:22 -0400
Received: from zok.SGI.COM ([204.94.215.101]:60598 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S316604AbSEPIHV>;
	Thu, 16 May 2002 04:07:21 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: marcelo@conectiva.com.br
Cc: linux-kernel@vger.kernel.org
Subject: [patch] 2.4.19-pre8 correct build of m8xx_pcmcia
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 16 May 2002 18:07:12 +1000
Message-ID: <31741.1021536432@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Obviously nobody has tried to set CONFIG_PCMCIA_M8XX to build
m8xx_pcmcia.

Index: 19-pre8.1/drivers/pcmcia/Makefile
--- 19-pre8.1/drivers/pcmcia/Makefile Fri, 03 May 2002 12:35:44 +1000 kaos (linux-2.4/w/b/10_Makefile 1.3.1.5 644)
+++ 19-pre8.1(w)/drivers/pcmcia/Makefile Thu, 16 May 2002 18:04:21 +1000 kaos (linux-2.4/w/b/10_Makefile 1.3.1.5 644)
@@ -60,7 +60,7 @@ else
 endif
 
 obj-$(CONFIG_PCMCIA_SA1100)	+= sa1100_cs.o
-obj-$)CONFIG_PCMCIA_M8XX)	+= m8xx_pcmcia.o
+obj-$(CONFIG_PCMCIA_M8XX)	+= m8xx_pcmcia.o
 
 sa1100_cs-objs-y				:= sa1100_generic.o
 sa1100_cs-objs-$(CONFIG_SA1100_ADSBITSY)	+= sa1100_adsbitsy.o sa1111_generic.o

