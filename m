Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262603AbTI1QNS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Sep 2003 12:13:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262606AbTI1QNR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Sep 2003 12:13:17 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:7911 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S262603AbTI1QNQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Sep 2003 12:13:16 -0400
Date: Sun, 28 Sep 2003 18:13:09 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: ralf@gnu.org
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] small cleanups for arch/mips/Makefile
Message-ID: <20030928161309.GK15338@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ralf,

the patch below simplifies arch/mips/Makefile in two places without 
changing the semantics.

Please apply
Adrian

--- linux-2.6.0-test6-full/arch/mips/Kconfig.old	2003-09-28 18:07:36.000000000 +0200
+++ linux-2.6.0-test6-full/arch/mips/Kconfig	2003-09-28 18:10:07.000000000 +0200
@@ -517,13 +517,11 @@
 config NONCOHERENT_IO
 	bool
 	depends on ZAO_CAPCELLA || VICTOR_MPC30X || TOSHIBA_JMR3927 || TOSHIBA_RBTX4927 || SNI_RM200_PCI || SGI_IP32 || SGI_IP22 || NEC_EAGLE || NEC_OSPREY || DDB5477 || DDB5476 || DDB5074 || MOMENCO_OCELOT || MOMENCO_OCELOT_C || MOMENCO_OCELOT_G || MIPS_SEAD || MIPS_MALTA || MIPS_MAGNUM_4000 || OLIVETTI_M700 || MIPS_ATLAS || LASAT || MIPS_ITE8172 || IBM_WORKPAD || HP_LASERJET || MIPS_IVR || MIPS_EV96100 || MIPS_EV64120 || DECSTATION || MIPS_COBALT || MIPS_PB1500 || MIPS_PB1100 || MIPS_PB1000 || CASIO_E55 || ACER_PICA_61 || TANBAC_TB0226 || TANBAC_TB0229
-	default y if ZAO_CAPCELLA || VICTOR_MPC30X || TOSHIBA_JMR3927 || TOSHIBA_RBTX4927 || SNI_RM200_PCI || SGI_IP32 || SGI_IP22 || NEC_EAGLE || NEC_OSPREY || DDB5477 || DDB5476 || DDB5074 || MOMENCO_OCELOT_G || MOMENCO_OCELOT || MIPS_SEAD || MIPS_MALTA || MIPS_MAGNUM_4000 || OLIVETTI_M700 || MIPS_ATLAS || LASAT || MIPS_ITE8172 || IBM_WORKPAD || HP_LASERJET || MIPS_IVR || MIPS_EV96100 || MIPS_EV64120 || DECSTATION || MIPS_COBALT || MIPS_PB1500 || MIPS_PB1100 || MIPS_PB1000 || CASIO_E55 || ACER_PICA_61 || TANBAC_TB0226 || TANBAC_TB0229
-	default n if (SIBYTE_SB1250 || SGI_IP27)
+	default y
 
 config CPU_LITTLE_ENDIAN
 	bool "Generate little endian code"
 	default y if ACER_PICA_61 || CASIO_E55 || DDB5074 || DDB5476 || DDB5477 || DECSTATION || HP_LASERJET || IBM_WORKPAD || LASAT || MIPS_COBALT || MIPS_ITE8172 || MIPS_IVR || MIPS_PB1000 || MIPS_PB1100 || MIPS_PB1500 || NEC_OSPREY || NEC_EAGLE || OLIVETTI_M700 || SNI_RM200_PCI || VICTOR_MPC30X || ZAO_CAPCELLA
-	default n if BAGET_MIPS || MIPS_EV64120 || MIPS_EV96100 || MOMENCO_OCELOT || MOMENCO_OCELOT_G || SGI_IP22 || SGI_IP27 || SGI_IP32 || TOSHIBA_JMR3927
 	help
 	  Some MIPS machines can be configured for either little or big endian
 	  byte order. These modes require different kernels. Say Y if your
