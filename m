Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264863AbSKVNqd>; Fri, 22 Nov 2002 08:46:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264867AbSKVNqd>; Fri, 22 Nov 2002 08:46:33 -0500
Received: from boden.synopsys.com ([204.176.20.19]:38296 "HELO
	boden.synopsys.com") by vger.kernel.org with SMTP
	id <S264863AbSKVNqc>; Fri, 22 Nov 2002 08:46:32 -0500
Date: Fri, 22 Nov 2002 14:53:22 +0100
From: Alex Riesen <Alexander.Riesen@synopsys.com>
To: linux-kernel@vger.kernel.org
Subject: 2.5.48+bk: piix: undefined references
Message-ID: <20021122135322.GE16412@riesen-pc.gr05.synopsys.com>
Reply-To: Alexander.Riesen@synopsys.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Organization: Synopsys, Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   ld -m elf_i386  -r -o init/built-in.o init/main.o init/version.o init/do_mounts.o init/initramfs.o
        ld -m elf_i386 -e stext -T arch/i386/vmlinux.lds.s arch/i386/kernel/head.o arch/i386/kernel/init_task.o  init/built-in.o --start-group  usr/built-in.o  arch/i386/kernel/built-in.o  arch/i386/mm/built-in.o  arch/i386/mach-generic/built-in.o  kernel/built-in.o  mm/built-in.o  fs/built-in.o  ipc/built-in.o  security/built-in.o  crypto/built-in.o  lib/lib.a  arch/i386/lib/lib.a  drivers/built-in.o  sound/built-in.o  arch/i386/pci/built-in.o  net/built-in.o --end-group  -o vmlinux
drivers/built-in.o(.text+0x3f392): In function `piix_ratemask':
: undefined reference to `eighty_ninty_three'
drivers/built-in.o(.text+0x3f45e): In function `piix_tune_drive':
: undefined reference to `ide_get_best_pio_mode'
drivers/built-in.o(.text+0x3f5f4): In function `piix_tune_chipset':
: undefined reference to `ide_rate_filter'
drivers/built-in.o(.text+0x3f8c9): In function `piix_tune_chipset':
: undefined reference to `ide_config_drive_speed'
drivers/built-in.o(.text+0x3f8e9): In function `piix_config_drive_for_dma':
: undefined reference to `ide_dma_speed'
drivers/built-in.o(.text+0x3f8ff): In function `piix_config_drive_for_dma':
: undefined reference to `ide_get_best_pio_mode'
drivers/built-in.o(.text+0x3f91d): In function `piix_config_drive_for_dma':
: undefined reference to `ide_dma_enable'
drivers/built-in.o(.text+0x3faea): In function `init_chipset_piix':
: undefined reference to `ide_pci_register_host_proc'
drivers/built-in.o(.text+0x40dbc): In function `via_set_drive':
: undefined reference to `ide_config_drive_speed'
drivers/built-in.o(.text+0x41117): In function `ide_match_hwif':
: undefined reference to `ide_hwifs'
...
drivers/built-in.o(.text+0x41d06): In function `ide_setup_pci_devices':
: undefined reference to `probe_hwif_init'
drivers/built-in.o(.text+0x423d4): In function `__ide_dma_off_quietly':
: undefined reference to `ide_toggle_bounce'
drivers/built-in.o(.text+0x424ac): In function `__ide_dma_on':
: undefined reference to `ide_toggle_bounce'
drivers/built-in.o(.text+0x425f9): In function `__ide_dma_read':
: undefined reference to `ide_set_handler'
drivers/built-in.o(.text+0x426b7): In function `__ide_dma_write':
: undefined reference to `ide_set_handler'
drivers/built-in.o(.text+0x42956): In function `__ide_dma_verbose':
: undefined reference to `eighty_ninty_three'
drivers/built-in.o(.init.text+0x2a53): In function `init_hwif_piix':
: undefined reference to `noautodma'
drivers/built-in.o(.init.text+0x2e30): In function `init_chipset_via82cxxx':
: undefined reference to `system_bus_clock'
drivers/built-in.o(.init.text+0x2f36): In function `init_chipset_via82cxxx':
: undefined reference to `ide_pci_register_host_proc'
drivers/built-in.o(.init.text+0x3014): In function `init_hwif_via82cxxx':
: undefined reference to `noautodma'
drivers/built-in.o(.init.text+0x30dc): In function `init_hwif_generic':
: undefined reference to `noautodma'

