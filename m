Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266552AbSLPJ6U>; Mon, 16 Dec 2002 04:58:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266548AbSLPJ6T>; Mon, 16 Dec 2002 04:58:19 -0500
Received: from cal003100.student.utwente.nl ([130.89.160.36]:57008 "EHLO
	margo.student.utwente.nl") by vger.kernel.org with ESMTP
	id <S266552AbSLPJ6P>; Mon, 16 Dec 2002 04:58:15 -0500
Date: Mon, 16 Dec 2002 11:06:10 +0100
To: linux-kernel@vger.kernel.org
Subject: Q: i845MP/P4-M laptop support? (specific problems listed)
Message-ID: <20021216100610.GA16816@margo.student.utwente.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
From: Simon Oosthoek <simon@margo.student.utwente.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all

I've been following kernel-traffic and sometimes the web-archives in search
for some clues about support for my laptop (jewel jade 8060, specs(in dutch):
URL:http://www.jewelnotebooks.nl/index.php?page=jade-8060)

I've noticed some problems and I've seen some proposals for patches and
fixes, but I don't have a clear picture of which is fixed and by which
patch...

The problems I have seen:
- apm doesn't seem to work 
  output: 
  APM BIOS 1.2 (kernel driver 1.16)
  AC on-line, no system battery
  
  Q: will the ACPI patches help with this?

- the -ac2 patch wasn't able to boot at all (no messages), but I haven't
tried it more than once... the intel speedstep feature would be nice to have
though...

- resource collision on PCI 00:1f.1?
  bootmessages: PCI: Device 00:1f.1 not available because of resource collisions

  Q: any fixes available for this?

- missing driver for smartmedia slot
  (I guess this is a feature request, if it's not available)
from "lspci -v":
02:06.0 System peripheral: Toshiba America Info Systems: Unknown device 0804
(rev 02)
        Subsystem: COMPAL Electronics Inc: Unknown device 0012
        Flags: slow devsel, IRQ 11
        Memory at e0000c00 (32-bit, non-prefetchable) [disabled] [size=32]
        Capabilities: <available only to root>


Otherwise I'm quite satisfied with linux on the laptop...

BTW, I'm not on the list, but I do sometimes parse the archives and
kernel-traffic. If anyone wants more details or if there's something I can
do to gather more information, please cc me or ask directly...

Cheers

Simon

-----
excerpt from the boot messages:

Kernel command line: BOOT_IMAGE=2420 ro root=301 devfs=mount pci=biosirq
No local APIC present or hardware disabled
...
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16)
Starting kswapd
Journalled Block Device driver loaded
ACPI: APM is already active, exiting
vesafb: framebuffer at 0xf0000000, mapped to 0xd0800000, size 32768k
vesafb: mode is 1024x768x32, linelength=4096, pages=1
vesafb: protected mode interface info at c000:e780
vesafb: scrolling: redraw
vesafb: directcolor: size=8:8:8:8, shift=24:16:8:0
Console: switching to colour frame buffer device 128x48
fb0: VESA VGA frame buffer device
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ
SERIAL_PCI enabled
ttyS01 at 0x02f8 (irq = 3) is a 16550A
PCI: Found IRQ 10 for device 00:1f.6
PCI: Sharing IRQ 10 with 00:1f.3
PCI: Sharing IRQ 10 with 00:1f.5
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH3M: IDE controller on PCI bus 00 dev f9
PCI: Device 00:1f.1 not available because of resource collisions
PCI: Assigned IRQ 11 for device 00:1f.1
ICH3M: BIOS setup was incomplete.

(note: this is all before the nvidia driver is loaded into the kernel,
making it tainted...)
