Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261775AbTEUH7H (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 May 2003 03:59:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261786AbTEUHz6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 May 2003 03:55:58 -0400
Received: from zeus.kernel.org ([204.152.189.113]:37591 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S261798AbTEUHno (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 May 2003 03:43:44 -0400
Date: Wed, 21 May 2003 10:56:43 +1000 (EST)
From: Brett <generica@email.com>
X-X-Sender: brett@bad-sports.com
To: linux-kernel@vger.kernel.org
Subject: two nobody cared messages at pcmcia init (2.5.69-bk14)
Message-ID: <Pine.LNX.4.44.0305211055140.22168-100000@bad-sports.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hey,

I realise some of these have been reported before
but I could see no resolution reached

I get these at pcmcia initialisation
and at shutdown

thanks,

	/ Brett

cs: IO port probe 0x0c00-0x0cff: excluding 0xc00-0xc7f 0xca0-0xcc7 0xcd0-0xcef
cs: IO port probe 0x0800-0x08ff: excluding 0x800-0x87f 0x8a0-0x8c7 0x8d0-0x8ef
cs: IO port probe 0x0100-0x04ff: excluding 0x1f8-0x1ff 0x378-0x37f 0x3c0-0x3e7 0x400-0x4c7 0x4d0-0x4ef
cs: IO port probe 0x0a00-0x0aff: clean.
cs: memory probe 0x0d0000-0x0dffff: clean.
irq 3: nobody cared!
Call Trace:
 [<c010a496>] handle_IRQ_event+0x76/0xe0
 [<c010a6ad>] do_IRQ+0x9d/0x130
 [<c0109018>] common_interrupt+0x18/0x20
 [<c010ac3c>] setup_irq+0x7c/0x100
 [<c01d84f0>] fake_irq+0x0/0x10
 [<c010a7aa>] request_irq+0x6a/0xb0
 [<c01d85e5>] try_irq+0xe5/0x160
 [<c01d84f0>] fake_irq+0x0/0x10
 [<c01dc022>] pcmcia_request_irq+0x1c2/0x200
 [<c01dc7f9>] CardServices+0x189/0x25e
 [<c3819ba3>] xirc2ps_config+0x3d3/0x9c0 [xirc2ps_cs]
 [<c01df2db>] pcic_set_mem_map+0x3b/0x70
 [<c01d5b78>] read_cis_mem+0x108/0x180
 [<c01d6207>] follow_link+0xb7/0x1a0
 [<c01d650a>] pcmcia_get_next_tuple+0x21a/0x270
 [<c381c96b>] dev_info+0xb/0x20 [xirc2ps_cs]
 [<c01d7616>] read_tuple+0x36/0x80
 [<c011ba23>] do_softirq+0xa3/0xb0
 [<c010a71a>] do_IRQ+0x10a/0x130
 [<c0109018>] common_interrupt+0x18/0x20
 [<c01d7797>] pcmcia_validate_cis+0x137/0x1a0
 [<c01497ea>] wake_up_buffer+0xa/0x20
 [<c018741c>] do_get_write_access+0x2cc/0x590
 [<c01497ea>] wake_up_buffer+0xa/0x20
 [<c018741c>] do_get_write_access+0x2cc/0x590
 [<c0187cf2>] journal_dirty_metadata+0x142/0x1b0
 [<c381a284>] xirc2ps_event+0x54/0x1b0 [xirc2ps_cs]
 [<c01db55c>] pcmcia_register_client+0x1dc/0x240
 [<c381c960>] dev_info+0x0/0x20 [xirc2ps_cs]
 [<c011f2db>] update_wall_time+0xb/0x40
 [<c011f6e3>] do_timer+0xf3/0x100
 [<c010e1de>] timer_interrupt+0x2e/0x120
 [<c011ba23>] do_softirq+0xa3/0xb0
 [<c01dc795>] CardServices+0x125/0x25e
 [<c01a0dd7>] kobject_put+0x17/0x50
 [<c38194ae>] xirc2ps_attach+0x13e/0x170 [xirc2ps_cs]
 [<c381c960>] dev_info+0x0/0x20 [xirc2ps_cs]
 [<c381a230>] xirc2ps_event+0x0/0x1b0 [xirc2ps_cs]
 [<c01ddc37>] get_pcmcia_driver+0x27/0x3c
 [<c381c980>] xirc2ps_cs_driver+0x0/0x80 [xirc2ps_cs]
 [<c01dce49>] bind_request+0xa9/0x120
 [<c381b7e5>] +0xa1/0xdc [xirc2ps_cs]
 [<c01dd7b5>] ds_ioctl+0x4a5/0x5b0
 [<c0114dbf>] schedule+0x1af/0x3c0
 [<c01150ac>] __wake_up+0x1c/0x50
 [<c0114ffa>] preempt_schedule+0x2a/0x50
 [<c023183c>] unix_dgram_sendmsg+0x46c/0x550
 [<c0114944>] scheduler_tick+0x54/0x310
 [<c01e498f>] sock_sendmsg+0x7f/0xa0
 [<c010e1de>] timer_interrupt+0x2e/0x120
 [<c0126e4b>] rcu_process_callbacks+0xdb/0x100
 [<c0126de4>] rcu_process_callbacks+0x74/0x100
 [<c011bbeb>] tasklet_action+0x3b/0x60
 [<c011ba23>] do_softirq+0xa3/0xb0
 [<c0114944>] scheduler_tick+0x54/0x310
 [<c011f41a>] update_process_times+0x2a/0x30
 [<c011f2db>] update_wall_time+0xb/0x40
 [<c011f6e3>] do_timer+0xf3/0x100
 [<c010e1de>] timer_interrupt+0x2e/0x120
 [<c0139b50>] zap_pmd_range+0x40/0x60
 [<c0139bb0>] unmap_page_range+0x40/0x80
 [<c0139cf4>] unmap_vmas+0x104/0x260
 [<c013d890>] unmap_region+0x80/0xd0
 [<c013d7fa>] unmap_vma_list+0x1a/0x30
 [<c013db3e>] do_munmap+0x10e/0x160
 [<c01588ea>] sys_ioctl+0xea/0x260
 [<c0108df7>] syscall_call+0x7/0xb

handlers:
[<c01d84f0>] (fake_irq+0x0/0x10)
eth0: Xircom: port 0x300, irq 3, hwaddr 00:80:C7:C4:ED:90
eth0: media 10BaseT, silicon revision 1
irq 5: nobody cared!
Call Trace:
 [<c010a496>] handle_IRQ_event+0x76/0xe0
 [<c010a6ad>] do_IRQ+0x9d/0x130
 [<c0109018>] common_interrupt+0x18/0x20
 [<c010ac3c>] setup_irq+0x7c/0x100
 [<c01d84f0>] fake_irq+0x0/0x10
 [<c010a7aa>] request_irq+0x6a/0xb0
 [<c01d85e5>] try_irq+0xe5/0x160
 [<c01d84f0>] fake_irq+0x0/0x10
 [<c01dc022>] pcmcia_request_irq+0x1c2/0x200
 [<c01dc7f9>] CardServices+0x189/0x25e
 [<c3816618>] simple_config+0x228/0x3b0 [8250_cs]
 [<c01dddf3>] i365_bset+0x23/0x50
 [<c011ee81>] mod_timer+0xe1/0x1a0
 [<c01b4f4d>] vt_console_print+0x22d/0x310
 [<c0115039>] default_wake_function+0x19/0x20
 [<c0115066>] __wake_up_common+0x26/0x50
 [<c01150ac>] __wake_up+0x1c/0x50
 [<c0118a38>] printk+0x108/0x170
 [<c019f836>] vsprintf+0x16/0x20
 [<c012bf95>] __print_symbol+0xf5/0x130
 [<c01dddf3>] i365_bset+0x23/0x50
 [<c01dee83>] i365_set_mem_map+0x1b3/0x200
 [<c01dee83>] i365_set_mem_map+0x1b3/0x200
 [<c01df2db>] pcic_set_mem_map+0x3b/0x70
 [<c01d59c0>] set_cis_map+0x30/0xe0
 [<c01d5b78>] read_cis_mem+0x108/0x180
 [<c01d5e01>] read_cis_cache+0xc1/0x130
 [<c01d726e>] parse_cftable_entry+0x20e/0x310
 [<c01d757c>] pcmcia_parse_tuple+0x7c/0xe0
 [<c01dc71b>] CardServices+0xab/0x25e
 [<c3816c96>] serial_config+0x1f6/0x2e0 [8250_cs]
 [<c01dee83>] i365_set_mem_map+0x1b3/0x200
 [<c01d59c0>] set_cis_map+0x30/0xe0
 [<c01d5b78>] read_cis_mem+0x108/0x180
 [<c01dddf3>] i365_bset+0x23/0x50
 [<c01df2db>] pcic_set_mem_map+0x3b/0x70
 [<c01d59c0>] set_cis_map+0x30/0xe0
 [<c01d5b78>] read_cis_mem+0x108/0x180
 [<c01d5e01>] read_cis_cache+0xc1/0x130
 [<c01d6207>] follow_link+0xb7/0x1a0
 [<c01d650a>] pcmcia_get_next_tuple+0x21a/0x270
 [<c01d6207>] follow_link+0xb7/0x1a0
 [<c01d650a>] pcmcia_get_next_tuple+0x21a/0x270
 [<c01d773e>] pcmcia_validate_cis+0xde/0x1a0
 [<c01497ea>] wake_up_buffer+0xa/0x20
 [<c01497ea>] wake_up_buffer+0xa/0x20
 [<c018741c>] do_get_write_access+0x2cc/0x590
 [<c01497ea>] wake_up_buffer+0xa/0x20
 [<c018741c>] do_get_write_access+0x2cc/0x590
 [<c0187cf2>] journal_dirty_metadata+0x142/0x1b0
 [<c01ddd14>] i365_get+0x24/0x70
 [<c3816dcc>] serial_event+0x4c/0xe0 [8250_cs]
 [<c01db55c>] pcmcia_register_client+0x1dc/0x240
 [<c38175c0>] dev_info+0x0/0x20 [8250_cs]
 [<c01df2db>] pcic_set_mem_map+0x3b/0x70
 [<c01d59c0>] set_cis_map+0x30/0xe0
 [<c01d5b78>] read_cis_mem+0x108/0x180
 [<c3817600>] serial_cs_driver+0x0/0x80 [8250_cs]
 [<c01dc795>] CardServices+0x125/0x25e
 [<c38161e1>] serial_attach+0x131/0x170 [8250_cs]
 [<c38175c0>] dev_info+0x0/0x20 [8250_cs]
 [<c3816d80>] serial_event+0x0/0xe0 [8250_cs]
 [<c01ddc37>] get_pcmcia_driver+0x27/0x3c
 [<c3817600>] serial_cs_driver+0x0/0x80 [8250_cs]
 [<c01dce49>] bind_request+0xa9/0x120
 [<c3816e94>] +0x7/0x13 [8250_cs]
 [<c01dd7b5>] ds_ioctl+0x4a5/0x5b0
 [<c0126de4>] rcu_process_callbacks+0x74/0x100
 [<c0114dbf>] schedule+0x1af/0x3c0
 [<c0114ffa>] preempt_schedule+0x2a/0x50
 [<c023183c>] unix_dgram_sendmsg+0x46c/0x550
 [<c01e498f>] sock_sendmsg+0x7f/0xa0
 [<c013bc4a>] handle_mm_fault+0xba/0x150
 [<c0131bc4>] free_pages_bulk+0x174/0x250
 [<c01150ee>] __wake_up_locked+0xe/0x20
 [<c0139b50>] zap_pmd_range+0x40/0x60
 [<c0139bb0>] unmap_page_range+0x40/0x80
 [<c0139cf4>] unmap_vmas+0x104/0x260
 [<c013d890>] unmap_region+0x80/0xd0
 [<c013d7fa>] unmap_vma_list+0x1a/0x30
 [<c013db3e>] do_munmap+0x10e/0x160
 [<c01588ea>] sys_ioctl+0xea/0x260
 [<c0108df7>] syscall_call+0x7/0xb

handlers:
[<c01d84f0>] (fake_irq+0x0/0x10)
tts/1 at I/O 0x2f8 (irq = 5) is a 16550A

