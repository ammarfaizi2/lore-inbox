Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135178AbQL3LG4>; Sat, 30 Dec 2000 06:06:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135179AbQL3LGp>; Sat, 30 Dec 2000 06:06:45 -0500
Received: from isis.its.uow.edu.au ([130.130.68.21]:38376 "EHLO
	isis.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S135178AbQL3LGd>; Sat, 30 Dec 2000 06:06:33 -0500
Message-ID: <3A4DBC02.92C0FD9A@uow.edu.au>
Date: Sat, 30 Dec 2000 21:42:10 +1100
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.0-test8 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Repeatable 2.4.0-test13-pre4 nfsd Oops rears it head again
In-Reply-To: <20001228161126.A982@lingas.basement.bogus> <200012282159.NAA00929@pizda.ninka.net> <20001228212116.A968@lingas.basement.bogus> <92ha5l$1qh$1@penguin.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> I bet that others will have other recommendations, but so far I have at
> least personally had good luck with the eepro100.

The 3c905C is a well manufactured and very feature-rich NIC which at
present appears to have fewer problem reports than eepro100, 8139 or tulip.

Available in PCI, Cardbus, Mini-PCI.  A dual-interface PCI version has
just been released (3c982), although we've yet to hear of anyone trying
it with Linux.

3com provide full specs without any NDA restrictions, plus a GPL'ed
driver.

Perhaps most significantly, the 905 has full scatter/gather support.
This isn't used at present, but Alexey's zerocopy-sendfile patches
do utilise it.  He currently has scatter-gather support for acenic,
3c905 and sunhme.  I don't know what the plans are to support other
100 mbps NICs.

The in-kernel 3c59x.c isn't the world's fastest driver.  On the todo list
for 2.5 is MMIO support, scatter-gather maintenance, optional use of DPD
polling and implementation of the onboard multicast hash filter. And 
implementation of the on-board VLAN support if 2.5 becomes VLAN-capable.

-
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
