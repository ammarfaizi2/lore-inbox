Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317063AbSHZNMs>; Mon, 26 Aug 2002 09:12:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317473AbSHZNMs>; Mon, 26 Aug 2002 09:12:48 -0400
Received: from mailgate5.cinetic.de ([217.72.192.165]:22488 "EHLO
	mailgate5.cinetic.de") by vger.kernel.org with ESMTP
	id <S317063AbSHZNMq>; Mon, 26 Aug 2002 09:12:46 -0400
Date: Mon, 26 Aug 2002 15:16:50 +0200
Message-Id: <200208261316.g7QDGoX12068@mailgate5.cinetic.de>
MIME-Version: 1.0
Organization: http://freemail.web.de/
From: <joerg.beyer@email.de>
To: joerg.beyer@email.de, "ZwaneMwaikambo" <zwane@linuxpower.ca>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Re: Re: <no subject>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zwane Mwaikambo <zwane@linuxpower.ca> schrieb am 25.08.02 14:10:12:
> On Sun, 25 Aug 2002 joerg.beyer@email.de wrote:
> 
> > you are right, I had no dma enabled. Now I recomiled the kernel with this
> > dma-related options:
> > 
> > CONFIG_BLK_DEV_IDEDMA_PCI=y
> > # CONFIG_BLK_DEV_IDEDMA_FORCED is not set
> > CONFIG_IDEDMA_PCI_AUTO=y
> > # CONFIG_IDEDMA_ONLYDISK is not set
> > CONFIG_BLK_DEV_IDEDMA=y
> > # CONFIG_IDEDMA_PCI_WIP is not set
> > # CONFIG_BLK_DEV_IDEDMA_TIMEOUT is not set
> > # CONFIG_IDEDMA_NEW_DRIVE_LISTINGS is not set
> > CONFIG_BLK_DEV_ADMA=y
> > # CONFIG_HPT34X_AUTODMA is not set
> > CONFIG_IDEDMA_AUTO=y
> > # CONFIG_IDEDMA_IVB is not set
> > # CONFIG_DMA_NONPCI is not set
> > 
> > 
> > and I still get many many errors on the nic. Do I need something more in .config?
> 
> That should fix your slowdown during untarring/disk access, as for your 
> NIC problem looks like you might be having a receive FIFO overflow, so 
> perhaps the card stops processing incoming packets? I have no clue, 
> Jeff?

I set max_interrupt_work to higher values, 
e.g. 500 (instead of the default value 20) and the message in /var/log/messages
does not appear - no wonder. But I still get large numbes of RX errors and
RX overruns (these numbers are equal most of the time). So receiving
is to slow and brings RX overruns.

Is there anything I can do about it? 

It's a Athlon 1200 and that should be
fast enough to receive data on a single connection.

    still confused, but now on a higher level
    Joerg

