Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288374AbSAQIc4>; Thu, 17 Jan 2002 03:32:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288326AbSAQIch>; Thu, 17 Jan 2002 03:32:37 -0500
Received: from arm.t19.ds.pwr.wroc.pl ([156.17.236.105]:3588 "EHLO
	arm.t19.ds.pwr.wroc.pl") by vger.kernel.org with ESMTP
	id <S288325AbSAQIcR>; Thu, 17 Jan 2002 03:32:17 -0500
To: Andre Hedrick <andre@linuxdiskcert.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Andre IDE patches + Promise, UDMA detection
In-Reply-To: <Pine.LNX.4.10.10201161624120.30663-100000@master.linux-ide.org>
X-Attribution: arekm
X-URL: http://www.t17.ds.pwr.wroc.pl/~misiek/ipv6/
Organization: PLD Linux Distribution Team
From: Arkadiusz Miskiewicz <misiek@pld.ORG.PL>
Date: 17 Jan 2002 09:31:55 +0100
In-Reply-To: <Pine.LNX.4.10.10201161624120.30663-100000@master.linux-ide.org>
Message-ID: <87heplcr9g.fsf@arm.t19.ds.pwr.wroc.pl>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andre Hedrick <andre@linuxdiskcert.org> writes:

> Because sometimes the decay rate of the capacitance check after execute
> drive diagnostics command from POST is faster than boot.
> 
> Also if this problem happens only after a cold boot, but a warm boot is
> valid, you can set the CONFIG_IDEDMA_IVB=y
Unfortunately problem always happens - cold boot, warm boot - no difference.
So setting CONFIG_IDEDMA_IVB=y won't help in this case?

My IDE config looks that:
CONFIG_IDE=m
CONFIG_BLK_DEV_IDE=m
# CONFIG_BLK_DEV_HD_IDE is not set
CONFIG_BLK_DEV_IDEDISK=m
# CONFIG_IDEDISK_MULTI_MODE is not set
# CONFIG_IDEDISK_STROKE is not set
CONFIG_IDE_TASKFILE_IO=y
# CONFIG_BLK_DEV_IDEDISK_VENDOR is not set
# CONFIG_BLK_DEV_IDEDISK_FUJITSU is not set
# CONFIG_BLK_DEV_IDEDISK_IBM is not set
# CONFIG_BLK_DEV_IDEDISK_MAXTOR is not set
# CONFIG_BLK_DEV_IDEDISK_QUANTUM is not set
# CONFIG_BLK_DEV_IDEDISK_SEAGATE is not set
# CONFIG_BLK_DEV_IDEDISK_WD is not set
CONFIG_BLK_DEV_IDECS=m
CONFIG_BLK_DEV_IDECD=m
CONFIG_BLK_DEV_IDETAPE=m
CONFIG_BLK_DEV_IDEFLOPPY=m
CONFIG_BLK_DEV_IDESCSI=m
# CONFIG_IDE_TASK_IOCTL is not set
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
# CONFIG_BLK_DEV_IDEDMA_FORCED is not set
# CONFIG_IDEDMA_PCI_AUTO is not set
CONFIG_BLK_DEV_IDEDMA=y
# CONFIG_IDEDMA_PCI_WIP is not set
# CONFIG_IDEDMA_NEW_DRIVE_LISTINGS is not set
# CONFIG_IDE_CHIPSETS is not set
# CONFIG_IDEDMA_AUTO is not set
# CONFIG_IDEDMA_IVB is not set
CONFIG_BLK_DEV_IDE_MODES=y
CONFIG_CD_NO_IDESCSI=y

> > Unfortunately it thinks that all my harddrives (connected to promise
> > via 80wire cable) are UDMA33! Now _sometimes_ after boot it detects
> > these (properly) as UDMA100 and sometimes (seems more frequently)
> > as UDMA33.

> Andre Hedrick
> Linux Disk Certification Project                Linux ATA Development

-- 
Arkadiusz Mi¶kiewicz   IPv6 ready PLD Linux at http://www.pld.org.pl
misiek(at)pld.org.pl   AM2-6BONE, 1024/3DB19BBD, arekm(at)ircnet, PWr
