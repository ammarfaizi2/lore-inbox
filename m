Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262216AbVBBCpL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262216AbVBBCpL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Feb 2005 21:45:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262214AbVBBCpI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Feb 2005 21:45:08 -0500
Received: from [211.58.254.17] ([211.58.254.17]:23945 "EHLO hemosu.com")
	by vger.kernel.org with ESMTP id S262216AbVBBCo4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Feb 2005 21:44:56 -0500
Date: Wed, 2 Feb 2005 11:44:54 +0900
From: Tejun Heo <tj@home-tj.org>
To: B.Zolnierkiewicz@elka.pw.edu.pl, linux-kernel@vger.kernel.org,
       linux-ide@vger.kernel.org
Subject: Re: [PATCH 2.6.11-rc2 02/29] ide: cleanup it8172
Message-ID: <20050202024454.GC621@htj.dyndns.org>
References: <20050202024017.GA621@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050202024017.GA621@htj.dyndns.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 02_ide_cleanup_it8172.patch
> 
> 	In drivers/ide/pci/it8172.h, it8172_ratefilter() and
> 	init_setup_it8172() are declared and the latter is referenced
> 	in it8172_chipsets.  Both functions are not defined or used
> 	anywhere.  This patch removes the prototypes and reference.
> 	it8172 should be compilable now.


Signed-off-by: Tejun Heo <tj@home-tj.org>                                       

Index: linux-ide-export/drivers/ide/pci/it8172.h
===================================================================
--- linux-ide-export.orig/drivers/ide/pci/it8172.h	2005-02-02 10:27:16.392120586 +0900
+++ linux-ide-export/drivers/ide/pci/it8172.h	2005-02-02 10:28:01.638779685 +0900
@@ -6,7 +6,6 @@
 #include <linux/ide.h>
 
 static u8 it8172_ratemask(ide_drive_t *drive);
-static u8 it8172_ratefilter(ide_drive_t *drive, u8 speed);
 static void it8172_tune_drive(ide_drive_t *drive, u8 pio);
 static u8 it8172_dma_2_pio(u8 xfer_rate);
 static int it8172_tune_chipset(ide_drive_t *drive, u8 xferspeed);
@@ -14,14 +13,12 @@ static int it8172_tune_chipset(ide_drive
 static int it8172_config_chipset_for_dma(ide_drive_t *drive);
 #endif
 
-static void init_setup_it8172(struct pci_dev *, ide_pci_device_t *);
 static unsigned int init_chipset_it8172(struct pci_dev *, const char *);
 static void init_hwif_it8172(ide_hwif_t *);
 
 static ide_pci_device_t it8172_chipsets[] __devinitdata = {
 	{	/* 0 */
 		.name		= "IT8172G",
-		.init_setup	= init_setup_it8172,
 		.init_chipset	= init_chipset_it8172,
 		.init_hwif	= init_hwif_it8172,
 		.channels	= 2,
