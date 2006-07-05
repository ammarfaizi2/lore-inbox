Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932305AbWGECUS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932305AbWGECUS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jul 2006 22:20:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932355AbWGECUS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jul 2006 22:20:18 -0400
Received: from py-out-1112.google.com ([64.233.166.179]:38469 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S932305AbWGECUQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jul 2006 22:20:16 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=uhn6yIjN/oGKDLe/fJGUzAI17ry3+8mTU0SZWKyALrMkC43K4+O16p93RahU+dH65awcJwEHsa+23fnvNV0NFHPuWyxZN0juuWsiRYu5XvobeDTG/slaMd6CdQpcdVwFsbElOoFvW5ZS6Njpl294yvyFYzgeGxHbIHJJvBuqk+8=
Message-ID: <a44ae5cd0607041920p691a1998w8b3fb844cab6b706@mail.gmail.com>
Date: Tue, 4 Jul 2006 19:20:16 -0700
From: "Miles Lane" <miles.lane@gmail.com>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Subject: Re: 2.6.17-mm5 + pcmcia/hostap/8139too patches -- inconsistent {hardirq-on-W} -> {in-hardirq-W} usage
Cc: "Arjan van de Ven" <arjan@infradead.org>, mingo@elte.hu,
       "Andrew Morton" <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1152005201.28597.14.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <a44ae5cd0607031431q8dcc698j1c447b1d51c7cc75@mail.gmail.com>
	 <1151963034.3108.59.camel@laptopd505.fenrus.org>
	 <1151965557.16528.36.camel@localhost.localdomain>
	 <a44ae5cd0607031614y2055828as6e0bbe2ce0d52ff1@mail.gmail.com>
	 <1152005201.28597.14.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/4/06, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> Ar Llu, 2006-07-03 am 16:14 -0700, ysgrifennodd Miles Lane:
> > eth2: NE2000 (DL10022 rev 30): io 0x300, irq 11, hw_addr 00:50:BA:73:92:3D
> > Which seems to indicate I need to tweak the PCMCIA settings to get this card
> > working.  I wonder if anyone is going to follow up on enabling shared IRQ
> > support.
>
>
> Try this. Note the SMP locking in this driver appears iffy and looks
> like it was never SMP sane.

The patch corrects the messages about shared interrupts:

pccard: PCMCIA card inserted into slot 0
cs: memory probe 0x0c0000-0x0fffff: excluding 0xc0000-0xcffff 0xdc000-0xfffff
cs: memory probe 0x50000000-0x51ffffff: excluding 0x50000000-0x51ffffff
cs: memory probe 0x60000000-0x60ffffff: clean.
cs: memory probe 0xa0000000-0xa0ffffff: clean.
cs: memory probe 0xe0200000-0xe02fffff: excluding 0xe0200000-0xe020ffff
pcmcia: registering new device pcmcia0.0
PM: Adding info for pcmcia:0.0
eth2: NE2000 (DL10022 rev 30): io 0x300, irq 11, hw_addr 00:50:BA:73:92:3D

I have lost the connector cable that attaches the card to an ethernet
cable, so I have been using a cable labelled 3COM instead.  It has
LEDs for 10 and 100 Kbps connections.
Neither LED is lighting up.  On the other hand, NetworkManager
seems aware when I have an ethernet cable attached.  I now
suspect that I need a new cable.  The card is a D-Link DFE-650
Fast Ethernet PCMCIA adapter.  Maybe I should order one of these:
http://shopping.yahoo.com/p:QVS%20CPN-GN100T%20:1991447348;_ylt=Ap_SzM9pNc5eVJDZKVqsYd5tpcsE;_ylu=X3oDMTBuZDl1N2RxBF9zAzU5MDk4NTIxBGx0AzQEc2VjA3Ny?clink=dmss//ctx=sc:cnetwork_adapter,c:cnetwork_adapter,mid:57,pid:1991447348,pdid:57,pos:6

What do you think?
           Miles
