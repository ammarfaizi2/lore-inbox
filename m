Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130547AbQKAUsa>; Wed, 1 Nov 2000 15:48:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131418AbQKAUsU>; Wed, 1 Nov 2000 15:48:20 -0500
Received: from proxy.ovh.net ([213.244.20.42]:44041 "HELO proxy.ovh.net")
	by vger.kernel.org with SMTP id <S130547AbQKAUsC>;
	Wed, 1 Nov 2000 15:48:02 -0500
Message-ID: <3A008171.19F8456B@ovh.net>
Date: Wed, 01 Nov 2000 21:47:45 +0100
From: octave klaba <oles@ovh.net>
X-Mailer: Mozilla 4.73 [en] (Win98; I)
X-Accept-Language: fr,en
MIME-Version: 1.0
Cc: eepro100@scyld.com, linux-kernel@vger.kernel.org
Subject: Re: 2.2.18p18 eepro100 issues (packets per irq, shared irqs)
In-Reply-To: <E13r4Kv-0000nC-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)@pop.zip.com.au
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > They share an irq, no matter if I'm using intels e100.o driver or the stock
> > linux one.  For performance reasons, can I make them each have a different
> > irq?  Doing it from ifconfig gives me a notsupported error, with either
> > driver.
> 
> Under 2.2 no. Under 2.4 maybe

one question: using driver 1.11 of eepro, on a server with 1 
network carte only, we have something really dirty in dmesg
it writes IRQ 20 !? why all this folks ? ;) 
the good news there is no more eth0 problems :)

Octave

IRQ to pin mappings:
IRQ0 -> 2
IRQ1 -> 1
IRQ3 -> 3
IRQ4 -> 4
IRQ5 -> 5
IRQ6 -> 6
IRQ7 -> 7
IRQ8 -> 8
IRQ9 -> 9
IRQ14 -> 14
IRQ16 -> 0
IRQ20 -> 4
IRQ24 -> 8
IRQ25 -> 9


eth0: OEM i82557/i82558 10/100 Ethernet at 0xf0002000, 00:E0:18:02:15:02, IRQ 20.
  Board assembly 668081-002, Physical connectors present: RJ45
  Primary interface chip i82555 PHY #1.
  General self-test: passed.
  Serial sub-system self-test: passed.
  Internal registers self-test: passed.
  ROM checksum self-test: passed (0x04f4518b).
  Receiver lock-up workaround activated.
eepro100.c:v1.11 7/19/2000 Donald Becker <becker@scyld.com>
  http://www.scyld.com/network/eepro100.html
eth1: OEM i82557/i82558 10/100 Ethernet at 0xf0004000, 00:E0:18:02:15:02, IRQ 20.
[...]
eth7: OEM i82557/i82558 10/100 Ethernet at 0xf0010000, 00:E0:18:02:15:02, IRQ 20.
  Board assembly 668081-002, Physical connectors present: RJ45
  Primary interface chip i82555 PHY #1.
  General self-test: passed.
  Serial sub-system self-test: passed.
  Internal registers self-test: passed.
  ROM checksum self-test: passed (0x04f4518b).
  Receiver lock-up workaround activated.
eepro100.c:v1.11 7/19/2000 Donald Becker <becker@scyld.com>
  http://www.scyld.com/network/eepro100.html
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
