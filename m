Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266013AbUAKWWn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jan 2004 17:22:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266018AbUAKWWm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jan 2004 17:22:42 -0500
Received: from ce.fis.unam.mx ([132.248.33.1]:31876 "EHLO ce.fis.unam.mx")
	by vger.kernel.org with ESMTP id S266013AbUAKWV5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jan 2004 17:21:57 -0500
Subject: Re: 2.6.1-mm2: BUG in kswapd?
From: Max Valdez <maxvalde@fis.unam.mx>
To: Jan Ischebeck <mail@jan-ischebeck.de>
Cc: kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1073842387.3720.5.camel@JHome.uni-bonn.de>
References: <1073842387.3720.5.camel@JHome.uni-bonn.de>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-DKQvgwC40yfhDh0YWnIU"
Message-Id: <1073859702.7991.4.camel@garaged.homeip.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sun, 11 Jan 2004 16:21:43 -0600
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-DKQvgwC40yfhDh0YWnIU
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

I think there is a memory leak on some part, but I dont know a damn
about kernel.

I have a similar problem with 2.6.1-mm1 and previous kernels, I'm
testing mm2 right now and still no problem, using vmware and nvidia.o
modules, but have an uptime of 5:30 hrs. so I need to wait some more
time, usually the kernel starts eating RAM and the hangs when swap start
to play because of the lack or "real" RAM.

here is a dmesg that I could get before one of those hangs

I dont know how to trace the error
Max
--------------------

        <Adaptec aic7890/91 Ultra2 SCSI adapter>
        aic7890/91: Ultra2 Wide Channel A, SCSI Id=3D7, 32/253 SCBs

(scsi0:A:0): 80.000MB/s transfers (40.000MHz, offset 31, 16bit)
  Vendor: SEAGATE   Model: ST318436LW        Rev: 0005
  Type:   Direct-Access                      ANSI SCSI revision: 03
scsi0:A:0:0: Tagged Queuing enabled.  Depth 32
Attached scsi generic sg0 at scsi0, channel 0, id 0, lun 0,  type 0
ide-scsi is deprecated for cd burning! Use ide-cd and give dev=3D/dev/hdX
as device
scsi1 : SCSI host adapter emulation for IDE ATAPI devices
  Vendor: SONY      Model: CD-RW  CRX225E    Rev: QYB2
  Type:   CD-ROM                             ANSI SCSI revision: 02
