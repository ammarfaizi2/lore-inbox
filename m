Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262046AbTCZTkY>; Wed, 26 Mar 2003 14:40:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262048AbTCZTix>; Wed, 26 Mar 2003 14:38:53 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:27147 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S262046AbTCZThg>; Wed, 26 Mar 2003 14:37:36 -0500
Date: Wed, 26 Mar 2003 19:48:45 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [BK PULL] (9/9) PCMCIA changes
Message-ID: <20030326194845.K8871@flint.arm.linux.org.uk>
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>
References: <20030326193427.B8871@flint.arm.linux.org.uk> <20030326193511.C8871@flint.arm.linux.org.uk> <20030326193537.D8871@flint.arm.linux.org.uk> <20030326193601.E8871@flint.arm.linux.org.uk> <20030326193625.F8871@flint.arm.linux.org.uk> <20030326194726.G8871@flint.arm.linux.org.uk> <20030326194747.H8871@flint.arm.linux.org.uk> <20030326194807.I8871@flint.arm.linux.org.uk> <20030326194827.J8871@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030326194827.J8871@flint.arm.linux.org.uk>; from rmk@arm.linux.org.uk on Wed, Mar 26, 2003 at 07:48:27PM +0000
X-Message-Flag: Your copy of Microsoft Outlook is vurnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.889.359.8 -> 1.889.359.9
#	drivers/pcmcia/Makefile	1.21    -> 1.22   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/03/24	hch@com.rmk.(none)	1.889.359.9
# [PCMCIA] drivers/pcmcia/Makefile tidyups
# 
# (1) use the builtin foo-$(BAR) mechanism of the 2.5 kbuild
# (2) align all += foo.o statements
# --------------------------------------------
#
diff -Nru a/drivers/pcmcia/Makefile b/drivers/pcmcia/Makefile
--- a/drivers/pcmcia/Makefile	Wed Mar 26 19:22:52 2003
+++ b/drivers/pcmcia/Makefile	Wed Mar 26 19:22:52 2003
@@ -2,46 +2,43 @@
 # Makefile for the kernel pcmcia subsystem (c/o David Hinds)
 #
 
-obj-$(CONFIG_PCMCIA)			+= pcmcia_core.o ds.o
+obj-$(CONFIG_PCMCIA)				+= pcmcia_core.o ds.o
 ifeq ($(CONFIG_CARDBUS),y)
-  obj-$(CONFIG_PCMCIA) 			+= yenta_socket.o
+  obj-$(CONFIG_PCMCIA) 				+= yenta_socket.o
 endif
 
-obj-$(CONFIG_I82365)			+= i82365.o
-obj-$(CONFIG_I82092)			+= i82092.o
-obj-$(CONFIG_TCIC)			+= tcic.o
-obj-$(CONFIG_HD64465_PCMCIA)		+= hd64465_ss.o
-obj-$(CONFIG_PCMCIA_SA1100)		+= sa1100_cs.o
-obj-$(CONFIG_PCMCIA_SA1111)		+= sa1111_cs.o
+obj-$(CONFIG_I82365)				+= i82365.o
+obj-$(CONFIG_I82092)				+= i82092.o
+obj-$(CONFIG_TCIC)				+= tcic.o
+obj-$(CONFIG_HD64465_PCMCIA)			+= hd64465_ss.o
+obj-$(CONFIG_PCMCIA_SA1100)			+= sa1100_cs.o
+obj-$(CONFIG_PCMCIA_SA1111)			+= sa1111_cs.o
 
-yenta_socket-objs				:= pci_socket.o yenta.o
+yenta_socket-y					+= pci_socket.o yenta.o
 
-pcmcia_core-objs-y				:= cistpl.o rsrc_mgr.o bulkmem.o cs.o
-pcmcia_core-objs-$(CONFIG_CARDBUS)		+= cardbus.o
-pcmcia_core-objs				:= $(pcmcia_core-objs-y)
+pcmcia_core-y					+= cistpl.o rsrc_mgr.o bulkmem.o cs.o
+pcmcia_core-$(CONFIG_CARDBUS)			+= cardbus.o
 
