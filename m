Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130509AbRBHTc3>; Thu, 8 Feb 2001 14:32:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129649AbRBHTcT>; Thu, 8 Feb 2001 14:32:19 -0500
Received: from mail.uni-kl.de ([131.246.137.52]:59264 "EHLO mail.uni-kl.de")
	by vger.kernel.org with ESMTP id <S129354AbRBHTcL>;
	Thu, 8 Feb 2001 14:32:11 -0500
Message-ID: <3A82F427.916F8F0C@itwm.fhg.de>
Date: Thu, 08 Feb 2001 20:31:51 +0100
From: Martin Braun <braun@itwm.fhg.de>
Organization: Fraunhofer ITWM
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: No sound on GA-7ZX (2.4.1-ac6, via audio)
Content-Type: multipart/mixed;
 boundary="------------3926C8FB65A49FDBE297B2B2"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------3926C8FB65A49FDBE297B2B2
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Hello all

I can not get sound working on a computer with a Gigabyte
GA-7ZX mainboard (KT133 chipset). Is this a known problem?
I have attached some config info. Mail me for further details.

Thanks in advance,

Martin Braun
-- 
+---------------------------------+----------------------------------+
| Martin Braun (Dipl.-Phys.)      | EMail: braun@itwm.fhg.de         |
| Fraunhofer Institut für Techno- |                                  |
| und Wirtschaftsmathematik       | Tel.: ++49(0)631/36681-19        |
| Gottlieb-Daimler-Straße         | Fax : ++49(0)631/36681-66        |
| D-67663 Kaiserslautern          | Geb.: PRE-Park 209               |
+---------------------------------+----------------------------------+
--------------3926C8FB65A49FDBE297B2B2
Content-Type: text/plain; charset=us-ascii;
 name="typescript"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="typescript"

Script started on Thu Feb  8 20:15:30 2001
$ lsmod
Module                  Size  Used by
nfs                    77632   4  (autoclean)
lockd                  49872   1  (autoclean) [nfs]
sunrpc                 59584   1  (autoclean) [nfs lockd]
eepro100               17536   1  (autoclean)
via82cxxx_audio        27680   0 
ac97_codec              8720   0  [via82cxxx_audio]
soundcore               4240   2  [via82cxxx_audio]
usb-uhci               22128   0  (unused)
usbcore                48656   1  [usb-uhci]
$ play /usr/share/sounds/KDE_Startup.wav
sox: Unable to set audio speed to 22050 (set to 0)
sox: Sampling rate for /dev/dsp file was not given

