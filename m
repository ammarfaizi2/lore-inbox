Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129988AbRBOUmV>; Thu, 15 Feb 2001 15:42:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130045AbRBOUmL>; Thu, 15 Feb 2001 15:42:11 -0500
Received: from minus.inr.ac.ru ([193.233.7.97]:36869 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id <S129988AbRBOUl6>;
	Thu, 15 Feb 2001 15:41:58 -0500
From: kuznet@ms2.inr.ac.ru
Message-Id: <200102152041.XAA21220@ms2.inr.ac.ru>
Subject: Re: MTU and 2.4.x kernel
To: alan@lxorguk.ukuu.org.uk (Alan Cox)
Date: Thu, 15 Feb 2001 23:41:17 +0300 (MSK)
Cc: alan@lxorguk.ukuu.org.uk, roger@kea.GRace.CRi.NZ,
        linux-kernel@vger.kernel.org
In-Reply-To: <E14TUzm-0000ni-00@the-village.bc.nu> from "Alan Cox" at Feb 15, 1 08:27:15 pm
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> I ran DNS reliably over AX.25 networks. They have an MTU of 216. They work.

Please, Alan, distinguish two things: "works" and "works, until
I ask X". The second is equal to "does not".

512 is maximal message size, which is transmitted without troubles,
hardwired to almost all the datagram protocols.


> > B. Accoutning, classification, resource reervation does not work on
> >    fragmented packets.
> 
> Thats a bug in accounting classification and resource reservation.

Sorry? It is bug in client mtu selection. Functions above are impossible
on fragmented packet even in theory. And because of A, if client uses mtu
296, it cannot use 100% of emerging and existing IP functions.


> Over a 9600 mobile phone link mtu 296 makes measurable differences to the
> latency when mixing a mail fetch with typing.

It is myth. Changing mtu until ~4K does not affect latency, it stays on 4K/bw.


>						 Over a radio link where 
> error rate causes exponential increases in probability of packet loss as

Another myth. All they do error correction and have so high latency,
that _increasing_ mtu only helps. And helps a lot.

When you have 22Kbit link and 2 second latency, mtu must be large.



> NetROM is MTU 128.

I wrote "<". 8)


> If you want to argue that a MTU < 512 is hard to deal with by MTU discovery
> you are right. So when you get a 'must fragment' below 512, just turn DF off
> for that socket.

It is exactly, which we make, Alan. 8)


> I repeat my request. Cite the RFC number and line.

I repeat my reply: it is sillogism of A and B. See above.
You can write RFC yourself. 8)

Alexey