sr0: scsi3-mmc drive: 40x/52x writer cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.20
Attached scsi CD-ROM sr0 at scsi1, channel 0, id 0, lun 0
Attached scsi generic sg1 at scsi1, channel 0, id 0, lun 0,  type 5
drivers/usb/core/usb.c: registered new driver usbfs
drivers/usb/core/usb.c: registered new driver hub
drivers/usb/host/uhci-hcd.c: USB Universal Host Controller Interface
driver v2.1
uhci_hcd 0000:00:07.2: UHCI Host Controller
uhci_hcd 0000:00:07.2: irq 10, io base 0000d000
uhci_hcd 0000:00:07.2: new USB bus registered, assigned bus number 1
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
ohci_hcd: 2003 Oct 13 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ohci_hcd: block sizes: ed 64 td 64
ohci_hcd 0000:00:10.0: OHCI Host Controller
ohci_hcd 0000:00:10.0: irq 5, pci mem f89f4000
ohci_hcd 0000:00:10.0: new USB bus registered, assigned bus number 2
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
hub 2-0:1.0: new USB device on port 2, assigned address 2
Linux video capture interface: v1.00
kjournald starting.  Commit interval 5 seconds
EXT3-fs warning: maximal mount count reached, running e2fsck is
recommended
EXT3 FS on hda4, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
vmmon: module license 'unspecified' taints kernel.
/dev/vmmon: Module vmmon: registered with major=3D10 minor=3D165
/dev/vmmon: Module vmmon: initialized
pnp: the driver 'parport_pc' has been registered
parport0: PC-style at 0x378 [PCSPP,TRISTATE]
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)
vmnet: module license 'unspecified' taints kernel.
/dev/vmnet: open called by PID 4358 (vmnet-bridge)
/dev/vmnet: hub 0 does not exist, allocating memory.
/dev/vmnet: port on hub 0 successfully opened
bridge-eth0: up
bridge-eth0: attached
/dev/vmnet: open called by PID 4396 (vmnet-natd)
/dev/vmnet: hub 8 does not exist, allocating memory.
/dev/vmnet: port on hub 8 successfully opened
/dev/vmnet: open called by PID 4948 (vmnet-netifup)
/dev/vmnet: hub 1 does not exist, allocating memory.
/dev/vmnet: port on hub 1 successfully opened
/dev/vmnet: open called by PID 4959 (vmnet-netifup)
/dev/vmnet: port on hub 8 successfully opened
/dev/vmnet: open called by PID 4972 (vmnet-dhcpd)
/dev/vmnet: port on hub 8 successfully opened
/dev/vmnet: open called by PID 4966 (vmnet-dhcpd)
/dev/vmnet: port on hub 1 successfully opened
nvidia: no version magic, tainting kernel.
nvidia: module license 'NVIDIA' taints kernel.
1: nvidia: loading NVIDIA Linux x86 nvidia.o Kernel Module  1.0-5328=20
Wed Dec 17 13:54:51 PST 2003
atkbd.c: Unknown key released (translated set 2, code 0x7a on
isa0060/serio0).
atkbd.c: Unknown key released (translated set 2, code 0x7a on
isa0060/serio0).
atkbd.c: Unknown key released (translated set 2, code 0x7a on
isa0060/serio0).
atkbd.c: Unknown key released (translated set 2, code 0x7a on
isa0060/serio0).
atkbd.c: Unknown key released (translated set 2, code 0x7a on
isa0060/serio0).
atkbd.c: Unknown key released (translated set 2, code 0x7a on
isa0060/serio0).
atkbd.c: Unknown key released (translated set 2, code 0x7a on
isa0060/serio0).
atkbd.c: Unknown key released (translated set 2, code 0x7a on
isa0060/serio0).
atkbd.c: Unknown key released (translated set 2, code 0x7a on
isa0060/serio0).
atkbd.c: Unknown key released (translated set 2, code 0x7a on
isa0060/serio0).
/dev/vmmon: Module vmmon: unloaded
pnp: the driver 'parport_pc' has been unregistered
bridge-eth0: down
bridge-eth0: detached
vmmon: module license 'unspecified' taints kernel.
/dev/vmmon: Module vmmon: registered with major=3D10 minor=3D165
/dev/vmmon: Module vmmon: initialized
/dev/vmmon: Module vmmon: unloaded
vmnet: module license 'unspecified' taints kernel.
vmmon: module license 'unspecified' taints kernel.
/dev/vmmon: Module vmmon: registered with major=3D10 minor=3D165
/dev/vmmon: Module vmmon: initialized
pnp: the driver 'parport_pc' has been registered
parport0: PC-style at 0x378 [PCSPP,TRISTATE]
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)
vmnet: module license 'unspecified' taints kernel.
/dev/vmnet: open called by PID 28507 (vmnet-bridge)
/dev/vmnet: hub 0 does not exist, allocating memory.
/dev/vmnet: port on hub 0 successfully opened
bridge-eth0: up
bridge-eth0: attached
/dev/vmnet: open called by PID 28530 (vmnet-natd)
/dev/vmnet: hub 8 does not exist, allocating memory.
/dev/vmnet: port on hub 8 successfully opened
/dev/vmnet: open called by PID 28810 (vmnet-netifup)
/dev/vmnet: hub 1 does not exist, allocating memory.
/dev/vmnet: port on hub 1 successfully opened
/dev/vmnet: open called by PID 28815 (vmnet-netifup)
/dev/vmnet: port on hub 8 successfully opened
/dev/vmnet: open called by PID 28832 (vmnet-dhcpd)
/dev/vmnet: port on hub 8 successfully opened
/dev/vmnet: open called by PID 28823 (vmnet-dhcpd)
/dev/vmnet: port on hub 1 successfully opened
/dev/vmnet: open called by PID 28809 (vmware-vmx)
/dev/vmnet: port on hub 8 successfully opened
kswapd0: page allocation failure. order:0, mode:0x50
Call Trace:
 [<c0149441>] __alloc_pages+0x301/0x350
 [<c023f96f>] elv_merged_request+0x1f/0x30
 [<c01494b5>] __get_free_pages+0x25/0x40
 [<c014d3c8>] cache_grow+0xe8/0x370
 [<c014d83d>] cache_alloc_refill+0x1ed/0x300
 [<c014dc49>] kmem_cache_alloc+0x49/0x50
 [<c01c85a0>] journal_alloc_journal_head+0x20/0xd0
 [<c0243420>] submit_bio+0x70/0x130
 [<c01c8803>] journal_add_journal_head+0x173/0x190
 [<c016e227>] bio_alloc+0xd7/0x1d0
 [<c01be106>] journal_dirty_data+0x36/0x3e0
 [<c016d8af>] submit_bh+0x7f/0x180
 [<c016be77>] __block_write_full_page+0x217/0x440
 [<c01b1913>] ext3_journal_dirty_data+0x23/0x70
 [<c01b1756>] walk_page_buffers+0x76/0x80
 [<c01b1ec4>] ext3_ordered_writepage+0x164/0x1c0
 [<c01b1d40>] journal_dirty_data_fn+0x0/0x20
 [<c0151259>] shrink_list+0x429/0x800
 [<c011a3f7>] smp_apic_timer_interrupt+0xd7/0x150
 [<c015185e>] shrink_cache+0x22e/0x540
 [<c01524a4>] shrink_zone+0x94/0xc0
 [<c01528f0>] balance_pgdat+0x1c0/0x250
 [<c0152a86>] kswapd+0x106/0x120
 [<c0123e30>] autoremove_wake_function+0x0/0x50
 [<c02e7baa>] ret_from_fork+0x6/0x14
 [<c0123e30>] autoremove_wake_function+0x0/0x50
 [<c0152980>] kswapd+0x0/0x120
 [<c010ac89>] kernel_thread_helper+0x5/0xc
