Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263182AbTEGN0V (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 09:26:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263186AbTEGN0U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 09:26:20 -0400
Received: from cibs9.sns.it ([192.167.206.29]:2578 "EHLO cibs9.sns.it")
	by vger.kernel.org with ESMTP id S263182AbTEGN0T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 09:26:19 -0400
Date: Wed, 7 May 2003 15:38:50 +0200 (CEST)
From: venom@sns.it
To: linux-kernel@vger.kernel.org
Subject: DRM problem with kernel 2.5.69, XF86 4.3.0 and i810 chipset
Message-ID: <Pine.LNX.4.43.0305071534110.29394-100000@cibs9.sns.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


HI,
afeter upgrading from 2.5.68 to 2.5.69 direct rendering with glx does
not work anymore with my i810 video card.
I get this message:

mtrr: base(0x44000000) is not aligned on a size(0x4b0000) boundary
[drm:i810_unlock] *ERROR* Process 441 using kernel context 0
agp_allocate_memory: dbd67b60
agp_allocate_memory: 00000000
agp_allocate_memory: dbd67a60

glx worked fine with 2.5.8 (and still does ;) ).

system is a pentium III 930 Mhz, 512MB RAM 133MHZ,
on i810 chipset (audio and video card)
kernel il 2.5.69 compiled with gcc 3.2.33 and binutils 2.13.90.0.18,
glibc 2.3.2.

agpgart and DRM for i810 are statically compiled into the kernel

lspci -v shows:
00:00.0 Host bridge: Intel Corp. 82815 815 Chipset Host Bridge and Memory
Controller Hub (rev 02)
        Flags: bus master, fast devsel, latency 0
        Capabilities: [88] #09 [f104]

00:02.0 VGA compatible controller: Intel Corp. 82815 CGC [Chipset Graphics
Controller] (rev 02) (prog-if 00 [VGA])
        Subsystem: Compaq Computer Corporation: Unknown device 0034
        Flags: bus master, 66Mhz, medium devsel, latency 0, IRQ 16
        Memory at 44000000 (32-bit, prefetchable) [size=64M]
        Memory at 40300000 (32-bit, non-prefetchable) [size=512K]
        Capabilities: [dc] Power Management version 2

00:1e.0 PCI bridge: Intel Corp. 82801AA PCI Bridge (rev 02) (prog-if 00 [Normal
decode])
        Flags: bus master, fast devsel, latency 0
        Bus: primary=00, secondary=02, subordinate=02, sec-latency=64
        I/O behind bridge: 00001000-00001fff
        Memory behind bridge: 40000000-402fffff

00:1f.0 ISA bridge: Intel Corp. 82801AA ISA Bridge (LPC) (rev 02)
        Flags: bus master, medium devsel, latency 0

00:1f.1 IDE interface: Intel Corp. 82801AA IDE (rev 02) (prog-if 80 [Master])
        Subsystem: Intel Corp. 82801AA IDE
        Flags: bus master, medium devsel, latency 0
        I/O ports at 2460 [size=16]

00:1f.2 USB Controller: Intel Corp. 82801AA USB (rev 02) (prog-if 00 [UHCI])
        Subsystem: Intel Corp. 82801AA USB
        Flags: bus master, medium devsel, latency 0, IRQ 19
        I/O ports at 2440 [size=32]

00:1f.5 Multimedia audio controller: Intel Corp. 82801AA AC'97 Audio (rev 02)
        Subsystem: Compaq Computer Corporation: Unknown device b1bf
        Flags: bus master, medium devsel, latency 0, IRQ 17
        I/O ports at 2000 [size=256]
        I/O ports at 2400 [size=64]

02:08.0 Ethernet controller: 3Com Corporation 3c905C-TX/TX-M [Tornado] (rev 78)
        Subsystem: 3Com Corporation 3C905C-TX Fast Etherlink for PC Management
NIC
        Flags: bus master, medium devsel, latency 64, IRQ 16
        I/O ports at 1000 [size=128]
        Memory at 40000000 (32-bit, non-prefetchable) [size=128]
        Expansion ROM at <unassigned> [disabled] [size=128K]
        Capabilities: [dc] Power Management version 2


Hope this helps

Luigi

