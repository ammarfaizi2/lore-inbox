Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264549AbTFEJ3v (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jun 2003 05:29:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264551AbTFEJ3v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jun 2003 05:29:51 -0400
Received: from [195.95.38.160] ([195.95.38.160]:2302 "HELO mail.vt4.net")
	by vger.kernel.org with SMTP id S264549AbTFEJ3s convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jun 2003 05:29:48 -0400
From: DevilKin <devilkin-lkml@blindguardian.org>
To: linux-kernel@vger.kernel.org
Subject: [2.5.70] irq9: nobody cared!
Date: Thu, 5 Jun 2003 11:44:22 +0200
User-Agent: KMail/1.5.2
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200306051144.28917.devilkin-lkml@blindguardian.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

I haven't been able to recreate this one, but PCMCIA didn't quite work after 
this:

irq 9: nobody cared!
Call Trace:
 [<c010ab80>] handle_IRQ_event+0x90/0x100
 [<c010add3>] do_IRQ+0xa3/0x140
 [<c0109398>] common_interrupt+0x18/0x20
 [<c010b38e>] setup_irq+0x7e/0xf0
 [<d11a8490>] fake_irq+0x0/0x10 [pcmcia_core]
 [<c010aeef>] request_irq+0x7f/0xd0
 [<d11b3250>] irq_table+0x90/0x100 [pcmcia_core]
 [<d11b28e4>] rsrc_sem+0x0/0x10 [pcmcia_core]
 [<d11a85bd>] try_irq+0x11d/0x190 [pcmcia_core]
 [<d11a8490>] fake_irq+0x0/0x10 [pcmcia_core]
 [<d11addd6>] +0x82/0x5cc [pcmcia_core]
 [<d11ac73a>] pcmcia_request_irq+0x1ca/0x210 [pcmcia_core]
 [<d11ad0c7>] CardServices+0x237/0x35e [pcmcia_core]
 [<d119575e>] simple_config+0x2ae/0x460 [8250_cs]
 [<c01e344e>] ide_do_request+0x21e/0x3c0
 [<c01e3a2d>] ide_intr+0x7d/0x190
 [<c01f6bf0>] ide_dma_intr+0x0/0xc0
 [<c010ab39>] handle_IRQ_event+0x49/0x100
 [<c010ae3c>] do_IRQ+0x10c/0x140
 [<c011349b>] mark_offset_tsc+0x21b/0x280
 [<c01215c6>] update_process_times+0x46/0x60
 [<c01216fd>] run_timer_softirq+0xfd/0x1a0
 [<c0121890>] do_timer+0xe0/0xf0
 [<c010eb56>] timer_interrupt+0xf6/0x120
 [<c010ae35>] do_IRQ+0x105/0x140
 [<c01160be>] scheduler_tick+0x5e/0x2e0
 [<c01215c6>] update_process_times+0x46/0x60
 [<c0121436>] update_wall_time+0x16/0x40
 [<c0121890>] do_timer+0xe0/0xf0
 [<c0128a53>] rcu_process_callbacks+0x83/0x100
 [<c011d856>] tasklet_action+0x46/0x70
 [<c010ae35>] do_IRQ+0x105/0x140
 [<c0109398>] common_interrupt+0x18/0x20
 [<c020007b>] vgacon_scroll+0x23b/0x240
 [<d11a52f7>] read_cis_mem+0x157/0x1a0 [pcmcia_core]
 [<d11a55a4>] read_cis_cache+0xf4/0x180 [pcmcia_core]
 [<d11a5f6d>] pcmcia_get_tuple_data+0x9d/0xb0 [pcmcia_core]
 [<d11a6c3b>] parse_cftable_entry+0x21b/0x350 [pcmcia_core]
 [<d11a721b>] pcmcia_parse_tuple+0xbb/0x180 [pcmcia_core]
 [<d1195e98>] serial_config+0x238/0x330 [8250_cs]
 [<d11a5000>] +0x0/0x80 [pcmcia_core]
 [<d11a52cc>] read_cis_mem+0x12c/0x1a0 [pcmcia_core]
 [<d11a5f6d>] pcmcia_get_tuple_data+0x9d/0xb0 [pcmcia_core]
 [<d11a7268>] pcmcia_parse_tuple+0x108/0x180 [pcmcia_core]
 [<d11a7383>] read_tuple+0xa3/0xb0 [pcmcia_core]
 [<d1198bb1>] yenta_set_mem_map+0x191/0x1e0 [yenta_socket]
 [<d119b26c>] +0x10c/0x860 [yenta_socket]
 [<d1198bb1>] yenta_set_mem_map+0x191/0x1e0 [yenta_socket]
 [<d119b26c>] +0x10c/0x860 [yenta_socket]
 [<d11a5e6c>] pcmcia_get_next_tuple+0x25c/0x2c0 [pcmcia_core]
 [<d11a594c>] pcmcia_get_first_tuple+0xbc/0x170 [pcmcia_core]
 [<d11a52cc>] read_cis_mem+0x12c/0x1a0 [pcmcia_core]
 [<d11a55a4>] read_cis_cache+0xf4/0x180 [pcmcia_core]
 [<d11a5e6c>] pcmcia_get_next_tuple+0x25c/0x2c0 [pcmcia_core]
 [<d11a74c3>] pcmcia_validate_cis+0x133/0x210 [pcmcia_core]
 [<c014e215>] bh_lru_install+0xb5/0x100
 [<d1195ff0>] serial_event+0x60/0x100 [8250_cs]
 [<d11abb2d>] pcmcia_register_client+0x1ed/0x260 [pcmcia_core]
 [<d1196800>] dev_info+0x0/0x20 [8250_cs]
 [<d1198bb1>] yenta_set_mem_map+0x191/0x1e0 [yenta_socket]
 [<d119b26c>] +0x10c/0x860 [yenta_socket]
 [<c014e3cf>] __bread+0x1f/0x40
 [<d11981fe>] pci_set_mem_map+0x3e/0x40 [yenta_socket]
 [<d119b26c>] +0x10c/0x860 [yenta_socket]
 [<d11a50c1>] set_cis_map+0x41/0x120 [pcmcia_core]
 [<d11ad03e>] CardServices+0x1ae/0x35e [pcmcia_core]
 [<d119fc94>] pcmcia_bus_type+0x14/0x100 [ds]
 [<d1195226>] serial_attach+0x146/0x190 [8250_cs]
 [<d1196800>] dev_info+0x0/0x20 [8250_cs]
 [<d1195f90>] serial_event+0x0/0x100 [8250_cs]
 [<d11960ca>] +0x7/0x1d [8250_cs]
 [<d119e587>] get_pcmcia_driver+0x37/0x46 [ds]
 [<d1196840>] serial_cs_driver+0x0/0x80 [8250_cs]
 [<d119d5bf>] bind_request+0xbf/0x150 [ds]
 [<d11960ca>] +0x7/0x1d [8250_cs]
 [<d119e0b3>] ds_ioctl+0x533/0x650 [ds]
 [<c011672a>] preempt_schedule+0x2a/0x50
 [<c0268ed0>] unix_dgram_sendmsg+0x470/0x560
 [<c02135be>] sock_sendmsg+0x9e/0xd0
 [<c0163bcc>] alloc_inode+0x1c/0x140
 [<c0164c45>] iget_locked+0x95/0xc0
 [<c01164f6>] schedule+0x1a6/0x3b0
 [<c0116872>] __wake_up_locked+0x22/0x30
 [<c013c99b>] zap_pmd_range+0x4b/0x70
 [<c013ca0b>] unmap_page_range+0x4b/0x80
 [<c013cb3e>] unmap_vmas+0xfe/0x230
 [<c0140385>] unmap_region+0x95/0xe0
 [<c0140278>] unmap_vma+0x48/0x90
 [<c01402df>] unmap_vma_list+0x1f/0x30
 [<c01406ac>] do_munmap+0x14c/0x190
 [<c015d610>] sys_ioctl+0x100/0x280
 [<c0140734>] sys_munmap+0x44/0x70
 [<c010922b>] syscall_call+0x7/0xb

handlers:
[<d11a8490>] (fake_irq+0x0/0x10 [pcmcia_core])
ttyS2 at I/O 0x3e8 (irq = 9) is a 16550A

- -- 
Penguin laptop (i686) running Linux 2.5.70 #1 Tue May 27 11:12:25 CEST 2003
The computer can't tell you the emotional story.  It can give you the exact
mathematical design, but what's missing is the eyebrows.
- - Frank Zappa
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE+3xD5puyeqyCEh60RAh6NAJ9R4dKPyHXkdtE+dH1R9I/jpEBzEgCfQ+7r
JhlUjAd2eeQH6eHFZF46nAg=
=KFQq
-----END PGP SIGNATURE-----

