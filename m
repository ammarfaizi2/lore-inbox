Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274963AbTHFJgG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 05:36:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274987AbTHFJgG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 05:36:06 -0400
Received: from mail.cybertrails.com ([162.42.150.35]:40967 "EHLO
	mail1.cybertrails.com") by vger.kernel.org with ESMTP
	id S274963AbTHFJfg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 05:35:36 -0400
Date: Wed, 6 Aug 2003 02:35:31 -0700
From: Paul Dickson <dickson@permanentmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: My report on running 2.6.0-test2 on a Dell Inspiron 7000 (PII,
 300MHz with 256MB)
Message-Id: <20030806023531.0c9b1d18.dickson@permanentmail.com>
In-Reply-To: <20030806021621.2da5a850.dickson@permanentmail.com>
References: <20030806021621.2da5a850.dickson@permanentmail.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Aug 2003 02:16:21 -0700, Paul Dickson wrote:

> But all is not perfect.  I'll attach the problems I had as replies (so
> each has it's own message thread).

I have two PC Cards in my notebook.  A network card and CF card (via an
adapter).  When the code was loaded, Kobjects spits out the following stack
dump:

Aug  6 01:22:23 violet kernel: Linux Kernel Card Services 3.1.22
Aug  6 01:22:23 violet kernel:   options:  [pci] [cardbus] [pm]
Aug  6 01:22:23 violet kernel: PCI: Found IRQ 11 for device 0000:00:04.0
Aug  6 01:22:23 violet kernel: PCI: Sharing IRQ 11 with 0000:01:00.0
Aug  6 01:22:23 violet kernel: Yenta IRQ list 0698, PCI irq11
Aug  6 01:22:23 violet kernel: Socket status: 30000020
Aug  6 01:22:23 violet kernel: PCI: Found IRQ 11 for device 0000:00:04.1
Aug  6 01:22:23 violet kernel: Yenta IRQ list 0698, PCI irq11
Aug  6 01:22:23 violet kernel: Socket status: 30000010
Aug  6 01:22:23 violet kernel: PCI: Enabling device 0000:02:00.0 (0000 -> 0003)
Aug  6 01:22:23 violet kernel: 3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
Aug  6 01:22:23 violet kernel: 0000:02:00.0: 3Com PCI 3CCFE575BT Cyclone CardBus at 0x1000. Vers LK1.1.19
Aug  6 01:22:23 violet kernel: cs: IO port probe 0x0c00-0x0cff: clean.
Aug  6 01:22:23 violet kernel: cs: IO port probe 0x0100-0x04ff: excluding 0x3c0-0x3df 0x3f8-0x3ff 0x4d0-0x4d7
Aug  6 01:22:23 violet kernel: cs: IO port probe 0x0a00-0x0aff: clean.
Aug  6 01:22:23 violet gpm: gpm startup succeeded
Aug  6 01:22:23 violet kernel: cs: memory probe 0xa0000000-0xa0ffffff: clean.
Aug  6 01:22:23 violet kernel: hde: LEXAR ATA_FLASH, CFA DISK drive
Aug  6 01:22:23 violet kernel: hdf: probing with STATUS(0xc0) instead of ALTSTATUS(0x0a)
Aug  6 01:22:23 violet kernel: hdf: probing with STATUS(0xc0) instead of ALTSTATUS(0x0a)
Aug  6 01:22:23 violet kernel: ide2 at 0x100-0x107,0x10e on irq 3
Aug  6 01:22:23 violet kernel: hde: max request size: 128KiB
Aug  6 01:22:23 violet kernel: hde: task_no_data_intr: status=0x51 { DriveReady SeekComplete Error }
Aug  6 01:22:23 violet kernel: hde: task_no_data_intr: error=0x04 { DriveStatusError }
Aug  6 01:22:23 violet kernel: hde: 62976 sectors (32 MB) w/1KiB Cache, CHS=984/2/32
Aug  6 01:22:23 violet kernel:  hde: hde1
Aug  6 01:22:23 violet kernel:  hde: hde1
Aug  6 01:22:23 violet kernel: kobject_register failed for hde1 (-17)
Aug  6 01:22:24 violet kernel: Call Trace:
Aug  6 01:22:24 violet kernel:  [<c02352ee>] kobject_register+0x4e/0x60
Aug  6 01:22:24 violet kernel:  [<c0187359>] register_disk+0x139/0x150
Aug  6 01:22:24 violet kernel:  [<c026af01>] add_disk+0x51/0x60
Aug  6 01:22:24 violet kernel:  [<c026ae80>] exact_match+0x0/0x10
Aug  6 01:22:24 violet kernel:  [<c026ae90>] exact_lock+0x0/0x20
Aug  6 01:22:24 violet kernel:  [<c028bbe8>] idedisk_attach+0x128/0x1b0
Aug  6 01:22:24 violet kernel:  [<c02873c1>] ata_attach+0xa1/0x1c0
Aug  6 01:22:24 violet kernel:  [<c028077e>] ideprobe_init+0xfe/0x11d
Aug  6 01:22:24 violet kernel:  [<c0285713>] ide_probe_module+0x13/0x20
Aug  6 01:22:24 violet kernel:  [<c028653e>] ide_register_hw+0x16e/0x1a0
Aug  6 01:22:24 violet kernel:  [<d0970273>] idecs_register+0x63/0x80 [ide_cs]
Aug  6 01:22:24 violet kernel:  [<d098d460>] CardServices+0x210/0x357 [pcmcia_core]
Aug  6 01:22:24 violet kernel:  [<d09707ae>] ide_config+0x51e/0x880 [ide_cs]
Aug  6 01:22:24 violet kernel:  [<d09850be>] set_cis_map+0x3e/0x120 [pcmcia_core]
Aug  6 01:22:24 violet kernel:  [<d0985595>] read_cis_cache+0xe5/0x170 [pcmcia_core]
Aug  6 01:22:24 violet kernel:  [<d0985f6d>] pcmcia_get_tuple_data+0x8d/0xa0 [pcmcia_core]
Aug  6 01:22:24 violet kernel:  [<d098732c>] pcmcia_parse_tuple+0x10c/0x170 [pcmcia_core]
Aug  6 01:22:24 violet kernel:  [<d0987404>] read_tuple+0x74/0x80 [pcmcia_core]
Aug  6 01:22:24 violet kernel:  [<d0985e8e>] pcmcia_get_next_tuple+0x26e/0x2c0 [pcmcia_core]
Aug  6 01:22:24 violet kernel:  [<d0985979>] pcmcia_get_first_tuple+0xa9/0x150 [pcmcia_core]
Aug  6 01:22:24 violet kernel:  [<c0118e55>] remap_area_pages+0x1d5/0x1f0
Aug  6 01:22:24 violet kernel:  [<c014b7c7>] unmap_vm_area+0x47/0x90
Aug  6 01:22:24 violet kernel:  [<d0925813>] yenta_set_mem_map+0x1b3/0x200 [yenta_socket]
Aug  6 01:22:24 violet kernel:  [<d09850be>] set_cis_map+0x3e/0x120 [pcmcia_core]
Aug  6 01:22:24 violet kernel:  [<d09850be>] set_cis_map+0x3e/0x120 [pcmcia_core]
Aug  6 01:22:24 violet kernel:  [<d0985595>] read_cis_cache+0xe5/0x170 [pcmcia_core]
Aug  6 01:22:24 violet kernel:  [<d0985f6d>] pcmcia_get_tuple_data+0x8d/0xa0 [pcmcia_core]
Aug  6 01:22:24 violet kernel:  [<d098732c>] pcmcia_parse_tuple+0x10c/0x170 [pcmcia_core]
Aug  6 01:22:24 violet kernel:  [<d0987404>] read_tuple+0x74/0x80 [pcmcia_core]
Aug  6 01:22:24 violet kernel:  [<d0985e8e>] pcmcia_get_next_tuple+0x26e/0x2c0 [pcmcia_core]
Aug  6 01:22:24 violet kernel:  [<d0985979>] pcmcia_get_first_tuple+0xa9/0x150 [pcmcia_core]
Aug  6 01:22:24 violet kernel:  [<d0985595>] read_cis_cache+0xe5/0x170 [pcmcia_core]
Aug  6 01:22:24 violet kernel:  [<d0985e8e>] pcmcia_get_next_tuple+0x26e/0x2c0 [pcmcia_core]
Aug  6 01:22:24 violet kernel:  [<d098750f>] pcmcia_validate_cis+0xff/0x1e0 [pcmcia_core]
Aug  6 01:22:24 violet kernel:  [<c0125466>] update_process_times+0x46/0x50
Aug  6 01:22:24 violet kernel:  [<c012d61c>] rcu_check_quiescent_state+0x8c/0x90
Aug  6 01:22:24 violet kernel:  [<c012d708>] rcu_process_callbacks+0xe8/0x110
Aug  6 01:22:24 violet kernel:  [<d0970ca8>] ide_event+0x68/0x100 [ide_cs]
Aug  6 01:22:24 violet kernel:  [<d098bede>] pcmcia_register_client+0x22e/0x270 [pcmcia_core]
Aug  6 01:22:24 violet kernel:  [<c010b348>] common_interrupt+0x18/0x20
Aug  6 01:22:24 violet kernel:  [<d0925813>] yenta_set_mem_map+0x1b3/0x200 [yenta_socket]
Aug  6 01:22:24 violet kernel:  [<c019d1f3>] do_get_write_access+0x2c3/0x5e0
Aug  6 01:22:24 violet crond: crond startup succeeded
Aug  6 01:22:24 violet kernel:  [<d098d3fb>] CardServices+0x1ab/0x357 [pcmcia_core]
Aug  6 01:22:24 violet kernel:  [<d097010a>] ide_attach+0x10a/0x150 [ide_cs]
Aug  6 01:22:24 violet kernel:  [<d0970c40>] ide_event+0x0/0x100 [ide_cs]
Aug  6 01:22:24 violet kernel:  [<d097652b>] bind_request+0x18b/0x230 [ds]
Aug  6 01:22:24 violet kernel:  [<c0238000>] __copy_from_user_ll+0x50/0x80
Aug  6 01:22:24 violet kernel:  [<d097717c>] ds_ioctl+0x62c/0x740 [ds]
Aug  6 01:22:24 violet kernel:  [<c011b970>] autoremove_wake_function+0x0/0x50
Aug  6 01:22:24 violet kernel:  [<c03240ef>] unix_dgram_sendmsg+0x35f/0x560
Aug  6 01:22:24 violet kernel:  [<c018110d>] proc_alloc_inode+0x4d/0x80
Aug  6 01:22:24 violet kernel:  [<c02c616e>] sock_sendmsg+0x8e/0xb0
Aug  6 01:22:24 violet kernel:  [<c0181097>] proc_read_inode+0x17/0x40
Aug  6 01:22:24 violet kernel:  [<c016bc01>] wake_up_inode+0x11/0x30
Aug  6 01:22:24 violet kernel:  [<c0119f7b>] schedule+0x1bb/0x3c0
Aug  6 01:22:24 violet kernel:  [<c011a2e2>] __wake_up_locked+0x22/0x30
Aug  6 01:22:24 violet kernel:  [<c011a1d0>] default_wake_function+0x0/0x30
Aug  6 01:22:25 violet kernel:  [<c011a007>] schedule+0x247/0x3c0
Aug  6 01:22:25 violet kernel:  [<c014218e>] zap_pmd_range+0x4e/0x70
Aug  6 01:22:25 violet kernel:  [<c01421fe>] unmap_page_range+0x4e/0x80
Aug  6 01:22:25 violet kernel:  [<c0119da0>] scheduler_tick+0x330/0x340
Aug  6 01:22:25 violet kernel:  [<c0125466>] update_process_times+0x46/0x50
Aug  6 01:22:26 violet kernel:  [<c01252d6>] update_wall_time+0x16/0x40
Aug  6 01:22:26 violet kernel:  [<c012d708>] rcu_process_callbacks+0xe8/0x110
Aug  6 01:22:26 violet kernel:  [<c01215c6>] tasklet_action+0x46/0x70
Aug  6 01:22:26 violet kernel:  [<c0163920>] sys_ioctl+0x100/0x280
Aug  6 01:22:26 violet kernel:  [<c010b189>] sysenter_past_esp+0x52/0x71
Aug  6 01:22:26 violet kernel: 
Aug  6 01:22:26 violet kernel: hde: task_no_data_intr: status=0x51 { DriveReady SeekComplete Error }
Aug  6 01:22:26 violet kernel: hde: task_no_data_intr: error=0x04 { DriveStatusError }
Aug  6 01:22:26 violet kernel: hde: Write Cache FAILED Flushing!
Aug  6 01:22:26 violet kernel: Module ide_cs cannot be unloaded due to unsafe usage in include/linux/module.h:483
Aug  6 01:22:26 violet kernel: ide-cs: hde: Vcc = 3.3, Vpp = 0.0
Aug  6 01:22:26 violet kernel:  hde: hde1
Aug  6 01:22:26 violet kernel: hde: task_no_data_intr: status=0x51 { DriveReady SeekComplete Error }
Aug  6 01:22:26 violet kernel: hde: task_no_data_intr: error=0x04 { DriveStatusError }
Aug  6 01:22:26 violet kernel: hde: Write Cache FAILED Flushing!
Aug  6 01:22:26 violet kernel:  hde: hde1
Aug  6 01:22:26 violet kernel: updfstab: numerical sysctl 1 23 is obsolete.
Aug  6 01:22:26 violet kernel: ip_tables: (C) 2000-2002 Netfilter core team
Aug  6 01:22:28 violet kernel: lp0: using parport0 (polling).
Aug  6 01:22:28 violet kernel: lp0: console ready

The CF is mounted and readable.

	-Paul

