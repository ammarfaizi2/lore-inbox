Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264838AbTAAQ4G>; Wed, 1 Jan 2003 11:56:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264975AbTAAQ4G>; Wed, 1 Jan 2003 11:56:06 -0500
Received: from louise.pinerecords.com ([213.168.176.16]:38847 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S264838AbTAAQ4F>; Wed, 1 Jan 2003 11:56:05 -0500
Date: Wed, 1 Jan 2003 18:04:29 +0100
From: Tomas Szepe <szepe@pinerecords.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] only show the "PCMCIA SCSI drivers" submenu if "PCMCIA SCSI drivers" is selected
Message-ID: <20030101170429.GI15200@louise.pinerecords.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trivial: This is a follow-up to your "Gigabit Ethernet submenu" precedent.

Only show the PCMCIA SCSI drivers submenu if the "PCMCIA SCSI drivers"
entry is selected.

-- 
Tomas Szepe <szepe@pinerecords.com>

diff -urN a/drivers/scsi/pcmcia/Kconfig b/drivers/scsi/pcmcia/Kconfig
--- a/drivers/scsi/pcmcia/Kconfig	2002-12-08 20:06:19.000000000 +0100
+++ b/drivers/scsi/pcmcia/Kconfig	2003-01-01 18:02:31.000000000 +0100
@@ -2,10 +2,8 @@
 # PCMCIA SCSI adapter configuration
 #
 
-menu "PCMCIA SCSI adapter support"
-	depends on SCSI!=n && HOTPLUG && PCMCIA!=n
-
 config SCSI_PCMCIA
+	depends on SCSI!=n && HOTPLUG && PCMCIA!=n
 	bool "PCMCIA SCSI adapter support"
 	help
 	  Say Y here if you intend to attach a PCMCIA or CardBus card to your
@@ -16,6 +14,9 @@
 	  kernel: saying N will just cause the configurator to skip all
 	  the questions PCMCIA SCSI host adapters.
 
+menu "PCMCIA SCSI adapter support"
+	depends on SCSI_PCMCIA
+
 config PCMCIA_AHA152X
 	tristate "Adaptec AHA152X PCMCIA support"
 	depends on SCSI_PCMCIA && m
