Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030546AbVKPX1q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030546AbVKPX1q (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 18:27:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030564AbVKPX1p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 18:27:45 -0500
Received: from e36.co.us.ibm.com ([32.97.110.154]:20895 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1030546AbVKPX1i
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 18:27:38 -0500
Subject: Re: 2.6.14 X spinning in the kernel
From: Badari Pulavarty <pbadari@us.ibm.com>
To: Dave Airlie <airlied@linux.ie>
Cc: Max Krasnyansky <maxk@qualcomm.com>, Andrew Morton <akpm@osdl.org>,
       lkml <linux-kernel@vger.kernel.org>, hugh@veritas.com
In-Reply-To: <Pine.LNX.4.58.0511162238480.24969@skynet>
References: <1132012281.24066.36.camel@localhost.localdomain>
	 <20051114161704.5b918e67.akpm@osdl.org>
	 <1132015952.24066.45.camel@localhost.localdomain>
	 <20051114173037.286db0d4.akpm@osdl.org> <437A6609.4050803@us.ibm.com>
	 <437B9FAC.4090809@qualcomm.com>
	 <1132177953.24066.80.camel@localhost.localdomain>
	 <Pine.LNX.4.58.0511162238480.24969@skynet>
Content-Type: multipart/mixed; boundary="=-2bE+ZGKvQHhYpUIhmRyA"
Date: Wed, 16 Nov 2005 15:27:25 -0800
Message-Id: <1132183645.24066.94.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-2bE+ZGKvQHhYpUIhmRyA
Content-Type: text/plain
Content-Transfer-Encoding: 7bit


> Again I say this is a chip hang, the chip isn't consuming any more data,
> so we run out of buffers...
> 
> Can you send me lspci -v, /var/log/Xorg.0.log, xorg.conf
> 
> If you are running a PCI Radeon you are screwed with the latest Fedora X
> packages, roll back a few to find the ones that work, the FC people took a
> really hacky patch from ATI and thought it was a good idea, and now it is
> in X.org, or turn off DRI...
> 

Okay, here is the data.

I am running RHEL4 and RHEL4 kernel runs fine with X.

Thanks,
Badari



--=-2bE+ZGKvQHhYpUIhmRyA
Content-Disposition: attachment; filename=lspci.out
Content-Type: text/plain; name=lspci.out; charset=utf-8
Content-Transfer-Encoding: 7bit

00:00.0 Host bridge: Intel Corporation E7520 Memory Controller Hub (rev 0c)
	Subsystem: IBM: Unknown device 02dd
	Flags: bus master, fast devsel, latency 0
	Memory at <ignored> (32-bit, non-prefetchable)
	Capabilities: [40] Vendor Specific Information

00:00.1 Class ff00: Intel Corporation E7525/E7520 Error Reporting Registers (rev 0c)
	Subsystem: IBM: Unknown device 02dd
	Flags: fast devsel

00:02.0 PCI bridge: Intel Corporation E7525/E7520/E7320 PCI Express Port A (rev 0c) (prog-if 00 [Normal decode])
	Flags: bus master, fast devsel, latency 0
	Bus: primary=00, secondary=02, subordinate=04, sec-latency=0
	Capabilities: [50] Power Management version 2
	Capabilities: [58] Message Signalled Interrupts: 64bit- Queue=0/1 Enable-
	Capabilities: [64] Express Root Port (Slot-) IRQ 0

00:04.0 PCI bridge: Intel Corporation E7525/E7520 PCI Express Port B (rev 0c) (prog-if 00 [Normal decode])
	Flags: bus master, fast devsel, latency 0
	Bus: primary=00, secondary=05, subordinate=05, sec-latency=0
	Memory behind bridge: dd000000-deffffff
	Capabilities: [50] Power Management version 2
	Capabilities: [58] Message Signalled Interrupts: 64bit- Queue=0/1 Enable-
	Capabilities: [64] Express Root Port (Slot-) IRQ 0

00:05.0 PCI bridge: Intel Corporation E7520 PCI Express Port B1 (rev 0c) (prog-if 00 [Normal decode])
	Flags: bus master, fast devsel, latency 0
	Bus: primary=00, secondary=06, subordinate=06, sec-latency=0
	Memory behind bridge: db000000-dcffffff
	Capabilities: [50] Power Management version 2
	Capabilities: [58] Message Signalled Interrupts: 64bit- Queue=0/1 Enable-
	Capabilities: [64] Express Root Port (Slot-) IRQ 0

00:06.0 PCI bridge: Intel Corporation E7520 PCI Express Port C (rev 0c) (prog-if 00 [Normal decode])
	Flags: bus master, fast devsel, latency 0
	Bus: primary=00, secondary=07, subordinate=09, sec-latency=0
	I/O behind bridge: 00004000-0000ffff
	Memory behind bridge: d9000000-daffffff
	Prefetchable memory behind bridge: 00000000df000000-00000000df000000
	Capabilities: [50] Power Management version 2
	Capabilities: [58] Message Signalled Interrupts: 64bit- Queue=0/1 Enable-
	Capabilities: [64] Express Root Port (Slot-) IRQ 0

00:08.0 System peripheral: Intel Corporation E7525/E7520/E7320 Extended Configuration Registers (rev 0c)
	Subsystem: IBM: Unknown device 02dd
	Flags: fast devsel

00:1d.0 USB Controller: Intel Corporation 82801EB/ER (ICH5/ICH5R) USB UHCI Controller #1 (rev 02) (prog-if 00 [UHCI])
	Subsystem: IBM: Unknown device 02dd
	Flags: bus master, medium devsel, latency 0, IRQ 129
	I/O ports at 2200 [size=32]

00:1d.1 USB Controller: Intel Corporation 82801EB/ER (ICH5/ICH5R) USB UHCI Controller #2 (rev 02) (prog-if 00 [UHCI])
	Subsystem: IBM: Unknown device 02dd
	Flags: bus master, medium devsel, latency 0, IRQ 145
	I/O ports at 2600 [size=32]

00:1d.7 USB Controller: Intel Corporation 82801EB/ER (ICH5/ICH5R) USB2 EHCI Controller (rev 02) (prog-if 20 [EHCI])
	Subsystem: IBM: Unknown device 02dd
	Flags: bus master, medium devsel, latency 0, IRQ 161
	Memory at f9000000 (32-bit, non-prefetchable) [size=1K]
	Capabilities: [50] Power Management version 2
	Capabilities: [58] Debug port

00:1e.0 PCI bridge: Intel Corporation 82801 PCI Bridge (rev c2) (prog-if 00 [Normal decode])
	Flags: bus master, fast devsel, latency 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
	I/O behind bridge: 00003000-00003fff
	Memory behind bridge: f8000000-f8ffffff
	Prefetchable memory behind bridge: f0000000-f7ffffff

00:1f.0 ISA bridge: Intel Corporation 82801EB/ER (ICH5/ICH5R) LPC Interface Bridge (rev 02)
	Flags: bus master, medium devsel, latency 0

00:1f.1 IDE interface: Intel Corporation 82801EB/ER (ICH5/ICH5R) IDE Controller (rev 02) (prog-if 8a [Master SecP PriP])
	Subsystem: IBM: Unknown device 02dd
	Flags: bus master, medium devsel, latency 0, IRQ 137
	I/O ports at <ignored>
	I/O ports at <ignored>
	I/O ports at <ignored>
	I/O ports at <ignored>
	I/O ports at 0480 [size=16]
	Memory at df100000 (32-bit, non-prefetchable) [size=1K]

00:1f.3 SMBus: Intel Corporation 82801EB/ER (ICH5/ICH5R) SMBus Controller (rev 02)
	Subsystem: IBM: Unknown device 02dd
	Flags: medium devsel, IRQ 137
	I/O ports at 0440 [size=32]

01:06.0 VGA compatible controller: ATI Technologies Inc Radeon RV100 QY [Radeon 7000/VE] (prog-if 00 [VGA])
	Subsystem: IBM: Unknown device 02c8
	Flags: bus master, stepping, medium devsel, latency 64, IRQ 153
	Memory at f0000000 (32-bit, prefetchable) [size=128M]
	I/O ports at 3000 [size=256]
	Memory at f8000000 (32-bit, non-prefetchable) [size=64K]
	[virtual] Expansion ROM at f8020000 [disabled] [size=128K]
	Capabilities: [50] Power Management version 2

02:00.0 PCI bridge: Intel Corporation 6700PXH PCI Express-to-PCI Bridge A (rev 09) (prog-if 00 [Normal decode])
	Flags: bus master, fast devsel, latency 0
	Bus: primary=02, secondary=03, subordinate=03, sec-latency=64
	Capabilities: [44] Express PCI/PCI-X Bridge IRQ 0
	Capabilities: [5c] Message Signalled Interrupts: 64bit+ Queue=0/0 Enable-
	Capabilities: [6c] Power Management version 2
	Capabilities: [d8] PCI-X bridge device.

02:00.2 PCI bridge: Intel Corporation 6700PXH PCI Express-to-PCI Bridge B (rev 09) (prog-if 00 [Normal decode])
	Flags: bus master, fast devsel, latency 0
	Bus: primary=02, secondary=04, subordinate=04, sec-latency=64
	Capabilities: [44] Express PCI/PCI-X Bridge IRQ 0
	Capabilities: [5c] Message Signalled Interrupts: 64bit+ Queue=0/0 Enable-
	Capabilities: [6c] Power Management version 2
	Capabilities: [d8] PCI-X bridge device.

05:00.0 Ethernet controller: Broadcom Corporation NetXtreme BCM5721 Gigabit Ethernet PCI Express (rev 11)
	Subsystem: IBM: Unknown device 02c6
	Flags: bus master, fast devsel, latency 0, IRQ 129
	Memory at deff0000 (64-bit, non-prefetchable) [size=64K]
	Capabilities: [48] Power Management version 2
	Capabilities: [50] Vital Product Data
	Capabilities: [58] Message Signalled Interrupts: 64bit+ Queue=0/3 Enable-
	Capabilities: [d0] Express Endpoint IRQ 0

06:00.0 Ethernet controller: Broadcom Corporation NetXtreme BCM5721 Gigabit Ethernet PCI Express (rev 11)
	Subsystem: IBM: Unknown device 02c6
	Flags: bus master, fast devsel, latency 0, IRQ 129
	Memory at dcff0000 (64-bit, non-prefetchable) [size=64K]
	Capabilities: [48] Power Management version 2
	Capabilities: [50] Vital Product Data
	Capabilities: [58] Message Signalled Interrupts: 64bit+ Queue=0/3 Enable-
	Capabilities: [d0] Express Endpoint IRQ 0

07:00.0 PCI bridge: Intel Corporation 80332 [Dobson] I/O processor (A-Segment Bridge) (rev 07) (prog-if 00 [Normal decode])
	Flags: bus master, fast devsel, latency 0
	Bus: primary=07, secondary=08, subordinate=08, sec-latency=64
	I/O behind bridge: 00004000-00004fff
	Memory behind bridge: d9000000-daffffff
	Prefetchable memory behind bridge: 00000000df000000-00000000df000000
	Capabilities: [44] Express PCI/PCI-X Bridge IRQ 0
	Capabilities: [5c] Message Signalled Interrupts: 64bit+ Queue=0/0 Enable-
	Capabilities: [6c] Power Management version 2
	Capabilities: [d8] PCI-X bridge device.

07:00.2 PCI bridge: Intel Corporation 80332 [Dobson] I/O processor (B-Segment Bridge) (rev 07) (prog-if 00 [Normal decode])
	Flags: bus master, fast devsel, latency 0
	Bus: primary=07, secondary=09, subordinate=09, sec-latency=64
	I/O behind bridge: 00005000-0000ffff
	Capabilities: [44] Express PCI/PCI-X Bridge IRQ 0
	Capabilities: [5c] Message Signalled Interrupts: 64bit+ Queue=0/0 Enable-
	Capabilities: [6c] Power Management version 2
	Capabilities: [d8] PCI-X bridge device.

08:07.0 SCSI storage controller: Adaptec AIC-7902B U320 (rev 10)
	Subsystem: IBM: Unknown device 02cc
	Flags: bus master, 66Mhz, slow devsel, latency 64, IRQ 177
	I/O ports at 4000 [disabled] [size=256]
	Memory at daffe000 (64-bit, non-prefetchable) [size=8K]
	I/O ports at 4100 [disabled] [size=256]
	[virtual] Expansion ROM at df000000 [disabled] [size=512K]
	Capabilities: [dc] Power Management version 2
	Capabilities: [a0] Message Signalled Interrupts: 64bit+ Queue=0/1 Enable-
	Capabilities: [94] PCI-X non-bridge device.

08:07.1 SCSI storage controller: Adaptec AIC-7902B U320 (rev 10)
	Subsystem: IBM: Unknown device 02cc
	Flags: bus master, 66Mhz, slow devsel, latency 64, IRQ 169
	I/O ports at 4200 [disabled] [size=256]
	Memory at daffc000 (64-bit, non-prefetchable) [size=8K]
	I/O ports at 4300 [disabled] [size=256]
	[virtual] Expansion ROM at df080000 [disabled] [size=512K]
	Capabilities: [dc] Power Management version 2
	Capabilities: [a0] Message Signalled Interrupts: 64bit+ Queue=0/1 Enable-
	Capabilities: [94] PCI-X non-bridge device.


--=-2bE+ZGKvQHhYpUIhmRyA
Content-Disposition: attachment; filename=Xorg.0.log
Content-Type: text/x-log; name=Xorg.0.log; charset=utf-8
Content-Transfer-Encoding: 7bit


X Window System Version 6.8.2
Release Date: 9 February 2005
X Protocol Version 11, Revision 0, Release 6.8.2
Build Operating System: Linux 2.4.21-27.EL x86_64 [ELF] 
Current Operating System: Linux localhost.localdomain 2.6.14 #2 SMP Mon Nov 14 16:33:20 PST 2005 x86_64
Build Date: 13 September 2005
Build Host: crowe.devel.redhat.com
 
	Before reporting problems, check http://wiki.X.Org
	to make sure that you have the latest version.
Module Loader present
OS Kernel: Linux version 2.6.14 (root@localhost.localdomain) (gcc version 3.4.4 20050721 (Red Hat 3.4.4-2)) #2 SMP Mon Nov 14 16:33:20 PST 2005 
Markers: (--) probed, (**) from config file, (==) default setting,
	(++) from command line, (!!) notice, (II) informational,
	(WW) warning, (EE) error, (NI) not implemented, (??) unknown.
(==) Log file: "/var/log/Xorg.0.log", Time: Wed Nov 16 15:07:00 2005
(==) Using config file: "/etc/X11/xorg.conf"
(==) ServerLayout "Default Layout"
(**) |-->Screen "Screen0" (0)
(**) |   |-->Monitor "Monitor0"
(**) |   |-->Device "Videocard0"
(**) |-->Input Device "Mouse0"
(**) |-->Input Device "Keyboard0"
(**) FontPath set to "unix/:7100"
(**) RgbPath set to "/usr/X11R6/lib/X11/rgb"
(==) ModulePath set to "/usr/X11R6/lib64/modules"
(WW) Open APM failed (/dev/apm_bios) (No such file or directory)
(II) Module ABI versions:
	X.Org ANSI C Emulation: 0.2
	X.Org Video Driver: 0.7
	X.Org XInput driver : 0.4
	X.Org Server Extension : 0.2
	X.Org Font Renderer : 0.4
(II) Loader running on linux
(II) LoadModule: "bitmap"
(II) Loading /usr/X11R6/lib64/modules/fonts/libbitmap.a
(II) Module bitmap: vendor="X.Org Foundation"
	compiled for 6.8.2, module version = 1.0.0
	Module class: X.Org Font Renderer
	ABI class: X.Org Font Renderer, version 0.4
(II) Loading font Bitmap
(II) LoadModule: "pcidata"
(II) Loading /usr/X11R6/lib64/modules/libpcidata.a
(II) Module pcidata: vendor="X.Org Foundation"
	compiled for 6.8.2, module version = 1.0.0
	ABI class: X.Org Video Driver, version 0.7
(++) using VT number 7

(II) PCI: PCI scan (all values are in hex)
(II) PCI: 00:00:0: chip 8086,3590 card 1014,02dd rev 0c class 06,00,00 hdr 80
(II) PCI: 00:00:1: chip 8086,3591 card 1014,02dd rev 0c class ff,00,00 hdr 00
(II) PCI: 00:02:0: chip 8086,3595 card 0000,0000 rev 0c class 06,04,00 hdr 01
(II) PCI: 00:04:0: chip 8086,3597 card 0000,0000 rev 0c class 06,04,00 hdr 01
(II) PCI: 00:05:0: chip 8086,3598 card 0000,0000 rev 0c class 06,04,00 hdr 01
(II) PCI: 00:06:0: chip 8086,3599 card 0000,0000 rev 0c class 06,04,00 hdr 01
(II) PCI: 00:08:0: chip 8086,359b card 1014,02dd rev 0c class 08,80,00 hdr 00
(II) PCI: 00:1d:0: chip 8086,24d2 card 1014,02dd rev 02 class 0c,03,00 hdr 80
(II) PCI: 00:1d:1: chip 8086,24d4 card 1014,02dd rev 02 class 0c,03,00 hdr 00
(II) PCI: 00:1d:7: chip 8086,24dd card 1014,02dd rev 02 class 0c,03,20 hdr 00
(II) PCI: 00:1e:0: chip 8086,244e card 0000,0000 rev c2 class 06,04,00 hdr 01
(II) PCI: 00:1f:0: chip 8086,24d0 card 0000,0000 rev 02 class 06,01,00 hdr 80
(II) PCI: 00:1f:1: chip 8086,24db card 1014,02dd rev 02 class 01,01,8a hdr 00
(II) PCI: 00:1f:3: chip 8086,24d3 card 1014,02dd rev 02 class 0c,05,00 hdr 00
(II) PCI: 01:06:0: chip 1002,5159 card 1014,02c8 rev 00 class 03,00,00 hdr 00
(II) PCI: 02:00:0: chip 8086,0329 card 0000,0000 rev 09 class 06,04,00 hdr 81
(II) PCI: 02:00:2: chip 8086,032a card 0000,0000 rev 09 class 06,04,00 hdr 81
(II) PCI: 05:00:0: chip 14e4,1659 card 1014,02c6 rev 11 class 02,00,00 hdr 00
(II) PCI: 06:00:0: chip 14e4,1659 card 1014,02c6 rev 11 class 02,00,00 hdr 00
(II) PCI: 07:00:0: chip 8086,0330 card 0000,0000 rev 07 class 06,04,00 hdr 81
(II) PCI: 07:00:2: chip 8086,0332 card 0000,0000 rev 07 class 06,04,00 hdr 81
(II) PCI: 08:07:0: chip 9005,801d card 1014,02cc rev 10 class 01,00,00 hdr 80
(II) PCI: 08:07:1: chip 9005,801d card 1014,02cc rev 10 class 01,00,00 hdr 80
(II) PCI: End of PCI scan
(II) Host-to-PCI bridge:
(II) Bus 0: bridge is at (0:0:0), (0,0,9), BCTRL: 0x0008 (VGA_EN is set)
(II) Bus 0 I/O range:
	[0] -1	0	0x00000000 - 0x0000ffff (0x10000) IX[B]
(II) Bus 0 non-prefetchable memory range:
	[0] -1	0	0x00000000 - 0xffffffff (0x100000000) MX[B]
(II) Bus 0 prefetchable memory range:
	[0] -1	0	0x00000000 - 0xffffffff (0x100000000) MX[B]
(II) PCI-to-PCI bridge:
(II) Bus 2: bridge is at (0:2:0), (0,2,4), BCTRL: 0x0003 (VGA_EN is cleared)
(II) PCI-to-PCI bridge:
(II) Bus 5: bridge is at (0:4:0), (0,5,5), BCTRL: 0x0003 (VGA_EN is cleared)
(II) Bus 5 non-prefetchable memory range:
	[0] -1	0	0xdd000000 - 0xdeffffff (0x2000000) MX[B]
(II) PCI-to-PCI bridge:
(II) Bus 6: bridge is at (0:5:0), (0,6,6), BCTRL: 0x0003 (VGA_EN is cleared)
(II) Bus 6 non-prefetchable memory range:
	[0] -1	0	0xdb000000 - 0xdcffffff (0x2000000) MX[B]
(II) PCI-to-PCI bridge:
(II) Bus 7: bridge is at (0:6:0), (0,7,9), BCTRL: 0x0003 (VGA_EN is cleared)
(II) Bus 7 I/O range:
	[0] -1	0	0x00004000 - 0x0000ffff (0xc000) IX[B]
(II) Bus 7 non-prefetchable memory range:
	[0] -1	0	0xd9000000 - 0xdaffffff (0x2000000) MX[B]
(II) Bus 7 prefetchable memory range:
	[0] -1	0	0xdf000000 - 0xdf0fffff (0x100000) MX[B]
(II) PCI-to-PCI bridge:
(II) Bus 1: bridge is at (0:30:0), (0,1,1), BCTRL: 0x0008 (VGA_EN is set)
(II) Bus 1 I/O range:
	[0] -1	0	0x00003000 - 0x00003fff (0x1000) IX[B]
(II) Bus 1 non-prefetchable memory range:
	[0] -1	0	0xf8000000 - 0xf8ffffff (0x1000000) MX[B]
(II) Bus 1 prefetchable memory range:
	[0] -1	0	0xf0000000 - 0xf7ffffff (0x8000000) MX[B]
(II) PCI-to-ISA bridge:
(II) Bus -1: bridge is at (0:31:0), (0,-1,-1), BCTRL: 0x0008 (VGA_EN is set)
(II) PCI-to-PCI bridge:
(II) Bus 3: bridge is at (2:0:0), (2,3,3), BCTRL: 0x0003 (VGA_EN is cleared)
(II) PCI-to-PCI bridge:
(II) Bus 4: bridge is at (2:0:2), (2,4,4), BCTRL: 0x0003 (VGA_EN is cleared)
(II) PCI-to-PCI bridge:
(II) Bus 8: bridge is at (7:0:0), (7,8,8), BCTRL: 0x0003 (VGA_EN is cleared)
(II) Bus 8 I/O range:
	[0] -1	0	0x00004000 - 0x00004fff (0x1000) IX[B]
(II) Bus 8 non-prefetchable memory range:
	[0] -1	0	0xd9000000 - 0xdaffffff (0x2000000) MX[B]
(II) Bus 8 prefetchable memory range:
	[0] -1	0	0xdf000000 - 0xdf0fffff (0x100000) MX[B]
(II) PCI-to-PCI bridge:
(II) Bus 9: bridge is at (7:0:2), (7,9,9), BCTRL: 0x0003 (VGA_EN is cleared)
(II) Bus 9 I/O range:
	[0] -1	0	0x00005000 - 0x0000ffff (0xb000) IX[B]
(--) PCI:*(1:6:0) ATI Technologies Inc Radeon RV100 QY [Radeon 7000/VE] rev 0, Mem @ 0xf0000000/27, 0xf8000000/16, I/O @ 0x3000/8
(II) Addressable bus resource ranges are
	[0] -1	0	0x00000000 - 0xffffffff (0x100000000) MX[B]
	[1] -1	0	0x00000000 - 0x0000ffff (0x10000) IX[B]
(II) OS-reported resource ranges:
	[0] -1	0	0xffe00000 - 0xffffffff (0x200000) MX[B](B)
	[1] -1	0	0x00100000 - 0x3fffffff (0x3ff00000) MX[B]E(B)
	[2] -1	0	0x000f0000 - 0x000fffff (0x10000) MX[B]
	[3] -1	0	0x000c0000 - 0x000effff (0x30000) MX[B]
	[4] -1	0	0x00000000 - 0x0009ffff (0xa0000) MX[B]
	[5] -1	0	0x0000ffff - 0x0000ffff (0x1) IX[B]
	[6] -1	0	0x00000000 - 0x000000ff (0x100) IX[B]
(II) PCI Memory resource overlap reduced 0xff000000 from 0xff000fff to 0xfeffffff
(II) Active PCI resource ranges:
	[0] -1	0	0xdaffc000 - 0xdaffdfff (0x2000) MX[B]
	[1] -1	0	0xdaffe000 - 0xdaffffff (0x2000) MX[B]
	[2] -1	0	0xdcff0000 - 0xdcffffff (0x10000) MX[B]
	[3] -1	0	0xdeff0000 - 0xdeffffff (0x10000) MX[B]
	[4] -1	0	0xdf100000 - 0xdf1003ff (0x400) MX[B]
	[5] -1	0	0xf9000000 - 0xf90003ff (0x400) MX[B]
	[6] -1	0	0xff000000 - 0xfeffffff (0x0) MX[B]O
	[7] -1	0	0xf8000000 - 0xf800ffff (0x10000) MX[B](B)
	[8] -1	0	0xf0000000 - 0xf7ffffff (0x8000000) MX[B](B)
	[9] -1	0	0x00000440 - 0x0000045f (0x20) IX[B]
	[10] -1	0	0x00000480 - 0x0000048f (0x10) IX[B]
	[11] -1	0	0x00000374 - 0x00000374 (0x1) IX[B]
	[12] -1	0	0x00000170 - 0x00000170 (0x1) IX[B]
	[13] -1	0	0x000003f4 - 0x000003f4 (0x1) IX[B]
	[14] -1	0	0x000001f0 - 0x000001f0 (0x1) IX[B]
	[15] -1	0	0x00002600 - 0x0000261f (0x20) IX[B]
	[16] -1	0	0x00002200 - 0x0000221f (0x20) IX[B]
	[17] -1	0	0x00003000 - 0x000030ff (0x100) IX[B](B)
(II) Inactive PCI resource ranges:
	[0] -1	0	0x00004300 - 0x000043ff (0x100) IX[B]
	[1] -1	0	0x00004200 - 0x000042ff (0x100) IX[B]
	[2] -1	0	0x00004100 - 0x000041ff (0x100) IX[B]
	[3] -1	0	0x00004000 - 0x000040ff (0x100) IX[B]
(II) Active PCI resource ranges after removing overlaps:
	[0] -1	0	0xdaffc000 - 0xdaffdfff (0x2000) MX[B]
	[1] -1	0	0xdaffe000 - 0xdaffffff (0x2000) MX[B]
	[2] -1	0	0xdcff0000 - 0xdcffffff (0x10000) MX[B]
	[3] -1	0	0xdeff0000 - 0xdeffffff (0x10000) MX[B]
	[4] -1	0	0xdf100000 - 0xdf1003ff (0x400) MX[B]
	[5] -1	0	0xf9000000 - 0xf90003ff (0x400) MX[B]
	[6] -1	0	0xff000000 - 0xfeffffff (0x0) MX[B]O
	[7] -1	0	0xf8000000 - 0xf800ffff (0x10000) MX[B](B)
	[8] -1	0	0xf0000000 - 0xf7ffffff (0x8000000) MX[B](B)
	[9] -1	0	0x00000440 - 0x0000045f (0x20) IX[B]
	[10] -1	0	0x00000480 - 0x0000048f (0x10) IX[B]
	[11] -1	0	0x00000374 - 0x00000374 (0x1) IX[B]
	[12] -1	0	0x00000170 - 0x00000170 (0x1) IX[B]
	[13] -1	0	0x000003f4 - 0x000003f4 (0x1) IX[B]
	[14] -1	0	0x000001f0 - 0x000001f0 (0x1) IX[B]
	[15] -1	0	0x00002600 - 0x0000261f (0x20) IX[B]
	[16] -1	0	0x00002200 - 0x0000221f (0x20) IX[B]
	[17] -1	0	0x00003000 - 0x000030ff (0x100) IX[B](B)
(II) Inactive PCI resource ranges after removing overlaps:
	[0] -1	0	0x00004300 - 0x000043ff (0x100) IX[B]
	[1] -1	0	0x00004200 - 0x000042ff (0x100) IX[B]
	[2] -1	0	0x00004100 - 0x000041ff (0x100) IX[B]
	[3] -1	0	0x00004000 - 0x000040ff (0x100) IX[B]
(II) OS-reported resource ranges after removing overlaps with PCI:
	[0] -1	0	0xffe00000 - 0xffffffff (0x200000) MX[B](B)
	[1] -1	0	0x00100000 - 0x3fffffff (0x3ff00000) MX[B]E(B)
	[2] -1	0	0x000f0000 - 0x000fffff (0x10000) MX[B]
	[3] -1	0	0x000c0000 - 0x000effff (0x30000) MX[B]
	[4] -1	0	0x00000000 - 0x0009ffff (0xa0000) MX[B]
	[5] -1	0	0x0000ffff - 0x0000ffff (0x1) IX[B]
	[6] -1	0	0x00000000 - 0x000000ff (0x100) IX[B]
(II) All system resource ranges:
	[0] -1	0	0xffe00000 - 0xffffffff (0x200000) MX[B](B)
	[1] -1	0	0x00100000 - 0x3fffffff (0x3ff00000) MX[B]E(B)
	[2] -1	0	0x000f0000 - 0x000fffff (0x10000) MX[B]
	[3] -1	0	0x000c0000 - 0x000effff (0x30000) MX[B]
	[4] -1	0	0x00000000 - 0x0009ffff (0xa0000) MX[B]
	[5] -1	0	0xdaffc000 - 0xdaffdfff (0x2000) MX[B]
	[6] -1	0	0xdaffe000 - 0xdaffffff (0x2000) MX[B]
	[7] -1	0	0xdcff0000 - 0xdcffffff (0x10000) MX[B]
	[8] -1	0	0xdeff0000 - 0xdeffffff (0x10000) MX[B]
	[9] -1	0	0xdf100000 - 0xdf1003ff (0x400) MX[B]
	[10] -1	0	0xf9000000 - 0xf90003ff (0x400) MX[B]
	[11] -1	0	0xff000000 - 0xfeffffff (0x0) MX[B]O
	[12] -1	0	0xf8000000 - 0xf800ffff (0x10000) MX[B](B)
	[13] -1	0	0xf0000000 - 0xf7ffffff (0x8000000) MX[B](B)
	[14] -1	0	0x0000ffff - 0x0000ffff (0x1) IX[B]
	[15] -1	0	0x00000000 - 0x000000ff (0x100) IX[B]
	[16] -1	0	0x00000440 - 0x0000045f (0x20) IX[B]
	[17] -1	0	0x00000480 - 0x0000048f (0x10) IX[B]
	[18] -1	0	0x00000374 - 0x00000374 (0x1) IX[B]
	[19] -1	0	0x00000170 - 0x00000170 (0x1) IX[B]
	[20] -1	0	0x000003f4 - 0x000003f4 (0x1) IX[B]
	[21] -1	0	0x000001f0 - 0x000001f0 (0x1) IX[B]
	[22] -1	0	0x00002600 - 0x0000261f (0x20) IX[B]
	[23] -1	0	0x00002200 - 0x0000221f (0x20) IX[B]
	[24] -1	0	0x00003000 - 0x000030ff (0x100) IX[B](B)
	[25] -1	0	0x00004300 - 0x000043ff (0x100) IX[B]
	[26] -1	0	0x00004200 - 0x000042ff (0x100) IX[B]
	[27] -1	0	0x00004100 - 0x000041ff (0x100) IX[B]
	[28] -1	0	0x00004000 - 0x000040ff (0x100) IX[B]
(II) LoadModule: "dbe"
(II) Loading /usr/X11R6/lib64/modules/extensions/libdbe.a
(II) Module dbe: vendor="X.Org Foundation"
	compiled for 6.8.2, module version = 1.0.0
	Module class: X.Org Server Extension
	ABI class: X.Org Server Extension, version 0.2
(II) Loading extension DOUBLE-BUFFER
(II) LoadModule: "extmod"
(II) Loading /usr/X11R6/lib64/modules/extensions/libextmod.a
(II) Module extmod: vendor="X.Org Foundation"
	compiled for 6.8.2, module version = 1.0.0
	Module class: X.Org Server Extension
	ABI class: X.Org Server Extension, version 0.2
(II) Loading extension SHAPE
(II) Loading extension MIT-SUNDRY-NONSTANDARD
(II) Loading extension BIG-REQUESTS
(II) Loading extension SYNC
(II) Loading extension MIT-SCREEN-SAVER
(II) Loading extension XC-MISC
(II) Loading extension XFree86-VidModeExtension
(II) Loading extension XFree86-Misc
(II) Loading extension XFree86-DGA
(II) Loading extension DPMS
(II) Loading extension TOG-CUP
(II) Loading extension Extended-Visual-Information
(II) Loading extension XVideo
(II) Loading extension XVideo-MotionCompensation
(II) Loading extension X-Resource
(II) LoadModule: "fbdevhw"
(II) Loading /usr/X11R6/lib64/modules/linux/libfbdevhw.a
(II) Module fbdevhw: vendor="X.Org Foundation"
	compiled for 6.8.2, module version = 0.0.2
	ABI class: X.Org Video Driver, version 0.7
(II) LoadModule: "glx"
(II) Loading /usr/X11R6/lib64/modules/extensions/libglx.a
(II) Module glx: vendor="X.Org Foundation"
	compiled for 6.8.2, module version = 1.0.0
	ABI class: X.Org Server Extension, version 0.2
(II) Loading sub module "GLcore"
(II) LoadModule: "GLcore"
(II) Loading /usr/X11R6/lib64/modules/extensions/libGLcore.a
(II) Module GLcore: vendor="X.Org Foundation"
	compiled for 6.8.2, module version = 1.0.0
	ABI class: X.Org Server Extension, version 0.2
(II) Loading extension GLX
(II) LoadModule: "record"
(II) Loading /usr/X11R6/lib64/modules/extensions/librecord.a
(II) Module record: vendor="X.Org Foundation"
	compiled for 6.8.2, module version = 1.13.0
	Module class: X.Org Server Extension
	ABI class: X.Org Server Extension, version 0.2
(II) Loading extension RECORD
(II) LoadModule: "freetype"
(II) Loading /usr/X11R6/lib64/modules/fonts/libfreetype.so
(II) Module freetype: vendor="X.Org Foundation & the After X-TT Project"
	compiled for 6.8.2, module version = 2.1.0
	Module class: X.Org Font Renderer
	ABI class: X.Org Font Renderer, version 0.4
(II) Loading font FreeType
(II) LoadModule: "type1"
(II) Loading /usr/X11R6/lib64/modules/fonts/libtype1.a
(II) Module type1: vendor="X.Org Foundation"
	compiled for 6.8.2, module version = 1.0.2
	Module class: X.Org Font Renderer
	ABI class: X.Org Font Renderer, version 0.4
(II) Loading font Type1
(II) Loading font CID
(II) LoadModule: "dri"
(II) Loading /usr/X11R6/lib64/modules/extensions/libdri.a
(II) Module dri: vendor="X.Org Foundation"
	compiled for 6.8.2, module version = 1.0.0
	ABI class: X.Org Server Extension, version 0.2
(II) Loading sub module "drm"
(II) LoadModule: "drm"
(II) Loading /usr/X11R6/lib64/modules/linux/libdrm.a
(II) Module drm: vendor="X.Org Foundation"
	compiled for 6.8.2, module version = 1.0.0
	ABI class: X.Org Server Extension, version 0.2
(II) Loading extension XFree86-DRI
(II) LoadModule: "radeon"
(II) Loading /usr/X11R6/lib64/modules/drivers/radeon_drv.o
(II) Module radeon: vendor="X.Org Foundation"
	compiled for 6.8.2, module version = 4.0.1
	Module class: X.Org Video Driver
	ABI class: X.Org Video Driver, version 0.7
(II) LoadModule: "ati"
(II) Loading /usr/X11R6/lib64/modules/drivers/ati_drv.o
(II) Module ati: vendor="X.Org Foundation"
	compiled for 6.8.2, module version = 6.5.6
	Module class: X.Org Video Driver
	ABI class: X.Org Video Driver, version 0.7
(II) LoadModule: "mouse"
(II) Loading /usr/X11R6/lib64/modules/input/mouse_drv.o
(II) Module mouse: vendor="X.Org Foundation"
	compiled for 6.8.2, module version = 1.0.0
	Module class: X.Org XInput Driver
	ABI class: X.Org XInput driver, version 0.4
(II) LoadModule: "kbd"
(II) Loading /usr/X11R6/lib64/modules/input/kbd_drv.o
(II) Module kbd: vendor="X.Org Foundation"
	compiled for 6.8.2, module version = 1.0.0
	Module class: X.Org XInput Driver
	ABI class: X.Org XInput driver, version 0.4
(II) ATI: ATI driver (version 6.5.6) for chipsets: ati, ativga
(II) R128: Driver for ATI Rage 128 chipsets:
	ATI Rage 128 Mobility M3 LE (PCI), ATI Rage 128 Mobility M3 LF (AGP),
	ATI Rage 128 Mobility M4 MF (AGP), ATI Rage 128 Mobility M4 ML (AGP),
	ATI Rage 128 Pro GL PA (PCI/AGP), ATI Rage 128 Pro GL PB (PCI/AGP),
	ATI Rage 128 Pro GL PC (PCI/AGP), ATI Rage 128 Pro GL PD (PCI),
	ATI Rage 128 Pro GL PE (PCI/AGP), ATI Rage 128 Pro GL PF (AGP),
	ATI Rage 128 Pro VR PG (PCI/AGP), ATI Rage 128 Pro VR PH (PCI/AGP),
	ATI Rage 128 Pro VR PI (PCI/AGP), ATI Rage 128 Pro VR PJ (PCI/AGP),
	ATI Rage 128 Pro VR PK (PCI/AGP), ATI Rage 128 Pro VR PL (PCI/AGP),
	ATI Rage 128 Pro VR PM (PCI/AGP), ATI Rage 128 Pro VR PN (PCI/AGP),
	ATI Rage 128 Pro VR PO (PCI/AGP), ATI Rage 128 Pro VR PP (PCI),
	ATI Rage 128 Pro VR PQ (PCI/AGP), ATI Rage 128 Pro VR PR (PCI),
	ATI Rage 128 Pro VR PS (PCI/AGP), ATI Rage 128 Pro VR PT (PCI/AGP),
	ATI Rage 128 Pro VR PU (PCI/AGP), ATI Rage 128 Pro VR PV (PCI/AGP),
	ATI Rage 128 Pro VR PW (PCI/AGP), ATI Rage 128 Pro VR PX (PCI/AGP),
	ATI Rage 128 GL RE (PCI), ATI Rage 128 GL RF (AGP),
	ATI Rage 128 RG (AGP), ATI Rage 128 VR RK (PCI),
	ATI Rage 128 VR RL (AGP), ATI Rage 128 4X SE (PCI/AGP),
	ATI Rage 128 4X SF (PCI/AGP), ATI Rage 128 4X SG (PCI/AGP),
	ATI Rage 128 4X SH (PCI/AGP), ATI Rage 128 4X SK (PCI/AGP),
	ATI Rage 128 4X SL (PCI/AGP), ATI Rage 128 4X SM (AGP),
	ATI Rage 128 4X SN (PCI/AGP), ATI Rage 128 Pro ULTRA TF (AGP),
	ATI Rage 128 Pro ULTRA TL (AGP), ATI Rage 128 Pro ULTRA TR (AGP),
	ATI Rage 128 Pro ULTRA TS (AGP?), ATI Rage 128 Pro ULTRA TT (AGP?),
	ATI Rage 128 Pro ULTRA TU (AGP?)
(II) RADEON: Driver for ATI Radeon chipsets: ATI Radeon QD (AGP),
	ATI Radeon QE (AGP), ATI Radeon QF (AGP), ATI Radeon QG (AGP),
	ATI Radeon VE/7000 QY (AGP/PCI), ATI Radeon VE/7000 QZ (AGP/PCI),
	ATI ES1000 515E (PCI), ATI ES1000 5969 (PCI),
	ATI Radeon Mobility M7 LW (AGP),
	ATI Mobility FireGL 7800 M7 LX (AGP),
	ATI Radeon Mobility M6 LY (AGP), ATI Radeon Mobility M6 LZ (AGP),
	ATI Radeon IGP320 (A3) 4136, ATI Radeon IGP320M (U1) 4336,
	ATI Radeon IGP330/340/350 (A4) 4137,
	ATI Radeon IGP330M/340M/350M (U2) 4337,
	ATI Radeon 7000 IGP (A4+) 4237, ATI Radeon Mobility 7000 IGP 4437,
	ATI FireGL 8700/8800 QH (AGP), ATI Radeon 8500 QL (AGP),
	ATI Radeon 9100 QM (AGP), ATI Radeon 8500 AIW BB (AGP),
	ATI Radeon 8500 AIW BC (AGP), ATI Radeon 7500 QW (AGP/PCI),
	ATI Radeon 7500 QX (AGP/PCI), ATI Radeon 9000/PRO If (AGP/PCI),
	ATI Radeon 9000 Ig (AGP/PCI), ATI FireGL Mobility 9000 (M9) Ld (AGP),
	ATI Radeon Mobility 9000 (M9) Lf (AGP),
	ATI Radeon Mobility 9000 (M9) Lg (AGP),
	ATI Radeon 9100 IGP (A5) 5834,
	ATI Radeon Mobility 9100 IGP (U3) 5835, ATI Radeon 9100 PRO IGP 7834,
	ATI Radeon Mobility 9200 IGP 7835, ATI Radeon 9200PRO 5960 (AGP),
	ATI Radeon 9200 5961 (AGP), ATI Radeon 9200 5962 (AGP),
	ATI Radeon 9200SE 5964 (AGP),
	ATI Radeon Mobility 9200 (M9+) 5C61 (AGP),
	ATI Radeon Mobility 9200 (M9+) 5C63 (AGP), ATI Radeon 9500 AD (AGP),
	ATI Radeon 9500 AE (AGP), ATI Radeon 9600TX AF (AGP),
	ATI FireGL Z1 AG (AGP), ATI Radeon 9700 Pro ND (AGP),
	ATI Radeon 9700/9500Pro NE (AGP), ATI Radeon 9700 NF (AGP),
	ATI FireGL X1 NG (AGP), ATI Radeon 9600 AP (AGP),
	ATI Radeon 9600SE AQ (AGP), ATI Radeon 9600XT AR (AGP),
	ATI Radeon 9600 AS (AGP), ATI FireGL T2 AT (AGP),
	ATI FireGL RV360 AV (AGP),
	ATI Radeon Mobility 9600/9700 (M10/M11) NP (AGP),
	ATI Radeon Mobility 9600 (M10) NQ (AGP),
	ATI Radeon Mobility 9600 (M11) NR (AGP),
	ATI Radeon Mobility 9600 (M10) NS (AGP),
	ATI FireGL Mobility T2 (M10) NT (AGP),
	ATI FireGL Mobility T2e (M11) NV (AGP), ATI Radeon 9800SE AH (AGP),
	ATI Radeon 9800 AI (AGP), ATI Radeon 9800 AJ (AGP),
	ATI FireGL X2 AK (AGP), ATI Radeon 9800PRO NH (AGP),
	ATI Radeon 9800 NI (AGP), ATI FireGL X2 NK (AGP),
	ATI Radeon 9800XT NJ (AGP), ATI Radeon X600 (RV380) 3E50 (PCIE),
	ATI FireGL V3200 (RV380) 3E54 (PCIE),
	ATI Radeon Mobility X600 (M24) 3150 (PCIE),
	ATI FireGL M24 GL 3154 (PCIE), ATI Radeon X300 (RV370) 5B60 (PCIE),
	ATI Radeon X600 (RV370) 5B62 (PCIE),
	ATI FireGL V3100 (RV370) 5B64 (PCIE),
	ATI FireGL D1100 (RV370) 5B65 (PCIE),
	ATI Radeon Mobility M300 (M22) 5460 (PCIE),
	ATI FireGL M22 GL 5464 (PCIE), ATI Radeon X800 (R420) JH (AGP),
	ATI Radeon X800PRO (R420) JI (AGP),
	ATI Radeon X800SE (R420) JJ (AGP), ATI Radeon X800 (R420) JK (AGP),
	ATI Radeon X800 (R420) JL (AGP), ATI FireGL X3 (R420) JM (AGP),
	ATI Radeon Mobility 9800 (M18) JN (AGP),
	ATI Radeon X800XT (R420) JP (AGP), ATI Radeon X800 (R423) UH (PCIE),
	ATI Radeon X800PRO (R423) UI (PCIE),
	ATI Radeon X800LE (R423) UJ (PCIE),
	ATI Radeon X800SE (R423) UK (PCIE),
	ATI FireGL V7200 (R423) UQ (PCIE), ATI FireGL V5100 (R423) UR (PCIE),
	ATI FireGL V7100 (R423) UT (PCIE),
	ATI Radeon X800XT (R423) 5D57 (PCIE)
(II) Primary Device is: PCI 01:06:0
(--) Assigning device section with no busID to primary device
(--) Chipset ATI Radeon VE/7000 QY (AGP/PCI) found
(II) resource ranges after xf86ClaimFixedResources() call:
	[0] -1	0	0xffe00000 - 0xffffffff (0x200000) MX[B](B)
	[1] -1	0	0x00100000 - 0x3fffffff (0x3ff00000) MX[B]E(B)
	[2] -1	0	0x000f0000 - 0x000fffff (0x10000) MX[B]
	[3] -1	0	0x000c0000 - 0x000effff (0x30000) MX[B]
	[4] -1	0	0x00000000 - 0x0009ffff (0xa0000) MX[B]
	[5] -1	0	0xdaffc000 - 0xdaffdfff (0x2000) MX[B]
	[6] -1	0	0xdaffe000 - 0xdaffffff (0x2000) MX[B]
	[7] -1	0	0xdcff0000 - 0xdcffffff (0x10000) MX[B]
	[8] -1	0	0xdeff0000 - 0xdeffffff (0x10000) MX[B]
	[9] -1	0	0xdf100000 - 0xdf1003ff (0x400) MX[B]
	[10] -1	0	0xf9000000 - 0xf90003ff (0x400) MX[B]
	[11] -1	0	0xff000000 - 0xfeffffff (0x0) MX[B]O
	[12] -1	0	0xf8000000 - 0xf800ffff (0x10000) MX[B](B)
	[13] -1	0	0xf0000000 - 0xf7ffffff (0x8000000) MX[B](B)
	[14] -1	0	0x0000ffff - 0x0000ffff (0x1) IX[B]
	[15] -1	0	0x00000000 - 0x000000ff (0x100) IX[B]
	[16] -1	0	0x00000440 - 0x0000045f (0x20) IX[B]
	[17] -1	0	0x00000480 - 0x0000048f (0x10) IX[B]
	[18] -1	0	0x00000374 - 0x00000374 (0x1) IX[B]
	[19] -1	0	0x00000170 - 0x00000170 (0x1) IX[B]
	[20] -1	0	0x000003f4 - 0x000003f4 (0x1) IX[B]
	[21] -1	0	0x000001f0 - 0x000001f0 (0x1) IX[B]
	[22] -1	0	0x00002600 - 0x0000261f (0x20) IX[B]
	[23] -1	0	0x00002200 - 0x0000221f (0x20) IX[B]
	[24] -1	0	0x00003000 - 0x000030ff (0x100) IX[B](B)
	[25] -1	0	0x00004300 - 0x000043ff (0x100) IX[B]
	[26] -1	0	0x00004200 - 0x000042ff (0x100) IX[B]
	[27] -1	0	0x00004100 - 0x000041ff (0x100) IX[B]
	[28] -1	0	0x00004000 - 0x000040ff (0x100) IX[B]
(II) Loading sub module "radeon"
(II) LoadModule: "radeon"
(II) Reloading /usr/X11R6/lib64/modules/drivers/radeon_drv.o
(II) resource ranges after probing:
	[0] -1	0	0xffe00000 - 0xffffffff (0x200000) MX[B](B)
	[1] -1	0	0x00100000 - 0x3fffffff (0x3ff00000) MX[B]E(B)
	[2] -1	0	0x000f0000 - 0x000fffff (0x10000) MX[B]
	[3] -1	0	0x000c0000 - 0x000effff (0x30000) MX[B]
	[4] -1	0	0x00000000 - 0x0009ffff (0xa0000) MX[B]
	[5] -1	0	0xdaffc000 - 0xdaffdfff (0x2000) MX[B]
	[6] -1	0	0xdaffe000 - 0xdaffffff (0x2000) MX[B]
	[7] -1	0	0xdcff0000 - 0xdcffffff (0x10000) MX[B]
	[8] -1	0	0xdeff0000 - 0xdeffffff (0x10000) MX[B]
	[9] -1	0	0xdf100000 - 0xdf1003ff (0x400) MX[B]
	[10] -1	0	0xf9000000 - 0xf90003ff (0x400) MX[B]
	[11] -1	0	0xff000000 - 0xfeffffff (0x0) MX[B]O
	[12] -1	0	0xf8000000 - 0xf800ffff (0x10000) MX[B](B)
	[13] -1	0	0xf0000000 - 0xf7ffffff (0x8000000) MX[B](B)
	[14] 0	0	0x000a0000 - 0x000affff (0x10000) MS[B]
	[15] 0	0	0x000b0000 - 0x000b7fff (0x8000) MS[B]
	[16] 0	0	0x000b8000 - 0x000bffff (0x8000) MS[B]
	[17] -1	0	0x0000ffff - 0x0000ffff (0x1) IX[B]
	[18] -1	0	0x00000000 - 0x000000ff (0x100) IX[B]
	[19] -1	0	0x00000440 - 0x0000045f (0x20) IX[B]
	[20] -1	0	0x00000480 - 0x0000048f (0x10) IX[B]
	[21] -1	0	0x00000374 - 0x00000374 (0x1) IX[B]
	[22] -1	0	0x00000170 - 0x00000170 (0x1) IX[B]
	[23] -1	0	0x000003f4 - 0x000003f4 (0x1) IX[B]
	[24] -1	0	0x000001f0 - 0x000001f0 (0x1) IX[B]
	[25] -1	0	0x00002600 - 0x0000261f (0x20) IX[B]
	[26] -1	0	0x00002200 - 0x0000221f (0x20) IX[B]
	[27] -1	0	0x00003000 - 0x000030ff (0x100) IX[B](B)
	[28] -1	0	0x00004300 - 0x000043ff (0x100) IX[B]
	[29] -1	0	0x00004200 - 0x000042ff (0x100) IX[B]
	[30] -1	0	0x00004100 - 0x000041ff (0x100) IX[B]
	[31] -1	0	0x00004000 - 0x000040ff (0x100) IX[B]
	[32] 0	0	0x000003b0 - 0x000003bb (0xc) IS[B]
	[33] 0	0	0x000003c0 - 0x000003df (0x20) IS[B]
(II) Setting vga for screen 0.
(II) RADEON(0): MMIO registers at 0xf8000000
(II) Loading sub module "vgahw"
(II) LoadModule: "vgahw"
(II) Loading /usr/X11R6/lib64/modules/libvgahw.a
(II) Module vgahw: vendor="X.Org Foundation"
	compiled for 6.8.2, module version = 0.1.0
	ABI class: X.Org Video Driver, version 0.7
(II) RADEON(0): vgaHWGetIOBase: hwp->IOBase is 0x03d0, hwp->PIOOffset is 0x0000
(II) RADEON(0): PCI bus 1 card 6 func 0
(**) RADEON(0): Depth 24, (--) framebuffer bpp 32
(II) RADEON(0): Pixel depth = 24 bits stored in 4 bytes (32 bpp pixmaps)
(==) RADEON(0): Default visual is TrueColor
(==) RADEON(0): RGB weight 888
(II) RADEON(0): Using 8 bits per RGB (8 bit DAC)
(II) Loading sub module "int10"
(II) LoadModule: "int10"
(II) Loading /usr/X11R6/lib64/modules/linux/libint10.a
(II) Module int10: vendor="X.Org Foundation"
	compiled for 6.8.2, module version = 1.0.0
	ABI class: X.Org Video Driver, version 0.7
(II) RADEON(0): initializing int10
(II) RADEON(0): Primary V_BIOS segment is: 0xc000
(--) RADEON(0): Chipset: "ATI Radeon VE/7000 QY (AGP/PCI)" (ChipID = 0x5159)
(--) RADEON(0): Linear framebuffer at 0xf0000000
(--) RADEON(0): VideoRAM: 16384 kByte (32 bit DDR SDRAM)
(II) RADEON(0): PCI card detected
(II) Loading sub module "ddc"
(II) LoadModule: "ddc"
(II) Loading /usr/X11R6/lib64/modules/libddc.a
(II) Module ddc: vendor="X.Org Foundation"
	compiled for 6.8.2, module version = 1.0.0
	ABI class: X.Org Video Driver, version 0.7
(II) Loading sub module "i2c"
(II) LoadModule: "i2c"
(II) Loading /usr/X11R6/lib64/modules/libi2c.a
(II) Module i2c: vendor="X.Org Foundation"
	compiled for 6.8.2, module version = 1.2.0
	ABI class: X.Org Video Driver, version 0.7
(II) RADEON(0): I2C bus "DDC" initialized.
(II) RADEON(0): Legacy BIOS detected
(II) RADEON(0): Connector0: DDCType-4, DACType-1, TMDSType-1, ConnectorType-3
(II) RADEON(0): Connector1: DDCType-3, DACType-0, TMDSType--1, ConnectorType-2
(II) RADEON(0): I2C device "DDC:ddc2" registered at address 0xA0.
(II) RADEON(0): I2C device "DDC:ddc2" removed.
(II) RADEON(0): DDC Type: 3, Detected Type: 1
(II) RADEON(0): I2C device "DDC:ddc2" registered at address 0xA0.
(II) RADEON(0): I2C device "DDC:ddc2" removed.
(II) RADEON(0): DDC Type: 4, Detected Type: 3
(II) RADEON(0): EDID data from the display on port 1 ----------------------
(II) RADEON(0): Manufacturer: IBM  Model: 19e3  Serial#: 16843009
(II) RADEON(0): Year: 2001  Week: 1
(II) RADEON(0): EDID Version: 1.2
(II) RADEON(0): Analog Display Input,  Input Voltage Level: 0.700/0.700 V
(II) RADEON(0): Sync:  Separate
(II) RADEON(0): Max H-Image Size [cm]: horiz.: 32  vert.: 24
(II) RADEON(0): Gamma: 2.26
(II) RADEON(0): DPMS capabilities: StandBy Suspend Off; RGB/Color Display
(II) RADEON(0): redX: 0.645 redY: 0.321   greenX: 0.282 greenY: 0.600
(II) RADEON(0): blueX: 0.142 blueY: 0.057   whiteX: 0.283 whiteY: 0.298
(II) RADEON(0): Supported VESA Video Modes:
(II) RADEON(0): 720x400@70Hz
(II) RADEON(0): 640x480@60Hz
(II) RADEON(0): 800x600@75Hz
(II) RADEON(0): 1024x768@75Hz
(II) RADEON(0): 1280x1024@75Hz
(II) RADEON(0): Manufacturer's mask: 0
(II) RADEON(0): Supported Future Video Modes:
(II) RADEON(0): #0: hsize: 640  vsize 480  refresh: 85  vid: 22833
(II) RADEON(0): #1: hsize: 800  vsize 600  refresh: 85  vid: 22853
(II) RADEON(0): #2: hsize: 1024  vsize 768  refresh: 85  vid: 22881
(II) RADEON(0): #3: hsize: 1600  vsize 1200  refresh: 65  vid: 17833
(II) RADEON(0): Supported additional Video Mode:
(II) RADEON(0): clock: 52.6 MHz   Image Size:  306 x 230 mm
(II) RADEON(0): h_active: 960  h_sync: 972  h_sync_end 1080 h_blank_end 1260 h_border: 0
(II) RADEON(0): v_active: 529  v_sync: 530  v_sync_end 540 v_blanking: 557 v_border: 0
(II) RADEON(0): Monitor name: IBM G78
(II) RADEON(0): Ranges: V min: 50  V max: 160 Hz, H min: 30  H max: 85 kHz, PixClock max 180 MHz
(II) RADEON(0): Serial No: 55-K9451
(II) RADEON(0): EDID data from the display on port 2-----------------------
(II) RADEON(0): Manufacturer: IBM  Model: 29a  Serial#: 16843009
(II) RADEON(0): Year: 2003  Week: 16
(II) RADEON(0): EDID Version: 1.3
(II) RADEON(0): Digital Display Input
(II) RADEON(0): Max H-Image Size [cm]: horiz.: 30  vert.: 23
(II) RADEON(0): Gamma: 1.00
(II) RADEON(0): No DPMS capabilities specified; RGB/Color Display
(II) RADEON(0): Default color space is primary color space
(II) RADEON(0): First detailed timing is preferred mode
(II) RADEON(0): redX: 0.640 redY: 0.330   greenX: 0.300 greenY: 0.600
(II) RADEON(0): blueX: 0.150 blueY: 0.060   whiteX: 0.312 whiteY: 0.329
(II) RADEON(0): Supported VESA Video Modes:
(II) RADEON(0): 720x400@70Hz
(II) RADEON(0): 640x480@60Hz
(II) RADEON(0): 640x480@72Hz
(II) RADEON(0): 640x480@75Hz
(II) RADEON(0): 800x600@56Hz
(II) RADEON(0): 800x600@60Hz
(II) RADEON(0): 800x600@72Hz
(II) RADEON(0): 800x600@75Hz
(II) RADEON(0): 1024x768@60Hz
(II) RADEON(0): 1024x768@70Hz
(II) RADEON(0): 1024x768@75Hz
(II) RADEON(0): Manufacturer's mask: 0
(II) RADEON(0): Supported Future Video Modes:
(II) RADEON(0): #0: hsize: 1024  vsize 768  refresh: 60  vid: 16481
(II) RADEON(0): Supported additional Video Mode:
(II) RADEON(0): clock: 65.0 MHz   Image Size:  300 x 225 mm
(II) RADEON(0): h_active: 1024  h_sync: 1048  h_sync_end 1184 h_blank_end 1344 h_border: 0
(II) RADEON(0): v_active: 768  v_sync: 771  v_sync_end 777 v_blanking: 806 v_border: 0
(II) RADEON(0): Serial No: Reserved
(II) RADEON(0): Monitor name: IBM RSA2
(II) RADEON(0): Ranges: V min: 50  V max: 160 Hz, H min: 30  H max: 70 kHz, PixClock max 110 MHz
(II) RADEON(0): 
(II) RADEON(0): Reversed DAC decteced
(II) RADEON(0): Primary:
 Monitor   -- CRT
 Connector -- VGA
 DAC Type  -- Primary
 TMDS Type -- NONE
 DDC Type  -- VGA_DDC
(II) RADEON(0): Secondary:
 Monitor   -- TMDS
 Connector -- DVI-I
 DAC Type  -- TVDAC/ExtDAC
 TMDS Type -- External
 DDC Type  -- CRT2_DDC
(II) RADEON(0): PLL parameters: rf=2700 rd=60 min=12000 max=35000; xclk=14300
(II) RADEON(0): DFP table revision: 3
(==) RADEON(0): Using gamma correction (1.0, 1.0, 1.0)
(II) RADEON(0): Validating modes on Primary head ---------
(II) RADEON(0): Valid Mode from Detailed timing table: 960x529
(II) RADEON(0): Valid Mode from standard timing table: 640x480
(II) RADEON(0): Valid Mode from standard timing table: 800x600
(II) RADEON(0): Valid Mode from standard timing table: 1024x768
(II) RADEON(0): Valid Mode from standard timing table: 1600x1200
(II) RADEON(0): Valid Mode from established timing table: 1280x1024
(II) RADEON(0): Valid Mode from established timing table: 1024x768
(II) RADEON(0): Valid Mode from established timing table: 800x600
(II) RADEON(0): Valid Mode from established timing table: 640x480
(II) RADEON(0): Total of 9 mode(s) found.
(II) RADEON(0): Total number of valid DDC mode(s) found: 9
(II) RADEON(0): Validating CRTC2 modes for MergedFB ------------ 
(II) RADEON(0): Valid Mode from Detailed timing table: 1024x768
(II) RADEON(0): Valid Mode from standard timing table: 1024x768
(II) RADEON(0): Valid Mode from established timing table: 1024x768
(II) RADEON(0): Valid Mode from established timing table: 1024x768
(II) RADEON(0): Valid Mode from established timing table: 1024x768
(II) RADEON(0): Valid Mode from established timing table: 800x600
(II) RADEON(0): Valid Mode from established timing table: 800x600
(II) RADEON(0): Valid Mode from established timing table: 800x600
(II) RADEON(0): Valid Mode from established timing table: 800x600
(II) RADEON(0): Valid Mode from established timing table: 640x480
(II) RADEON(0): Valid Mode from established timing table: 640x480
(II) RADEON(0): Valid Mode from established timing table: 640x480
(II) RADEON(0): Total of 12 mode(s) found.
(II) RADEON(0): Total number of valid DDC mode(s) found: 12
(II) RADEON(0): Total of 12 CRTC2 modes found for MergedFB------------ 
(II) RADEON(0): Modes for CRT1: ********************
(--) RADEON(0): Virtual size is 800x600 (pitch 800)
(**) RADEON(0): *Default mode "800x600": 56.3 MHz (scaled from 0.0 MHz), 53.7 kHz, 85.1 Hz
(II) RADEON(0): Modeline "800x600"   56.30  800 832 896 1048  600 601 604 631 +hsync +vsync
(**) RADEON(0): *Default mode "640x480": 36.0 MHz (scaled from 0.0 MHz), 43.3 kHz, 85.0 Hz
(II) RADEON(0): Modeline "640x480"   36.00  640 696 752 832  480 481 484 509 -hsync -vsync
(**) RADEON(0):  Default mode "800x600": 49.5 MHz (scaled from 0.0 MHz), 46.9 kHz, 75.0 Hz
(II) RADEON(0): Modeline "800x600"   49.50  800 816 896 1056  600 601 604 625 +hsync +vsync
(**) RADEON(0):  Default mode "640x480": 25.2 MHz (scaled from 0.0 MHz), 31.5 kHz, 60.0 Hz
(II) RADEON(0): Modeline "640x480"   25.20  640 656 752 800  480 490 492 525 -hsync -vsync
(II) RADEON(0): Modes for CRT2: ********************
(--) RADEON(0): Virtual size is 800x600 (pitch 800)
(**) RADEON(0): *Default mode "800x600": 50.0 MHz (scaled from 0.0 MHz), 48.1 kHz, 72.2 Hz
(II) RADEON(0): Modeline "800x600"   50.00  800 856 976 1040  600 637 643 666 +hsync +vsync
(**) RADEON(0): *Default mode "640x480": 31.5 MHz (scaled from 0.0 MHz), 37.9 kHz, 72.8 Hz
(II) RADEON(0): Modeline "640x480"   31.50  640 664 704 832  480 489 491 520 -hsync -vsync
(**) RADEON(0):  Default mode "800x600": 49.5 MHz (scaled from 0.0 MHz), 46.9 kHz, 75.0 Hz
(II) RADEON(0): Modeline "800x600"   49.50  800 816 896 1056  600 601 604 625 +hsync +vsync
(**) RADEON(0):  Default mode "800x600": 40.0 MHz (scaled from 0.0 MHz), 37.9 kHz, 60.3 Hz
(II) RADEON(0): Modeline "800x600"   40.00  800 840 968 1056  600 601 605 628 +hsync +vsync
(**) RADEON(0):  Default mode "800x600": 36.0 MHz (scaled from 0.0 MHz), 35.2 kHz, 56.2 Hz
(II) RADEON(0): Modeline "800x600"   36.00  800 824 896 1024  600 601 603 625 +hsync +vsync
(**) RADEON(0):  Default mode "640x480": 31.5 MHz (scaled from 0.0 MHz), 37.5 kHz, 75.0 Hz
(II) RADEON(0): Modeline "640x480"   31.50  640 656 720 840  480 481 484 500 -hsync -vsync
(**) RADEON(0):  Default mode "640x480": 25.2 MHz (scaled from 0.0 MHz), 31.5 kHz, 60.0 Hz
(II) RADEON(0): Modeline "640x480"   25.20  640 656 752 800  480 490 492 525 -hsync -vsync
(II) RADEON(0): Generating MergedFB mode list
(II) RADEON(0): No MetaModes given, linking first modes by default
(II) RADEON(0): Merged 800x600 and 800x600 to 800x600 (Clone)
(II) RADEON(0): Merged 640x480 and 640x480 to 640x480 (Clone)
(--) RADEON(0): MergedFB: Virtual width 800
(--) RADEON(0): MergedFB: Virtual height 600
(--) RADEON(0): MergedFB: Display dimensions: (320, 240) mm
(--) RADEON(0): MergedFB: DPI set to (63, 63)
(II) Loading sub module "fb"
(II) LoadModule: "fb"
(II) Loading /usr/X11R6/lib64/modules/libfb.a
(II) Module fb: vendor="X.Org Foundation"
	compiled for 6.8.2, module version = 1.0.0
	ABI class: X.Org ANSI C Emulation, version 0.2
(II) Loading sub module "ramdac"
(II) LoadModule: "ramdac"
(II) Loading /usr/X11R6/lib64/modules/libramdac.a
(II) Module ramdac: vendor="X.Org Foundation"
	compiled for 6.8.2, module version = 0.1.0
	ABI class: X.Org Video Driver, version 0.7
(II) Loading sub module "xaa"
(II) LoadModule: "xaa"
(II) Loading /usr/X11R6/lib64/modules/libxaa.a
(II) Module xaa: vendor="X.Org Foundation"
	compiled for 6.8.2, module version = 1.2.0
	ABI class: X.Org Video Driver, version 0.7
(II) RADEON(0): Depth moves disabled by default
(II) Loading sub module "shadowfb"
(II) LoadModule: "shadowfb"
(II) Loading /usr/X11R6/lib64/modules/libshadowfb.a
(II) Module shadowfb: vendor="X.Org Foundation"
	compiled for 6.8.2, module version = 1.0.0
	ABI class: X.Org ANSI C Emulation, version 0.2
(II) RADEON(0): Page flipping disabled
(!!) RADEON(0): For information on using the multimedia capabilities
	of this adapter, please see http://gatos.sf.net.
(--) Depth 24 pixmap format is 32 bpp
(II) do I need RAC?  No, I don't.
(II) resource ranges after preInit:
	[0] 0	0	0xf8000000 - 0xf800ffff (0x10000) MX[B]
	[1] 0	0	0xf0000000 - 0xf7ffffff (0x8000000) MX[B]
	[2] -1	0	0xffe00000 - 0xffffffff (0x200000) MX[B](B)
	[3] -1	0	0x00100000 - 0x3fffffff (0x3ff00000) MX[B]E(B)
	[4] -1	0	0x000f0000 - 0x000fffff (0x10000) MX[B]
	[5] -1	0	0x000c0000 - 0x000effff (0x30000) MX[B]
	[6] -1	0	0x00000000 - 0x0009ffff (0xa0000) MX[B]
	[7] -1	0	0xdaffc000 - 0xdaffdfff (0x2000) MX[B]
	[8] -1	0	0xdaffe000 - 0xdaffffff (0x2000) MX[B]
	[9] -1	0	0xdcff0000 - 0xdcffffff (0x10000) MX[B]
	[10] -1	0	0xdeff0000 - 0xdeffffff (0x10000) MX[B]
	[11] -1	0	0xdf100000 - 0xdf1003ff (0x400) MX[B]
	[12] -1	0	0xf9000000 - 0xf90003ff (0x400) MX[B]
	[13] -1	0	0xff000000 - 0xfeffffff (0x0) MX[B]O
	[14] -1	0	0xf8000000 - 0xf800ffff (0x10000) MX[B](B)
	[15] -1	0	0xf0000000 - 0xf7ffffff (0x8000000) MX[B](B)
	[16] 0	0	0x000a0000 - 0x000affff (0x10000) MS[B](OprU)
	[17] 0	0	0x000b0000 - 0x000b7fff (0x8000) MS[B](OprU)
	[18] 0	0	0x000b8000 - 0x000bffff (0x8000) MS[B](OprU)
	[19] 0	0	0x00003000 - 0x000030ff (0x100) IX[B]
	[20] -1	0	0x0000ffff - 0x0000ffff (0x1) IX[B]
	[21] -1	0	0x00000000 - 0x000000ff (0x100) IX[B]
	[22] -1	0	0x00000440 - 0x0000045f (0x20) IX[B]
	[23] -1	0	0x00000480 - 0x0000048f (0x10) IX[B]
	[24] -1	0	0x00000374 - 0x00000374 (0x1) IX[B]
	[25] -1	0	0x00000170 - 0x00000170 (0x1) IX[B]
	[26] -1	0	0x000003f4 - 0x000003f4 (0x1) IX[B]
	[27] -1	0	0x000001f0 - 0x000001f0 (0x1) IX[B]
	[28] -1	0	0x00002600 - 0x0000261f (0x20) IX[B]
	[29] -1	0	0x00002200 - 0x0000221f (0x20) IX[B]
	[30] -1	0	0x00003000 - 0x000030ff (0x100) IX[B](B)
	[31] -1	0	0x00004300 - 0x000043ff (0x100) IX[B]
	[32] -1	0	0x00004200 - 0x000042ff (0x100) IX[B]
	[33] -1	0	0x00004100 - 0x000041ff (0x100) IX[B]
	[34] -1	0	0x00004000 - 0x000040ff (0x100) IX[B]
	[35] 0	0	0x000003b0 - 0x000003bb (0xc) IS[B](OprU)
	[36] 0	0	0x000003c0 - 0x000003df (0x20) IS[B](OprU)
(WW) RADEON(0): Failed to set up write-combining range (0xf0000000,0x1000000)
(II) RADEON(0): Dynamic Clock Scaling Disabled
(WW) RADEON(0): Direct Rendering is disabled by default on Radeon VE/7000
	hardware due to instability, but has been forced on with
	"Option "dri" in xorg.conf.  You may experience instability.
drmOpenDevice: node name is /dev/dri/card0
drmOpenDevice: open result is -1, (No such device)
drmOpenDevice: open result is -1, (No such device)
drmOpenDevice: Open failed
drmOpenDevice: node name is /dev/dri/card0
drmOpenDevice: open result is -1, (No such device)
drmOpenDevice: open result is -1, (No such device)
drmOpenDevice: Open failed
drmOpenByBusid: Searching for BusID pci:0000:01:06.0
drmOpenDevice: node name is /dev/dri/card0
drmOpenDevice: open result is 6, (OK)
drmOpenByBusid: drmOpenMinor returns 6
drmOpenByBusid: drmGetBusid reports pci:0000:01:06.0
(II) RADEON(0): [drm] loaded kernel module for "radeon" driver
(II) RADEON(0): [drm] DRM interface version 1.2
(II) RADEON(0): [drm] created "radeon" driver at busid "pci:0000:01:06.0"
(II) RADEON(0): [drm] added 8192 byte SAREA at 0x10000000
(II) RADEON(0): [drm] mapped SAREA 0x10000000 to 0x2aaaabc5b000
(II) RADEON(0): [drm] framebuffer handle = 0xf0000000
(II) RADEON(0): [drm] added 1 reserved context for kernel
(II) RADEON(0): [pci] 8192 kB allocated with handle 0x0026d200
(II) RADEON(0): [pci] ring handle = 0x10001000
(II) RADEON(0): [pci] Ring mapped at 0x2aaaabc5d000
(II) RADEON(0): [pci] Ring contents 0x00000000
(II) RADEON(0): [pci] ring read ptr handle = 0x10002000
(II) RADEON(0): [pci] Ring read ptr mapped at 0x2aaaabd5e000
(II) RADEON(0): [pci] Ring read ptr contents 0x00000000
(II) RADEON(0): [pci] vertex/indirect buffers handle = 0x10003000
(II) RADEON(0): [pci] Vertex/indirect buffers mapped at 0x2aaaabd5f000
(II) RADEON(0): [pci] Vertex/indirect buffers contents 0x00000000
(II) RADEON(0): [pci] GART texture map handle = 0x10004000
(II) RADEON(0): [pci] GART Texture map mapped at 0x2aaaabf5f000
(II) RADEON(0): [drm] register handle = 0xf8000000
(II) RADEON(0): [dri] Visual configs initialized
(II) RADEON(0): CP in BM mode
(II) RADEON(0): Using 8 MB GART aperture
(II) RADEON(0): Using 1 MB for the ring buffer
(II) RADEON(0): Using 2 MB for vertex/indirect buffers
(II) RADEON(0): Using 5 MB for GART textures
(II) RADEON(0): Memory manager initialized to (0,0) (800,5242)
(II) RADEON(0): Reserved area from (0,600) to (800,602)
(II) RADEON(0): Largest offscreen area available: 800 x 4640
(II) RADEON(0): Will use back buffer at offset 0x3d0000
(II) RADEON(0): Will use depth buffer at offset 0x5a5000
(II) RADEON(0): Will use 8704 kb for textures at offset 0x780000
(II) RADEON(0): Render acceleration disabled
(II) RADEON(0): Using XFree86 Acceleration Architecture (XAA)
	Screen to screen bit blits
	Solid filled rectangles
	8x8 mono pattern filled rectangles
	Indirect CPU to Screen color expansion
	Solid Lines
	Dashed Lines
	Scanline Image Writes
	Offscreen Pixmaps
	Setting up tile and stipple cache:
		32 128x128 slots
		22 256x256 slots
		6 512x512 slots
(II) RADEON(0): Acceleration enabled
(==) RADEON(0): Backing store disabled
(==) RADEON(0): Silken mouse enabled
(II) RADEON(0): Using hardware cursor (scanline 602)
(II) RADEON(0): Largest offscreen area available: 800 x 4634
(**) Option "dpms"
(**) RADEON(0): DPMS enabled
(II) RADEON(0): Running MergedFB in Clone mode, Radeon Pseudo-Xinerama disabled
(II) RADEON(0): X context handle = 0x00000001
(II) RADEON(0): [drm] installed DRM signal handler
(II) RADEON(0): [DRI] installation complete
(II) RADEON(0): [drm] Added 32 65536 byte vertex/indirect buffers
(II) RADEON(0): [drm] Mapped 32 vertex/indirect buffers
(II) RADEON(0): [drm] dma control initialized, using IRQ 153
(II) RADEON(0): [drm] Initialized kernel GART heap manager, 5111808
(II) RADEON(0): Direct rendering enabled
(==) RandR enabled
(II) Initializing built-in extension MIT-SHM
(II) Initializing built-in extension XInputExtension
(II) Initializing built-in extension XTEST
(II) Initializing built-in extension XKEYBOARD
(II) Initializing built-in extension LBX
(II) Initializing built-in extension XC-APPGROUP
(II) Initializing built-in extension SECURITY
(II) Initializing built-in extension XINERAMA
(II) Initializing built-in extension XFIXES
(II) Initializing built-in extension XFree86-Bigfont
(II) Initializing built-in extension RENDER
(II) Initializing built-in extension RANDR
(II) Initializing built-in extension COMPOSITE
(II) Initializing built-in extension DAMAGE
(II) Initializing built-in extension XEVIE
(**) Option "Protocol" "IMPS/2"
(**) Mouse0: Device: "/dev/input/mice"
(**) Mouse0: Protocol: "IMPS/2"
(**) Option "CorePointer"
(**) Mouse0: Core Pointer
(**) Option "Device" "/dev/input/mice"
(**) Option "Emulate3Buttons" "yes"
(**) Mouse0: Emulate3Buttons, Emulate3Timeout: 50
(**) Option "ZAxisMapping" "4 5"
(**) Mouse0: ZAxisMapping: buttons 4 and 5
(**) Mouse0: Buttons: 5
(**) Option "CoreKeyboard"
(**) Keyboard0: Core Keyboard
(**) Option "Protocol" "standard"
(**) Keyboard0: Protocol: standard
(**) Option "AutoRepeat" "500 30"
(**) Option "XkbRules" "xorg"
(**) Keyboard0: XkbRules: "xorg"
(**) Option "XkbModel" "pc105"
(**) Keyboard0: XkbModel: "pc105"
(**) Option "XkbLayout" "us"
(**) Keyboard0: XkbLayout: "us"
(**) Option "CustomKeycodes" "off"
(**) Keyboard0: CustomKeycodes disabled
(II) XINPUT: Adding extended input device "Keyboard0" (type: KEYBOARD)
(II) XINPUT: Adding extended input device "Mouse0" (type: MOUSE)
(II) Mouse0: ps2EnableDataReporting: succeeded

--=-2bE+ZGKvQHhYpUIhmRyA
Content-Disposition: attachment; filename=xorg.conf
Content-Type: text/plain; name=xorg.conf; charset=utf-8
Content-Transfer-Encoding: 7bit


# XFree86 4 configuration created by pyxf86config

Section "ServerLayout"
	Identifier     "Default Layout"
	Screen      0  "Screen0" 0 0
	InputDevice    "Mouse0" "CorePointer"
	InputDevice    "Keyboard0" "CoreKeyboard"
EndSection

Section "Files"

# RgbPath is the location of the RGB database.  Note, this is the name of the 
# file minus the extension (like ".txt" or ".db").  There is normally
# no need to change the default.
# Multiple FontPath entries are allowed (they are concatenated together)
# By default, Red Hat 6.0 and later now use a font server independent of
# the X server to render fonts.
	RgbPath      "/usr/X11R6/lib/X11/rgb"
	FontPath     "unix/:7100"
EndSection

Section "Module"
	Load  "dbe"
	Load  "extmod"
	Load  "fbdevhw"
	Load  "glx"
	Load  "record"
	Load  "freetype"
	Load  "type1"
	Load  "dri"
EndSection

Section "InputDevice"

# Specify which keyboard LEDs can be user-controlled (eg, with xset(1))
#	Option	"Xleds"		"1 2 3"
# To disable the XKEYBOARD extension, uncomment XkbDisable.
#	Option	"XkbDisable"
# To customise the XKB settings to suit your keyboard, modify the
# lines below (which are the defaults).  For example, for a non-U.S.
# keyboard, you will probably want to use:
#	Option	"XkbModel"	"pc102"
# If you have a US Microsoft Natural keyboard, you can use:
#	Option	"XkbModel"	"microsoft"
#
# Then to change the language, change the Layout setting.
# For example, a german layout can be obtained with:
#	Option	"XkbLayout"	"de"
# or:
#	Option	"XkbLayout"	"de"
#	Option	"XkbVariant"	"nodeadkeys"
#
# If you'd like to switch the positions of your capslock and
# control keys, use:
#	Option	"XkbOptions"	"ctrl:swapcaps"
# Or if you just want both to be control, use:
#	Option	"XkbOptions"	"ctrl:nocaps"
#
	Identifier  "Keyboard0"
	Driver      "kbd"
	Option	    "XkbModel" "pc105"
	Option	    "XkbLayout" "us"
EndSection

Section "InputDevice"
	Identifier  "Mouse0"
	Driver      "mouse"
	Option	    "Protocol" "IMPS/2"
	Option	    "Device" "/dev/input/mice"
	Option	    "ZAxisMapping" "4 5"
	Option	    "Emulate3Buttons" "yes"
EndSection

Section "Monitor"
	Identifier   "Monitor0"
	VendorName   "Monitor Vendor"
	ModelName    "Unknown monitor"
	HorizSync    31.5 - 37.9
	VertRefresh  50.0 - 70.0
	Option	    "dpms"
EndSection

Section "Device"
	Identifier  "Videocard0"
	Driver      "radeon"
	VendorName  "Videocard vendor"
	BoardName   "ATI Radeon 7000"
EndSection

Section "Screen"
	Identifier "Screen0"
	Device     "Videocard0"
	Monitor    "Monitor0"
	DefaultDepth     24
	SubSection "Display"
		Viewport   0 0
		Depth     16
		Modes    "800x600" "640x480"
	EndSubSection
	SubSection "Display"
		Viewport   0 0
		Depth     24
		Modes    "800x600" "640x480"
	EndSubSection
EndSection

Section "DRI"
	Group        0
	Mode         0666
EndSection


--=-2bE+ZGKvQHhYpUIhmRyA--

