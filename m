Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261688AbTFBTwm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jun 2003 15:52:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261769AbTFBTwl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jun 2003 15:52:41 -0400
Received: from fed1mtao05.cox.net ([68.6.19.126]:4311 "EHLO fed1mtao05.cox.net")
	by vger.kernel.org with ESMTP id S261688AbTFBTwi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jun 2003 15:52:38 -0400
Date: Mon, 2 Jun 2003 13:05:50 -0700 (MST)
From: James Blanford <jimmybgood@cox.net>
Reply-To: jimmybgood9@yahoo.com
Subject: 2.4.21-rc6-rmap15j possible drive format corruption
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=us-ascii
Content-Disposition: INLINE
Message-Id: <20030602200601.YWX5311.fed1mtao05.cox.net@ip68-0-167-78.tc.ph.cox.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Now this could just be a complete coincidence and my hard drive decided
to head south just minutes after the second time I booted
2.4.21-rc6-rmap15j.  But it is also quite reminiscent of the
Thanksgiving, 2001 greased-turkey release.  This time I have no system
problems or error messages, but got a report of 3 ATA errors (my drive's
first) from a running SMART daemon.

Both smartmontool's smartctl and Seagate's SeaTools Desktop gave an
error that basically meant that the drive self-tests could not be run.
Seagate offered the possibility that a low-level format could correct
the problem.  More ominously, upon booting to a system on a different
drive and running badblocks, badblocks hangs testing the beginning of
the partition that my root is mounted on. Everything else is ok
including fsck (without badblocks).

drive:	Seagate 340016A, ATA 40GB
board:	ECS K7S5A, SiS 735 chipset, SiS 5513 on board IDE
filesystem:	ext3 built into kernel
config:	

#
# IDE chipset support/bugfixes
#
# CONFIG_BLK_DEV_CMD640 is not set
CONFIG_BLK_DEV_IDEPCI=y
# CONFIG_BLK_DEV_GENERIC is not set
# CONFIG_IDEPCI_SHARE_IRQ is not set
CONFIG_BLK_DEV_IDEDMA_PCI=y
# CONFIG_BLK_DEV_OFFBOARD is not set
# CONFIG_BLK_DEV_IDEDMA_FORCED is not set
CONFIG_IDEDMA_PCI_AUTO=y
# CONFIG_IDEDMA_ONLYDISK is not set
CONFIG_BLK_DEV_IDEDMA=y
# CONFIG_BLK_DEV_OFFBOARD is not set
# CONFIG_BLK_DEV_IDEDMA_FORCED is not set
CONFIG_IDEDMA_PCI_AUTO=y
# CONFIG_IDEDMA_ONLYDISK is not set
CONFIG_BLK_DEV_IDEDMA=y
# CONFIG_IDEDMA_PCI_WIP is not set
# CONFIG_BLK_DEV_ADMA100 is not set
# CONFIG_BLK_DEV_AEC62XX is not set
# CONFIG_BLK_DEV_ALI15X3 is not set
# CONFIG_BLK_DEV_AMD74XX is not set
# CONFIG_BLK_DEV_CMD64X is not set
# CONFIG_BLK_DEV_TRIFLEX is not set
# CONFIG_BLK_DEV_CY82C693 is not set
# CONFIG_BLK_DEV_CS5530 is not set
# CONFIG_BLK_DEV_HPT34X is not set
# CONFIG_BLK_DEV_HPT366 is not set
# CONFIG_BLK_DEV_PIIX is not set
# CONFIG_BLK_DEV_NS87415 is not set
# CONFIG_BLK_DEV_OPTI621 is not set
# CONFIG_BLK_DEV_PDC202XX_OLD is not set
# CONFIG_BLK_DEV_PDC202XX_NEW is not set
# CONFIG_BLK_DEV_RZ1000 is not set
# CONFIG_BLK_DEV_SC1200 is not set
# CONFIG_BLK_DEV_SIIMAGE is not set
CONFIG_BLK_DEV_SIS5513=y
# CONFIG_BLK_DEV_SLC90E66 is not set
# CONFIG_BLK_DEV_TRM290 is not set
# CONFIG_BLK_DEV_VIA82CXXX is not set
# CONFIG_IDE_CHIPSETS is not set
CONFIG_IDEDMA_AUTO=y
# CONFIG_IDEDMA_IVB is not set
# CONFIG_DMA_NONPCI is not set
CONFIG_BLK_DEV_IDE_MODES=y
# CONFIG_BLK_DEV_ATARAID is not set

I normally don't post and know that this could be a hardware problem
only.  I decided to post because I (and I imagine anyone else) would
have missed it if I had not been running smartd.  Or maybe all this
smart stuff is just bogus?

What, me worry?

     -  Alfred

PS Not subscribed, but lurking
