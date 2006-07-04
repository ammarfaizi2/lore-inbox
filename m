Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750872AbWGDICB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750872AbWGDICB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jul 2006 04:02:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750965AbWGDICA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jul 2006 04:02:00 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:42694 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1750872AbWGDICA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jul 2006 04:02:00 -0400
Subject: Re: 2.6.17-mm5 + pcmcia/hostap/8139too patches -- inconsistent
	{hardirq-on-W} -> {in-hardirq-W} usage
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Miles Lane <miles.lane@gmail.com>
Cc: Arjan van de Ven <arjan@infradead.org>, mingo@elte.hu,
       Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <a44ae5cd0607031614y2055828as6e0bbe2ce0d52ff1@mail.gmail.com>
References: <a44ae5cd0607031431q8dcc698j1c447b1d51c7cc75@mail.gmail.com>
	 <1151963034.3108.59.camel@laptopd505.fenrus.org>
	 <1151965557.16528.36.camel@localhost.localdomain>
	 <a44ae5cd0607031614y2055828as6e0bbe2ce0d52ff1@mail.gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 04 Jul 2006 09:18:47 +0100
Message-Id: <1152001127.28597.5.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Llu, 2006-07-03 am 16:14 -0700, ysgrifennodd Miles Lane:
> pcmcia: request for exclusive IRQ could not be fulfilled.
> pcmcia: the driver needs updating to supported shared IRQ lines.
> eth2: NE2000 (DL10022 rev 30): io 0x300, irq 11, hw_addr 00:50:BA:73:92:3D
> Which seems to indicate I need to tweak the PCMCIA settings to get this card
> working.  I wonder if anyone is going to follow up on enabling shared IRQ
> support.

Thats a bug in the PCMCIA driver. The 8390 driver core supports shared
IRQ so you should just need to turn it on in pcnet_cs


