Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129926AbRBOU2U>; Thu, 15 Feb 2001 15:28:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129850AbRBOU2K>; Thu, 15 Feb 2001 15:28:10 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:48649 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129903AbRBOU1y>; Thu, 15 Feb 2001 15:27:54 -0500
Subject: Re: MTU and 2.4.x kernel
To: kuznet@ms2.inr.ac.ru
Date: Thu, 15 Feb 2001 20:27:15 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), roger@kea.GRace.CRi.NZ,
        linux-kernel@vger.kernel.org
In-Reply-To: <200102151933.WAA20558@ms2.inr.ac.ru> from "kuznet@ms2.inr.ac.ru" at Feb 15, 2001 10:33:23 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14TUzm-0000ni-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> A. Datagram protocols do not work with mtus not allowing to send
>    512 byte frames (even DNS).

I ran DNS reliably over AX.25 networks. They have an MTU of 216. They work.
Please explain your claim in more detail. Please explain why the real world
is violating your version of the laws of physics.

> B. Accoutning, classification, resource reervation does not work on
>    fragmented packets.

Thats a bug in accounting classification and resource reservation. We expect
cisco to fix their ECN bugs I think its rather cheeky to refuse to deal
with our own flaws.

> mistake, I found some fun talking to people, which suffer of superstition
> that "mtu 296 is good for..." (latency for example) 8)8)8)

Over a 9600 mobile phone link mtu 296 makes measurable differences to the
latency when mixing a mail fetch with typing. Over a radio link where 
error rate causes exponential increases in probability of packet loss as
the frame length grows the issue is even more visible.

> Right observation. It stops to work even earlier: at mtu<128.
> It is strict limit. Pardon, discussing marginal cases is useless.
> If someone has device with mtu of 128, let him to put it back to the place,
> where he found it.

NetROM is MTU 128. It is a neccessary but inconvenient limitation that would
require ripping out tens of thousands of nodes to fix. 

> I would prefer that minimal MTU on internet stayed on 576, which
> is already fact.

Only in your mind. Not in the real world. If you wont fix the TCP/IP code
to handle a 128 byte MTU properly then -ac will diverge from the main tree
because some of us want Linux to work on real world tricky environments.

If you want to argue that a MTU < 512 is hard to deal with by MTU discovery
you are right. So when you get a 'must fragment' below 512, just turn DF off
for that socket. Its not exactly a hard problem to solve properly.


I repeat my request. Cite the RFC number and line.

Alan

