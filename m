Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318736AbSHQU7a>; Sat, 17 Aug 2002 16:59:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318737AbSHQU7a>; Sat, 17 Aug 2002 16:59:30 -0400
Received: from ulima.unil.ch ([130.223.144.143]:54162 "HELO ulima.unil.ch")
	by vger.kernel.org with SMTP id <S318736AbSHQU72>;
	Sat, 17 Aug 2002 16:59:28 -0400
Date: Sat, 17 Aug 2002 23:03:24 +0200
From: Gregoire Favre <greg@ulima.unil.ch>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.20-pre2-ac3 oops
Message-ID: <20020817210324.GA6593@ulima.unil.ch>
References: <20020816181957.GA14157@ulima.unil.ch> <1029615216.4809.55.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1029615216.4809.55.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 17, 2002 at 09:13:36PM +0100, Alan Cox wrote:

> These are a bit disturbing to say the least. If you boot without ACPI
> and PnPBIOS do those vanish. I think thats unrelated however but is
> something wrong

I don't got those using 2.4.20-pre1-ac1, but I only put the whole log
because I was happy my Palm did a good job in seeing the "console" ;-)

> An lspci -v and info on what is attached to each ide controller would be
> good

00:00.0 Host bridge: Intel Corp. 82845 845 (Brookdale) Chipset Host Bridge (rev 11)
        Flags: bus master, fast devsel, latency 0
        Memory at e0000000 (32-bit, prefetchable) [size=64M]
        Capabilities: [e4] #09 [a104]
        Capabilities: [a0] AGP version 2.0

00:01.0 PCI bridge: Intel Corp. 82845 845 (Brookdale) Chipset AGP Bridge (rev 11) (prog-if 00 [Normal decode])
        Flags: bus master, 66Mhz, fast devsel, latency 32
        Bus: primary=00, secondary=01, subordinate=02, sec-latency=32
        Memory behind bridge: dec00000-dfdfffff
        Prefetchable memory behind bridge: da800000-de9fffff

00:1d.0 USB Controller: Intel Corp.: Unknown device 24c2 (rev 01) (prog-if 00 [UHCI])
        Subsystem: Micro-star International Co Ltd: Unknown device 3982
        Flags: bus master, medium devsel, latency 0, IRQ 16
        I/O ports at d800 [size=32]

00:1d.1 USB Controller: Intel Corp.: Unknown device 24c4 (rev 01) (prog-if 00 [UHCI])
        Subsystem: Micro-star International Co Ltd: Unknown device 3982
        Flags: bus master, medium devsel, latency 0, IRQ 19
        I/O ports at dc00 [size=32]

00:1d.7 USB Controller: Intel Corp.: Unknown device 24cd (rev 01) (prog-if 20 [EHCI])
        Subsystem: Micro-star International Co Ltd: Unknown device 3981
        Flags: bus master, medium devsel, latency 0, IRQ 23
        Memory at dfffbc00 (32-bit, non-prefetchable) [size=1K]
        Capabilities: [50] Power Management version 2
        Capabilities: [58] #0a [2080]

00:1e.0 PCI bridge: Intel Corp. 82801BA/CA PCI Bridge (rev 81) (prog-if 00 [Normal decode])
        Flags: bus master, fast devsel, latency 0
        Bus: primary=00, secondary=03, subordinate=03, sec-latency=32
        I/O behind bridge: 0000b000-0000bfff
        Memory behind bridge: dfe00000-dfefffff
        Prefetchable memory behind bridge: dea00000-deafffff

00:1f.0 ISA bridge: Intel Corp.: Unknown device 24c0 (rev 01)
        Flags: bus master, medium devsel, latency 0

00:1f.1 IDE interface: Intel Corp. 82801DB ICH4 IDE (rev 01) (prog-if 8a [Master SecP PriP])
        Subsystem: Micro-star International Co Ltd: Unknown device 3982
        Flags: bus master, medium devsel, latency 0, IRQ 18
        I/O ports at 01f0
        I/O ports at 03f4
        I/O ports at 0170
        I/O ports at 0374
        I/O ports at fc00 [size=16]
        Memory at 20000000 (32-bit, non-prefetchable) [size=1K]

