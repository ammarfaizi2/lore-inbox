Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264469AbUAJAJa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jan 2004 19:09:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264526AbUAJAJa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jan 2004 19:09:30 -0500
Received: from amber.ccs.neu.edu ([129.10.116.51]:17827 "EHLO
	amber.ccs.neu.edu") by vger.kernel.org with ESMTP id S264469AbUAJAJ1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jan 2004 19:09:27 -0500
Subject: Re: 2.6.1-mm1 and modular IDE.
From: Stan Bubrouski <stan@ccs.neu.edu>
To: "Wojciech 'Sas' Cieciwa" <cieciwa@alpha.zarz.agh.edu.pl>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58L.0401092345370.9003@alpha.zarz.agh.edu.pl>
References: <Pine.LNX.4.58L.0401092345370.9003@alpha.zarz.agh.edu.pl>
Content-Type: text/plain
Message-Id: <1073693365.2706.15.camel@duergar>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-8) 
Date: Fri, 09 Jan 2004 19:09:26 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-01-09 at 17:50, Wojciech 'Sas' Cieciwa wrote:
> OK. I try to build 2.6.1 with and without -mm1 patch.
> Both with options listed below.
> in attachment are output logs.
> they are identical - that means that modular IDE in 2.6.1-mm1 is broken.
> 

Correct me if I'm wrong, but wouldn't modular IDE be a bad idea anyways
if you don't have SCSI boot drive?  Think about it, without IDE layer,
how's it going to mount the IDE drives to get the IDE module off of one
of them?  You'd need it compiled in, right?

-sb

> Sorry.
> 					Sas.
> P.S.
> Or, ...
> I'm so stupid, that I can't build kernel.
> 
> [...]
> 
> #
> # ATA/ATAPI/MFM/RLL support
> #
> CONFIG_IDE=m
> CONFIG_BLK_DEV_IDE=m
> 
> #
> # Please see Documentation/ide.txt for help/info on IDE drives
> #
> # CONFIG_BLK_DEV_HD_IDE is not set
> CONFIG_BLK_DEV_IDEDISK=m
> CONFIG_IDEDISK_MULTI_MODE=y
> # CONFIG_IDEDISK_STROKE is not set
> CONFIG_BLK_DEV_IDECS=m
> CONFIG_BLK_DEV_IDECD=m
> CONFIG_BLK_DEV_IDETAPE=m
> CONFIG_BLK_DEV_IDEFLOPPY=m
> CONFIG_BLK_DEV_IDESCSI=m
> # CONFIG_IDE_TASK_IOCTL is not set
> CONFIG_IDE_TASKFILE_IO=y
> 
> #
> # IDE chipset support/bugfixes
> #
> CONFIG_BLK_DEV_CMD640=y
> CONFIG_BLK_DEV_CMD640_ENHANCED=y
> CONFIG_BLK_DEV_IDEPNP=y
> CONFIG_BLK_DEV_IDEPCI=y
> CONFIG_IDEPCI_SHARE_IRQ=y
> # CONFIG_BLK_DEV_OFFBOARD is not set
> CONFIG_BLK_DEV_GENERIC=y
> CONFIG_BLK_DEV_OPTI621=m
> CONFIG_BLK_DEV_RZ1000=m
> CONFIG_BLK_DEV_IDEDMA_PCI=y
> # CONFIG_BLK_DEV_IDEDMA_FORCED is not set
> CONFIG_IDEDMA_PCI_AUTO=y
> # CONFIG_IDEDMA_ONLYDISK is not set
> CONFIG_IDEDMA_PCI_WIP=y
> # CONFIG_IDEDMA_NEW_DRIVE_LISTINGS is not set
> CONFIG_BLK_DEV_ADMA=y
> CONFIG_BLK_DEV_AEC62XX=m
> CONFIG_BLK_DEV_ALI15X3=m
> # CONFIG_WDC_ALI15X3 is not set
> CONFIG_BLK_DEV_AMD74XX=m
> CONFIG_BLK_DEV_CMD64X=m
> CONFIG_BLK_DEV_TRIFLEX=m
> CONFIG_BLK_DEV_CY82C693=m
> CONFIG_BLK_DEV_CS5520=m
> CONFIG_BLK_DEV_CS5530=m
> CONFIG_BLK_DEV_HPT34X=m
> # CONFIG_HPT34X_AUTODMA is not set
> CONFIG_BLK_DEV_HPT366=m
> CONFIG_BLK_DEV_SC1200=m
> CONFIG_BLK_DEV_PIIX=m
> CONFIG_BLK_DEV_NS87415=m
> CONFIG_BLK_DEV_PDC202XX_OLD=m
> CONFIG_BLK_DEV_PDC202XX_NEW=m
> CONFIG_BLK_DEV_SVWKS=m
> CONFIG_BLK_DEV_SIIMAGE=m
> CONFIG_BLK_DEV_SIS5513=m
> CONFIG_BLK_DEV_SLC90E66=m
> CONFIG_BLK_DEV_TRM290=m
> CONFIG_BLK_DEV_VIA82CXXX=m
> CONFIG_IDE_CHIPSETS=y
> 
> #
> # Note: most of these also require special kernel boot parameters
> #
> CONFIG_BLK_DEV_4DRIVES=y
> CONFIG_BLK_DEV_ALI14XX=m
> CONFIG_BLK_DEV_DTC2278=m
> CONFIG_BLK_DEV_HT6560B=m
> CONFIG_BLK_DEV_PDC4030=m
> CONFIG_BLK_DEV_QD65XX=m
> CONFIG_BLK_DEV_UMC8672=m
> CONFIG_BLK_DEV_IDEDMA=y
> CONFIG_IDEDMA_IVB=y
> CONFIG_IDEDMA_AUTO=y
> # CONFIG_DMA_NONPCI is not set
> # CONFIG_BLK_DEV_HD is not set
> 
> #
> # SCSI device support
> #
> CONFIG_SCSI=m
> CONFIG_SCSI_PROC_FS=y
> 
> [...]

