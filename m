Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267903AbTAMROj>; Mon, 13 Jan 2003 12:14:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267906AbTAMROj>; Mon, 13 Jan 2003 12:14:39 -0500
Received: from auemail1.lucent.com ([192.11.223.161]:21416 "EHLO
	auemail1.firewall.lucent.com") by vger.kernel.org with ESMTP
	id <S267903AbTAMROi>; Mon, 13 Jan 2003 12:14:38 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15906.62947.738373.947969@gargle.gargle.HOWL>
Date: Mon, 13 Jan 2003 12:22:43 -0500
From: "John Stoffel" <stoffel@lucent.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Bill Davidsen <davidsen@tmr.com>, Jean-Daniel Pauget <jd@disjunkt.com>,
       Alan Cox <alan@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.21pre3-ac2
In-Reply-To: <1042470092.18624.12.camel@irongate.swansea.linux.org.uk>
References: <Pine.LNX.3.96.1030112222243.17657C-100000@gatekeeper.tmr.com>
	<1042470092.18624.12.camel@irongate.swansea.linux.org.uk>
X-Mailer: VM 7.07 under Emacs 20.6.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Alan> I'm seeing enough other -ac specific errors to be fairly sure
Alan> its not just hardware in the current -ac tree case. I don't know
Alan> what the common factor is yet - it 'works for me' which makes it
Alan> hard to pin down

I'm now running -ac3 and it seems more stable.  I've got a Dual Xeon
550 Mhz Dell with 768mb of ECC memory and a Matrox G450 card.  Nice
stable system usually.

Alan> Guess #1 is reverting mm/shmem.c. Guess #2 is reverting the buffer cache
Alan> changes. Guess #3 is new IDE + highmem and Guess #4 is quota related (are
Alan> people seeing the problem with quota disabled ?)

I'm not running with quotas at all, and I've seen the complete lockup
under -ac1 and -ac2.  I'll see about stressing -ac3 with some
filesystem stuff to see what happens.  

Here are the options I have enabled for IDE on my system:
    
    CONFIG_PARIDE=m
    CONFIG_PARIDE_PARPORT=m
    CONFIG_PARIDE_PD=m
    CONFIG_PARIDE_PCD=m
    CONFIG_PARIDE_PF=m
    CONFIG_PARIDE_PT=m
    CONFIG_PARIDE_PG=m
    CONFIG_IDE=y
    CONFIG_BLK_DEV_IDE=y
    CONFIG_BLK_DEV_IDEDISK=y
    CONFIG_IDEDISK_MULTI_MODE=y
    CONFIG_BLK_DEV_IDECD=y
    CONFIG_BLK_DEV_IDETAPE=m
    CONFIG_BLK_DEV_IDEFLOPPY=m
    CONFIG_BLK_DEV_IDESCSI=m
    CONFIG_BLK_DEV_IDEPCI=y
    CONFIG_IDEPCI_SHARE_IRQ=y
    CONFIG_BLK_DEV_IDEDMA_PCI=y
    CONFIG_IDEDMA_PCI_AUTO=y
    CONFIG_BLK_DEV_IDEDMA=y
    CONFIG_IDEDMA_AUTO=y
    CONFIG_BLK_DEV_IDE_MODES=y


Maybe I can pull the buffer cache and/or SHMEM changes.  

John
