Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261228AbSIWMsE>; Mon, 23 Sep 2002 08:48:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261238AbSIWMsE>; Mon, 23 Sep 2002 08:48:04 -0400
Received: from mail.pixelwings.com ([194.152.163.212]:21520 "EHLO
	pixelwings.com") by vger.kernel.org with ESMTP id <S261228AbSIWMsD> convert rfc822-to-8bit;
	Mon, 23 Sep 2002 08:48:03 -0400
Date: Mon, 23 Sep 2002 14:53:10 +0200 (CEST)
From: Clemens Schwaighofer <cs@pixelwings.com>
X-X-Sender: gullevek@lynx.piwi.intern
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.38
In-Reply-To: <Pine.LNX.4.33.0209212130360.2433-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.44.0209231450590.31908-100000@lynx.piwi.intern>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 21 Sep 2002, Linus Torvalds wrote:

in 2.5.38 same thing is broken as in 2.5.37. ACPI thing?

  ld -m elf_i386 -e stext -T arch/i386/vmlinux.lds.s 
arch/i386/kernel/head.o arch/i386/kernel/init_task.o  init/built-in.o 
--start-group  arch/i386/kernel/built-in.o  arch/i386/mm/built-in.o  
arch/i386/mach-generic/built-in.o kernel/built-in.o mm/built-in.o 
fs/built-in.o ipc/built-in.o security/built-in.o  lib/lib.a  
arch/i386/lib/lib.a  drivers/built-in.o  sound/built-in.o  
arch/i386/math-emu/built-in.o  arch/i386/pci/built-in.o  net/built-in.o 
--end-group -o vmlinux
arch/i386/kernel/built-in.o: In function `disconnect_bsp_APIC':
arch/i386/kernel/built-in.o(.text+0xc9e8): undefined reference to 
`pic_mode'
arch/i386/kernel/built-in.o: In function `clear_IO_APIC':
arch/i386/kernel/built-in.o(.text+0xd26b): undefined reference to 
`nr_ioapics'
arch/i386/kernel/built-in.o(.text+0xd2ae): undefined reference to 
`nr_ioapics'
arch/i386/kernel/built-in.o: In function `IO_APIC_get_PCI_irq_vector':
 
[....] 

drivers/built-in.o: In function 
`quirk_via_ioapic':
drivers/built-in.o(.text.init+0x117b): undefined reference to `nr_ioapics'
arch/i386/pci/built-in.o: In function `pirq_enable_irq':
arch/i386/pci/built-in.o(.text+0x185f): undefined reference to 
`mp_irq_entries'
arch/i386/pci/built-in.o: In function `pcibios_irq_init':
arch/i386/pci/built-in.o(.text.init+0x1296): undefined reference to 
`mp_irq_entries'
arch/i386/pci/built-in.o: In function `pcibios_fixup_irqs':
arch/i386/pci/built-in.o(.text.init+0x1360): undefined reference to 
`mp_irq_entries'
make: *** [vmlinux] Error 1

-- 
"Der Krieg ist ein Massaker von Leuten, die sich nicht kennen, zum
Nutzen von Leuten, die sich kennen, aber nicht massakrieren"
- Paul Valéry (1871-1945)
mfg, Clemens Schwaighofer                       PIXELWINGS Medien GMBH
Kandlgasse 15/5, A-1070 Wien                      T: [+43 1] 524 58 50
JETZT NEU! MIT FEWA GEWASCHEN       -->      http://www.pixelwings.com

