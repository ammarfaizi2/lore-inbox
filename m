Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267145AbTBQN4F>; Mon, 17 Feb 2003 08:56:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267154AbTBQN4E>; Mon, 17 Feb 2003 08:56:04 -0500
Received: from [207.61.129.108] ([207.61.129.108]:52194 "EHLO
	mail.datawire.net") by vger.kernel.org with ESMTP
	id <S267145AbTBQNz1>; Mon, 17 Feb 2003 08:55:27 -0500
From: Shawn Starr <shawn.starr@datawire.net>
Organization: Datawire Communication Networks Inc.
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.xx ACPI/Sb16 IRQ conflict 
Date: Mon, 17 Feb 2003 09:06:33 -0500
User-Agent: KMail/1.5
Cc: Simone Piunno <pioppo@ferrara.linux.it>, Grover@unaropia,
       Andrew <andrew.grover@intel.com>, Adam Belay <ambx1@neo.rr.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200302170906.33198.shawn.starr@datawire.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I can confirm this with 2.5.61 and my SB16AWE card. There seems to be a bug 
when PCI interrupts are set by ACPI on a IBM 300PL 6892-N2U.

Also, the IBM BIOS's PnP for OS is enabled.

When the PnP BIOS is disabled and pci=noacpi is NOT used. There are no 
conflicts. When PnP BIOS is enabled and we don't set pci=noacpi we get 
conflicts with IRQs. 

We might need a workaround or is this a bug in IBM's ACPI implimentation?

Shawn.

>List:     linux-kernel
>Subject:  2.5.42 ACPI/Sb16 IRQ conflict
From:     Simone Piunno <pioppo () ferrara ! linux ! it>
>Date:     2002-10-16 20:29:08

>Hi,

>I'm trying 2.5.42 compiled with ACPI and OSS ISA-Pnp Soundblaster 16.
>When playing audio, the sound is heavily chopped.
>dmesg says:

>ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
>isapnp: Scanning for PnP cards...
>isapnp: SB audio device quirk - increasing port range
>isapnp: Card 'Creative SB16 PnP'
>isapnp: 1 Plug & Play card detected total
>ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 10
>ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 5
>[-cut-]
>Soundblaster audio driver Copyright (C) by Hannu Savolainen 1993-1996
>sb: Creative SB16 PnP detected
>sb: ISAPnP reports 'Creative SB16 PnP' at i/o 0x220, irq 5, dma 1, 5
>SB 4.13 detected OK (220)
>sb: Interrupt test on IRQ5 failed - Probable IRQ conflict
>Sound Blaster 16 (4.13)> at 0x220 irq 5 dma 1,5
><Sound Blaster 16> at 0x330 irq 5 dma 0,0
>sb: 1 Soundblaster PnP card(s) found.

>Motherboard is Asus P5A.
>Audio is compiled as a module
>isapnp and ACPI are statically linked

>With ALSA was even worse (no output at all).

>After appending "pci=noapci" into lilo.conf, now OSS happily works
>again without problems.  I haven't tried yet if ALSA too benefits
>from pci=noapci.

>Feel free to contact me if you need more info.

>Regards,
>Simone

-- 
Shawn Starr
UNIX Systems Administrator, Operations
Datawire Communication Networks Inc.
10 Carlson Court, Suite 300
Toronto, ON, M9W 6L2
T: 416-213-2001 ext 179  F: 416-213-2008
shawn.starr@datawire.net
"The power to Transact" - http://www.datawire.net