vmware-vmx: page allocation failure. order:0, mode:0x50
Call Trace:
 [<c0149441>] __alloc_pages+0x301/0x350
 [<c0144a98>] find_or_create_page+0xb8/0xd0
 [<c016b051>] grow_dev_page+0x31/0x1b0
 [<c016b278>] __getblk_slow+0xa8/0x100
 [<c016b73f>] __getblk+0x4f/0x60
 [<c01b0a6a>] ext3_alloc_branch+0x15a/0x2d0
 [<c01b1008>] ext3_get_block_handle+0x178/0x3b0
 [<c02430a0>] __make_request+0x4e0/0x660
 [<c023f96f>] elv_merged_request+0x1f/0x30
 [<c02430a0>] __make_request+0x4e0/0x660
 [<c01b1295>] ext3_get_block+0x55/0xa0
 [<c016bf2c>] __block_write_full_page+0x2cc/0x440
 [<c016af63>] create_buffers+0x63/0xb0
 [<c016d786>] block_write_full_page+0x106/0x130
 [<c01b1240>] ext3_get_block+0x0/0xa0
 [<c01b1e4b>] ext3_ordered_writepage+0xeb/0x1c0
 [<c01b1240>] ext3_get_block+0x0/0xa0
 [<c01b1d20>] bget_one+0x0/0x10
 [<c0151259>] shrink_list+0x429/0x800
 [<c010efb9>] do_IRQ+0x109/0x200
 [<c014fc58>] __pagevec_release+0x28/0x40
 [<c014fc58>] __pagevec_release+0x28/0x40
 [<c015185e>]
shrink_cache+0x22e/0x540
 [<c0152595>] shrink_caches+0xc5/0xe0
 [<c015266b>] try_to_free_pages+0xbb/0x180
 [<c014931c>] __alloc_pages+0x1dc/0x350
 [<c01494b5>] __get_free_pages+0x25/0x40
 [<c017e43c>] __pollwait+0x8c/0xd0
 [<c02e274b>] unix_poll+0x2b/0xa0
 [<c0289f09>] sock_poll+0x29/0x40
 [<c017e81f>] do_select+0x29f/0x340
 [<c017e3b0>] __pollwait+0x0/0xd0
 [<c017ebfb>] sys_select+0x2fb/0x520
 [<c02e7cc7>] syscall_call+0x7/0xb
 [<c02e007b>] unix_dgram_connect+0x2b/0x210

