Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269081AbRHROel>; Sat, 18 Aug 2001 10:34:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270179AbRHROeb>; Sat, 18 Aug 2001 10:34:31 -0400
Received: from [65.105.206.211] ([65.105.206.211]:54143 "EHLO
	MAIL.confluencenetworks.com") by vger.kernel.org with ESMTP
	id <S269081AbRHROeS> convert rfc822-to-8bit; Sat, 18 Aug 2001 10:34:18 -0400
Subject: RE: Via usb problems...
Date: Sat, 18 Aug 2001 07:33:37 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-ID: <71AD71402EB8B04AB30F351C1EE5707C17C8CB@MAIL.confluencenetworks.com>
content-class: urn:content-classes:message
X-MimeOLE: Produced By Microsoft Exchange V6.0.4417.0
Thread-Topic: Via usb problems...
Thread-Index: AcEnMWgcS0ZAKrnSSIum1t8rlH53jwAwTo4w
From: "Curtis Bridges" <cbridges@confluencenetworks.com>
To: <linux-usb-devel@lists.sourceforge.net>
Cc: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

More updates:

I tried this hardware setup (see lspci output below) against kernel
2.4.8 and xfree86 4.1 and now everything behaves like it does in Win2k;
meaning the usb mouse "skips" and stops working for a fraction of a
second about once every 60 seconds.  With earlier kernel/xfree setups
once the mouse skipped for the first time, it would never come back
until I rebooted (since I don't dare mess with /dev stuff too much)

Here is my lspci -v output:

00:00.0 Host bridge: VIA Technologies, Inc.: Unknown device 3099
	Flags: bus master, medium devsel, latency 8
	Memory at e0000000 (32-bit, prefetchable) [size=64M]
	Capabilities: <available only to root>

00:01.0 PCI bridge: VIA Technologies, Inc.: Unknown device b099 (prog-if
00 [Normal decode])
	Flags: bus master, 66Mhz, medium devsel, latency 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	I/O behind bridge: 0000a000-0000afff
	Memory behind bridge: dde00000-dfefffff
	Prefetchable memory behind bridge: cdc00000-ddcfffff
	Capabilities: <available only to root>

00:07.0 Ethernet controller: 3Com Corporation 3c905C-TX [Fast Etherlink]
(rev 78)
	Subsystem: 3Com Corporation 3C905C-TX Fast Etherlink for PC
Management NIC
	Flags: bus master, medium devsel, latency 64, IRQ 11
	I/O ports at d800 [size=128]
	Memory at dfffff80 (32-bit, non-prefetchable) [size=128]
	Expansion ROM at dffa0000 [disabled] [size=128K]
	Capabilities: <available only to root>

00:09.0 Multimedia audio controller: Ensoniq ES1371 [AudioPCI-97] (rev
07)
	Subsystem: Ensoniq: Unknown device 8001
	Flags: bus master, slow devsel, latency 64, IRQ 10
	I/O ports at d400 [size=64]
	Capabilities: <available only to root>

00:11.0 ISA bridge: VIA Technologies, Inc.: Unknown device 3074
	Subsystem: VIA Technologies, Inc.: Unknown device 3074
	Flags: bus master, stepping, medium devsel, latency 0
	Capabilities: <available only to root>

00:11.1 IDE interface: VIA Technologies, Inc. VT82C586 IDE [Apollo] (rev
06) (prog-if 8a [Master SecP PriP])
	Subsystem: VIA Technologies, Inc. VT82C586 IDE [Apollo]
	Flags: bus master, medium devsel, latency 32
	I/O ports at ff00 [size=16]
	Capabilities: <available only to root>

00:11.2 USB Controller: VIA Technologies, Inc. VT82C586B USB (rev 18)
(prog-if 00 [UHCI])
	Subsystem: Unknown device 0925:1234
	Flags: bus master, medium devsel, latency 64, IRQ 12
	I/O ports at c800 [size=32]
	Capabilities: <available only to root>

00:11.3 USB Controller: VIA Technologies, Inc. VT82C586B USB (rev 18)
(prog-if 00 [UHCI])
	Subsystem: Unknown device 0925:1234
	Flags: bus master, medium devsel, latency 64, IRQ 12
	I/O ports at cc00 [size=32]
	Capabilities: <available only to root>

00:11.4 USB Controller: VIA Technologies, Inc. VT82C586B USB (rev 18)
(prog-if 00 [UHCI])
	Subsystem: Unknown device 0925:1234
	Flags: bus master, medium devsel, latency 64, IRQ 12
	I/O ports at d000 [size=32]
	Capabilities: <available only to root>

01:00.0 VGA compatible controller: nVidia Corporation NV11 (rev b2)
(prog-if 00 [VGA])
	Flags: bus master, 66Mhz, medium devsel, latency 64, IRQ 10
	Memory at de000000 (32-bit, non-prefetchable) [size=16M]
	Memory at d0000000 (32-bit, prefetchable) [size=128M]
	Expansion ROM at dfef0000 [disabled] [size=64K]
	Capabilities: <available only to root>





-----Original Message-----
From: Alan Cox [mailto:alan@lxorguk.ukuu.org.uk]
Sent: Friday, August 17, 2001 11:33 AM
To: Curtis Bridges
Cc: linux-kernel@vger.kernel.org; linux-usb-devel@lists.sourceforge.net
Subject: Re: Via usb problems...


> The work-around for the problem is provided by VIA in the form of some
> updated drivers for windows.  It appears to be some sort of usb
filter,
> possibly for low bandwidth USB peripherals.  I suspect this isn't a
> working resolution for most people on this list and I was wondering if
> anyone has been working on this in the kernel?  I might be able to
> provide some more information if it is needed to diagnose and solve
the
> problem...

Can you provide me

1.	The lspci -v info for your box (chip revision etc)
2.	Details ont he updated windows drivers (eg URL for)
3.	The USB devices

> Does VIA have any engineers working on linux drivers?

Directly, I don't believe so. However they do provide contact points for
some of us and have provided workarounds for other bugs. We now have a 
mechanism in place for making such requests.

Firstly however I'd like the USB folks to look at the debug and traces
to be
sure this isnt a VIA chip bug. If it is I'll take it up with VIA
