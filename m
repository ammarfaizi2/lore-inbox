Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264715AbSKSJwy>; Tue, 19 Nov 2002 04:52:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264854AbSKSJwy>; Tue, 19 Nov 2002 04:52:54 -0500
Received: from rrzs2.rz.uni-regensburg.de ([132.199.1.2]:37832 "EHLO
	rrzs2.rz.uni-regensburg.de") by vger.kernel.org with ESMTP
	id <S264715AbSKSJwx>; Tue, 19 Nov 2002 04:52:53 -0500
Date: Tue, 19 Nov 2002 10:59:55 +0100
From: Christian Guggenberger 
	<Christian.Guggenberger@physik.uni-regensburg.de>
To: soohrt@soohrt.org
Cc: linux-kernel@vger.kernel.org
Subject: 2.4.20-rc1-ac4 HPT374 doesn't find connected ide drives
Message-ID: <20021119105955.A23008@pc9391.uni-regensburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 1.2.4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Linux detects the two HPT374 controllers, but not the attached drives.
> 
> The Mainboard is an EPOX EP-8K5A3+ with 2 VIA vt8235 ide controllers
> and 4 Highpoint 374.
> 
> I increased the channels: limit for the HPT374 in drivers/ide/pci/hpt366.h
> to 4.
> --- drivers/ide/pci/hpt366.h.old        2002-11-19 17:41:33.000000000 +0100
> +++ drivers/ide/pci/hpt366.h    2002-11-19 17:41:45.000000000 +0100
> @@ -508,5 +508,5 @@
> 		init_hwif:	init_hwif_hpt366,
> 		init_dma:	init_dma_hpt366,
> -                channels:	2,      /* 4 */
> +                channels:	4,      /* 2 */
> 		autodma:	AUTODMA,
> 		enablebits:	{{0x00,0x00,0x00}, {0x00,0x00,0x00}},
> 

I have the same board, and the controller works fine for me in 2.5.4*, as 
2.4-ac doesn't contain xfs suport. I only have one drive attached, but as I 
remember I first had to configure the (raid) controller' BIOS (Ctrl-H at boot 
time) (even for just a bunch of disks) before using the drives. But I'm not 
100%ly sure.

I don't think there's any need for your patch, cause the hpt374 only has two 
channels, but there are two controllers on that board.

ANother QUestion: Did you ever get the onboard via-rhine NIC working with 
IO-APIC (both BIOS and kernel) enabled?

Christian

