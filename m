Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268019AbTCFM4s>; Thu, 6 Mar 2003 07:56:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268031AbTCFM4s>; Thu, 6 Mar 2003 07:56:48 -0500
Received: from nessie.weebeastie.net ([61.8.7.205]:18122 "EHLO
	nessie.lochness.weebeastie.net") by vger.kernel.org with ESMTP
	id <S268019AbTCFM4r>; Thu, 6 Mar 2003 07:56:47 -0500
Date: Fri, 7 Mar 2003 00:03:40 +1100
From: CaT <cat@zip.com.au>
To: dahinds@users.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: 2.5.64 - xircom realport no workie well
Message-ID: <20030306130340.GA453@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Organisation: Furball Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Heyas.

With the 2.5.x series of kernels I've lost serial port functionality of
my xircom pcmcia card and the network port, whilst working, does give
errors on eject. The dmesg from an insert/eject sequence is:

cs: cb_alloc(bus 2): vendor 0x115d, device 0x0003
PCI: Enabling device 02:00.0 (0000 -> 0003)
PCI: Setting latency timer of device 02:00.0 to 64
eth1: Xircom cardbus revision 3 at irq 10 
PCI: Enabling device 02:00.1 (0000 -> 0003)
ttyS15 at I/O 0x1880 (irq = 10) is a 16550A
Trying to free nonexistent resource <00001880-00001887>
cs: cb_free(bus 2)

When accessing the serial port (ttyS15) all I get is:

13 [23:58:06] root@theirongiant:/usr/src/linux>> cat /dev/ttyS15
cat: /dev/ttyS15: Input/output error

I know this card has a real modem in it as I've used it in the past with
some version of 2.4.x and pcmcia-cs package. I'd like to use the kernel
stuff though so that I can stop having to install 4MB or so of modules into
/lib.

If you need any help from me with debugging/testing/whatnot, then please
holler. I'll try to do any testing etc asap.

Oh yeah. Relevant .config options:

CONFIG_PCMCIA=y
CONFIG_PCMCIA_XIRCOM=y
CONFIG_NET_PCMCIA=y
CONFIG_PCMCIA_XIRC2PS=y
CONFIG_SERIAL_8250_CS=y
CONFIG_BLK_DEV_IDECS=y

-- 
"Other countries of course, bear the same risk. But there's no doubt his
hatred is mainly directed at us. After all this is the guy who tried to         kill my dad."
        - George W. Bush Jr, 'President' of the United States
          September 26, 2002 (from a political fundraiser in Huston, Texas)

