Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131775AbRCOQ1N>; Thu, 15 Mar 2001 11:27:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131779AbRCOQ0x>; Thu, 15 Mar 2001 11:26:53 -0500
Received: from gepetto.dc.luth.se ([130.240.42.40]:24047 "EHLO
	gepetto.dc.luth.se") by vger.kernel.org with ESMTP
	id <S131775AbRCOQ0r>; Thu, 15 Mar 2001 11:26:47 -0500
Date: Thu, 15 Mar 2001 17:22:53 +0100
From: kozkir-8 <kozkir-8@student.luth.se>
X-Mailer: The Bat! (v1.49) UNREG / CD5BF9353B3B7091
Reply-To: kozkir-8 <kozkir-8@student.luth.se>
X-Priority: 3 (Normal)
Message-ID: <1159080569.20010315172253@student.luth.se>
To: linux-kernel@vger.kernel.org
Subject: VIA686A chipset crash under 2.4.2-ac20
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Kernel 2.4.2 with ac20 patch seems doesn't like my motherboard
I have FIC SD11 with VIA686A chipset. I compiled it with support of
VIA82Cxxx and DMA support by default. First it seemed like work but
after a while I started to get errors like these:

kernel: hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
kernel: hda: dma_intr: error=0x84 { DriveStatusError BadCRC }

Before I compiled kernel 2.4.2 without ac patches and got the same errors.

HDD Fujitsu MPE3136AT.

Here is a part of config file for kernel (only set variables)

#
# ATA/IDE/MFM/RLL support
#
CONFIG_IDE=y

#
# IDE, ATA and ATAPI Block devices
#
CONFIG_BLK_DEV_IDE=y
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTI_MODE=y
CONFIG_BLK_DEV_IDECD=y

#
# IDE chipset support/bugfixes
#
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_IDEDMA_PCI_AUTO=y
CONFIG_BLK_DEV_IDEDMA=y
CONFIG_BLK_DEV_VIA82CXXX=y
CONFIG_IDEDMA_AUTO=y
CONFIG_BLK_DEV_IDE_MODES=y


