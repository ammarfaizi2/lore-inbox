Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263021AbSJGMtz>; Mon, 7 Oct 2002 08:49:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263022AbSJGMtz>; Mon, 7 Oct 2002 08:49:55 -0400
Received: from modemcable061.219-201-24.mtl.mc.videotron.ca ([24.201.219.61]:41373
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S263021AbSJGMtx>; Mon, 7 Oct 2002 08:49:53 -0400
Date: Mon, 7 Oct 2002 08:41:25 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: Mikael Pettersson <mikpe@csd.uu.se>
cc: jgarzik@pobox.com, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][2.5][RFT] 3c509.c extra ethtool features
In-Reply-To: <200210071040.MAA18108@harpo.it.uu.se>
Message-ID: <Pine.LNX.4.44.0210070836580.24365-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Oct 2002, Mikael Pettersson wrote:

> 3c509-TPO, ca 1994 vintage, ethtool eth0 output:
> 
> Settings for eth0:
> 	Supported ports: [ TP AUI ]
> 	Supported link modes:   10baseT/Half 10baseT/Full 
> 	Supports auto-negotiation: No
> 	Advertised link modes:  Not reported
> 	Advertised auto-negotiation: No
> 	Speed: 10Mb/s
> 	Duplex: Half
> 	Port: Twisted Pair
> 	PHYAD: 0
> 	Transceiver: internal
> 	Auto-negotiation: off
> 	Current message level: 0x00000002 (2)
> 	Link detected: yes

Cool.

> So far so good (except it reports AUI although it has none).

Hmm, that info is from the card registers, perhaps your board just doesn't 
have the interface wired?

> Unfortunately, this simple query killed the link, and I had to
> down/up eth0 to get it back.

Could be a missing EL3WINDOW change somewhere, i don't write to any 
registers in the query path. I'll check that out.

> Next I tried ethtool -s to change some settings (port, speed,
> full duplex) and all returned errors. I kind of expected that.
> Next I tried to rlogin to this box from another: complete kernel hang :-(

Could be one of the -EINVALs i think i need more sanity checks in there.

> I may be able to test some more later this week, on a slightly newer
> 3c509(B?) TP/AUI combo NIC.

Thanks,
	Zwane
-- 
function.linuxpower.ca

