Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932103AbWGGPpc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932103AbWGGPpc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 11:45:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932114AbWGGPpb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 11:45:31 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:8937 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932103AbWGGPpb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 11:45:31 -0400
Subject: Re: 2.6.17-mm6
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andrew Morton <akpm@osdl.org>
Cc: "J.A. =?ISO-8859-1?Q?Magall=F3n ?=" <jamagallon@ono.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060706145752.64ceddd0.akpm@osdl.org>
References: <20060703030355.420c7155.akpm@osdl.org>
	 <20060705234347.47ef2600@werewolf.auna.net>
	 <20060705155602.6e0b4dce.akpm@osdl.org>
	 <20060706015706.37acb9af@werewolf.auna.net>
	 <20060705170228.9e595851.akpm@osdl.org>
	 <20060706163646.735f419f@werewolf.auna.net>
	 <20060706164802.6085d203@werewolf.auna.net>
	 <20060706234425.678cbc2f@werewolf.auna.net>
	 <20060706145752.64ceddd0.akpm@osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 07 Jul 2006 17:02:48 +0100
Message-Id: <1152288168.20883.8.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Iau, 2006-07-06 am 14:57 -0700, ysgrifennodd Andrew Morton:
> > ata1: PATA max UDMA/100 cmd 0x1F0 ctl 0x3F6 bmdma 0xF000 irq 14
> > ata2: PATA max UDMA/100 cmd 0x170 ctl 0x376 bmdma 0xF008 irq 15
> > ata3: SATA max UDMA/133 cmd 0xC000 ctl 0xC402 bmdma 0xD000 irq 16
> > ata4: SATA max UDMA/133 cmd 0xC800 ctl 0xCC02 bmdma 0xD008 irq 16
> > 
> 
> Ah-hah, thanks.  I think this is a relatively-FAQ, but I forget the answer.
> Alan's the man.

The "mixed" drivers/ide and drivers/scsi setup for the ICH is really
ugly (look at the pci/quirks.c code for it to see just *how* ugly). It
is still present but the default behaviour at the moment is to assume
that you want to use libata for your drives.

For most distros I've tried this doesn't seem to break anything. Some
older distros don't use labels for root searching so need root= passing
the first time to fix it.

That bit of code is really Jeff code but I can certainly put a Kconfig
line and submit a diff to allow users to pick whether their PIIX/ICH
should be handled half and half if Andrew or Jeff think that is wise.

Alan