-sa1111_cs-objs-y				:= sa1111_generic.o
-sa1111_cs-objs-$(CONFIG_SA1100_ADSBITSY)	+= sa1100_adsbitsy.o
-sa1111_cs-objs-$(CONFIG_ASSABET_NEPONSET)	+= sa1100_neponset.o
-sa1111_cs-objs-$(CONFIG_SA1100_BADGE4)		+= sa1100_badge4.o
-sa1111_cs-objs-$(CONFIG_SA1100_GRAPHICSMASTER)	+= sa1100_graphicsmaster.o
-sa1111_cs-objs-$(CONFIG_SA1100_JORNADA720)	+= sa1100_jornada720.o
-sa1111_cs-objs-$(CONFIG_SA1100_PFS168)		+= sa1100_pfs168.o
-sa1111_cs-objs-$(CONFIG_SA1100_PT_SYSTEM3)	+= sa1100_system3.o
-sa1111_cs-objs-$(CONFIG_SA1100_XP860)		+= sa1100_xp860.o
-sa1111_cs-objs					:= $(sa1111_cs-objs-y)
+sa1111_cs-y					+= sa1111_generic.o
+sa1111_cs-$(CONFIG_SA1100_ADSBITSY)		+= sa1100_adsbitsy.o
+sa1111_cs-$(CONFIG_ASSABET_NEPONSET)		+= sa1100_neponset.o
+sa1111_cs-$(CONFIG_SA1100_BADGE4)		+= sa1100_badge4.o
+sa1111_cs-$(CONFIG_SA1100_GRAPHICSMASTER)	+= sa1100_graphicsmaster.o
+sa1111_cs-$(CONFIG_SA1100_JORNADA720)		+= sa1100_jornada720.o
+sa1111_cs-$(CONFIG_SA1100_PFS168)		+= sa1100_pfs168.o
+sa1111_cs-$(CONFIG_SA1100_PT_SYSTEM3)		+= sa1100_system3.o
+sa1111_cs-$(CONFIG_SA1100_XP860)		+= sa1100_xp860.o
 
-sa1100_cs-objs-y				:= sa1100_generic.o
-sa1100_cs-objs-$(CONFIG_SA1100_ASSABET)		+= sa1100_assabet.o
-sa1100_cs-objs-$(CONFIG_SA1100_CERF)		+= sa1100_cerf.o
-sa1100_cs-objs-$(CONFIG_SA1100_FLEXANET)	+= sa1100_flexanet.o
-sa1100_cs-objs-$(CONFIG_SA1100_FREEBIRD)	+= sa1100_freebird.o
-sa1100_cs-objs-$(CONFIG_SA1100_GRAPHICSCLIENT)	+= sa1100_graphicsclient.o
-sa1100_cs-objs-$(CONFIG_SA1100_H3600)		+= sa1100_h3600.o
-sa1100_cs-objs-$(CONFIG_SA1100_PANGOLIN)	+= sa1100_pangolin.o
-sa1100_cs-objs-$(CONFIG_SA1100_SHANNON)		+= sa1100_shannon.o
-sa1100_cs-objs-$(CONFIG_SA1100_SIMPAD)		+= sa1100_simpad.o
-sa1100_cs-objs-$(CONFIG_SA1100_STORK)		+= sa1100_stork.o
-sa1100_cs-objs-$(CONFIG_SA1100_TRIZEPS) 	+= sa1100_trizeps.o
-sa1100_cs-objs-$(CONFIG_SA1100_YOPY)		+= sa1100_yopy.o
-sa1100_cs-objs					:= $(sa1100_cs-objs-y)
+sa1100_cs-y					+= sa1100_generic.o
+sa1100_cs-$(CONFIG_SA1100_ASSABET)		+= sa1100_assabet.o
+sa1100_cs-$(CONFIG_SA1100_CERF)			+= sa1100_cerf.o
+sa1100_cs-$(CONFIG_SA1100_FLEXANET)		+= sa1100_flexanet.o
+sa1100_cs-$(CONFIG_SA1100_FREEBIRD)		+= sa1100_freebird.o
+sa1100_cs-$(CONFIG_SA1100_GRAPHICSCLIENT)	+= sa1100_graphicsclient.o
+sa1100_cs-$(CONFIG_SA1100_H3600)		+= sa1100_h3600.o
+sa1100_cs-$(CONFIG_SA1100_PANGOLIN)		+= sa1100_pangolin.o
+sa1100_cs-$(CONFIG_SA1100_SHANNON)		+= sa1100_shannon.o
+sa1100_cs-$(CONFIG_SA1100_SIMPAD)		+= sa1100_simpad.o
+sa1100_cs-$(CONFIG_SA1100_STORK)		+= sa1100_stork.o
+sa1100_cs-$(CONFIG_SA1100_TRIZEPS) 		+= sa1100_trizeps.o
+sa1100_cs-$(CONFIG_SA1100_YOPY)			+= sa1100_yopy.o

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

