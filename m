Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316408AbSFQK7O>; Mon, 17 Jun 2002 06:59:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316896AbSFQK7O>; Mon, 17 Jun 2002 06:59:14 -0400
Received: from sproxy.gmx.de ([213.165.64.20]:44319 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S316408AbSFQK7N>;
	Mon, 17 Jun 2002 06:59:13 -0400
Date: Mon, 17 Jun 2002 12:59:05 +0200
From: Hanno =?ISO-8859-1?Q?B=F6ck?= <hanno@gmx.de>
To: linux-kernel@vger.kernel.org
Subject: 2.5.22 compile problems
Message-Id: <20020617125905.5511b12c.hanno@gmx.de>
Organization: Mecronome Webdesign - http://www.mecronome.de/
X-Mailer: Sylpheed version 0.7.8claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I tried to compile 2.5.22 and got the following errors:

   ld -m elf_i386  -r -o init.o main.o version.o do_mounts.o
make[1]: Verlassen des Verzeichnisses Verzeichnis »/usr/src/linux-2.5.22/init«
  ld -m elf_i386 -T /usr/src/linux-2.5.22/arch/i386/vmlinux.lds -e stext arch/i386/kernel/head.o arch/i386/kernel/init_task.o init/init.o --start-group arch/i386/kernel/kernel.o arch/i386/mm/mm.o kernel/kernel.o mm/mm.o fs/fs.o ipc/ipc.o /usr/src/linux-2.5.22/arch/i386/lib/lib.a lib/lib.a /usr/src/linux-2.5.22/arch/i386/lib/lib.a drivers/built-in.o sound/sound.o arch/i386/pci/pci.o net/network.o --end-group -o vmlinux
arch/i386/kernel/kernel.o: In function `intel_thermal_interrupt':
arch/i386/kernel/kernel.o(.text+0x7821): undefined reference to `ack_APIC_irq'
arch/i386/kernel/kernel.o: In function `intel_init_thermal':
arch/i386/kernel/kernel.o(.text.init+0x1450): undefined reference to `apic_read'
arch/i386/kernel/kernel.o(.text.init+0x149b): undefined reference to `apic_write_around'
arch/i386/kernel/kernel.o(.text.init+0x14cd): undefined reference to `apic_read'
arch/i386/kernel/kernel.o(.text.init+0x14e0): undefined reference to `apic_write_around'
make: *** [vmlinux] Fehler 1



I have tried kernels 2.5.18, 2.5.20, 2.5.21 and 2.5.22 and I always had compile problems. Can't someone test the kernel-source with all options activated before it is released?
I think it doesn't matter if this happens sometimes in the 2.5-series, but it should not become usual.
