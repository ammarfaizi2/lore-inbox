Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271730AbTGRHP5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 03:15:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271732AbTGRHP5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 03:15:57 -0400
Received: from 157.Red-80-32-159.pooles.rima-tde.net ([80.32.159.157]:59140
	"EHLO oxo") by vger.kernel.org with ESMTP id S271733AbTGRHPy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 03:15:54 -0400
Message-ID: <3F17A1DB.10504@iquis.com>
Date: Fri, 18 Jul 2003 09:29:31 +0200
From: Juan Pedro Paredes Caballero <juampe@iquis.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3.1) Gecko/20030618 Debian/1.3.1-3
X-Accept-Language: en
MIME-Version: 1.0
To: kernel <linux-kernel@vger.kernel.org>
Subject: linux-2.6.0-test1: PCMCIA SanDisk, Card Module ide_cs cannot be unloaded
 due to unsafe usage
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When I enter my SanDisk Card

hde: SanDisk SDCFB-16, CFA DISK drive
ide2 at 0x100-0x107,0x10e on irq 3
hde: max request size: 128KiB
hde: task_no_data_intr: status=0x51 { DriveReady SeekComplete Error }
hde: task_no_data_intr: error=0x04 { DriveStatusError }
hde: 31360 sectors (16 MB) w/1KiB Cache, CHS=490/2/32
 /dev/ide/host2/bus0/target0/lun0: p1
 /dev/ide/host2/bus0/target0/lun0: p1
devfs_mk_bdev: could not append to parent for 
ide/host2/bus0/target0/lun0/part1
kobject_register failed for hde1 (-17)
Call Trace:
 [kobject_register+89/96] kobject_register+0x59/0x60
 [register_disk+327/384] register_disk+0x147/0x180
 [add_disk+80/96] add_disk+0x50/0x60
 [exact_match+0/16] exact_match+0x0/0x10
 [exact_lock+0/32] exact_lock+0x0/0x20
 [idedisk_attach+284/448] idedisk_attach+0x11c/0x1c0
 [ata_attach+65/208] ata_attach+0x41/0xd0
 [ideprobe_init+254/285] ideprobe_init+0xfe/0x11d
 [set_cis_map+64/288] set_cis_map+0x40/0x120
 [ide_probe_module+19/32] ide_probe_module+0x13/0x20
 [ide_register_hw+334/384] ide_register_hw+0x14e/0x180
 [__crc_parport_ieee1284_epp_write_data+1417244/6889293] 
idecs_register+0x58/0x70 [ide_cs]
 [CardServices+533/862] CardServices+0x215/0x35e
 [__crc_parport_ieee1284_epp_write_data+1418579/6889293] 
ide_config+0x51f/0x840 [ide_cs]
 [scheduler_tick+94/768] scheduler_tick+0x5e/0x300
 [update_process_times+70/96] update_process_times+0x46/0x60
 [tasklet_action+70/112] tasklet_action+0x46/0x70
 [do_IRQ+197/240] do_IRQ+0xc5/0xf0
 [common_interrupt+24/32] common_interrupt+0x18/0x20
 [read_cis_cache+134/384] read_cis_cache+0x86/0x180
 [pcmcia_get_next_tuple+588/688] pcmcia_get_next_tuple+0x24c/0x2b0
 [pcmcia_get_first_tuple+188/368] pcmcia_get_first_tuple+0xbc/0x170
 [yenta_set_mem_map+417/496] yenta_set_mem_map+0x1a1/0x1f0
 [scheduler_tick+94/768] scheduler_tick+0x5e/0x300
 [update_process_times+70/96] update_process_times+0x46/0x60
 [tasklet_action+70/112] tasklet_action+0x46/0x70
 [do_IRQ+197/240] do_IRQ+0xc5/0xf0
 [common_interrupt+24/32] common_interrupt+0x18/0x20
 [read_cis_cache+134/384] read_cis_cache+0x86/0x180
 [pcmcia_get_next_tuple+588/688] pcmcia_get_next_tuple+0x24c/0x2b0
 [pcmcia_get_first_tuple+188/368] pcmcia_get_first_tuple+0xbc/0x170
 [read_cis_cache+244/384] read_cis_cache+0xf4/0x180
 [pcmcia_get_next_tuple+588/688] pcmcia_get_next_tuple+0x24c/0x2b0
 [pcmcia_validate_cis+307/528] pcmcia_validate_cis+0x133/0x210
 [__find_get_block+108/192] __find_get_block+0x6c/0xc0
 [create_virtual_node+838/1328] create_virtual_node+0x346/0x530
 [pathrelse_and_restore+67/80] pathrelse_and_restore+0x43/0x50
 [__crc_parport_ieee1284_epp_write_data+1419775/6889293] 
ide_event+0x6b/0x110 [ide_cs]
 [pcmcia_register_client+517/576] pcmcia_register_client+0x205/0x240
 [yenta_set_mem_map+417/496] yenta_set_mem_map+0x1a1/0x1f0
 [reiserfs_cut_from_item+421/1168] reiserfs_cut_from_item+0x1a5/0x490
 [bh_lru_install+164/224] bh_lru_install+0xa4/0xe0
 [CardServices+430/862] CardServices+0x1ae/0x35e
 [__crc_parport_ieee1284_epp_write_data+1416901/6889293] 
ide_attach+0x111/0x150 [ide_cs]
 [__crc_parport_ieee1284_epp_write_data+1419668/6889293] 
ide_event+0x0/0x110 [ide_cs]
 [get_pcmcia_driver+55/80] get_pcmcia_driver+0x37/0x50
 [bind_request+216/432] bind_request+0xd8/0x1b0
 [ds_ioctl+1388/1696] ds_ioctl+0x56c/0x6a0
 [sock_def_readable+95/112] sock_def_readable+0x5f/0x70
 [unix_dgram_sendmsg+1011/1232] unix_dgram_sendmsg+0x3f3/0x4d0
 [buffered_rmqueue+178/336] buffered_rmqueue+0xb2/0x150
 [sock_sendmsg+158/208] sock_sendmsg+0x9e/0xd0
 [do_anonymous_page+273/480] do_anonymous_page+0x111/0x1e0
 [wake_up_inode+15/48] wake_up_inode+0xf/0x30
 [buffered_rmqueue+178/336] buffered_rmqueue+0xb2/0x150
 [zap_pmd_range+75/112] zap_pmd_range+0x4b/0x70
 [unmap_page_range+75/144] unmap_page_range+0x4b/0x90
 [unmap_vmas+255/576] unmap_vmas+0xff/0x240
 [unmap_region+149/224] unmap_region+0x95/0xe0
 [unmap_vma+72/144] unmap_vma+0x48/0x90
 [unmap_vma_list+31/48] unmap_vma_list+0x1f/0x30
 [do_munmap+304/384] do_munmap+0x130/0x180
 [sys_ioctl+201/592] sys_ioctl+0xc9/0x250
 [sys_munmap+68/112] sys_munmap+0x44/0x70
 [syscall_call+7/11] syscall_call+0x7/0xb

Module ide_cs cannot be unloaded due to unsafe usage in 
include/linux/module.h:482
ide-cs: hde: Vcc = 3.3, Vpp = 0.0