vmware-vmx: page allocation failure. order:0, mode:0x50
Call Trace:
 [<c0149441>] __alloc_pages+0x301/0x350
 [<c0144a98>] find_or_create_page+0xb8/0xd0
 [<c016b051>] grow_dev_page+0x31/0x1b0
 [<c016b278>] __getblk_slow+0xa8/0x100
 [<c016b73f>] __getblk+0x4f/0x60
 [<c01b0a6a>] ext3_alloc_branch+0x15a/0x2d0
 [<c01b1008>] ext3_get_block_handle+0x178/0x3b0
 [<c02430a0>] __make_request+0x4e0/0x660
 [<c023f96f>] elv_merged_request+0x1f/0x30
 [<c02430a0>] __make_request+0x4e0/0x660
 [<c01b1295>] ext3_get_block+0x55/0xa0
 [<c016bf2c>] __block_write_full_page+0x2cc/0x440
 [<c016af63>] create_buffers+0x63/0xb0
 [<c016d786>] block_write_full_page+0x106/0x130
 [<c01b1240>] ext3_get_block+0x0/0xa0
 [<c01b1e4b>] ext3_ordered_writepage+0xeb/0x1c0
 [<c01b1240>] ext3_get_block+0x0/0xa0
 [<c01b1d20>] bget_one+0x0/0x10
 [<c0151259>] shrink_list+0x429/0x800
 [<c010efb9>] do_IRQ+0x109/0x200
 [<c014fc58>] __pagevec_release+0x28/0x40
 [<c014fc58>] __pagevec_release+0x28/0x40
 [<c015185e>] shrink_cache+0x22e/0x540
 [<c0152595>] shrink_caches+0xc5/0xe0
 [<c015266b>] try_to_free_pages+0xbb/0x180
 [<c014931c>] __alloc_pages+0x1dc/0x350
 [<c01494b5>] __get_free_pages+0x25/0x40
 [<c017e43c>] __pollwait+0x8c/0xd0
 [<c02e274b>] unix_poll+0x2b/0xa0
 [<c0289f09>] sock_poll+0x29/0x40
 [<c017e81f>] do_select+0x29f/0x340
 [<c017e3b0>] __pollwait+0x0/0xd0
 [<c017ebfb>] sys_select+0x2fb/0x520
 [<c02e7cc7>] syscall_call+0x7/0xb
 [<c02e007b>] unix_dgram_connect+0x2b/0x210

fixdep: page allocation failure. order:0, mode:0x50
Call Trace:
 [<c0149441>] __alloc_pages+0x301/0x350
 [<c023f96f>] elv_merged_request+0x1f/0x30
 [<c01494b5>] __get_free_pages+0x25/0x40
 [<c014d3c8>] cache_grow+0xe8/0x370
 [<c014d83d>] cache_alloc_refill+0x1ed/0x300
 [<c014dc49>] kmem_cache_alloc+0x49/0x50
 [<c01c85a0>] journal_alloc_journal_head+0x20/0xd0
 [<c0243420>] submit_bio+0x70/0x130
 [<c01c8803>] journal_add_journal_head+0x173/0x190
 [<c016e227>] bio_alloc+0xd7/0x1d0
 [<c01be106>] journal_dirty_data+0x36/0x3e0
 [<c016d8af>] submit_bh+0x7f/0x180
 [<c016be77>] __block_write_full_page+0x217/0x440
 [<c01b1913>] ext3_journal_dirty_data+0x23/0x70
 [<c01b1756>] walk_page_buffers+0x76/0x80
 [<c01b1ec4>] ext3_ordered_writepage+0x164/0x1c0
 [<c01b1d40>] journal_dirty_data_fn+0x0/0x20
 [<c0151259>] shrink_list+0x429/0x800
 [<c0130116>] update_wall_time+0x16/0x40
 [<c014fc58>] __pagevec_release+0x28/0x40
 [<c015185e>] shrink_cache+0x22e/0x540
 [<c0152595>] shrink_caches+0xc5/0xe0
 [<c015266b>] try_to_free_pages+0xbb/0x180
 [<c014931c>] __alloc_pages+0x1dc/0x350
 [<c014c24b>] do_page_cache_readahead+0x1bb/0x240
 [<c0145a41>] filemap_nopage+0x191/0x3d0
 [<c0157278>] do_no_page+0x108/0x4d0
 [<c0154775>] pte_alloc_map+0xf5/0x160
 [<c0183051>] dput+0x31/0x420
 [<c01578ae>] handle_mm_fault+0x10e/0x220
 [<c01586ea>] __vma_link+0x3a/0xa0
 [<c011d9cc>] do_page_fault+0x30c/0x500
 [<c015909d>] do_mmap_pgoff+0x38d/0x6b0
 [<c011425f>] sys_mmap2+0x9f/0xb0
 [<c011d6c0>] do_page_fault+0x0/0x500
 [<c02e8733>] error_code+0x2f/0x38