00:1f.3 SMBus: Intel Corp.: Unknown device 24c3 (rev 01)
        Subsystem: Micro-star International Co Ltd: Unknown device 3982
        Flags: medium devsel, IRQ 17
        I/O ports at 0c00 [size=32]

00:1f.5 Multimedia audio controller: Intel Corp.: Unknown device 24c5 (rev 01)
        Subsystem: Micro-star International Co Ltd: Unknown device 3982
        Flags: bus master, medium devsel, latency 0, IRQ 17
        I/O ports at d400 [size=256]
        I/O ports at d000 [size=64]
        Memory at dffffe00 (32-bit, non-prefetchable) [size=512]
        Memory at dffffd00 (32-bit, non-prefetchable) [size=256]
        Capabilities: [50] Power Management version 2

01:00.0 VGA compatible controller: Matrox Graphics, Inc. MGA G550 AGP (rev 01) (prog-if 00 [VGA])
        Subsystem: Matrox Graphics, Inc. Millennium G550 Dual Head DDR 32Mb
        Flags: bus master, medium devsel, latency 32, IRQ 16
        Memory at dc000000 (32-bit, prefetchable) [size=32M]
        Memory at dfdfc000 (32-bit, non-prefetchable) [size=16K]
        Memory at df000000 (32-bit, non-prefetchable) [size=8M]
        Expansion ROM at dfdc0000 [disabled] [size=128K]
        Capabilities: [dc] Power Management version 2
        Capabilities: [f0] AGP version 2.0

03:00.0 Network controller: AVM Audiovisuelles MKTG & Computer System GmbH A1 ISDN [Fritz] (rev 02)
        Subsystem: AVM Audiovisuelles MKTG & Computer System GmbH FRITZ!Card ISDN Controller
        Flags: medium devsel, IRQ 16
        Memory at dfefefe0 (32-bit, non-prefetchable) [size=32]
        I/O ports at b800 [size=32]

03:01.0 Multimedia controller: Philips Semiconductors SAA7146 (rev 01)
        Subsystem: Technotrend Systemtechnik GmbH: Unknown device 0000
        Flags: bus master, medium devsel, latency 32, IRQ 17
        Memory at dfefec00 (32-bit, non-prefetchable) [size=512]

03:02.0 SCSI storage controller: Adaptec AIC-7892A U160/m (rev 02)
        Subsystem: Adaptec 29160LP Low Profile Ultra160 SCSI Controller
        Flags: bus master, 66Mhz, medium devsel, latency 32, IRQ 18
        BIST result: 00
        I/O ports at bc00 [disabled] [size=256]
        Memory at dfeff000 (64-bit, non-prefetchable) [size=4K]
        Expansion ROM at dfec0000 [disabled] [size=128K]
        Capabilities: [dc] Power Management version 2

03:03.0 SCSI storage controller: Adaptec AHA-2940U/UW/D / AIC-7881U
        Flags: bus master, medium devsel, latency 32, IRQ 19
        I/O ports at b400 [disabled] [size=256]
        Memory at dfefd000 (32-bit, non-prefetchable) [size=4K]
        Expansion ROM at dfee0000 [disabled] [size=64K]

03:04.0 Multimedia controller: Philips Semiconductors SAA7146 (rev 01)
        Subsystem: Technotrend Systemtechnik GmbH: Unknown device 0000
        Flags: bus master, medium devsel, latency 32, IRQ 16
        Memory at dfefea00 (32-bit, non-prefetchable) [size=512]

03:08.0 Ethernet controller: Intel Corp.: Unknown device 103a (rev 81)
        Subsystem: Intel Corp.: Unknown device 1039
        Flags: bus master, medium devsel, latency 32, IRQ 20
        Memory at dfef8000 (32-bit, non-prefetchable) [size=4K]
        I/O ports at b000 [size=64]
        Capabilities: [dc] Power Management version 2

And, on the first ide, I got a 120 Gb Maxtor HD and one the second a
250 Mb ZIP, both are master.

Thank you very much,

	Grégoire
________________________________________________________________
http://ulima.unil.ch/greg ICQ:16624071 mailto:greg@ulima.unil.ch
