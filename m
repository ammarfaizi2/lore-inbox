Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271997AbTGYJqn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jul 2003 05:46:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271998AbTGYJqn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jul 2003 05:46:43 -0400
Received: from dsl-200-55-80-165.prima.net.ar ([200.55.80.165]:3200 "EHLO
	runner.matiu.com.ar") by vger.kernel.org with ESMTP id S271997AbTGYJqh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jul 2003 05:46:37 -0400
Subject: Crash when inserting a PCMCIA CF card
From: Matias Alejo Garcia <linux@matiu.com.ar>
To: Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1059130704.1379.7.camel@runner>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 25 Jul 2003 06:58:25 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
When I insert a SanDisk o Ridata CompactFlash card to the PCMCIA adapter
(this used to work OK in 2.4.20), the load of the module ide-cs dumps a
Call Trace, then, if I eject the CF card, the system crash. (see below)

Is there a patch for this? I am sure the problem is in ide-cs, others
pcmcia cards are working OK.

Thanks. Matias
Logs:(starting when I load cardctl and ds/yenta_socket/pcmcia_core,
the problem is at 6:33:13, when I insert the CF card)


Jul 25 06:32:57 runner kernel: Linux Kernel Card Services 3.1.22
Jul 25 06:32:57 runner kernel:   options:  [pci] [cardbus] [pm]
Jul 25 06:32:57 runner kernel: PCI: Found IRQ 11 for device 0000:02:01.0
Jul 25 06:32:57 runner kernel: PCI: Sharing IRQ 11 with 0000:02:01.1
Jul 25 06:32:57 runner kernel: PCI: Sharing IRQ 11 with 0000:02:01.2
Jul 25 06:32:57 runner kernel: Yenta IRQ list 06f8, PCI irq11
Jul 25 06:32:57 runner kernel: Socket status: 30000006
Jul 25 06:32:57 runner kernel: PCI: Found IRQ 11 for device 0000:02:01.1
Jul 25 06:32:57 runner kernel: PCI: Sharing IRQ 11 with 0000:02:01.0
Jul 25 06:32:57 runner kernel: PCI: Sharing IRQ 11 with 0000:02:01.2
Jul 25 06:32:57 runner /sbin/hotplug: no runnable
/etc/hotplug/pcmcia_socket.agent is installed
Jul 25 06:32:57 runner kernel: Yenta IRQ list 06f8, PCI irq11
Jul 25 06:32:57 runner kernel: Socket status: 30000006
Jul 25 06:32:57 runner /sbin/hotplug: no runnable
/etc/hotplug/pcmcia_socket.agent is installed
Jul 25 06:32:58 runner cardmgr[679]: starting, version is 3.1.31
Jul 25 06:32:58 runner cardmgr[679]: watching 2 sockets
Jul 25 06:32:58 runner cardmgr[679]: Card Services release does not
match
Jul 25 06:32:58 runner kernel: cs: IO port probe 0x0c00-0x0cff: clean.
Jul 25 06:32:58 runner kernel: cs: IO port probe 0x0100-0x04ff:
excluding 0x280-0x287 0x2f8-0x2ff 0x378-0x37f 0x3c0-0x3df 0x3f8-0x3ff
0x4d0-0x4d7
Jul 25 06:32:58 runner kernel: cs: IO port probe 0x0a00-0x0aff: clean.
Jul 25 06:33:13 runner cardmgr[679]: socket 1: ATA/IDE Fixed Disk
Jul 25 06:33:13 runner kernel: cs: memory probe 0xa0000000-0xa0ffffff:
clean.
Jul 25 06:33:14 runner cardmgr[679]: executing: 'modprobe ide-cs'
Jul 25 06:33:16 runner /sbin/hotplug: no runnable /etc/hotplug/ide.agent
is installed
Jul 25 06:33:16 runner kernel: hdc: SanDisk SDCFB-32, CFA DISK drive
Jul 25 06:33:16 runner kernel: ide1 at 0x100-0x107,0x10e on irq 3
Jul 25 06:33:16 runner kernel: hdc: max request size: 128KiB
Jul 25 06:33:16 runner kernel: hdc: task_no_data_intr: status=0x51 {
DriveReady SeekComplete Error }
Jul 25 06:33:16 runner kernel: hdc: task_no_data_intr: error=0x04 {
DriveStatusError }
Jul 25 06:33:16 runner /sbin/hotplug: no runnable
/etc/hotplug/block.agent is installed
Jul 25 06:33:16 runner kernel: hdc: 62720 sectors (32 MB) w/1KiB Cache,
CHS=490/4/32
Jul 25 06:33:16 runner kernel:  hdc: hdc1
Jul 25 06:33:17 runner kernel:  hdc: hdc1
Jul 25 06:33:17 runner kernel: kobject_register failed for hdc1 (-17)
Jul 25 06:33:17 runner kernel: Call Trace:
Jul 25 06:33:17 runner kernel:  [<c01ee01a>] kobject_register+0x50/0x5a
Jul 25 06:33:17 runner kernel:  [<c018a5d2>] register_disk+0x136/0x13e
Jul 25 06:33:17 runner kernel:  [<c023a960>] add_disk+0x4e/0x5e
Jul 25 06:33:17 runner cardmgr[679]: executing: './ide start hdc'
Jul 25 06:33:17 runner /sbin/hotplug: no runnable
/etc/hotplug/block.agent is installed
Jul 25 06:33:17 runner kernel:  [<c023a8ec>] exact_match+0x0/0x8
Jul 25 06:33:17 runner kernel:  [<c023a8f4>] exact_lock+0x0/0x1e
Jul 25 06:33:17 runner kernel:  [<c0255362>] idedisk_attach+0x12c/0x1ac
Jul 25 06:33:17 runner kernel:  [<c0250c76>] ata_attach+0x96/0x1b2
Jul 25 06:33:17 runner kernel:  [<c024a777>] ideprobe_init+0xdf/0xfb
Jul 25 06:33:17 runner kernel:  [<c024f201>] ide_probe_module+0xd/0x10
Jul 25 06:33:17 runner kernel:  [<c024feda>] ide_register_hw+0x154/0x186
Jul 25 06:33:17 runner kernel:  [<e0902260>] idecs_register+0x5e/0x70
[ide_cs]
Jul 25 06:33:17 runner kernel:  [<e093aace>] CardServices+0x208/0x351
[pcmcia_core]
Jul 25 06:33:17 runner kernel:  [<e09330b4>] set_cis_map+0x40/0x10c
[pcmcia_core]
Jul 25 06:33:17 runner kernel:  [<e090277e>] ide_config+0x50c/0x854
[ide_cs]
Jul 25 06:33:17 runner kernel:  [<e09332a1>] read_cis_mem+0x121/0x18c
[pcmcia_core]
Jul 25 06:33:17 runner kernel:  [<e09330b4>] set_cis_map+0x40/0x10c
[pcmcia_core]
Jul 25 06:33:17 runner kernel:  [<e09332a1>] read_cis_mem+0x121/0x18c
[pcmcia_core]
Jul 25 06:33:17 runner kernel:  [<e0933545>] read_cis_cache+0xdf/0x16a
[pcmcia_core]
Jul 25 06:33:17 runner kernel:  [<e0933e45>]
pcmcia_get_tuple_data+0x91/0x96 [pcmcia_core]
Jul 25 06:33:17 runner kernel:  [<e0935065>]
pcmcia_parse_tuple+0x109/0x16e [pcmcia_core]
Jul 25 06:33:17 runner kernel:  [<e093516c>] read_tuple+0xa2/0xa4
[pcmcia_core]
Jul 25 06:33:17 runner kernel:  [<e08f27ba>]
yenta_set_mem_map+0x1e0/0x232 [yenta_socket]
Jul 25 06:33:17 runner kernel:  [<e08f27ba>]
yenta_set_mem_map+0x1e0/0x232 [yenta_socket]
Jul 25 06:33:17 runner kernel:  [<e0933d63>]
pcmcia_get_next_tuple+0x231/0x282 [pcmcia_core]
Jul 25 06:33:17 runner kernel:  [<e09338b4>]
pcmcia_get_first_tuple+0xa0/0x138 [pcmcia_core]
Jul 25 06:33:17 runner kernel:  [<c022c559>] scrup+0x12f/0x13a
Jul 25 06:33:17 runner kernel:  [<e08f27ba>]
yenta_set_mem_map+0x1e0/0x232 [yenta_socket]
Jul 25 06:33:17 runner kernel:  [<c0231398>]
poke_blanked_console+0x5c/0x76
Jul 25 06:33:17 runner kernel:  [<c0230737>]
vt_console_print+0x213/0x302
Jul 25 06:33:17 runner kernel:  [<e08f27ba>]
yenta_set_mem_map+0x1e0/0x232 [yenta_socket]
Jul 25 06:33:17 runner kernel:  [<e09330b4>] set_cis_map+0x40/0x10c
[pcmcia_core]
Jul 25 06:33:17 runner kernel:  [<e09332a1>] read_cis_mem+0x121/0x18c
[pcmcia_core]
Jul 25 06:33:17 runner kernel:  [<e09332a1>] read_cis_mem+0x121/0x18c
[pcmcia_core]
Jul 25 06:33:17 runner kernel:  [<e0933545>] read_cis_cache+0xdf/0x16a
[pcmcia_core]
Jul 25 06:33:17 runner kernel:  [<e0933e45>]
pcmcia_get_tuple_data+0x91/0x96 [pcmcia_core]
Jul 25 06:33:17 runner kernel:  [<e0935065>]
pcmcia_parse_tuple+0x109/0x16e [pcmcia_core]
Jul 25 06:33:17 runner kernel:  [<e093516c>] read_tuple+0xa2/0xa4
[pcmcia_core]
Jul 25 06:33:17 runner kernel:  [<e08f27ba>]
yenta_set_mem_map+0x1e0/0x232 [yenta_socket]
Jul 25 06:33:17 runner kernel:  [<e08f27ba>]
yenta_set_mem_map+0x1e0/0x232 [yenta_socket]
Jul 25 06:33:17 runner kernel:  [<e0933d63>]
pcmcia_get_next_tuple+0x231/0x282 [pcmcia_core]
Jul 25 06:33:17 runner kernel:  [<e09338b4>]
pcmcia_get_first_tuple+0xa0/0x138 [pcmcia_core]
Jul 25 06:33:17 runner kernel:  [<e0933545>] read_cis_cache+0xdf/0x16a
[pcmcia_core]
Jul 25 06:33:17 runner kernel:  [<e0933d63>]
pcmcia_get_next_tuple+0x231/0x282 [pcmcia_core]
Jul 25 06:33:17 runner kernel:  [<e093528c>]
pcmcia_validate_cis+0x11e/0x1ea [pcmcia_core]
Jul 25 06:33:17 runner kernel:  [<c0159fc3>] wake_up_buffer+0xf/0x26
Jul 25 06:33:17 runner kernel:  [<c019f1cb>]
do_get_write_access+0x2cb/0x5e8
Jul 25 06:33:17 runner kernel:  [<e0902c55>] ide_event+0x67/0xea
[ide_cs]
Jul 25 06:33:17 runner kernel:  [<e0939676>]
pcmcia_register_client+0x1c8/0x1fe [pcmcia_core]
Jul 25 06:33:17 runner kernel:  [<c0193d5e>]
ext3_mark_iloc_dirty+0x28/0x36
Jul 25 06:33:17 runner kernel:  [<e08f27ba>]
yenta_set_mem_map+0x1e0/0x232 [yenta_socket]
Jul 25 06:33:17 runner kernel:  [<c0190d19>]
ext3_splice_branch+0x123/0x1da
Jul 25 06:33:17 runner kernel:  [<e093aa67>] CardServices+0x1a1/0x351
[pcmcia_core]
Jul 25 06:33:17 runner kernel:  [<e0902110>] ide_attach+0x110/0x150
[ide_cs]
Jul 25 06:33:17 runner kernel:  [<e0902bee>] ide_event+0x0/0xea [ide_cs]
Jul 25 06:33:17 runner kernel:  [<e08fe3bf>] get_pcmcia_driver+0x3f/0x5a
[ds]
Jul 25 06:33:17 runner kernel:  [<e08fd4b0>] bind_request+0x180/0x214
[ds]
Jul 25 06:33:17 runner kernel:  [<e08fe069>] ds_ioctl+0x5eb/0x6ec [ds]
Jul 25 06:33:17 runner kernel:  [<c029f95a>] sock_def_readable+0x82/0x84
Jul 25 06:33:17 runner kernel:  [<c0303be9>]
unix_dgram_sendmsg+0x36b/0x56c
Jul 25 06:33:17 runner kernel:  [<c029c39a>] sock_sendmsg+0x9e/0xca
Jul 25 06:33:17 runner kernel:  [<c0170d18>] alloc_inode+0x1c/0x148
Jul 25 06:33:17 runner kernel:  [<c0171cde>] iget_locked+0x96/0xc0
Jul 25 06:33:17 runner kernel:  [<c01840b9>] proc_read_inode+0x17/0x3c
Jul 25 06:33:17 runner kernel:  [<c013d531>] find_get_page+0x29/0x64
Jul 25 06:33:17 runner kernel:  [<c013e8d6>] filemap_nopage+0x26c/0x384
Jul 25 06:33:17 runner kernel:  [<c014125f>] __rmqueue+0xcb/0x11c
Jul 25 06:33:17 runner kernel:  [<c0141671>] buffered_rmqueue+0xd1/0x192
Jul 25 06:33:17 runner kernel:  [<c0141671>] buffered_rmqueue+0xd1/0x192
Jul 25 06:33:17 runner kernel:  [<c0149762>] zap_pmd_range+0x48/0x64
Jul 25 06:33:17 runner kernel:  [<c01497c7>] unmap_page_range+0x49/0x88
Jul 25 06:33:17 runner kernel:  [<c01498c8>] unmap_vmas+0xc2/0x22e
Jul 25 06:33:17 runner kernel:  [<c014d2d1>] unmap_region+0x9b/0xde
Jul 25 06:33:17 runner kernel:  [<c014d1d0>] unmap_vma+0x40/0x7e
Jul 25 06:33:17 runner kernel:  [<c014d22a>] unmap_vma_list+0x1c/0x28
Jul 25 06:33:17 runner kernel:  [<c014d600>] do_munmap+0x166/0x1ce
Jul 25 06:33:17 runner kernel:  [<c016a6d1>] sys_ioctl+0xf3/0x27a
Jul 25 06:33:17 runner kernel:  [<c010b22b>] syscall_call+0x7/0xb
Jul 25 06:33:17 runner kernel:
Jul 25 06:33:17 runner kernel: Module ide_cs cannot be unloaded due to
unsafe usage in include/linux/module.h:482
Jul 25 06:33:17 runner kernel: ide-cs: hdc: Vcc = 3.3, Vpp = 0.0
Jul 25 06:33:17 runner kernel: updfstab: numerical sysctl 1 23 is
obsolete.


