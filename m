Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318211AbSHZSvc>; Mon, 26 Aug 2002 14:51:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318216AbSHZSvc>; Mon, 26 Aug 2002 14:51:32 -0400
Received: from mailgate5.cinetic.de ([217.72.192.165]:31153 "EHLO
	mailgate5.cinetic.de") by vger.kernel.org with ESMTP
	id <S318211AbSHZSva>; Mon, 26 Aug 2002 14:51:30 -0400
Date: Mon, 26 Aug 2002 20:55:32 +0200
Message-Id: <200208261855.g7QItWX08701@mailgate5.cinetic.de>
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
>
ok, now I am a step further: I have a testcase, where I used a 10MB file with random
content. I scp'd this file from another machine to the laptop:

joerg@laptop> scp otter_machine:/tmp/10mb_file /tmp/

with the 8139too NIC module this takes 8 minutes, 32 second and has
about 97500 error on the NIC, all are RC oerruns.

When I do the same with Donald Beckers rtl8139 module then the transfer
takes 10 seconds and has about 1865 errors - not perfect but much better.

I dont want to generalize, but for my case the rtl8139 module seems
to fit much better.

Thanks for your help
Joerg

