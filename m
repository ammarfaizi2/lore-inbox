Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261866AbSJ2Xra>; Tue, 29 Oct 2002 18:47:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261908AbSJ2Xra>; Tue, 29 Oct 2002 18:47:30 -0500
Received: from earth.colorado-research.com ([65.171.192.8]:14599 "EHLO
	earth.colorado-research.com") by vger.kernel.org with ESMTP
	id <S261866AbSJ2Xr3>; Tue, 29 Oct 2002 18:47:29 -0500
Message-Id: <200210292353.g9TNrq514597@earth.colorado-research.com>
Content-Type: text/plain; charset=US-ASCII
From: Orion Poplawski <orion@colorado-research.com>
Organization: CoRA
To: linux-kernel@vger.kernel.org
Subject: Running linux-2.4.20-rc1 on Dell Dimension 4550
Date: Tue, 29 Oct 2002 16:53:50 -0700
X-Mailer: KMail [version 1.3.2]
Cc: req@earth.colorado-research.com
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thought I'd post some information about what I'm seeing running RH7.3 with 
kernel 2.4.20-rc1 on a brand new Dell Dimension 4550.  Currently there are 
two problems with the machine:

- When I swtich to a text console and back to the X screen, the machine locks 
up (or at least the console does not respond anymore).

- The sound driver does not load, although it seems to try.

I'm seeing the following lines of concern from the kernel:

Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH4: IDE controller on PCI bus 00 dev f9
PCI: Device 00:1f.1 not available because of resource collisions
PCI: Found IRQ 9 for device 00:1f.1
PCI: Sharing IRQ 9 with 00:1d.2
ICH4: BIOS setup was incomplete.
ICH4: chipset revision 1
ICH4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:DMA, hdd:pio

and:

Intel 810 + AC97 Audio, version 0.21, 15:48:58 Oct 29 2002
PCI: Found IRQ 11 for device 00:1f.5
PCI: Sharing IRQ 11 with 00:1f.3
PCI: Setting latency timer of device 00:1f.5 to 64
i810: Intel ICH4 found at IO 0xcc40 and 0xc800, IRQ 11
i810_audio: Audio Controller supports 6 channels.
i810_audio: Primary codec not ready.

lspci -v for the devices of concern:

00:1d.2 USB Controller: Intel Corp. 82801DB USB (Hub  (rev 01) (prog-if 00 
[UHCI])
        Subsystem: Dell Computer Corporation: Unknown device 0142
        Flags: bus master, medium devsel, latency 0, IRQ 9
        I/O ports at ff40 [size=32]

00:1f.1 IDE interface: Intel Corp. 82801DB ICH4 IDE (rev 01) (prog-if 8a 
[Master SecP PriP])
        Subsystem: Dell Computer Corporation: Unknown device 0142
        Flags: bus master, medium devsel, latency 0, IRQ 9
        I/O ports at <unassigned> [size=8]
        I/O ports at <unassigned> [size=4]
        I/O ports at <unassigned> [size=8]
        I/O ports at <unassigned> [size=4]
        I/O ports at ffa0 [size=16]
        Memory at 10000000 (32-bit, non-prefetchable) [disabled] [size=1K]

00:1f.3 SMBus: Intel Corp. 82801DB SMBus (rev 01)
        Subsystem: Dell Computer Corporation: Unknown device 0142
        Flags: medium devsel, IRQ 11
        I/O ports at cc80 [size=32]

00:1f.5 Multimedia audio controller: Intel Corp. 82801DB AC'97 Audio (rev 01)
        Subsystem: Dell Computer Corporation: Unknown device 0142
        Flags: bus master, medium devsel, latency 0, IRQ 11
        I/O ports at c800 [size=256]
        I/O ports at cc40 [size=64]
        Memory at ffa04400 (32-bit, non-prefetchable) [size=512]
        Memory at ffa04000 (32-bit, non-prefetchable) [size=256]
        Capabilities: [50] Power Management version 2

Any help/advice would be greatly appreciated.  I'm happy to try out new 
patches.

Orion Poplawski

