Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129790AbRAKO0F>; Thu, 11 Jan 2001 09:26:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131546AbRAKOZr>; Thu, 11 Jan 2001 09:25:47 -0500
Received: from vela.salleURL.edu ([130.206.42.85]:54537 "EHLO
	vela.salleURL.edu") by vger.kernel.org with ESMTP
	id <S130706AbRAKOZd>; Thu, 11 Jan 2001 09:25:33 -0500
Date: Thu, 11 Jan 2001 15:38:53 +0000 (GMT)
From: Carles Pina i Estany <is08139@salleURL.edu>
To: <linux-kernel@vger.kernel.org>
Subject: PCMCIA Cards on 2.4.0
Message-ID: <Pine.LNX.4.30.0101111328001.14183-100000@vela.salleURL.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

I have a Digital HiNote VP.

PCMCIA's works fine with Kernel 2.4.0 test12 (I think that I cannot change
pcmcia card with the computer running because the new PCMCIA is not
detected).

With Kernel 2.4.0 and the same .config PCMCIA don't work. It is detected
on boot, yenta socket, assigns two IRQ's, but when I do:

pinux:/etc/pcmcia# cardctl ident
Socket 0:
  no product info available
Socket 1:
  no product info available

I try with modules, and builtin in kernel.

Sometimes the pcmcia is detected, sometimes no (I always insert the pcmcia
card before power of the computer).

I have a Kingston Network Card and a serial card (Quatech SSP-100).
Now, if I insert the Kingston card on socket 1 and I don't insert serial
port on socket 0 works (I think). But I do the test, and I remember that
if I put the serial card on socket 1 don't work.

I recompile with diferent options, with Power Managament, without, with
PCI, without, with serial support to pcmcia and without...

Sometimes the cards are detected... but sometimes only one, only two...

I repeat that I use the same configuration that Kernel 2.4.0test12. Why
with test12 work and the final release don't work?

(a friend of me have a similar problem, other friend doesn't have any
problem)

pinux:/etc/pcmcia# cardmgr -V
cardmgr version 3.1.23


With Kernel that works fine (2.4.0test12)

PCI: Found IRQ 9 for device 00:04.0
PCI: Found IRQ 10 for device 00:04.1
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 4096 bind 4096)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
Yenta IRQ list 0000, PCI irq9
Socket status: 30000007
Yenta IRQ list 0000, PCI irq10
Socket status: 30000411

With the other kernel only change the Socket status (I think that I insert
a card, then socket status change ¿?)

When I can I will test ac version, I see in the ChangeLog that there are
some changes with PCMCIA driver.

Thank you very much!

PD: Is this the correct mailinglist to the question?

----
Carles Pina i Estany
   E-Mail: cpina@linuxfan.com || #ICQ: 14446118 || Nick: Pinux
   URL: http://www.salleurl.edu/~is08139
   Unos días después de instalar Windows 95 se me desgastó el botón de reset.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
