Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317305AbSHYMF6>; Sun, 25 Aug 2002 08:05:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317308AbSHYMF6>; Sun, 25 Aug 2002 08:05:58 -0400
Received: from swazi.realnet.co.sz ([196.28.7.2]:57533 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S317305AbSHYMF6>; Sun, 25 Aug 2002 08:05:58 -0400
Date: Sun, 25 Aug 2002 14:26:46 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@linux-box.realnet.co.sz
To: joerg.beyer@email.de
Cc: linux-kernel@vger.kernel.org
Subject: Re: Re: <no subject>
In-Reply-To: <200208251107.g7PB7wX12648@mailgate5.cinetic.de>
Message-ID: <Pine.LNX.4.44.0208251410000.28574-100000@linux-box.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 25 Aug 2002 joerg.beyer@email.de wrote:

> you are right, I had no dma enabled. Now I recomiled the kernel with this
> dma-related options:
> 
> CONFIG_BLK_DEV_IDEDMA_PCI=y
> # CONFIG_BLK_DEV_IDEDMA_FORCED is not set
> CONFIG_IDEDMA_PCI_AUTO=y
> # CONFIG_IDEDMA_ONLYDISK is not set
> CONFIG_BLK_DEV_IDEDMA=y
> # CONFIG_IDEDMA_PCI_WIP is not set
> # CONFIG_BLK_DEV_IDEDMA_TIMEOUT is not set
> # CONFIG_IDEDMA_NEW_DRIVE_LISTINGS is not set
> CONFIG_BLK_DEV_ADMA=y
> # CONFIG_HPT34X_AUTODMA is not set
> CONFIG_IDEDMA_AUTO=y
> # CONFIG_IDEDMA_IVB is not set
> # CONFIG_DMA_NONPCI is not set
> 
> 
> and I still get many many errors on the nic. Do I need something more in .config?

That should fix your slowdown during untarring/disk access, as for your 
NIC problem looks like you might be having a receive FIFO overflow, so 
perhaps the card stops processing incoming packets? I have no clue, 
Jeff?

	Zwane

-- 
function.linuxpower.ca



