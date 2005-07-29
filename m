Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262262AbVG2DyE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262262AbVG2DyE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 23:54:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262283AbVG2DyE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 23:54:04 -0400
Received: from livid.absolutedigital.net ([66.92.46.173]:17671 "EHLO
	mx2.absolutedigital.net") by vger.kernel.org with ESMTP
	id S262262AbVG2DyC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 23:54:02 -0400
Date: Thu, 28 Jul 2005 23:54:07 -0400 (EDT)
From: Cal Peake <cp@absolutedigital.net>
To: Linus Torvalds <torvalds@osdl.org>, perex@suse.cz
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.13-rc4 (snd-cs46xx)
In-Reply-To: <Pine.LNX.4.58.0507281625270.3307@g5.osdl.org>
Message-ID: <Pine.LNX.4.61.0507282328520.966@lancer.cnet.absolutedigital.net>
References: <Pine.LNX.4.58.0507281625270.3307@g5.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Getting this nastiness when probing snd-cs46xx:

Unable to handle kernel paging request at virtual address 000a75a8
 printing eip:
c01afe52
*pde = 00000000
Oops: 0000 [#1]
Modules linked in: snd_cs46xx gameport snd_rawmidi snd_seq_device snd_ac97_codec snd_pcm snd_timer snd soundcore snd_page_alloc ipt_state ipt_REJECT ipt_LOG ip_conntrack iptable_filter ip_tables nfs lockd sunrpc cifs smbfs hfsplus udf isofs zlib_inflate ntfs msdos vfat fat nls_utf8 nls_iso8859_1 nls_cp437 nls_base e100 mii usb_storage sd_mod scsi_mod usbhid ohci_hcd ehci_hcd usbcore parport_pc parport psmouse pcspkr ide_cd cdrom floppy loop radeon drm nvidia_agp agpgart thermal processor fan button ac
CPU:    0
EIP:    0060:[<c01afe52>]    Not tainted VLI
EFLAGS: 00010246   (2.6.13-rc4) 
EIP is at sub_alloc+0x42/0x170
eax: 00000440   ebx: 00000022   ecx: 00000000   edx: f7c3cd5c
esi: 00000440   edi: 000a75a8   ebp: 00000000   esp: f7c3cd44
ds: 007b   es: 007b   ss: 0068
Process modprobe (pid: 762, threadinfo=f7c3c000 task=f7df4550)
Stack: f7c3cd5c 00000020 00000000 00000440 00000440 00000000 00000000 c1cdf26c 
       c1ceaf54 00000000 c1cdf260 000000d0 ffffffff f7736018 c1cdf26c 00000002 
       f7733f60 c1ceaf54 c0335a74 c01afff8 c0335a74 00000000 f7c3cda0 00000000 
Call Trace:
 [<c01afff8>] idr_get_new_above_int+0x78/0x120
 [<c01b010f>] idr_get_new+0x1f/0x50
 [<c017d409>] get_inode_number+0x39/0x60
 [<c017d6c7>] proc_register+0x17/0xb0
 [<c017db05>] create_proc_entry+0x85/0xd0
 [<f8b18f80>] snd_create_proc_entry+0x20/0x30 [snd]
 [<f8b194f4>] snd_info_register+0x44/0xb0 [snd]
 [<f8bbc0d2>] snd_pcm_lib_preallocate_pages1+0x92/0xd0 [snd_pcm]
 [<f8bbc184>] snd_pcm_lib_preallocate_pages_for_all+0x44/0x70 [snd_pcm]
 [<f8be5030>] snd_cs46xx_pcm_rear+0xe0/0x100 [snd_cs46xx]
 [<f8be30f9>] snd_card_cs46xx_probe+0xf9/0x250 [snd_cs46xx]
 [<c01b9cbd>] pci_match_device+0x1d/0xb0
 [<c01b9da8>] __pci_device_probe+0x58/0x70
 [<c01b9def>] pci_device_probe+0x2f/0x50
 [<c01fb168>] driver_probe_device+0x38/0xb0
 [<c01fb270>] __driver_attach+0x0/0x50
 [<c01fb2bc>] __driver_attach+0x4c/0x50
 [<c01fa799>] bus_for_each_dev+0x69/0x80
 [<c01fb2e6>] driver_attach+0x26/0x30
 [<c01fb270>] __driver_attach+0x0/0x50
 [<c01fac73>] bus_add_driver+0x83/0xe0
 [<c01ba08d>] pci_register_driver+0x6d/0x90
 [<f897e00f>] alsa_card_cs46xx_init+0xf/0x13 [snd_cs46xx]
 [<c012efb1>] sys_init_module+0x141/0x1d0
 [<c0102c95>] syscall_call+0x7/0xb
Code: 08 8b 3a c7 44 8c 1c 00 00 00 00 49 89 4c 24 14 8d 2c 89 8d b6 00 00 00 00 8b 44 24 10 89 e9 8d 54 24 18 d3 f8 89 44 24 0c 89 c6 <8b> 07 83 e6 1f c7 44 24 04 20 00 00 00 89 14 24 89 74 24 08 f7 
 

2.6.13-rc3-git9 is OK. I'll try poking around at the ALSA changes, see if 
I can figure out which one is the culprit.

thx,
-cp

-- 
"Democracy can learn some things from Communism; for example,
   when a Communist politician is through, he is through."
                        -- Unknown
