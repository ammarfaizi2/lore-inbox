Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129834AbQK1GSw>; Tue, 28 Nov 2000 01:18:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S130008AbQK1GSn>; Tue, 28 Nov 2000 01:18:43 -0500
Received: from marks-43.caltech.edu ([131.215.92.43]:27662 "EHLO
        velius.chaos2.org") by vger.kernel.org with ESMTP
        id <S129834AbQK1GSg>; Tue, 28 Nov 2000 01:18:36 -0500
Date: Mon, 27 Nov 2000 21:48:04 -0800 (PST)
From: Jacob Luna Lundberg <jacob@velius.chaos2.org>
To: Toby Jaffey <toby@earth.li>
cc: Andre Hedrick <andre@linux-ide.org>, linux-kernel@vger.kernel.org
Subject: Re: test-10 tulip "eth0 timed out" (smp, heavy IDE use)
Message-ID: <Pine.LNX.4.21.0011272132240.10109-100000@velius.chaos2.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > Linksys LNE version 4, 00:0d.0 Ethernet controller: Bridgecom, Inc:
> > Unknown device 0985 (rev 11)
[...]
> > Nov 28 04:04:52 twoey kernel: NETDEV WATCHDOG: eth0: transmit timed out
> > Nov 28 04:04:52 twoey kernel: eth0: Transmit timed out, status fc664010,
> > CSR12 00000000, resetting...

I can replicate this message any day you want.  It seems that this card is
perhaps a bit too sensitive to high interrupt latencies or something to
that effect.  Dan Hollis worked on my box for several days and we found
that the problem tends to trigger (in my case) when nfs is in use.  But I
still haven't had time to explore further.  :(

Dan tells me the chip in question is a Centaur so I presume eventually
kernels will identify it correctly once somebody adds it to the list.  :)

-Jacob

-- 

" ... mutant DEC .au files ... "

-http://ocean.hhardy.net/ftp/systems/linux/snd/Lsox/Sox/
 [1999.09.22 - sorry, link is dead nowadays]

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