$ cat /proc/driver/via/0/*
Vendor name      : SigmaTel STAC????
Vendor id        : 8384 7600
AC97 Version     : 1.0
Capabilities     :
DAC resolutions  : -16-bit- -18-bit-
ADC resolutions  : -16-bit- -18-bit-
3D enhancement   : SigmaTel 3D Enhancement
POP path         : pre 3D
Sim. stereo      : off
3D enhancement   : off
Loudness         : off
Mono output      : MIX
MIC select       : MIC1
ADC/DAC loopback : off
Ext Capabilities :
VIA 82Cxxx Audio driver 1.1.14a

Via 82Cxxx PCI registers:

40  Codec Ready: yes
    Codec Low-power: no
    Secondary Codec Ready: no

41  Interface Enable: enable
    De-Assert Reset: yes
    Force SYNC high: no
    Force SDO high: no
    Variable Sample Rate On-Demand Mode: enable
    SGD Read Channel PCM Data Out: enable
    FM Channel PCM Data Out: disable
    SB PCM Data Out: disable

42  Game port enabled: yes
    SoundBlaster enabled: no
    FM enabled: no
    MIDI enabled: no

44  AC-Link Interface Access: no
    Secondary Codec Support: no

$ lspci -vx
00:00.0 Host bridge: VIA Technologies, Inc.: Unknown device 0305 (rev 02)
	Flags: bus master, medium devsel, latency 8
	Memory at e0000000 (32-bit, prefetchable) [size=64M]
	Capabilities: [a0] AGP version 2.0
	Capabilities: [c0] Power Management version 2
00: 06 11 05 03 06 00 10 22 02 00 00 06 00 08 00 00
10: 08 00 00 e0 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 a0 00 00 00 00 00 00 00 00 00 00 00

00:01.0 PCI bridge: VIA Technologies, Inc.: Unknown device 8305 (prog-if 00 [Normal decode])
	Flags: bus master, 66Mhz, medium devsel, latency 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	I/O behind bridge: 00009000-00009fff
	Memory behind bridge: dda00000-dfafffff
	Prefetchable memory behind bridge: cd800000-dd8fffff
	Capabilities: [80] Power Management version 2
00: 06 11 05 83 07 00 30 22 00 00 04 06 00 00 01 00
10: 00 00 00 00 00 00 00 00 00 01 01 00 90 90 00 00
20: a0 dd a0 df 80 cd 80 dd 00 00 00 00 00 00 00 00
30: 00 00 00 00 80 00 00 00 00 00 00 00 00 00 08 00

00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super] (rev 22)
	Subsystem: VIA Technologies, Inc. VT82C686/A PCI to ISA Bridge
	Flags: bus master, stepping, medium devsel, latency 0
00: 06 11 86 06 87 00 10 02 22 00 01 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 06 11 86 06
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:07.1 IDE interface: VIA Technologies, Inc. VT82C586 IDE [Apollo] (rev 10) (prog-if 8a [Master SecP PriP])
	Flags: bus master, medium devsel, latency 32
	I/O ports at ffa0 [size=16]
	Capabilities: [c0] Power Management version 2
00: 06 11 71 05 07 00 90 02 10 8a 01 01 00 20 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: a1 ff 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 c0 00 00 00 00 00 00 00 ff 00 00 00

00:07.2 USB Controller: VIA Technologies, Inc. VT82C586B USB (rev 10) (prog-if 00 [UHCI])
	Subsystem: Unknown device 0925:1234
	Flags: bus master, medium devsel, latency 64, IRQ 9
	I/O ports at c000 [size=32]
	Capabilities: [80] Power Management version 2
00: 06 11 38 30 17 01 10 02 10 00 03 0c 08 40 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 01 c0 00 00 00 00 00 00 00 00 00 00 25 09 34 12
30: 00 00 00 00 80 00 00 00 00 00 00 00 09 04 00 00

00:07.3 USB Controller: VIA Technologies, Inc. VT82C586B USB (rev 10) (prog-if 00 [UHCI])
	Subsystem: Unknown device 0925:1234
	Flags: bus master, medium devsel, latency 64, IRQ 9
	I/O ports at c400 [size=32]
	Capabilities: [80] Power Management version 2
00: 06 11 38 30 17 01 10 02 10 00 03 0c 08 40 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 01 c4 00 00 00 00 00 00 00 00 00 00 25 09 34 12
30: 00 00 00 00 80 00 00 00 00 00 00 00 09 04 00 00

00:07.4 SMBus: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 30)
	Flags: medium devsel
	Capabilities: [68] Power Management version 2
00: 06 11 57 30 00 00 90 02 30 00 05 0c 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 68 00 00 00 00 00 00 00 00 00 00 00

00:07.5 Multimedia audio controller: VIA Technologies, Inc. VT82C686 [Apollo Super AC97/Audio] (rev 20)
	Subsystem: Giga-byte Technology: Unknown device a000
	Flags: medium devsel, IRQ 10
	I/O ports at d000 [size=256]
	I/O ports at cc00 [size=4]
	I/O ports at c800 [size=4]
	Capabilities: [c0] Power Management version 2
00: 06 11 58 30 01 00 10 02 20 00 01 04 00 00 00 00
10: 01 d0 00 00 01 cc 00 00 01 c8 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 58 14 00 a0
30: 00 00 00 00 c0 00 00 00 00 00 00 00 0a 03 00 00

00:0d.0 Ethernet controller: Intel Corporation 82557 [Ethernet Pro 100] (rev 08)
	Subsystem: Intel Corporation EtherExpress PRO/100+ Management Adapter
	Flags: bus master, medium devsel, latency 64, IRQ 5
	Memory at dffff000 (32-bit, non-prefetchable) [size=4K]
	I/O ports at bc00 [size=64]
	Memory at dfe00000 (32-bit, non-prefetchable) [size=1M]
	Expansion ROM at dfd00000 [disabled] [size=1M]
	Capabilities: [dc] Power Management version 2
00: 86 80 29 12 17 00 90 02 08 00 00 02 08 40 00 00
10: 00 f0 ff df 01 bc 00 00 00 00 e0 df 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 86 80 0c 00
30: 00 00 d0 df dc 00 00 00 00 00 00 00 05 01 08 38

01:00.0 VGA compatible controller: nVidia Corporation NV11 (rev a1) (prog-if 00 [VGA])
	Flags: bus master, 66Mhz, medium devsel, latency 64, IRQ 11
	Memory at de000000 (32-bit, non-prefetchable) [size=16M]
	Memory at d0000000 (32-bit, prefetchable) [size=128M]
	Expansion ROM at dfaf0000 [disabled] [size=64K]
	Capabilities: [60] Power Management version 2
	Capabilities: [44] AGP version 2.0
00: de 10 10 01 07 00 b0 02 a1 00 00 03 00 40 00 00
10: 00 00 00 de 08 00 00 d0 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 af df 60 00 00 00 00 00 00 00 0b 01 05 01

$ exit
Script done on Thu Feb  8 20:16:39 2001

--------------3926C8FB65A49FDBE297B2B2--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