ENOMEM in journal_alloc_journal_head, retrying.
vmware-vmx: page allocation failure. order:0, mode:0x50
Call Trace:
 [<c0149441>] __alloc_pages+0x301/0x350
 [<c0144a98>] find_or_create_page+0xb8/0xd0
 [<c016b051>] grow_dev_page+0x31/0x1b0
 [<c016b278>] __getblk_slow+0xa8/0x100
 [<c016b73f>] __getblk+0x4f/0x60
 [<c016b7cf>] __bread+0x1f/0x50
 [<c01b075c>] ext3_get_branch+0x6c/0x100
 [<c01b0f3b>] ext3_get_block_handle+0xab/0x3b0
 [<c025bc1c>] ata_output_data+0xac/0xb0
 [<c01c85a0>] journal_alloc_journal_head+0x20/0xd0
 [<c01b1295>] ext3_get_block+0x55/0xa0
 [<c016bf2c>] __block_write_full_page+0x2cc/0x440
 [<c016af63>] create_buffers+0x63/0xb0
 [<c016d786>] block_write_full_page+0x106/0x130
 [<c01b1240>] ext3_get_block+0x0/0xa0
 [<c01b1e4b>] ext3_ordered_writepage+0xeb/0x1c0
 [<c01b1240>] ext3_get_block+0x0/0xa0
 [<c01b1d20>] bget_one+0x0/0x10
 [<c0151259>] shrink_list+0x429/0x800
 [<c011a3f7>] smp_apic_timer_interrupt+0xd7/0x150
 [<c02e86b6>] apic_timer_interrupt+0x1a/0x20
 [<c014fc58>] __pagevec_release+0x28/0x40
 [<c015185e>] shrink_cache+0x22e/0x540
 [<c0152595>] shrink_caches+0xc5/0xe0
 [<c015266b>] try_to_free_pages+0xbb/0x180
 [<c014931c>] __alloc_pages+0x1dc/0x350
 [<c01466fe>] __generic_file_aio_write_nolock+0x35e/0xbd0
 [<c011eb68>] recalc_task_prio+0xa8/0x1d0
 [<c028d944>] kfree_skbmem+0x24/0x30
 [<c028d9bf>] __kfree_skb+0x6f/0xf0
 [<c02e1f50>] unix_stream_recvmsg+0x2d0/0x720
 [<c01470dd>] __generic_file_write_nolock+0x9d/0xc0
 [<c0289892>] sock_aio_read+0xc2/0xe0
 [<c0123e30>] autoremove_wake_function+0x0/0x50
 [<c0167e41>] do_sync_read+0xb1/0xe0
 [<c017e3a4>] poll_freewait+0x44/0x50
 [<c01474c6>] generic_file_writev+0x46/0xc0
 [<c01685fc>] do_readv_writev+0x22c/0x2d0
 [<c0167fa0>] do_sync_write+0x0/0xe0
 [<c012009f>] scheduler_tick+0x3f/0x6d0
 [<c0168768>] vfs_writev+0x58/0x70
 [<c0168832>] sys_writev+0x42/0x70
 [<c02e7cc7>] syscall_call+0x7/0xb
 [<c02e007b>] unix_dgram_connect+0x2b/0x210

