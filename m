Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266839AbUIIToO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266839AbUIIToO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 15:44:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266825AbUIITmJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 15:42:09 -0400
Received: from main.gmane.org ([80.91.224.249]:23508 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S266850AbUIITdY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 15:33:24 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Pasi Savolainen <psavo@iki.fi>
Subject: Re: 2.6.9-rc1-mm4
Date: Thu, 9 Sep 2004 19:33:21 +0000 (UTC)
Message-ID: <slrnck1c00.qoe.psavo@varg.dyndns.org>
References: <20040907020831.62390588.akpm@osdl.org> <slrnck16pl.qoe.psavo@varg.dyndns.org>
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: a11a.mannikko1.ton.tut.fi
User-Agent: slrn/0.9.8.0 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Pasi Savolainen <psavo@iki.fi>:
> * Andrew Morton <akpm@osdl.org>:
>>
>>
>> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.9-rc1/2.6.9-rc1-mm4/
>>
>
...
> (firefox, opera, all have run for hours).

Eh, started other SNES emulator (snes9x) and hit this with opera:

Sep  9 22:05:14 tienel kernel: c01326ff
Sep  9 22:05:14 tienel kernel: PREEMPT SMP 
Sep  9 22:05:14 tienel kernel: Modules linked in: joydev usbhid mga sd_mod sg sr_mod ide_cd cdrom parport_pc lp parport binfmt _misc ipv6 uhci_hcd ohci_hcd ehci_hcd nls_iso8859_1 nls_cp437 vfat fat usb_storage usbcore scsi_mod amd76x_pm amd_k7_agp agpgart snd_ens1371 snd_rawmidi snd_seq_device snd_pcm_oss snd_mixer_oss snd_pcm snd_timer snd_page_alloc snd_ac97_codec snd soundcore gameport w83781d i2c_sensor i2c_amd756 i2c_core eepro100 mii
Sep  9 22:05:14 tienel kernel: CPU:    1
Sep  9 22:05:14 tienel kernel: EIP:    0060:[remove_wait_queue+31/112] Not tainted VLI
Sep  9 22:05:14 tienel kernel: EFLAGS: 00010012   (2.6.9-rc1-mm4) 
Sep  9 22:05:14 tienel kernel: EIP is at remove_wait_queue+0x1f/0x70
Sep  9 22:05:14 tienel kernel: eax: 00000000   ebx: e66acff0   ecx: e66ad040   edx: e66acffc
Sep  9 22:05:14 tienel kernel: esi: e66ad040   edi: 00000296   ebp: 00000005   esp: f29c7ed8
Sep  9 22:05:14 tienel kernel: ds: 007b   es: 007b   ss: 0068
Sep  9 22:05:14 tienel kernel: Process opera (pid: 2479, threadinfo=f29c6000 task=f7d5d000)
Sep  9 22:05:14 tienel kernel: Stack: e66acfec c016a3c4 e66ad000 c016a3c4 00000000 00000000 00000005 c016a75d 
Sep  9 22:05:14 tienel kernel:        00000000 00000000 00000018 00000000 00000000 00000000 00000104 00000018 
Sep  9 22:05:14 tienel kernel:        f29c6000 f7b7f3cc f7b7f3c8 f7b7f3c4 f7b7f3d8 f7b7f3d4 f7b7f3d0 00000000 
Sep  9 22:05:14 tienel kernel: Call Trace:
Sep  9 22:05:14 tienel kernel:  [poll_freewait+36/80] poll_freewait+0x24/0x50
Sep  9 22:05:14 tienel kernel:  [poll_freewait+36/80] poll_freewait+0x24/0x50
Sep  9 22:05:14 tienel kernel:  [do_select+445/704] do_select+0x1bd/0x2c0
Sep  9 22:05:14 tienel kernel:  [__pollwait+0/208] __pollwait+0x0/0xd0
Sep  9 22:05:14 tienel kernel:  [sys_select+686/1184] sys_select+0x2ae/0x4a0
Sep  9 22:05:14 tienel kernel:  [unix_ioctl+127/208] unix_ioctl+0x7f/0xd0
Sep  9 22:05:14 tienel kernel:  [sys_gettimeofday+44/112] sys_gettimeofday+0x2c/0x70
Sep  9 22:05:14 tienel kernel:  [sysenter_past_esp+82/113] sysenter_past_esp+0x52/0x71
Sep  9 22:05:14 tienel kernel: Code: 00 8d 74 26 00 8d bc 27 00 00 00 00 83 ec 0c 89 1c 24 89 74 24 04 89 7c 24 08 89 d3 89 c6 e8 c9 a4 15 00 8d 53 0c 89 c7 8b 42 04 <39> 10 75 3c 8b 4b 0c 39 51 04 75 2a 89 41 04 89 08 c7 42 04 00 
Sep  9 22:05:14 tienel kernel:  <6>note: opera[2479] exited with preempt_count 1
Sep  9 22:05:14 tienel kernel:  [schedule+1503/1520] schedule+0x5df/0x5f0
Sep  9 22:05:14 tienel kernel:  [zap_pmd_range+63/96] zap_pmd_range+0x3f/0x60
Sep  9 22:05:14 tienel kernel:  [free_pages_and_swap_cache+87/128] free_pages_and_swap_cache+0x57/0x80
Sep  9 22:05:14 tienel kernel:  [unmap_vmas+448/512] unmap_vmas+0x1c0/0x200
Sep  9 22:05:14 tienel kernel:  [exit_mmap+144/352] exit_mmap+0x90/0x160
Sep  9 22:05:14 tienel kernel:  [mmput+45/192] mmput+0x2d/0xc0
Sep  9 22:05:14 tienel kernel:  [do_exit+369/1040] do_exit+0x171/0x410
Sep  9 22:05:14 tienel kernel:  [die+380/384] die+0x17c/0x180
Sep  9 22:05:14 tienel kernel:  [do_page_fault+0/1376] do_page_fault+0x0/0x560
Sep  9 22:05:14 tienel kernel:  [do_page_fault+520/1376] do_page_fault+0x208/0x560
Sep  9 22:05:14 tienel kernel:  [find_busiest_queue+145/176] find_busiest_queue+0x91/0xb0
Sep  9 22:05:14 tienel kernel:  [load_balance_newidle+116/144] load_balance_newidle+0x74/0x90
Sep  9 22:05:14 tienel kernel:  [finish_task_switch+59/144] finish_task_switch+0x3b/0x90
Sep  9 22:05:14 tienel kernel:  [schedule+698/1520] schedule+0x2ba/0x5f0
Sep  9 22:05:14 tienel kernel:  [do_page_fault+0/1376] do_page_fault+0x0/0x560
Sep  9 22:05:14 tienel kernel:  [error_code+45/56] error_code+0x2d/0x38
Sep  9 22:05:14 tienel kernel:  [remove_wait_queue+31/112] remove_wait_queue+0x1f/0x70
Sep  9 22:05:14 tienel kernel:  [poll_freewait+36/80] poll_freewait+0x24/0x50
Sep  9 22:05:14 tienel kernel:  [poll_freewait+36/80] poll_freewait+0x24/0x50
Sep  9 22:05:14 tienel kernel:  [do_select+445/704] do_select+0x1bd/0x2c0
Sep  9 22:05:14 tienel kernel:  [__pollwait+0/208] __pollwait+0x0/0xd0
Sep  9 22:05:14 tienel kernel:  [sys_select+686/1184] sys_select+0x2ae/0x4a0
Sep  9 22:05:14 tienel kernel:  [unix_ioctl+127/208] unix_ioctl+0x7f/0xd0
Sep  9 22:05:14 tienel kernel:  [sys_gettimeofday+44/112] sys_gettimeofday+0x2c/0x70
Sep  9 22:05:14 tienel kernel:  [sysenter_past_esp+82/113] sysenter_past_esp+0x52/0x71

-- 
Psi -- <http://iki.fi/psavo>

