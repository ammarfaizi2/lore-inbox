Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287208AbSALRkF>; Sat, 12 Jan 2002 12:40:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287204AbSALRj5>; Sat, 12 Jan 2002 12:39:57 -0500
Received: from smtp012.mail.yahoo.com ([216.136.173.32]:23557 "HELO
	smtp012.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S287208AbSALRjo>; Sat, 12 Jan 2002 12:39:44 -0500
Subject: 2.5.2-pre11 fails to build
From: Michael Gruner <stockraser@yahoo.de>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1010856988.4928.0.camel@highflyer>
Mime-Version: 1.0
X-Mailer: Evolution/1.0 (Preview Release)
Date: 12 Jan 2002 18:38:24 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hello,

trying to run a make bzImage for the 2.5.2-pre11 shows me the following
failure:

ld -m elf_i386 -T /usr/src/linux-2.5.2-pre11/arch/i386/vmlinux.lds -e
stext arch/i386/kernel/head.o arch/i386/kernel/init_task.o init/main.o
init/version.o init/do_mounts.o \
	--start-group \
	arch/i386/kernel/kernel.o arch/i386/mm/mm.o kernel/kernel.o mm/mm.o
fs/fs.o ipc/ipc.o \
	 drivers/char/char.o drivers/block/block.o drivers/misc/misc.o
drivers/net/net.o drivers/media/media.o drivers/cdrom/driver.o
drivers/video/video.o \
	net/network.o \
	/usr/src/linux-2.5.2-pre11/arch/i386/lib/lib.a
/usr/src/linux-2.5.2-pre11/lib/lib.a
/usr/src/linux-2.5.2-pre11/arch/i386/lib/lib.a \
	--end-group \
	-o vmlinux
init/main.o: In function `start_kernel':
init/main.o(.text.init+0x62e): undefined reference to `proc_root_init'
init/main.o: In function `do_basic_setup':
init/main.o(.text.init+0x694): undefined reference to `pci_init'
arch/i386/kernel/kernel.o: In function `register_irq_proc':
arch/i386/kernel/kernel.o(.text+0x3223): undefined reference to
`proc_mkdir'
arch/i386/kernel/kernel.o: In function `init_irq_proc':
arch/i386/kernel/kernel.o(.text+0x3241): undefined reference to
`proc_mkdir'
arch/i386/kernel/kernel.o(.text+0x3256): undefined reference to
`create_proc_entry'
arch/i386/kernel/kernel.o: In function `pcibios_update_resource':
arch/i386/kernel/kernel.o(.text+0x6bf6): undefined reference to
`pci_write_config_dword'
arch/i386/kernel/kernel.o(.text+0x6c02): undefined reference to
`pci_read_config_dword'
arch/i386/kernel/kernel.o: In function `pcibios_enable_resources':
arch/i386/kernel/kernel.o(.text+0x6c7a): undefined reference to
`pci_read_config_word'
arch/i386/kernel/kernel.o(.text+0x6d11): undefined reference to
`pci_write_config_word'
arch/i386/kernel/kernel.o: In function `pcibios_set_master':
arch/i386/kernel/kernel.o(.text+0x6d31): undefined reference to
`pci_read_config_byte'
arch/i386/kernel/kernel.o(.text+0x6d8b): undefined reference to
`pci_write_config_byte'
arch/i386/kernel/kernel.o: In function `read_config_nybble':
arch/i386/kernel/kernel.o(.text+0x7840): undefined reference to
`pci_read_config_byte'
arch/i386/kernel/kernel.o: In function `write_config_nybble':
arch/i386/kernel/kernel.o(.text+0x7882): undefined reference to
`pci_read_config_byte'
arch/i386/kernel/kernel.o(.text+0x78bb): undefined reference to
`pci_write_config_byte'
arch/i386/kernel/kernel.o: In function `pirq_piix_get':
arch/i386/kernel/kernel.o(.text+0x792b): undefined reference to
`pci_read_config_byte'
arch/i386/kernel/kernel.o: In function `pirq_piix_set':
arch/i386/kernel/kernel.o(.text+0x7959): undefined reference to
`pci_write_config_byte'
arch/i386/kernel/kernel.o: In function `pirq_sis_get':
arch/i386/kernel/kernel.o(.text+0x7a6f): undefined reference to
`pci_read_config_byte'
arch/i386/kernel/kernel.o: In function `pirq_sis_set':
arch/i386/kernel/kernel.o(.text+0x7b4c): undefined reference to
`pci_write_config_byte'
arch/i386/kernel/kernel.o: In function `pirq_bios_set':
arch/i386/kernel/kernel.o(.text+0x7c9b): undefined reference to
`pci_get_interrupt_pin'
arch/i386/kernel/kernel.o: In function `pcibios_lookup_irq':
arch/i386/kernel/kernel.o(.text+0x7d46): undefined reference to
`pci_read_config_byte'
arch/i386/kernel/kernel.o(.text+0x7eda): undefined reference to
`pci_devices'
arch/i386/kernel/kernel.o(.text+0x7ee3): undefined reference to
`pci_devices'
arch/i386/kernel/kernel.o(.text+0x7ef8): undefined reference to
`pci_read_config_byte'
arch/i386/kernel/kernel.o(.text+0x7f78): undefined reference to
`pci_devices'
arch/i386/kernel/kernel.o: In function `pcibios_enable_irq':
arch/i386/kernel/kernel.o(.text+0x7fb5): undefined reference to
`pci_read_config_byte'
arch/i386/kernel/kernel.o: In function `have_wrcomb':
arch/i386/kernel/kernel.o(.text+0x815c): undefined reference to
`pci_find_class'
arch/i386/kernel/kernel.o: In function `init_cyrix':
arch/i386/kernel/kernel.o(.text.init+0x179d): undefined reference to
`isa_dma_bridge_buggy'
arch/i386/kernel/kernel.o: In function `pcibios_allocate_bus_resources':
arch/i386/kernel/kernel.o(.text.init+0x30e9): undefined reference to
`pci_find_parent_resource'
arch/i386/kernel/kernel.o: In function `pcibios_allocate_resources':
arch/i386/kernel/kernel.o(.text.init+0x3149): undefined reference to
`pci_devices'
arch/i386/kernel/kernel.o(.text.init+0x314f): undefined reference to
`pci_devices'
arch/i386/kernel/kernel.o(.text.init+0x3169): undefined reference to
`pci_read_config_word'
arch/i386/kernel/kernel.o(.text.init+0x31a4): undefined reference to
`pci_find_parent_resource'
arch/i386/kernel/kernel.o(.text.init+0x320a): undefined reference to
`pci_read_config_dword'
arch/i386/kernel/kernel.o(.text.init+0x321c): undefined reference to
`pci_write_config_dword'
arch/i386/kernel/kernel.o(.text.init+0x3227): undefined reference to
`pci_devices'
arch/i386/kernel/kernel.o: In function `pcibios_assign_resources':
arch/i386/kernel/kernel.o(.text.init+0x323d): undefined reference to
`pci_devices'
arch/i386/kernel/kernel.o(.text.init+0x3244): undefined reference to
`pci_devices'
arch/i386/kernel/kernel.o(.text.init+0x329a): undefined reference to
`pci_assign_resource'
arch/i386/kernel/kernel.o(.text.init+0x32db): undefined reference to
`pci_assign_resource'
arch/i386/kernel/kernel.o(.text.init+0x32e6): undefined reference to
`pci_devices'
arch/i386/kernel/kernel.o: In function `pcibios_resource_survey':
arch/i386/kernel/kernel.o(.text.init+0x32f9): undefined reference to
`pci_root_buses'
arch/i386/kernel/kernel.o: In function `pcibios_sort':
arch/i386/kernel/kernel.o(.text.init+0x36ab): undefined reference to
`pci_devices'
arch/i386/kernel/kernel.o(.text.init+0x36af): undefined reference to
`pci_devices'
arch/i386/kernel/kernel.o(.text.init+0x36d2): undefined reference to
`pci_devices'
arch/i386/kernel/kernel.o(.text.init+0x36e4): undefined reference to
`pci_devices'
arch/i386/kernel/kernel.o(.text.init+0x36f7): undefined reference to
`pci_devices'
arch/i386/kernel/kernel.o(.text.init+0x37b2): more undefined references
to `pci_devices' follow
arch/i386/kernel/kernel.o: In function `pcibios_fixup_peer_bridges':
arch/i386/kernel/kernel.o(.text.init+0x3a18): undefined reference to
`pci_root_buses'
arch/i386/kernel/kernel.o(.text.init+0x3a1d): undefined reference to
`pci_bus_exists'
arch/i386/kernel/kernel.o(.text.init+0x3a6f): undefined reference to
`pci_read_config_word'
arch/i386/kernel/kernel.o(.text.init+0x3a9f): undefined reference to
`pci_scan_bus'
arch/i386/kernel/kernel.o: In function `pci_fixup_i450nx':
arch/i386/kernel/kernel.o(.text.init+0x3b08): undefined reference to
`pci_read_config_byte'
arch/i386/kernel/kernel.o(.text.init+0x3b16): undefined reference to
`pci_read_config_byte'
arch/i386/kernel/kernel.o(.text.init+0x3b1f): undefined reference to
`pci_read_config_byte'
arch/i386/kernel/kernel.o(.text.init+0x3b3c): undefined reference to
`pci_scan_bus'
arch/i386/kernel/kernel.o(.text.init+0x3b5d): undefined reference to
`pci_scan_bus'
arch/i386/kernel/kernel.o: In function `pci_fixup_i450gx':
arch/i386/kernel/kernel.o(.text.init+0x3b8d): undefined reference to
`pci_read_config_byte'
arch/i386/kernel/kernel.o(.text.init+0x3bb7): undefined reference to
`pci_scan_bus'
arch/i386/kernel/kernel.o: In function `pci_fixup_via_northbridge_bug':
arch/i386/kernel/kernel.o(.text.init+0x3cac): undefined reference to
`pci_read_config_byte'
arch/i386/kernel/kernel.o(.text.init+0x3cd2): undefined reference to
`pci_write_config_byte'
arch/i386/kernel/kernel.o: In function `pcibios_fixup_bus':
arch/i386/kernel/kernel.o(.text.init+0x3ced): undefined reference to
`pci_read_bridge_bases'
arch/i386/kernel/kernel.o: In function `pcibios_init':
arch/i386/kernel/kernel.o(.text.init+0x3db6): undefined reference to
`pci_scan_bus'
arch/i386/kernel/kernel.o: In function `pirq_peer_trick':
arch/i386/kernel/kernel.o(.text.init+0x40d3): undefined reference to
`pci_scan_bus'
arch/i386/kernel/kernel.o: In function `pirq_find_router':
arch/i386/kernel/kernel.o(.text.init+0x4149): undefined reference to
`pci_find_slot'
arch/i386/kernel/kernel.o: In function `pcibios_fixup_irqs':
arch/i386/kernel/kernel.o(.text.init+0x4232): undefined reference to
`pci_devices'
arch/i386/kernel/kernel.o(.text.init+0x4238): undefined reference to
`pci_devices'
arch/i386/kernel/kernel.o(.text.init+0x4279): undefined reference to
`pci_devices'
arch/i386/kernel/kernel.o(.text.init+0x4281): undefined reference to
`pci_devices'
arch/i386/kernel/kernel.o(.text.init+0x4287): undefined reference to
`pci_devices'
arch/i386/kernel/kernel.o(.text.init+0x4299): undefined reference to
`pci_read_config_byte'
arch/i386/kernel/kernel.o(.text.init+0x42bc): undefined reference to
`pci_devices'
arch/i386/kernel/kernel.o: In function `mtrr_init':
arch/i386/kernel/kernel.o(.text.init+0x4721): undefined reference to
`proc_root'
arch/i386/kernel/kernel.o(.text.init+0x4730): undefined reference to
`create_proc_entry'
arch/i386/kernel/kernel.o: In function `sys_call_table':
arch/i386/kernel/kernel.o(.data+0x2fc): undefined reference to
`sys_nfsservctl'
kernel/kernel.o: In function `register_sysctl_table':
kernel/kernel.o(.text+0x7538): undefined reference to `proc_sys_root'
kernel/kernel.o: In function `unregister_sysctl_table':
kernel/kernel.o(.text+0x755d): undefined reference to `proc_sys_root'
kernel/kernel.o: In function `register_proc_table':
kernel/kernel.o(.text+0x7620): undefined reference to `proc_match'
kernel/kernel.o(.text+0x763d): undefined reference to
`create_proc_entry'
kernel/kernel.o: In function `unregister_proc_table':
kernel/kernel.o(.text+0x76e7): undefined reference to
`remove_proc_entry'
kernel/kernel.o: In function `sysctl_init':
kernel/kernel.o(.text.init+0x621): undefined reference to
`proc_sys_root'
kernel/kernel.o(.data+0x88c): undefined reference to `sg_big_buff'
fs/fs.o: In function `mnt_init':
fs/fs.o(.text.init+0x972): undefined reference to `init_rootfs'
fs/fs.o(.data+0x8f4): undefined reference to `msdos_partition'
ipc/ipc.o: In function `msg_init':
ipc/ipc.o(.text.init+0xdd): undefined reference to `create_proc_entry'
ipc/ipc.o: In function `sem_init':
ipc/ipc.o(.text.init+0x11f): undefined reference to `create_proc_entry'
ipc/ipc.o: In function `shm_init':
ipc/ipc.o(.text.init+0x155): undefined reference to `create_proc_entry'
drivers/char/char.o: In function `tty_open':
drivers/char/char.o(.text+0x1e15): undefined reference to
`devpts_pty_new'
drivers/char/char.o: In function `tty_register_driver':
drivers/char/char.o(.text+0x2f45): undefined reference to
`proc_tty_register_driver'
drivers/char/char.o: In function `tty_unregister_driver':
drivers/char/char.o(.text+0x307f): undefined reference to
`proc_tty_unregister_driver'
drivers/char/char.o: In function `pty_close':
drivers/char/char.o(.text+0x66c6): undefined reference to
`devpts_pty_kill'
drivers/char/char.o: In function `misc_init':
drivers/char/char.o(.text.init+0x73a): undefined reference to
`create_proc_entry'
drivers/block/block.o: In function `blk_dev_init':
drivers/block/block.o(.text.init+0xdd): undefined reference to
`ide_init'
net/network.o: In function `net_dev_init':
net/network.o(.text.init+0x382): undefined reference to `proc_net'
net/network.o(.text.init+0x38f): undefined reference to
`create_proc_entry'
net/network.o(.text.init+0x3ab): undefined reference to
`create_proc_entry'
net/network.o: In function `dev_mcast_init':
net/network.o(.text.init+0x41a): undefined reference to
`create_proc_entry'
net/network.o: In function `ip_rt_init':
net/network.o(.text.init+0x5cf): undefined reference to `proc_net'
net/network.o(.text.init+0x5df): undefined reference to
`create_proc_entry'
net/network.o(.text.init+0x5f2): undefined reference to `proc_net'
net/network.o(.text.init+0x5ff): undefined reference to
`create_proc_entry'
net/network.o: In function `arp_init':
net/network.o(.text.init+0xa85): undefined reference to `proc_net'
net/network.o(.text.init+0xa95): undefined reference to
`create_proc_entry'
net/network.o: In function `inet_init':
net/network.o(.text.init+0xcb8): undefined reference to `proc_net'
net/network.o(.text.init+0xcc8): undefined reference to
`create_proc_entry'
net/network.o(.text.init+0xcdb): undefined reference to `proc_net'
net/network.o(.text.init+0xce8): undefined reference to
`create_proc_entry'
net/network.o(.text.init+0xcfb): undefined reference to `proc_net'
net/network.o(.text.init+0xd08): undefined reference to
`create_proc_entry'
net/network.o(.text.init+0xd1b): undefined reference to `proc_net'
net/network.o(.text.init+0xd28): undefined reference to
`create_proc_entry'
net/network.o(.text.init+0xd3b): undefined reference to `proc_net'
net/network.o(.text.init+0xd48): undefined reference to
`create_proc_entry'
net/network.o(.text.init+0xd5b): undefined reference to `proc_net'
net/network.o(.text.init+0xd68): undefined reference to
`create_proc_entry'
net/network.o: In function `ip_fib_init':
net/network.o(.text.init+0xd81): undefined reference to `proc_net'
net/network.o(.text.init+0xd8e): undefined reference to
`create_proc_entry'
net/network.o: In function `af_unix_init':
net/network.o(.text.init+0xe94): undefined reference to
`create_proc_entry'
net/network.o: In function `netlink_proto_init':
net/network.o(.text.init+0xecf): undefined reference to
`create_proc_entry'
net/network.o: In function `packet_init':
net/network.o(.text.init+0xf0d): undefined reference to
`create_proc_entry'
make: *** [vmlinux] Error 1

Unfortunatly i just don't have any experiences in hacking the kernel,
but i'll try to learn. Who can help me to build that thing?

thanks
micha





_________________________________________________________
Do You Yahoo!?
Get your free @yahoo.com address at http://mail.yahoo.com

