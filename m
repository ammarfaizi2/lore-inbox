Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317264AbSHYLD6>; Sun, 25 Aug 2002 07:03:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317269AbSHYLD6>; Sun, 25 Aug 2002 07:03:58 -0400
Received: from mailgate5.cinetic.de ([217.72.192.165]:57758 "EHLO
	mailgate5.cinetic.de") by vger.kernel.org with ESMTP
	id <S317264AbSHYLD5>; Sun, 25 Aug 2002 07:03:57 -0400
Date: Sun, 25 Aug 2002 13:07:58 +0200
Message-Id: <200208251107.g7PB7wX12648@mailgate5.cinetic.de>
MIME-Version: 1.0
Organization: http://freemail.web.de/
From: <joerg.beyer@email.de>
To: joerg.beyer@email.de, "ZwaneMwaikambo" <zwane@linuxpower.ca>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Re: <no subject>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zwane Mwaikambo <zwane@linuxpower.ca> schrieb am 25.08.02 12:47:22:
> On Sun, 25 Aug 2002 joerg.beyer@email.de wrote:
> 
> > Disk access, like untaring a big tar file (e.g. kernel sources)
> > are really slow.
> 
> > ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
> > hda: HITACHI_DK23DA-20, ATA DISK drive
> > hdc: QSI DVD-ROM SDR-081, ATAPI CD/DVD-ROM drive
> > ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
> > ide1 at 0x170-0x177,0x376 on irq 15
> > hda: 39070080 sectors (20004 MB) w/2048KiB Cache, CHS=2432/255/63
> > hdc: ATAPI 24X DVD-ROM drive, 512kB Cache
> 
> You seem to be running without DMA.

you are right, I had no dma enabled. Now I recomiled the kernel with this
dma-related options:

CONFIG_BLK_DEV_IDEDMA_PCI=y
# CONFIG_BLK_DEV_IDEDMA_FORCED is not set
CONFIG_IDEDMA_PCI_AUTO=y
# CONFIG_IDEDMA_ONLYDISK is not set
CONFIG_BLK_DEV_IDEDMA=y
# CONFIG_IDEDMA_PCI_WIP is not set
# CONFIG_BLK_DEV_IDEDMA_TIMEOUT is not set
# CONFIG_IDEDMA_NEW_DRIVE_LISTINGS is not set
CONFIG_BLK_DEV_ADMA=y
# CONFIG_HPT34X_AUTODMA is not set
CONFIG_IDEDMA_AUTO=y
# CONFIG_IDEDMA_IVB is not set
# CONFIG_DMA_NONPCI is not set


and I still get many many errors on the nic. Do I need something more in .config?

    Joerg

