Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261397AbSJPUpO>; Wed, 16 Oct 2002 16:45:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261402AbSJPUpO>; Wed, 16 Oct 2002 16:45:14 -0400
Received: from flug.4net.it ([194.243.234.21]:8637 "HELO flug.ferrara.linux.it")
	by vger.kernel.org with SMTP id <S261397AbSJPUpN>;
	Wed, 16 Oct 2002 16:45:13 -0400
Date: Wed, 16 Oct 2002 22:29:08 +0200
From: Simone Piunno <pioppo@ferrara.linux.it>
To: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Cc: devel@ferrara.linux.it
Subject: 2.5.42 ACPI/Sb16 IRQ conflict
Message-ID: <20021016202907.GA2256@ferrara.linux.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Organization: Ferrara LUG
X-Operating-System: Linux 2.5.42
X-Message: GnuPG/PGP5 are welcome
X-Key-ID: 860314FC/C09E842C
X-Key-FP: 9C15F0D3E3093593AC952C92A0CD52B4860314FC
X-Key-URL: http://members.ferrara.linux.it/pioppo/mykey.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

I'm trying 2.5.42 compiled with ACPI and OSS ISA-Pnp Soundblaster 16.
When playing audio, the sound is heavily chopped.
dmesg says:

ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
isapnp: Scanning for PnP cards...
isapnp: SB audio device quirk - increasing port range
isapnp: Card 'Creative SB16 PnP'
isapnp: 1 Plug & Play card detected total
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 10
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 5
[-cut-]
Soundblaster audio driver Copyright (C) by Hannu Savolainen 1993-1996
sb: Creative SB16 PnP detected
sb: ISAPnP reports 'Creative SB16 PnP' at i/o 0x220, irq 5, dma 1, 5
SB 4.13 detected OK (220)
sb: Interrupt test on IRQ5 failed - Probable IRQ conflict
<Sound Blaster 16 (4.13)> at 0x220 irq 5 dma 1,5
<Sound Blaster 16> at 0x330 irq 5 dma 0,0
sb: 1 Soundblaster PnP card(s) found.

Motherboard is Asus P5A.
Audio is compiled as a module
isapnp and ACPI are statically linked

With ALSA was even worse (no output at all).

After appending "pci=noapci" into lilo.conf, now OSS happily works
again without problems.  I haven't tried yet if ALSA too benefits
from pci=noapci.

Feel free to contact me if you need more info.

Regards,
Simone

-- 
Adde parvum parvo magnus acervus erit.
Simone Piunno, FerraraLUG - http://members.ferrara.linux.it/pioppo
