Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263238AbSITSUo>; Fri, 20 Sep 2002 14:20:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263280AbSITSUo>; Fri, 20 Sep 2002 14:20:44 -0400
Received: from lopsy-lu.misterjones.org ([62.4.18.26]:57222 "EHLO
	crisis.wild-wind.fr.eu.org") by vger.kernel.org with ESMTP
	id <S263238AbSITSUn>; Fri, 20 Sep 2002 14:20:43 -0400
To: linux-kernel@vger.kernel.org
Cc: torvalds@transmeta.com
Subject: [PATCH] Missing mii.o in driver/net/Makefile
Organization: Metropolis -- Nowhere
X-Attribution: maz
X-Baby-1: =?iso-8859-1?q?Lo=EBn?= 12 juin 1996 13:10
X-Baby-2: None
X-Love-1: Gone
X-Love-2: Crazy-Cat
Reply-to: mzyngier@freesurf.fr
From: Marc Zyngier <mzyngier@freesurf.fr>
Date: 20 Sep 2002 20:25:28 +0200
Message-ID: <wrpptv87c2v.fsf@hina.wild-wind.fr.eu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Eepro100 in 2.5.37-BK needs to be linked to mii.o.
So here is the patch...

        M.

diff -Nru a/drivers/net/Makefile b/drivers/net/Makefile
--- a/drivers/net/Makefile	Fri Sep 20 20:18:34 2002
+++ b/drivers/net/Makefile	Fri Sep 20 20:18:34 2002
@@ -41,7 +41,7 @@
 obj-$(CONFIG_VORTEX) += 3c59x.o
 obj-$(CONFIG_NE2K_PCI) += ne2k-pci.o 8390.o
 obj-$(CONFIG_PCNET32) += pcnet32.o mii.o
-obj-$(CONFIG_EEPRO100) += eepro100.o
+obj-$(CONFIG_EEPRO100) += eepro100.o mii.o
 obj-$(CONFIG_TLAN) += tlan.o
 obj-$(CONFIG_EPIC100) += epic100.o mii.o
 obj-$(CONFIG_SIS900) += sis900.o

-- 
Places change, faces change. Life is so very strange.
