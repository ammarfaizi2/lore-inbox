Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313472AbSDMMxR>; Sat, 13 Apr 2002 08:53:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313511AbSDMMxQ>; Sat, 13 Apr 2002 08:53:16 -0400
Received: from mailhost.terra.es ([195.235.113.151]:34909 "EHLO
	tsmtp4.mail.isp") by vger.kernel.org with ESMTP id <S313472AbSDMMxP>;
	Sat, 13 Apr 2002 08:53:15 -0400
Date: Sat, 13 Apr 2002 14:54:54 +0200
From: Diego Calleja <DiegoCG@teleline.es>
To: linux-kernel@vger.kernel.org
Cc: Lionel.Bouton@inet6.fr, alan@redhat.com
Subject: bug: Kernel timer added twice al c0198391 (2.4.19-pre5-ac3)
Message-Id: <20020413145455.638a8c40.DiegoCG@teleline.es>
X-Mailer: Sylpheed version 0.7.4 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel used: 2.4.19-pre5-ac3
I have SiS 5513 IDE chipset

Problem: This happened after doing hdparm -Y /dev/hdc:

/dev/hdc: issuing sleep command

hdc: timeout waiting for DMA
hdc: ide_dma_timeout: Lets do it again!stat = 0xd0, dma_stat = 0x20
hdc: DMA disabled
hdc: ide_set_handler: handler not null, old=c0198510, new=c0196b74
bug: Kernel timer added twice at c0198391

After this, the drive does'n write anything...

.config options:

CONFIG_BLK_DEV_FD=m
CONFIG_BLK_DEV_LOOP=m
CONFIG_BLK_DEV_IDE=y
# CONFIG_BLK_DEV_HD_IDE is not set
# CONFIG_BLK_DEV_HD is not set
CONFIG_BLK_DEV_IDEDISK=y
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
# CONFIG_BLK_DEV_CMD640 is not set
# CONFIG_BLK_DEV_CMD640_ENHANCED is not set
# CONFIG_BLK_DEV_ISAPNP is not set
# CONFIG_BLK_DEV_RZ1000 is not set
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
# CONFIG_BLK_DEV_OFFBOARD is not set
# CONFIG_BLK_DEV_IDEDMA_FORCED is not set
CONFIG_BLK_DEV_IDEDMA=y
CONFIG_BLK_DEV_IDEDMA_TIMEOUT=y
CONFIG_BLK_DEV_ADMA=y
# CONFIG_BLK_DEV_AEC62XX is not set
# CONFIG_BLK_DEV_ALI15X3 is not set
# CONFIG_BLK_DEV_AMD74XX is not set
# CONFIG_BLK_DEV_CMD64X is not set
# CONFIG_BLK_DEV_CMD680 is not set
# CONFIG_BLK_DEV_CY82C693 is not set
# CONFIG_BLK_DEV_CS5530 is not set
# CONFIG_BLK_DEV_HPT34X is not set
# CONFIG_BLK_DEV_HPT366 is not set
# CONFIG_BLK_DEV_PIIX is not set
# CONFIG_BLK_DEV_NS87415 is not set
# CONFIG_BLK_DEV_OPTI621 is not set
# CONFIG_BLK_DEV_PDC202XX is not set
# CONFIG_BLK_DEV_SVWKS is not set
CONFIG_BLK_DEV_SIS5513=y
# CONFIG_BLK_DEV_SLC90E66 is not set
# CONFIG_BLK_DEV_TRM290 is not set
# CONFIG_BLK_DEV_VIA82CXXX is not set
CONFIG_BLK_DEV_IDE_MODES=y
# CONFIG_BLK_DEV_ATARAID is not set
# CONFIG_BLK_DEV_ATARAID_PDC is not set
# CONFIG_BLK_DEV_ATARAID_HPT is not set

CONFIG_IDE=y
CONFIG_IDEDISK_MULTI_MODE=y
# CONFIG_IDEDISK_STROKE is not set
# CONFIG_IDE_TASK_IOCTL is not set
CONFIG_IDE_TASKFILE_IO=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_IDEDMA_PCI_AUTO=y
# CONFIG_IDEDMA_ONLYDISK is not set
CONFIG_IDEDMA_PCI_WIP=y
# CONFIG_IDEDMA_NEW_DRIVE_LISTINGS is not set
# CONFIG_IDE_CHIPSETS is not set
CONFIG_IDEDMA_AUTO=y
# CONFIG_IDEDMA_IVB is not set

