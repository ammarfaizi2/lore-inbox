Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130750AbRBQJIr>; Sat, 17 Feb 2001 04:08:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130773AbRBQJIg>; Sat, 17 Feb 2001 04:08:36 -0500
Received: from pcsalo.cern.ch ([137.138.213.103]:33805 "EHLO pcsalo.cern.ch")
	by vger.kernel.org with ESMTP id <S130750AbRBQJI1>;
	Sat, 17 Feb 2001 04:08:27 -0500
Date: Sat, 17 Feb 2001 10:08:21 +0100
From: Fons Rademakers <Fons.Rademakers@cern.ch>
To: linux-kernel@vger.kernel.org
Cc: andre@suse.com
Subject: had: lost interrupt...
Message-ID: <20010217100820.A16593@pcsalo.cern.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

   in my laptop (HP 4150B) I upgraded from a 12GB IBM Travelstar to an
20GB IBM Travelstar (both 4200rpm). After the upgrade I moved also to
2.4.2-pre3 and reiserfs. However, the problem I now have is that after
resume I get the message "hda: lost interrupt" and the only thing to do
is to reset the machine (in the only good thing is that reiserfs saved
me a lot of fsck time).

Any idea what the problem might be? Is the larger disk not supported by
the BIOS (it is recognized properly). People mentioned not to use DMA
anymore?

With 2.2.18 and the 12GB disk there were never problems (except that the
disk got bad blocks ;-().

My IDE setup in .config is below.


Cheers, Fons.



CONFIG_BLK_DEV_IDE=y

#
# Please see Documentation/ide.txt for help/info on IDE drives
#
# CONFIG_BLK_DEV_HD_IDE is not set
# CONFIG_BLK_DEV_HD is not set
CONFIG_BLK_DEV_IDEDISK=y
# CONFIG_IDEDISK_MULTI_MODE is not set
# CONFIG_BLK_DEV_IDEDISK_VENDOR is not set
# CONFIG_BLK_DEV_COMMERIAL is not set
CONFIG_BLK_DEV_IDECD=y
# CONFIG_BLK_DEV_IDETAPE is not set
CONFIG_BLK_DEV_IDEFLOPPY=y
# CONFIG_BLK_DEV_IDESCSI is not set
#
# IDE chipset support/bugfixes
#
# CONFIG_BLK_DEV_CMD640 is not set
# CONFIG_BLK_DEV_RZ1000 is not set
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
# CONFIG_BLK_DEV_OFFBOARD is not set
# CONFIG_IDEDMA_PCI_AUTO is not set
CONFIG_BLK_DEV_IDEDMA=y
# CONFIG_IDEDMA_PCI_WIP is not set
# CONFIG_BLK_DEV_AEC62XX is not set
# CONFIG_BLK_DEV_ALI15X3 is not set
# CONFIG_BLK_DEV_AMD7409 is not set
# CONFIG_BLK_DEV_CMD64X is not set
# CONFIG_BLK_DEV_CY82C693 is not set
# CONFIG_BLK_DEV_CS5530 is not set
# CONFIG_BLK_DEV_HPT34X is not set
# CONFIG_BLK_DEV_HPT366 is not set
CONFIG_BLK_DEV_PIIX=y
# CONFIG_BLK_DEV_NS87415 is not set
# CONFIG_BLK_DEV_OPTI621 is not set
# CONFIG_BLK_DEV_PDC202XX is not set
# CONFIG_BLK_DEV_OSB4 is not set
# CONFIG_BLK_DEV_SIS5513 is not set
# CONFIG_BLK_DEV_SLC90E66 is not set
# CONFIG_BLK_DEV_TRM290 is not set
# CONFIG_BLK_DEV_VIA82CXXX is not set
# CONFIG_IDE_CHIPSETS is not set
# CONFIG_IDEDMA_AUTO is not set
# CONFIG_IDEDMA_IVB is not set
# CONFIG_DMA_NONPCI is not set
CONFIG_BLK_DEV_IDE_MODES=y

-- 
Org:    CERN, European Laboratory for Particle Physics.
Mail:   1211 Geneve 23, Switzerland
E-Mail: Fons.Rademakers@cern.ch              Phone: +41 22 7679248
WWW:    http://root.cern.ch/~rdm/            Fax:   +41 22 7677910
