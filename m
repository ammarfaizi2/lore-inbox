Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262004AbSI3KVx>; Mon, 30 Sep 2002 06:21:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262005AbSI3KVx>; Mon, 30 Sep 2002 06:21:53 -0400
Received: from pa90.banino.sdi.tpnet.pl ([213.76.211.90]:55056 "EHLO
	alf.amelek.gda.pl") by vger.kernel.org with ESMTP
	id <S262004AbSI3KVw>; Mon, 30 Sep 2002 06:21:52 -0400
Subject: Re: [patch] fix parport_serial / serial link order (for 2.4.20-pre8)
In-Reply-To: <Pine.LNX.4.44.0209300515420.24805-100000@montezuma.mastecende.com>
To: Zwane Mwaikambo <zwane@linuxpower.ca>
Date: Mon, 30 Sep 2002 12:27:09 +0200 (CEST)
CC: Marek Michalkiewicz <marekm@amelek.gda.pl>, twaugh@redhat.com,
       serial24@macrolink.com, Linux Kernel <linux-kernel@vger.kernel.org>
X-Mailer: ELM [version 2.4ME+ PL95 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Message-Id: <E17vxld-0004kB-00@alf.amelek.gda.pl>
From: Marek Michalkiewicz <marekm@amelek.gda.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Tim would know better there since he removed it, but iirc it had something 
> to do with the BARs used, hmm your card has the same PCI id and is serial 
> neutered to an extent, what happens if you treat it as if it really does 
> have both serial ports there? Does it still work without causing other 
> problems so you can safely ignore it? FYI, Interrupt driven works great 
> for me.

Hmm, not sure what you're talking about - I have both serial ports working
fine, sharing one IRQ.  Not sure what the regions 3-5 are for though...
If you have a parport IRQ sharing patch to test, you can send it to me.

The card is just a bare NM9835 chip + two GD75232 chips (RS232 drivers),
no configuration EEPROM mounted, so all data is from the NM9835 defaults
and all such cards should work the same way...

00:09.0 Communication controller: Unknown device 9710:9835 (rev 01)
	Subsystem: LSI Logic / Symbios Logic (formerly NCR): Unknown device 0012
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 9
	Region 0: I/O ports at ac00 [size=8]
	Region 1: I/O ports at b000 [size=8]
	Region 2: I/O ports at b400 [size=8]
	Region 3: I/O ports at b800 [size=8]
	Region 4: I/O ports at bc00 [size=8]
	Region 5: I/O ports at c000 [size=16]

parport0: PC-style at 0x378 [PCSPP,TRISTATE,EPP]
parport_pc: Via 686A parallel port: io=0x378
...
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI ISAPNP enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
PCI parallel port detected: 9710:9835, I/O at 0xb400(0x0)
parport1: PC-style at 0xb400 [PCSPP,TRISTATE,EPP]
ttyS04 at port 0xac00 (irq = 9) is a 16550A
ttyS05 at port 0xb000 (irq = 9) is a 16550A
lp0: using parport0 (polling).
lp0: console ready
lp1: using parport1 (polling).

> link order shouldn't affect the decision seeing as it affects all 
> parport_serial anyway. You might have to wait it out and see what Tim/Ed 
> have to say but i do have patches for both lying about.

OK, I'll try to be patient ;)

Marek