vmware-vmx: page allocation failure. order:0, mode:0x50
Call Trace:
 [<c0149441>] __alloc_pages+0x301/0x350
 [<c0144a98>] find_or_create_page+0xb8/0xd0
 [<c016b051>] grow_dev_page+0x31/0x1b0
 [<c016b278>] __getblk_slow+0xa8/0x100
 [<c016b73f>] __getblk+0x4f/0x60
 [<c016b7cf>] __bread+0x1f/0x50
 [<c01b075c>] ext3_get_branch+0x6c/0x100
 [<c01b0f3b>] ext3_get_block_handle+0xab/0x3b0
 [<c025bc1c>] ata_output_data+0xac/0xb0
 [<c01c85a0>] journal_alloc_journal_head+0x20/0xd0
 [<c01b1295>] ext3_get_block+0x55/0xa0
 [<c016bf2c>] __block_write_full_page+0x2cc/0x440
 [<c016af63>] create_buffers+0x63/0xb0
 [<c016d786>] block_write_full_page+0x106/0x130
 [<c01b1240>] ext3_get_block+0x0/0xa0
 [<c01b1e4b>] ext3_ordered_writepage+0xeb/0x1c0
 [<c01b1240>] ext3_get_block+0x0/0xa0
 [<c01b1d20>] bget_one+0x0/0x10
 [<c0151259>] shrink_list+0x429/0x800
 [<c011a3f7>] smp_apic_timer_interrupt+0xd7/0x150
 [<c02e86b6>] apic_timer_interrupt+0x1a/0x20
 [<c014fc58>] __pagevec_release+0x28/0x40
 [<c015185e>] shrink_cache+0x22e/0x540
 [<c0152595>] shrink_caches+0xc5/0xe0
 [<c015266b>] try_to_free_pages+0xbb/0x180
 [<c014931c>] __alloc_pages+0x1dc/0x350
 [<c01466fe>] __generic_file_aio_write_nolock+0x35e/0xbd0
 [<c011eb68>] recalc_task_prio+0xa8/0x1d0
 [<c028d944>] kfree_skbmem+0x24/0x30
 [<c028d9bf>] __kfree_skb+0x6f/0xf0
 [<c02e1f50>] unix_stream_recvmsg+0x2d0/0x720
 [<c01470dd>] __generic_file_write_nolock+0x9d/0xc0
 [<c0289892>] sock_aio_read+0xc2/0xe0
 [<c0123e30>] autoremove_wake_function+0x0/0x50
 [<c0167e41>] do_sync_read+0xb1/0xe0
 [<c017e3a4>] poll_freewait+0x44/0x50
 [<c01474c6>] generic_file_writev+0x46/0xc0
 [<c01685fc>] do_readv_writev+0x22c/0x2d0
 [<c0167fa0>] do_sync_write+0x0/0xe0
 [<c012009f>] scheduler_tick+0x3f/0x6d0
 [<c0168768>] vfs_writev+0x58/0x70
 [<c0168832>] sys_writev+0x42/0x70
 [<c02e7cc7>] syscall_call+0x7/0xb
 [<c02e007b>] unix_dgram_connect+0x2b/0x210


--=20
Linux garaged 2.6.1-mm1 #3 SMP Sat Jan 10 13:18:40 CST 2004 i686 Pentium II=
I (Coppermine) GenuineIntel GNU/Linux
-----BEGIN GEEK CODE BLOCK-----
Version: 3.1
GS/ d-s:a-28C++ILHA+++P+L++>+++E---W++N*o--K-w++++O-M--V--PS+PEY--PGP++t5XR=
tv++b++DI--D-G++e++h-r+y**
------END GEEK CODE BLOCK------
gpg-key: http://garaged.homeip.net/gpg-key.txt

--=-DKQvgwC40yfhDh0YWnIU
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQBAAcx2NNkpVEFxW78RAk1+AJ0Z2sdj1DiCnBjuxL8tjTnHOBjQcgCdEpfr
eqdZiiG2KfvJIF41zJu7DyU=
=kzYw
-----END PGP SIGNATURE-----

--=-DKQvgwC40yfhDh0YWnIU--

