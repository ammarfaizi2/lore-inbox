Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290841AbSBZQSP>; Tue, 26 Feb 2002 11:18:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290919AbSBZQSG>; Tue, 26 Feb 2002 11:18:06 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:3568
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S290841AbSBZQRx>; Tue, 26 Feb 2002 11:17:53 -0500
Date: Tue, 26 Feb 2002 08:18:31 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Andre Hedrick <andre@linuxdiskcert.org>
Cc: Matthias Andree <matthias.andree@stud.uni-dortmund.de>,
        linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.18-ac1
Message-ID: <20020226161831.GE4393@matchmail.com>
Mail-Followup-To: Andre Hedrick <andre@linuxdiskcert.org>,
	Matthias Andree <matthias.andree@stud.uni-dortmund.de>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20020226102748.GA1402@merlin.emma.line.org> <Pine.LNX.4.10.10202260316480.14807-100000@master.linux-ide.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.10.10202260316480.14807-100000@master.linux-ide.org>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 26, 2002 at 03:22:54AM -0800, Andre Hedrick wrote:
> 
> Use caution but I should have removed the generic ablity to enable
> taskfile IO operations core as there is an atomic bug discovered upon
> error in multi-mode write.  As long as you do not call enable that option
> all is cool.
...
> Thus I have pulled the patches for now for 2.4.X, but those do not have
> the ablity to enable other transport layer core, so if this was the update
> applied all is COOL!
> 

Uhh, so is the problem triggerable at all on 2.4.xx-ac?

Which config option should be disabled?

#
# ATA/IDE/MFM/RLL support
#
CONFIG_IDE=y

#
# IDE, ATA and ATAPI Block devices
#
CONFIG_BLK_DEV_IDE=y

#
# Please see Documentation/ide.txt for help/info on IDE drives
#
# CONFIG_BLK_DEV_HD_IDE is not set
# CONFIG_BLK_DEV_HD is not set
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTI_MODE=y
# CONFIG_IDEDISK_STROKE is not set
# CONFIG_BLK_DEV_IDEDISK_VENDOR is not set
# CONFIG_BLK_DEV_IDEDISK_FUJITSU is not set
# CONFIG_BLK_DEV_IDEDISK_IBM is not set
# CONFIG_BLK_DEV_IDEDISK_MAXTOR is not set
# CONFIG_BLK_DEV_IDEDISK_QUANTUM is not set
# CONFIG_BLK_DEV_IDEDISK_SEAGATE is not set
# CONFIG_BLK_DEV_IDEDISK_WD is not set
# CONFIG_BLK_DEV_COMMERIAL is not set
# CONFIG_BLK_DEV_TIVO is not set
# CONFIG_BLK_DEV_IDECS is not set
CONFIG_BLK_DEV_IDECD=m
CONFIG_BLK_DEV_IDETAPE=m
CONFIG_BLK_DEV_IDEFLOPPY=m
CONFIG_BLK_DEV_IDESCSI=m
# CONFIG_IDE_TASK_IOCTL is not set
CONFIG_IDE_TASKFILE_IO=y

#
# IDE chipset support/bugfixes
#
CONFIG_BLK_DEV_CMD640=y
# CONFIG_BLK_DEV_CMD640_ENHANCED is not set
# CONFIG_BLK_DEV_ISAPNP is not set
CONFIG_BLK_DEV_RZ1000=y
CONFIG_BLK_DEV_IDEPCI=y
# CONFIG_IDEPCI_SHARE_IRQ is not set
CONFIG_BLK_DEV_IDEDMA_PCI=y
# CONFIG_BLK_DEV_OFFBOARD is not set
# CONFIG_BLK_DEV_IDEDMA_FORCED is not set
CONFIG_IDEDMA_PCI_AUTO=y
# CONFIG_IDEDMA_ONLYDISK is not set
CONFIG_BLK_DEV_IDEDMA=y
CONFIG_IDEDMA_PCI_WIP=y
# CONFIG_BLK_DEV_IDEDMA_TIMEOUT is not set
CONFIG_IDEDMA_NEW_DRIVE_LISTINGS=y
CONFIG_BLK_DEV_ADMA=y
CONFIG_BLK_DEV_AEC62XX=y
CONFIG_AEC62XX_TUNING=y
CONFIG_BLK_DEV_ALI15X3=y
# CONFIG_WDC_ALI15X3 is not set
CONFIG_BLK_DEV_AMD74XX=y
# CONFIG_AMD74XX_OVERRIDE is not set
CONFIG_BLK_DEV_CMD64X=y
CONFIG_BLK_DEV_CMD680=y
CONFIG_BLK_DEV_CY82C693=y
CONFIG_BLK_DEV_CS5530=y
CONFIG_BLK_DEV_HPT34X=y
# CONFIG_HPT34X_AUTODMA is not set
CONFIG_BLK_DEV_HPT366=y
CONFIG_BLK_DEV_PIIX=y
CONFIG_PIIX_TUNING=y
# CONFIG_BLK_DEV_NS87415 is not set
# CONFIG_BLK_DEV_OPTI621 is not set
# CONFIG_BLK_DEV_PDC_ADMA is not set
CONFIG_BLK_DEV_PDC202XX=y
CONFIG_PDC202XX_BURST=y
CONFIG_PDC202XX_FORCE=y
CONFIG_BLK_DEV_SVWKS=y
CONFIG_BLK_DEV_SIS5513=y
CONFIG_BLK_DEV_SLC90E66=y
CONFIG_BLK_DEV_TRM290=y
CONFIG_BLK_DEV_VIA82CXXX=y
# CONFIG_IDE_CHIPSETS is not set
# CONFIG_BLK_DEV_ELEVATOR_NOOP is not set
CONFIG_IDEDMA_AUTO=y
# CONFIG_IDEDMA_IVB is not set
# CONFIG_DMA_NONPCI is not set
CONFIG_BLK_DEV_IDE_MODES=y
CONFIG_BLK_DEV_ATARAID=m
CONFIG_BLK_DEV_ATARAID_PDC=m
CONFIG_BLK_DEV_ATARAID_HPT=m

