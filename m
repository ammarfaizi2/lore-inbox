Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269457AbRHCQRK>; Fri, 3 Aug 2001 12:17:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269456AbRHCQQu>; Fri, 3 Aug 2001 12:16:50 -0400
Received: from gusi.leathercollection.ph ([202.163.192.10]:35299 "HELO
	gusi.leathercollection.ph") by vger.kernel.org with SMTP
	id <S269455AbRHCQQl>; Fri, 3 Aug 2001 12:16:41 -0400
Date: Sat, 4 Aug 2001 00:16:23 +0800 (PHT)
From: Federico Sevilla III <jijo@leathercollection.ph>
X-X-Sender: <jijo@gusi.leathercollection.local>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Xircom CardBus RBE-100 "No MII transceiver found"
Message-ID: <Pine.LNX.4.33.0108040006540.4008-100000@gusi.leathercollection.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everyone,

I'm using 2.4.8-pre3, with pcmcia-cs 3.1.27 (no pcmcia modules from the
pcmcia package, all from the kernel). I have support for CardBus built in.
I've tried compiling support for my Xircom CardBus RBE-100 into the kernel
and as a module. It just won't work. On both occasions dmesg shows
something like this:

cs: cb_alloc(bus 5): vendor 0x115d, device 0x0003
PCI: Failed to allocate resource 0(1000-fff) for 05:00.0
  got res[11000000:110007ff] for resource 1 of PCI device 115d:0003
  got res[11000800:11000fff] for resource 2 of PCI device 115d:0003
  got res[10c00000:10c03fff] for resource 1 of PCI device 115d:0003
PCI: Enabling device 05:00.00 (0000 -> 0003)
tulip_attach(05:00.0)
PCI: Setting latency timer of device 05:00.0 to 64
xircom_tulip_cb.c:v0.91 4/14/99 becker@scyld.com (modified by danilo@cs.uni-magdeburg.de for XIRCOM CBE, fixed by Doug Ledford)
xircom(05:00.0): ***WARNING***: No MII transceiver found!
eth0: Xircom Cardbus Adapter (DEC 21143 compatible mode) rev 3 at 0x1000, 00:00:00:00:00:00, IRQ 9.

I've got an Acer Extensa 503T, which has an O2Micro controller.

The link does not go up at all, the lights on the switch I'm connected to
and on the NIC itself remain turned off. I would love to test going on
PROMISC mode as I hear that may fix things, but I can't get the link up.
Forcing eth0 up by doing an "ifconfig eth0 up" then "dhclient eth0" won't
work.

$ cardctl status
Socket 0:
  no card
Socket 1:
  3.3V CardBus card
  function 0: [ready]

$ cardctl ident 1
  product info: "Xircom", "CardBus Ethernet II 10/100", "CBEII-10/100", "1.03"
  manfid: 0x0105, 0x0103
  function: 6 (network)

I hope someone can either tell me straight out that this is not a support
Xircom card (I'm under the impression that somehow it is, although I
really can't get it to work), or can help me fix things.

I apologize if this is rather newbieish for this list.

Thanks in advance!

 --> Jijo

--
Federico Sevilla III  :: jijo@leathercollection.ph
Network Administrator :: The Leather Collection, Inc.
GnuPG Key: <http://www.leathercollection.ph/jijo.gpg>

