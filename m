Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135776AbRDTBsx>; Thu, 19 Apr 2001 21:48:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135778AbRDTBso>; Thu, 19 Apr 2001 21:48:44 -0400
Received: from evl.evl.uic.edu ([131.193.48.80]:1806 "EHLO evl.uic.edu")
	by vger.kernel.org with ESMTP id <S135776AbRDTBsd>;
	Thu, 19 Apr 2001 21:48:33 -0400
Date: Thu, 19 Apr 2001 20:48:30 -0500 (CDT)
From: He Ding <eric@evl.uic.edu>
To: linux-kernel@vger.kernel.org
cc: eric@evl.uic.edu
Subject: SGI Visual Workstation support?
Message-ID: <Pine.SGI.3.95.1010419204616.1082257A-100000@clark.evl.uic.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I tried to compile kernel 2.4.3. with SGI Visual Workstation support
selected.

I got the error as follows:

ld -m elf_i386 -T /usr/src/linux/arch/i386/vmlinux.lds -e stext
arch/i386/kernel/head.o arch/i386/kernel/init_task.o init/main.o
init/version.o \
	--start-group \
	arch/i386/kernel/kernel.o arch/i386/mm/mm.o kernel/kernel.o
mm/mm.o fs/fs.o ipc/ipc.o \
	drivers/block/block.o drivers/char/char.o drivers/misc/misc.o
drivers/net/net.o drivers/media/media.o  drivers/char/agp/agp.o
drivers/char/drm/drm.o drivers/ide/idedriver.o drivers/scsi/scsidrv.o
drivers/cdrom/driver.o drivers/sound/sounddrivers.o drivers/pci/driver.o
drivers/pcmcia/pcmcia.o drivers/net/pcmcia/pcmcia_net.o drivers/pnp/pnp.o
drivers/video/video.o drivers/usb/usbdrv.o \
	net/network.o \
	/usr/src/linux/arch/i386/lib/lib.a /usr/src/linux/lib/lib.a
/usr/src/linux/arch/i386/lib/lib.a \
	--end-group \
	-o vmlinux
arch/i386/kernel/kernel.o: In function `enable_irq':
arch/i386/kernel/kernel.o(.text+0x3713): undefined reference to
`irq_vector'
arch/i386/kernel/kernel.o: In function `timer_interrupt':
arch/i386/kernel/kernel.o(.text+0x6947): undefined reference to
`smp_found_config'
arch/i386/kernel/kernel.o: In function `disconnect_bsp_APIC':
arch/i386/kernel/kernel.o(.text+0x8aa2): undefined reference to `pic_mode'
arch/i386/kernel/kernel.o: In function `init_VISWS_APIC_irqs':
arch/i386/kernel/kernel.o(.text+0x9177): undefined reference to
`setup_x86_irq'
arch/i386/kernel/kernel.o: In function `pcibios_fixup_irqs':
arch/i386/kernel/kernel.o(.text.init+0x3002): undefined reference to
`visws_get_PCI_irq_vector'
arch/i386/kernel/kernel.o: In function `do_boot_cpu':
arch/i386/kernel/kernel.o(.text.init+0x3966): undefined reference to
`apic_version'
arch/i386/kernel/kernel.o: In function `smp_boot_cpus':
arch/i386/kernel/kernel.o(.text.init+0x3e7b): undefined reference to
`boot_cpu_id'
arch/i386/kernel/kernel.o(.text.init+0x3eb4): undefined reference to
`smp_found_config'
arch/i386/kernel/kernel.o(.text.init+0x3ec7): undefined reference to
`boot_cpu_id'
arch/i386/kernel/kernel.o(.text.init+0x3ece): undefined reference to
`phys_cpu_present_map'
arch/i386/kernel/kernel.o(.text.init+0x3ef9): undefined reference to
`phys_cpu_present_map'
arch/i386/kernel/kernel.o(.text.init+0x3eff): undefined reference to
`boot_cpu_id'
arch/i386/kernel/kernel.o(.text.init+0x3f06): undefined reference to
`apic_version'
arch/i386/kernel/kernel.o(.text.init+0x3f2e): undefined reference to
`phys_cpu_present_map'
arch/i386/kernel/kernel.o(.text.init+0x3f62): undefined reference to
`smp_found_config'
arch/i386/kernel/kernel.o(.text.init+0x3f76): undefined reference to
`phys_cpu_present_map'
arch/i386/kernel/kernel.o(.text.init+0x3fb7): undefined reference to
`boot_cpu_id'
arch/i386/kernel/kernel.o(.text.init+0x3fd7): undefined reference to
`phys_cpu_present_map'
arch/i386/kernel/kernel.o(.text.init+0x3ff2): undefined reference to
`boot_cpu_id'
arch/i386/kernel/kernel.o(.text.init+0x4003): undefined reference to
`phys_cpu_present_map'
arch/i386/kernel/kernel.o(.text.init+0x4037): undefined reference to
`phys_cpu_present_map'
arch/i386/kernel/kernel.o: In function `connect_bsp_APIC':
arch/i386/kernel/kernel.o(.text.init+0x4162): undefined reference to
`pic_mode'
arch/i386/kernel/kernel.o: In function `setup_local_APIC':
arch/i386/kernel/kernel.o(.text.init+0x42a3): undefined reference to
`phys_cpu_present_map'
arch/i386/kernel/kernel.o(.text.init+0x432d): undefined reference to
`pic_mode'
arch/i386/kernel/kernel.o: In function `init_apic_mappings':
arch/i386/kernel/kernel.o(.text.init+0x43fb): undefined reference to
`smp_found_config'
arch/i386/kernel/kernel.o(.text.init+0x4404): undefined reference to
`mp_lapic_addr'
arch/i386/kernel/kernel.o(.text.init+0x4451): undefined reference to
`boot_cpu_id'
arch/i386/kernel/kernel.o(.text.init+0x4464): undefined reference to
`boot_cpu_id'
drivers/pci/driver.o: In function `pci_fixup_device':
drivers/pci/driver.o(.text+0x11a7): undefined reference to
`pcibios_fixups'
make: *** [vmlinux] Error 1


Eric He 
PhD candidate
Electronic Visualization Laboratory
University of Illinois at Chicago 
(312) 996-3002



