Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264129AbUBQIu4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 03:50:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264137AbUBQIu4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 03:50:56 -0500
Received: from bart.one-2-one.net ([217.115.142.76]:32785 "EHLO
	bart.webpack.hosteurope.de") by vger.kernel.org with ESMTP
	id S264129AbUBQIuy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 03:50:54 -0500
Date: Tue, 17 Feb 2004 09:54:52 +0100 (CET)
From: Martin Diehl <lists@mdiehl.de>
X-X-Sender: martin@notebook.home.mdiehl.de
To: Linus Torvalds <torvalds@osdl.org>
cc: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.3-rc4
In-Reply-To: <Pine.LNX.4.58.0402161945540.30742@home.osdl.org>
Message-ID: <Pine.LNX.4.44.0402170946140.31216-100000@notebook.home.mdiehl.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Feb 2004, Linus Torvalds wrote:

> Bartlomiej Zolnierkiewicz:
>   o make __ide_dma_off() generic and remove ide_hwif_t->ide_dma_off

doesn't build for me:

drivers/built-in.o(.text+0x3aa33): In function `set_using_dma':
: undefined reference to `__ide_dma_off'
drivers/built-in.o(.text+0x401bc): In function `check_dma_crc':
: undefined reference to `__ide_dma_off'
make: *** [.tmp_vmlinux1] Error 1

relevant .config section below.

Martin

-------------------------

#
# ATA/ATAPI/MFM/RLL support
#
CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y

#
# Please see Documentation/ide.txt for help/info on IDE drives
#
# CONFIG_BLK_DEV_HD_IDE is not set
CONFIG_BLK_DEV_IDEDISK=y
# CONFIG_IDEDISK_MULTI_MODE is not set
# CONFIG_IDEDISK_STROKE is not set
# CONFIG_BLK_DEV_IDECS is not set
# CONFIG_BLK_DEV_IDECD is not set
# CONFIG_BLK_DEV_IDETAPE is not set
# CONFIG_BLK_DEV_IDEFLOPPY is not set
# CONFIG_BLK_DEV_IDESCSI is not set
# CONFIG_IDE_TASK_IOCTL is not set
# CONFIG_IDE_TASKFILE_IO is not set

#
# IDE chipset support/bugfixes
#
CONFIG_IDE_GENERIC=y
# CONFIG_BLK_DEV_CMD640 is not set
# CONFIG_BLK_DEV_IDEPCI is not set
# CONFIG_IDE_CHIPSETS is not set
# CONFIG_BLK_DEV_IDEDMA is not set
# CONFIG_IDEDMA_AUTO is not set
# CONFIG_DMA_NONPCI is not set
# CONFIG_BLK_DEV_HD is not set


