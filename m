Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262361AbTFBOS0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jun 2003 10:18:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262362AbTFBOS0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jun 2003 10:18:26 -0400
Received: from AToulouse-105-1-28-54.w81-51.abo.wanadoo.fr ([81.51.110.54]:32516
	"EHLO choocroot.dyndns.org") by vger.kernel.org with ESMTP
	id S262361AbTFBOSW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jun 2003 10:18:22 -0400
Date: Mon, 2 Jun 2003 16:29:44 +0200
From: =?iso-8859-15?B?Suly9G1lIEF1Z+k=?= <jauge@club-internet.fr>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.21 can't set IDE DMA on harddrive (HDIO_SET_DMA failed: Operation not permitted)
Message-ID: <20030602142944.GA2094@satellite.workgroup.fr>
References: <20030602114838.GA1730@satellite.workgroup.fr> <200306022200.37685.kernel@kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200306022200.37685.kernel@kolivas.org>
Organization: none
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 02, 2003 at 10:00:37PM +1000, Con Kolivas wrote:
> On Mon, 2 Jun 2003 21:48, Jérôme Augé wrote:
> > Hi,
> >
> > I'm now using kernel 2.4.20-13.8 (from RH8) and 2.4.21-ck1 (from Con
> > Kolivas based on 2.4.21-rc6) and I'm unable to set the dma for my
> > harddrive with hdparm:
> 
> Feel free to blame me, but I haven't formally released 2.4.21-ck1, and you 
> should really try the vanilla 2.4.21-rc kernel. Then you can post a bug 
> report that the actual IDE developers can look at. Mine is a non-standard 
> kernel tree and bug reports with that branch should just be directed to me.
> 

I just tried a vanilla 2.4.21-rc6 and I get the same error messages when
trying to activate the DMA with hdparm.

I guess this is related to the new E-IDE code 7.00 in the 2.4.21 kernel
...

Here is the IDE config of this 2.4.21-rc6 kernel:

--8<--
#
# ATA/IDE/MFM/RLL support
#
CONFIG_IDE=y
#
# IDE, ATA and ATAPI Block devices
#
CONFIG_BLK_DEV_IDE=y
# CONFIG_BLK_DEV_HD_IDE is not set
# CONFIG_BLK_DEV_HD is not set
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTI_MODE=y
# CONFIG_IDEDISK_STROKE is not set
# CONFIG_BLK_DEV_IDECS is not set
CONFIG_BLK_DEV_IDECD=y
# CONFIG_BLK_DEV_IDETAPE is not set
# CONFIG_BLK_DEV_IDEFLOPPY is not set
# CONFIG_BLK_DEV_IDESCSI is not set
# CONFIG_IDE_TASK_IOCTL is not set
CONFIG_BLK_DEV_CMD640=y
# CONFIG_BLK_DEV_CMD640_ENHANCED is not set
# CONFIG_BLK_DEV_ISAPNP is not set
CONFIG_BLK_DEV_IDEPCI=y
# CONFIG_BLK_DEV_GENERIC is not set
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
# CONFIG_BLK_DEV_OFFBOARD is not set
# CONFIG_BLK_DEV_IDEDMA_FORCED is not set
CONFIG_IDEDMA_PCI_AUTO=y
# CONFIG_IDEDMA_ONLYDISK is not set
CONFIG_BLK_DEV_IDEDMA=y
# CONFIG_IDEDMA_PCI_WIP is not set
# CONFIG_BLK_DEV_ADMA100 is not set
# CONFIG_BLK_DEV_AEC62XX is not set
# CONFIG_BLK_DEV_ALI15X3 is not set
# CONFIG_WDC_ALI15X3 is not set
# CONFIG_BLK_DEV_AMD74XX is not set
# CONFIG_AMD74XX_OVERRIDE is not set
# CONFIG_BLK_DEV_CMD64X is not set
# CONFIG_BLK_DEV_TRIFLEX is not set
# CONFIG_BLK_DEV_CY82C693 is not set
# CONFIG_BLK_DEV_CS5530 is not set
# CONFIG_BLK_DEV_HPT34X is not set
# CONFIG_HPT34X_AUTODMA is not set
# CONFIG_BLK_DEV_HPT366 is not set
# CONFIG_BLK_DEV_PIIX is not set
# CONFIG_BLK_DEV_NS87415 is not set
# CONFIG_BLK_DEV_OPTI621 is not set
# CONFIG_BLK_DEV_PDC202XX_OLD is not set
# CONFIG_PDC202XX_BURST is not set
# CONFIG_BLK_DEV_PDC202XX_NEW is not set
# CONFIG_BLK_DEV_RZ1000 is not set
# CONFIG_BLK_DEV_SC1200 is not set
# CONFIG_BLK_DEV_SVWKS is not set
# CONFIG_BLK_DEV_SIIMAGE is not set
# CONFIG_BLK_DEV_SIS5513 is not set
# CONFIG_BLK_DEV_SLC90E66 is not set
# CONFIG_BLK_DEV_TRM290 is not set
# CONFIG_BLK_DEV_VIA82CXXX is not set
# CONFIG_IDE_CHIPSETS is not set
CONFIG_IDEDMA_AUTO=y
# CONFIG_IDEDMA_IVB is not set
# CONFIG_DMA_NONPCI is not set
CONFIG_BLK_DEV_IDE_MODES=y
# CONFIG_BLK_DEV_ATARAID is not set
# CONFIG_BLK_DEV_ATARAID_PDC is not set
# CONFIG_BLK_DEV_ATARAID_HPT is not set
# CONFIG_BLK_DEV_ATARAID_SII is not set
-->8--

-- 

