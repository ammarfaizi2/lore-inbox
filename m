Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315517AbSGNBTU>; Sat, 13 Jul 2002 21:19:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315529AbSGNBTT>; Sat, 13 Jul 2002 21:19:19 -0400
Received: from p50886DAC.dip.t-dialin.net ([80.136.109.172]:21124 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S315517AbSGNBTS>; Sat, 13 Jul 2002 21:19:18 -0400
Date: Sat, 13 Jul 2002 19:22:09 -0600 (MDT)
From: Lightweight Patch Manager <patch@luckynet.dynu.com>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH][2.5] We need sys_rx164 only once on Alpha...
Message-ID: <Pine.LNX.4.44.0207131920050.3331-100000@hawkeye.luckynet.adm>
X-Location: Potsdam; Germany
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

sys_rx164.o is defined in the oby-y line of arch/alpha/kernel/Makefile, 
and once again one line later. This removes the second definition.

Index: thunder-2.5/arch/alpha/kernel/Makefile
===================================================================
RCS file: thunder-2.5/arch/alpha/kernel/Makefile,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 Makefile
--- thunder-2.5/arch/alpha/kernel/Makefile	19 Jun 2002 02:11:53 -0000	1.1.1.1
+++ thunder-2.5/arch/alpha/kernel/Makefile	14 Jul 2002 01:20:02 -0000
@@ -34,7 +34,7 @@
 	    sys_alcor.o sys_cabriolet.o sys_dp264.o sys_eb64p.o sys_eiger.o \
 	    sys_jensen.o sys_miata.o sys_mikasa.o sys_nautilus.o sys_titan.o \
 	    sys_noritake.o sys_rawhide.o sys_ruffian.o sys_rx164.o \
-	    sys_sable.o sys_sio.o sys_sx164.o sys_takara.o sys_rx164.o \
+	    sys_sable.o sys_sio.o sys_sx164.o sys_takara.o \
 	    sys_wildfire.o core_wildfire.o irq_pyxis.o
 
 else

