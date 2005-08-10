Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965145AbVHJPCA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965145AbVHJPCA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Aug 2005 11:02:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965146AbVHJPCA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Aug 2005 11:02:00 -0400
Received: from dsl3-63-249-67-204.cruzio.com ([63.249.67.204]:48561 "EHLO
	cichlid.com") by vger.kernel.org with ESMTP id S965145AbVHJPB7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Aug 2005 11:01:59 -0400
Date: Wed, 10 Aug 2005 07:58:40 -0700
From: Andrew Burgess <aab@cichlid.com>
Message-Id: <200508101458.j7AEwepW008555@cichlid.com>
To: linux-kernel@vger.kernel.org
Subject: Oops: Real-Time Preemption 2.6.13-rc5-RT-V0.7.52-16 kmem_cache_alloc?
Cc: mingo@elte.hu
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm making another kernel with SLAB_DEBUG set, sound correct?

messages:

Aug  9 17:22:26 cichlid kernel: Linux version 2.6.13-rc5-RT-V0.7.52-16-up-1 (root@athlon) (gcc version 3.4.4 20050721 (Red Hat 3.4.4-2)) #1 Mon Aug 8 16:02:26 PDT 2005
...
Aug  9 17:22:27 cichlid kernel: Kernel command line: ro root=LABEL=/ rhgb vga=791 pci=noacpi noapic acpi=ht
...
Aug 10 05:15:04 cichlid kernel: Oops: 0002 [#1]
Aug 10 05:15:04 cichlid kernel: PREEMPT 
Aug 10 05:15:04 cichlid kernel: Modules linked in: w83627hf eeprom i2c_sensor i2c_isa i2c_dev snd_usb_audio snd_usb_lib snd_hwdep snd_ice1712 snd_ice17xx_ak4xxx snd_ak4xxx_adda snd_cs8427 snd_i2c snd_mpu401_uart snd_rawmidi snd_seq_device snd_intel8x0 snd_ac97_codec snd_pcm_oss snd_mixer_oss snd_pcm snd_timer snd soundcore snd_page_alloc uhci_hcd ipt_TOS ipt_state ipt_REJECT ipt_MASQUERADE ipt_LOG ipt_multiport ip_nat_ftp ip_conntrack_ftp iptable_mangle iptable_nat ip_conntrack usb_storage ftdi_sio usbserial emi26 dsbr100 parport_pc lp parport ipv6 autofs4 sunrpc iptable_filter ip_tables nls_utf8 loop ohci1394 ieee1394 ehci_hcd bt878 bttv video_buf v4l2_common btcx_risc tveeprom videodev nvidiafb i2c_algo_bit intel_agp agpgart i2c_i801 i2c_core pdc202xx_old kaweth usbnet mii floppy ext3 jbd dm_mod ata_piix libata 3w_xxxx sd_mod scsi_mod
Aug 10 05:15:04 cichlid kernel: CPU:    0
Aug 10 05:15:04 cichlid rt_monitor[6215]: 49 processes 12% cpu
Aug 10 05:15:04 cichlid kernel: EIP:    0060:[cache_alloc_refill+231/593]    Not tainted VLI
Aug 10 05:15:04 cichlid kernel: EIP:    0060:[<c0140c58>]    Not tainted VLI
Aug 10 05:15:04 cichlid kernel: EFLAGS: 00010246   (2.6.13-rc5-RT-V0.7.52-16-up-1) 
Aug 10 05:15:04 cichlid kernel: EIP is at cache_alloc_refill+0xe7/0x251
Aug 10 05:15:04 cichlid kernel: eax: 2e2f312e   ebx: ffffffff   ecx: ca16c000   edx: f7cde48c
Aug 10 05:15:04 cichlid kernel: esi: ca16c018   edi: f7cde480   ebp: c253bcf0   esp: c253bcc0
Aug 10 05:15:04 cichlid kernel: ds: 007b   es: 007b   ss: 0068   preempt: 00000001
Aug 10 05:15:04 cichlid kernel: Process cp (pid: 10480, threadinfo=c253a000 task=c424a7b0 stack_left=7308 worst_left=-1)
Aug 10 05:15:04 cichlid kernel: Stack: c846621c 00000000 c253bcd0 f7cb2400 f7cb2410 f7cde48c f7cde494 c253bcfc 
Aug 10 05:15:04 cichlid kernel:        c19bac60 f7cde4c4 f7cde480 f7136c00 c253bd10 c0140ff0 f7cde480 00000050 
Aug 10 05:15:04 cichlid kernel:        00000000 80000000 00000000 d6a2f048 c253bd20 f8bda24d f7cde480 00000050 
Aug 10 05:15:04 cichlid kernel: Call Trace:
Aug 10 05:15:04 cichlid kernel:  [show_stack+128/150] show_stack+0x80/0x96 (28)
Aug 10 05:15:04 cichlid kernel:  [<c01035b4>] show_stack+0x80/0x96 (28)
Aug 10 05:15:04 cichlid kernel:  [show_registers+405/511] show_registers+0x195/0x1ff (56)
Aug 10 05:15:04 cichlid kernel:  [<c010377b>] show_registers+0x195/0x1ff (56)
Aug 10 05:15:04 cichlid kernel:  [die+243/387] die+0xf3/0x183 (64)
Aug 10 05:15:04 cichlid kernel:  [<c0103975>] die+0xf3/0x183 (64)
Aug 10 05:15:04 cichlid kernel:  [do_page_fault+870/1402] do_page_fault+0x366/0x57a (92)
Aug 10 05:15:04 cichlid kernel:  [<c01124cc>] do_page_fault+0x366/0x57a (92)
Aug 10 05:15:04 cichlid kernel:  [error_code+79/84] error_code+0x4f/0x54 (108)
Aug 10 05:15:04 cichlid kernel:  [<c01031f7>] error_code+0x4f/0x54 (108)
Aug 10 05:15:04 cichlid kernel:  [kmem_cache_alloc+185/189] kmem_cache_alloc+0xb9/0xbd (32)
Aug 10 05:15:04 cichlid kernel:  [<c0140ff0>] kmem_cache_alloc+0xb9/0xbd (32)
Aug 10 05:15:05 cichlid kernel:  [pg0+947561037/1069343744] ext3_alloc_inode+0x1b/0x4a [ext3] (16)
Aug 10 05:15:05 cichlid kernel:  [<f8bda24d>] ext3_alloc_inode+0x1b/0x4a [ext3] (16)
Aug 10 05:15:05 cichlid kernel:  [alloc_inode+30/398] alloc_inode+0x1e/0x18e (28)
Aug 10 05:15:05 cichlid kernel:  [<c017068e>] alloc_inode+0x1e/0x18e (28)
Aug 10 05:15:05 cichlid kernel:  [get_new_inode_fast+20/284] get_new_inode_fast+0x14/0x11c (32)
Aug 10 05:15:05 cichlid kernel:  [<c0171375>] get_new_inode_fast+0x14/0x11c (32)
Aug 10 05:15:05 cichlid kernel:  [iget_locked+187/221] iget_locked+0xbb/0xdd (36)
Aug 10 05:15:05 cichlid kernel:  [<c0171924>] iget_locked+0xbb/0xdd (36)
Aug 10 05:15:05 cichlid kernel:  [pg0+947548294/1069343744] ext3_lookup+0x59/0xb8 [ext3] (32)
Aug 10 05:15:05 cichlid kernel:  [<f8bd7086>] ext3_lookup+0x59/0xb8 [ext3] (32)
Aug 10 05:15:05 cichlid kernel:  [real_lookup+173/209] real_lookup+0xad/0xd1 (36)
Aug 10 05:15:05 cichlid kernel:  [<c0164a83>] real_lookup+0xad/0xd1 (36)
Aug 10 05:15:05 cichlid kernel:  [do_lookup+137/149] do_lookup+0x89/0x95 (36)
Aug 10 05:15:05 cichlid kernel:  [<c0164dd7>] do_lookup+0x89/0x95 (36)
Aug 10 05:15:05 cichlid kernel:  [__link_path_walk+1978/4246] __link_path_walk+0x7ba/0x1096 (100)
Aug 10 05:15:05 cichlid kernel:  [<c016559d>] __link_path_walk+0x7ba/0x1096 (100)
Aug 10 05:15:05 cichlid kernel:  [link_path_walk+66/270] link_path_walk+0x42/0x10e (100)
Aug 10 05:15:05 cichlid kernel:  [<c0165ebb>] link_path_walk+0x42/0x10e (100)
Aug 10 05:15:05 cichlid kernel:  [path_lookup+147/444] path_lookup+0x93/0x1bc (36)
Aug 10 05:15:05 cichlid kernel:  [<c0166229>] path_lookup+0x93/0x1bc (36)
Aug 10 05:15:05 cichlid kernel:  [__user_walk+53/82] __user_walk+0x35/0x52 (32)
Aug 10 05:15:05 cichlid kernel:  [<c01664ea>] __user_walk+0x35/0x52 (32)
Aug 10 05:15:05 cichlid kernel:  [vfs_lstat+23/82] vfs_lstat+0x17/0x52 (92)
Aug 10 05:15:05 cichlid kernel:  [<c01608aa>] vfs_lstat+0x17/0x52 (92)
Aug 10 05:15:05 cichlid kernel:  [sys_lstat64+25/56] sys_lstat64+0x19/0x38 (100)
Aug 10 05:15:05 cichlid kernel:  [<c0160eef>] sys_lstat64+0x19/0x38 (100)
Aug 10 05:15:05 cichlid kernel:  [sysenter_past_esp+84/117] sysenter_past_esp+0x54/0x75 (-8116)
Aug 10 05:15:05 cichlid kernel:  [<c0102f7b>] sysenter_past_esp+0x54/0x75 (-8116)
Aug 10 05:15:05 cichlid kernel: Code: 01 8b 51 10 0f b7 41 14 83 c2 01 89 51 10 0f b7 04 46 66 89 41 14 8b 7d 08 3b 57 3c 73 08 83 eb 01 83 fb ff 75 bd 8b 51 04 8b 01 <89> 50 04 89 02 c7 41 04 00 02 20 00 66 83 79 14 ff c7 01 00 01 
