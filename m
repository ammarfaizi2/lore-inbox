Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266555AbUIISZR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266555AbUIISZR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 14:25:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266547AbUIISX7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 14:23:59 -0400
Received: from main.gmane.org ([80.91.224.249]:15058 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S266491AbUIISEq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 14:04:46 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Pasi Savolainen <psavo@iki.fi>
Subject: Re: 2.6.9-rc1-mm4
Date: Thu, 9 Sep 2004 18:04:37 +0000 (UTC)
Message-ID: <slrnck16pl.qoe.psavo@varg.dyndns.org>
References: <20040907020831.62390588.akpm@osdl.org>
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: a11a.mannikko1.ton.tut.fi
User-Agent: slrn/0.9.8.0 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Andrew Morton <akpm@osdl.org>:
>
>
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.9-rc1/2.6.9-rc1-mm4/
>

Got these two. Just upgraded from 2.6.7-mm1. I think zsnes (SNES
emulator) is causing these as both happened within minutes of starting
it. X just dies and leaves video in graphics mode, keyboard and mouse
are not rebindable (screen cleaned up after startx from ssh login).
The latter one (19:35:05) is probably more interesting, as zsnes died
seconds before X did. Without running zsnes, system seems stable
(firefox, opera, all have run for hours).

Thanks.

- -
Sep  9 18:51:58 tienel syslogd 1.4.1#15: restart.
Sep  9 18:51:58 tienel kernel: klogd 1.4.1#15, log source = /proc/kmsg started.
Sep  9 18:51:58 tienel kernel: Inspecting /boot/System.map-2.6.9-rc1-mm4
Sep  9 18:51:58 tienel kernel: Loaded 27134 symbols from /boot/System.map-2.6.9-rc1-mm4.
Sep  9 18:51:58 tienel kernel: Symbols match kernel version 2.6.9.
Sep  9 18:51:58 tienel kernel: No module symbols loaded - kernel modules not enabled. 
Sep  9 18:51:58 tienel kernel: Linux version 2.6.9-rc1-mm4 (root@tienel) (gcc version 3.3.4 (Debian 1:3.3.4-11)) #1 SMP Thu Sep 9 18:10:50 EEST 2004
...
Sep  9 19:23:35 tienel kernel: c01326ff
Sep  9 19:23:35 tienel kernel: PREEMPT SMP 
Sep  9 19:23:35 tienel kernel: Modules linked in: ntfs joydev usbhid mga sd_mod sg sr_mod ide_cd cdrom parport_pc lp parport binfmt_misc ipv6 uhci_hcd ohci_hcd ehci_hcd nls_iso8859_1 nls_cp437 vfat fat usb_storage usbcore scsi_mod amd76x_pm amd_k7_agp agpgart snd_ens1371 snd_rawmidi snd_seq_device snd_pcm_oss snd_mixer_oss snd_pcm snd_timer snd_page_alloc snd_ac97_codec snd soundcore gameport w83781d i2c_sensor i2c_amd756 i2c_core eepro100 mii
Sep  9 19:23:35 tienel kernel: CPU:    1
Sep  9 19:23:35 tienel kernel: EIP:    0060:[remove_wait_queue+31/112]    Not tainted VLI
Sep  9 19:23:35 tienel kernel: EFLAGS: 00013012   (2.6.9-rc1-mm4) 
Sep  9 19:23:35 tienel kernel: EIP is at remove_wait_queue+0x1f/0x70
Sep  9 19:23:35 tienel kernel: eax: 00000000   ebx: e5a74ff0   ecx: e5a7521c   edx: e5a74ffc
Sep  9 19:23:35 tienel kernel: esi: e5a7521c   edi: 00003296   ebp: 00000018   esp: f6e1fed8
Sep  9 19:23:35 tienel kernel: ds: 007b   es: 007b   ss: 0068
Sep  9 19:23:35 tienel kernel: Process XFree86 (pid: 2026, threadinfo=f6e1e000 task=f6dde000)
Sep  9 19:23:35 tienel kernel: Stack: e5a74fec c016a3c4 e5a75000 c016a3c4 00000000 00800000 00000018 c016a75d 
Sep  9 19:23:35 tienel kernel:        00000000 00000000 00ffff0a 00000000 00000000 00800000 00000345 00ffff0a 
Sep  9 19:23:35 tienel kernel:        f6e1e000 f6dc00e4 f6dc00c4 f6dc00a4 f6dc0144 f6dc0124 f6dc0104 00124f4e 
Sep  9 19:23:35 tienel kernel: Call Trace:
Sep  9 19:23:35 tienel kernel:  [poll_freewait+36/80] poll_freewait+0x24/0x50
Sep  9 19:23:35 tienel kernel:  [poll_freewait+36/80] poll_freewait+0x24/0x50
Sep  9 19:23:35 tienel kernel:  [do_select+445/704] do_select+0x1bd/0x2c0
Sep  9 19:23:35 tienel kernel:  [__pollwait+0/208] __pollwait+0x0/0xd0
Sep  9 19:23:35 tienel kernel:  [sys_select+686/1184] sys_select+0x2ae/0x4a0
Sep  9 19:23:35 tienel kernel:  [sys_gettimeofday+44/112] sys_gettimeofday+0x2c/0x70
Sep  9 19:23:35 tienel kernel:  [sysenter_past_esp+82/113] sysenter_past_esp+0x52/0x71
Sep  9 19:23:35 tienel kernel: Code: 00 8d 74 26 00 8d bc 27 00 00 00 00 83 ec 0c 89 1c 24 89 74 24 04 89 7c 24 08 89 d3 89 c6 e8 c9 a4 15 00 8d 53 0c 89 c7 8b 42 04 <39> 10 75 3c 8b 4b 0c 39 51 04 75 2a 89 41 04 89 08 c7 42 04 00 
Sep  9 19:23:35 tienel kernel:  <6>note: XFree86[2026] exited with preempt_count 1
Sep  9 19:23:35 tienel kernel:  [schedule+1503/1520] schedule+0x5df/0x5f0
Sep  9 19:23:35 tienel kernel:  [free_pages_and_swap_cache+87/128] free_pages_and_swap_cache+0x57/0x80
Sep  9 19:23:35 tienel kernel:  [unmap_vmas+448/512] unmap_vmas+0x1c0/0x200
Sep  9 19:23:35 tienel kernel:  [exit_mmap+144/352] exit_mmap+0x90/0x160
Sep  9 19:23:35 tienel kernel:  [mmput+45/192] mmput+0x2d/0xc0
Sep  9 19:23:35 tienel kernel:  [do_exit+369/1040] do_exit+0x171/0x410
Sep  9 19:23:35 tienel kernel:  [die+380/384] die+0x17c/0x180
Sep  9 19:23:35 tienel kernel:  [do_page_fault+0/1376] do_page_fault+0x0/0x560
Sep  9 19:23:35 tienel kernel:  [do_page_fault+520/1376] do_page_fault+0x208/0x560
Sep  9 19:23:35 tienel kernel:  [find_busiest_queue+145/176] find_busiest_queue+0x91/0xb0
Sep  9 19:23:35 tienel kernel:  [load_balance_newidle+116/144] load_balance_newidle+0x74/0x90
Sep  9 19:23:35 tienel kernel:  [finish_task_switch+59/144] finish_task_switch+0x3b/0x90
Sep  9 19:23:35 tienel kernel:  [schedule+698/1520] schedule+0x2ba/0x5f0
Sep  9 19:23:35 tienel kernel:  [__alloc_pages+552/944] __alloc_pages+0x228/0x3b0
Sep  9 19:23:35 tienel kernel:  [do_page_fault+0/1376] do_page_fault+0x0/0x560
Sep  9 19:23:35 tienel kernel:  [error_code+45/56] error_code+0x2d/0x38
Sep  9 19:23:35 tienel kernel:  [remove_wait_queue+31/112] remove_wait_queue+0x1f/0x70
Sep  9 19:23:35 tienel kernel:  [poll_freewait+36/80] poll_freewait+0x24/0x50
Sep  9 19:23:35 tienel kernel:  [poll_freewait+36/80] poll_freewait+0x24/0x50
Sep  9 19:23:35 tienel kernel:  [do_select+445/704] do_select+0x1bd/0x2c0
Sep  9 19:23:35 tienel kernel:  [__pollwait+0/208] __pollwait+0x0/0xd0
Sep  9 19:23:35 tienel kernel:  [sys_select+686/1184] sys_select+0x2ae/0x4a0
Sep  9 19:23:35 tienel kernel:  [sys_gettimeofday+44/112] sys_gettimeofday+0x2c/0x70
Sep  9 19:23:35 tienel kernel:  [sysenter_past_esp+82/113] sysenter_past_esp+0x52/0x71
Sep  9 19:23:35 tienel kernel:  [schedule+1503/1520] schedule+0x5df/0x5f0
Sep  9 19:23:35 tienel kernel:  [__wake_up_common+55/96] __wake_up_common+0x37/0x60
Sep  9 19:23:35 tienel kernel:  [wait_for_completion+122/224] wait_for_completion+0x7a/0xe0
Sep  9 19:23:35 tienel kernel:  [default_wake_function+0/16] default_wake_function+0x0/0x10
Sep  9 19:23:35 tienel kernel:  [default_wake_function+0/16] default_wake_function+0x0/0x10
Sep  9 19:23:35 tienel kernel:  [call_usermodehelper+176/192] call_usermodehelper+0xb0/0xc0
Sep  9 19:23:35 tienel kernel:  [__call_usermodehelper+0/80] __call_usermodehelper+0x0/0x50
Sep  9 19:23:35 tienel kernel:  [kset_hotplug+418/496] kset_hotplug+0x1a2/0x1f0
Sep  9 19:23:35 tienel kernel:  [sysfs_hash_and_remove+119/225] sysfs_hash_and_remove+0x77/0xe1
Sep  9 19:23:35 tienel kernel:  [kobject_del+15/32] kobject_del+0xf/0x20
Sep  9 19:23:35 tienel kernel:  [class_device_del+136/176] class_device_del+0x88/0xb0
Sep  9 19:23:35 tienel kernel:  [class_device_unregister+8/16] class_device_unregister+0x8/0x10
Sep  9 19:23:35 tienel kernel:  [vcs_remove_devfs+17/36] vcs_remove_devfs+0x11/0x24
Sep  9 19:23:35 tienel kernel:  [con_close+132/144] con_close+0x84/0x90
Sep  9 19:23:35 tienel kernel:  [release_dev+1636/1664] release_dev+0x664/0x680
Sep  9 19:23:35 tienel kernel:  [skb_dequeue+75/96] skb_dequeue+0x4b/0x60
Sep  9 19:23:35 tienel kernel:  [skb_queue_purge+10/64] skb_queue_purge+0xa/0x40
Sep  9 19:23:35 tienel kernel:  [unix_sock_destructor+17/256] unix_sock_destructor+0x11/0x100
Sep  9 19:23:35 tienel kernel:  [dput+30/496] dput+0x1e/0x1f0
Sep  9 19:23:35 tienel kernel:  [unix_release_sock+406/560] unix_release_sock+0x196/0x230
Sep  9 19:23:35 tienel kernel:  [invalidate_inode_buffers+21/160] invalidate_inode_buffers+0x15/0xa0
Sep  9 19:23:35 tienel kernel:  [clear_inode+18/208] clear_inode+0x12/0xd0
Sep  9 19:23:35 tienel kernel:  [tty_release+53/112] tty_release+0x35/0x70
Sep  9 19:23:35 tienel kernel:  [__fput+265/288] __fput+0x109/0x120
Sep  9 19:23:35 tienel kernel:  [filp_close+79/128] filp_close+0x4f/0x80
Sep  9 19:23:35 tienel kernel:  [put_files_struct+89/176] put_files_struct+0x59/0xb0
Sep  9 19:23:35 tienel kernel:  [do_exit+417/1040] do_exit+0x1a1/0x410
Sep  9 19:23:35 tienel kernel:  [die+380/384] die+0x17c/0x180
Sep  9 19:23:35 tienel kernel:  [do_page_fault+0/1376] do_page_fault+0x0/0x560
Sep  9 19:23:35 tienel kernel:  [do_page_fault+520/1376] do_page_fault+0x208/0x560
Sep  9 19:23:35 tienel kernel:  [find_busiest_queue+145/176] find_busiest_queue+0x91/0xb0
Sep  9 19:23:35 tienel kernel:  [load_balance_newidle+116/144] load_balance_newidle+0x74/0x90
Sep  9 19:23:35 tienel kernel:  [finish_task_switch+59/144] finish_task_switch+0x3b/0x90
Sep  9 19:23:35 tienel kernel:  [schedule+698/1520] schedule+0x2ba/0x5f0
Sep  9 19:23:35 tienel kernel:  [__alloc_pages+552/944] __alloc_pages+0x228/0x3b0
Sep  9 19:23:35 tienel kernel:  [do_page_fault+0/1376] do_page_fault+0x0/0x560
Sep  9 19:23:35 tienel kernel:  [error_code+45/56] error_code+0x2d/0x38
Sep  9 19:23:35 tienel kernel:  [remove_wait_queue+31/112] remove_wait_queue+0x1f/0x70
Sep  9 19:23:35 tienel kernel:  [poll_freewait+36/80] poll_freewait+0x24/0x50
Sep  9 19:23:35 tienel kernel:  [poll_freewait+36/80] poll_freewait+0x24/0x50
Sep  9 19:23:35 tienel kernel:  [do_select+445/704] do_select+0x1bd/0x2c0
Sep  9 19:23:35 tienel kernel:  [__pollwait+0/208] __pollwait+0x0/0xd0
Sep  9 19:23:35 tienel kernel:  [sys_select+686/1184] sys_select+0x2ae/0x4a0
Sep  9 19:23:35 tienel kernel:  [sys_gettimeofday+44/112] sys_gettimeofday+0x2c/0x70
Sep  9 19:23:35 tienel kernel:  [sysenter_past_esp+82/113] sysenter_past_esp+0x52/0x71
Sep  9 19:23:35 tienel kernel:  [schedule+1503/1520] schedule+0x5df/0x5f0
Sep  9 19:23:35 tienel kernel:  [wait_for_completion+122/224] wait_for_completion+0x7a/0xe0
Sep  9 19:23:35 tienel kernel:  [default_wake_function+0/16] default_wake_function+0x0/0x10
Sep  9 19:23:35 tienel kernel:  [default_wake_function+0/16] default_wake_function+0x0/0x10
Sep  9 19:23:35 tienel kernel:  [call_usermodehelper+176/192] call_usermodehelper+0xb0/0xc0
Sep  9 19:23:35 tienel kernel:  [__call_usermodehelper+0/80] __call_usermodehelper+0x0/0x50
Sep  9 19:23:35 tienel kernel:  [kset_hotplug+418/496] kset_hotplug+0x1a2/0x1f0
Sep  9 19:23:35 tienel kernel:  [sysfs_hash_and_remove+119/225] sysfs_hash_and_remove+0x77/0xe1
Sep  9 19:23:35 tienel kernel:  [kobject_del+15/32] kobject_del+0xf/0x20
Sep  9 19:23:35 tienel kernel:  [class_device_del+136/176] class_device_del+0x88/0xb0
Sep  9 19:23:35 tienel kernel:  [class_device_unregister+8/16] class_device_unregister+0x8/0x10
Sep  9 19:23:35 tienel kernel:  [con_close+132/144] con_close+0x84/0x90
Sep  9 19:23:35 tienel kernel:  [release_dev+1636/1664] release_dev+0x664/0x680
Sep  9 19:23:35 tienel kernel:  [skb_dequeue+75/96] skb_dequeue+0x4b/0x60
Sep  9 19:23:35 tienel kernel:  [skb_queue_purge+10/64] skb_queue_purge+0xa/0x40
Sep  9 19:23:35 tienel kernel:  [unix_sock_destructor+17/256] unix_sock_destructor+0x11/0x100
Sep  9 19:23:35 tienel kernel:  [dput+30/496] dput+0x1e/0x1f0
Sep  9 19:23:35 tienel kernel:  [unix_release_sock+406/560] unix_release_sock+0x196/0x230
Sep  9 19:23:35 tienel kernel:  [invalidate_inode_buffers+21/160] invalidate_inode_buffers+0x15/0xa0
Sep  9 19:23:35 tienel kernel:  [clear_inode+18/208] clear_inode+0x12/0xd0
Sep  9 19:23:35 tienel kernel:  [tty_release+53/112] tty_release+0x35/0x70
Sep  9 19:23:35 tienel kernel:  [__fput+265/288] __fput+0x109/0x120
Sep  9 19:23:35 tienel kernel:  [filp_close+79/128] filp_close+0x4f/0x80
Sep  9 19:23:35 tienel kernel:  [put_files_struct+89/176] put_files_struct+0x59/0xb0
Sep  9 19:23:35 tienel kernel:  [do_exit+417/1040] do_exit+0x1a1/0x410
Sep  9 19:23:35 tienel kernel:  [die+380/384] die+0x17c/0x180
Sep  9 19:23:35 tienel kernel:  [do_page_fault+0/1376] do_page_fault+0x0/0x560
Sep  9 19:23:35 tienel kernel:  [do_page_fault+520/1376] do_page_fault+0x208/0x560
Sep  9 19:23:35 tienel kernel:  [find_busiest_queue+145/176] find_busiest_queue+0x91/0xb0
Sep  9 19:23:35 tienel kernel:  [load_balance_newidle+116/144] load_balance_newidle+0x74/0x90
Sep  9 19:23:35 tienel kernel:  [finish_task_switch+59/144] finish_task_switch+0x3b/0x90
Sep  9 19:23:35 tienel kernel:  [schedule+698/1520] schedule+0x2ba/0x5f0
Sep  9 19:23:35 tienel kernel:  [__alloc_pages+552/944] __alloc_pages+0x228/0x3b0
Sep  9 19:23:35 tienel kernel:  [do_page_fault+0/1376] do_page_fault+0x0/0x560
Sep  9 19:23:35 tienel kernel:  [error_code+45/56] error_code+0x2d/0x38
Sep  9 19:23:35 tienel kernel:  [remove_wait_queue+31/112] remove_wait_queue+0x1f/0x70
Sep  9 19:23:35 tienel kernel:  [poll_freewait+36/80] poll_freewait+0x24/0x50
Sep  9 19:23:35 tienel kernel:  [poll_freewait+36/80] poll_freewait+0x24/0x50
Sep  9 19:23:35 tienel kernel:  [do_select+445/704] do_select+0x1bd/0x2c0
Sep  9 19:23:35 tienel kernel:  [__pollwait+0/208] __pollwait+0x0/0xd0
Sep  9 19:23:35 tienel kernel:  [sys_select+686/1184] sys_select+0x2ae/0x4a0
Sep  9 19:23:35 tienel kernel:  [sys_gettimeofday+44/112] sys_gettimeofday+0x2c/0x70
Sep  9 19:23:35 tienel kernel:  [sysenter_past_esp+82/113] sysenter_past_esp+0x52/0x71
...
Sep  9 19:25:48 tienel syslogd 1.4.1#15: restart.
Sep  9 19:25:49 tienel kernel: klogd 1.4.1#15, log source = /proc/kmsg started.
Sep  9 19:25:49 tienel kernel: Inspecting /boot/System.map-2.6.9-rc1-mm4
Sep  9 19:25:49 tienel kernel: Loaded 27134 symbols from /boot/System.map-2.6.9-rc1-mm4.
Sep  9 19:25:49 tienel kernel: Symbols match kernel version 2.6.9.
Sep  9 19:25:49 tienel kernel: No module symbols loaded - kernel modules not enabled. 
Sep  9 19:25:49 tienel kernel: Linux version 2.6.9-rc1-mm4 (root@tienel) (gcc version 3.3.4 (Debian 1:3.3.4-11)) #1 SMP Thu Sep 9 18:10:50 EEST 2004
...
Sep  9 19:35:05 tienel kernel: c01326ff
Sep  9 19:35:05 tienel kernel: PREEMPT SMP 
Sep  9 19:35:05 tienel kernel: Modules linked in: joydev usbhid mga sd_mod sg sr_mod ide_cd cdrom parport_pc lp parport binfmt_misc ipv6 uhci_hcd ohci_hcd ehci_hcd nls_iso8859_1 nls_cp437 vfat fat usb_storage usbcore scsi_mod amd76x_pm amd_k7_agp agpgart snd_ens1371 snd_rawmidi snd_seq_device snd_pcm_oss snd_mixer_oss snd_pcm snd_timer snd_page_alloc snd_ac97_codec snd soundcore gameport w83781d i2c_sensor i2c_amd756 i2c_core eepro100 mii
Sep  9 19:35:05 tienel kernel: CPU:    1
Sep  9 19:35:05 tienel kernel: EIP:    0060:[remove_wait_queue+31/112]    Not tainted VLI
Sep  9 19:35:05 tienel kernel: EFLAGS: 00010012   (2.6.9-rc1-mm4) 
Sep  9 19:35:05 tienel kernel: EIP is at remove_wait_queue+0x1f/0x70
Sep  9 19:35:05 tienel kernel: eax: 00000000   ebx: f1f76ff0   ecx: f1f77024   edx: f1f76ffc
Sep  9 19:35:05 tienel kernel: esi: f1f77024   edi: 00000296   ebp: 00000006   esp: f2147ed8
Sep  9 19:35:05 tienel kernel: ds: 007b   es: 007b   ss: 0068
Sep  9 19:35:05 tienel kernel: Process zsnes (pid: 1938, threadinfo=f2146000 task=f220d550)
Sep  9 19:35:05 tienel kernel: Stack: f1f76fec c016a3c4 f1f77000 c016a3c4 00000020 00000000 00000006 c016a75d 
Sep  9 19:35:05 tienel kernel:        00000000 00000020 00000000 00000000 00000020 00000000 00000104 00000020 
Sep  9 19:35:05 tienel kernel:        f2146000 f7b9256c f7b92568 f7b92564 f7b92578 f7b92574 f7b92570 00002704 
Sep  9 19:35:05 tienel kernel: Call Trace:
Sep  9 19:35:05 tienel kernel:  [poll_freewait+36/80] poll_freewait+0x24/0x50
Sep  9 19:35:05 tienel kernel:  [poll_freewait+36/80] poll_freewait+0x24/0x50
Sep  9 19:35:05 tienel kernel:  [do_select+445/704] do_select+0x1bd/0x2c0
Sep  9 19:35:05 tienel kernel:  [__pollwait+0/208] __pollwait+0x0/0xd0
Sep  9 19:35:05 tienel kernel:  [sys_select+686/1184] sys_select+0x2ae/0x4a0
Sep  9 19:35:05 tienel kernel:  [dnotify_parent+53/192] dnotify_parent+0x35/0xc0
Sep  9 19:35:05 tienel kernel:  [sysenter_past_esp+82/113] sysenter_past_esp+0x52/0x71
Sep  9 19:35:05 tienel kernel: Code: 00 8d 74 26 00 8d bc 27 00 00 00 00 83 ec 0c 89 1c 24 89 74 24 04 89 7c 24 08 89 d3 89 c6 e8 c9 a4 15 00 8d 53 0c 89 c7 8b 42 04 <39> 10 75 3c 8b 4b 0c 39 51 04 75 2a 89 41 04 89 08 c7 42 04 00 
Sep  9 19:35:05 tienel kernel:  <6>note: zsnes[1938] exited with preempt_count 1
Sep  9 19:38:45 tienel kernel: c01326ff
Sep  9 19:38:45 tienel kernel: PREEMPT SMP 
Sep  9 19:38:45 tienel kernel: Modules linked in: joydev usbhid mga sd_mod sg sr_mod ide_cd cdrom parport_pc lp parport binfmt_misc ipv6 uhci_hcd ohci_hcd ehci_hcd nls_iso8859_1 nls_cp437 vfat fat usb_storage usbcore scsi_mod amd76x_pm amd_k7_agp agpgart snd_ens1371 snd_rawmidi snd_seq_device snd_pcm_oss snd_mixer_oss snd_pcm snd_timer snd_page_alloc snd_ac97_codec snd soundcore gameport w83781d i2c_sensor i2c_amd756 i2c_core eepro100 mii
Sep  9 19:38:45 tienel kernel: CPU:    1
Sep  9 19:38:45 tienel kernel: EIP:    0060:[remove_wait_queue+31/112]    Not tainted VLI
Sep  9 19:38:45 tienel kernel: EFLAGS: 00013012   (2.6.9-rc1-mm4) 
Sep  9 19:38:45 tienel kernel: EIP is at remove_wait_queue+0x1f/0x70
Sep  9 19:38:45 tienel kernel: eax: 00000000   ebx: f1504ff0   ecx: f15051c8   edx: f1504ffc
Sep  9 19:38:45 tienel kernel: esi: f15051c8   edi: 00003296   ebp: 00000015   esp: f5ca5ed8
Sep  9 19:38:45 tienel kernel: ds: 007b   es: 007b   ss: 0068
Sep  9 19:38:45 tienel kernel: Process XFree86 (pid: 1742, threadinfo=f5ca4000 task=f7703aa0)
Sep  9 19:38:45 tienel kernel: Stack: f1504fec c016a3c4 f1505000 c016a3c4 00000000 00002000 00000015 c016a75d 
Sep  9 19:38:45 tienel kernel:        00000000 00000000 001fff0a 00000000 00000000 00002000 00000304 001fff0a 
Sep  9 19:38:45 tienel kernel:        f5ca4000 f1b50ae4 f1b50ac4 f1b50aa4 f1b50b44 f1b50b24 f1b50b04 00000030 
Sep  9 19:38:45 tienel kernel: Call Trace:
Sep  9 19:38:45 tienel kernel:  [poll_freewait+36/80] poll_freewait+0x24/0x50
Sep  9 19:38:45 tienel kernel:  [poll_freewait+36/80] poll_freewait+0x24/0x50
Sep  9 19:38:45 tienel kernel:  [do_select+445/704] do_select+0x1bd/0x2c0
Sep  9 19:38:45 tienel kernel:  [__pollwait+0/208] __pollwait+0x0/0xd0
Sep  9 19:38:45 tienel kernel:  [sys_select+686/1184] sys_select+0x2ae/0x4a0
Sep  9 19:38:45 tienel kernel:  [sys_gettimeofday+44/112] sys_gettimeofday+0x2c/0x70
Sep  9 19:38:45 tienel kernel:  [sysenter_past_esp+82/113] sysenter_past_esp+0x52/0x71
Sep  9 19:38:45 tienel kernel: Code: 00 8d 74 26 00 8d bc 27 00 00 00 00 83 ec 0c 89 1c 24 89 74 24 04 89 7c 24 08 89 d3 89 c6 e8 c9 a4 15 00 8d 53 0c 89 c7 8b 42 04 <39> 10 75 3c 8b 4b 0c 39 51 04 75 2a 89 41 04 89 08 c7 42 04 00 
Sep  9 19:38:45 tienel kernel:  <6>note: XFree86[1742] exited with preempt_count 1
Sep  9 19:38:45 tienel kernel:  [schedule+1503/1520] schedule+0x5df/0x5f0
Sep  9 19:38:45 tienel kernel:  [free_pages_and_swap_cache+87/128] free_pages_and_swap_cache+0x57/0x80
Sep  9 19:38:45 tienel kernel:  [unmap_vmas+448/512] unmap_vmas+0x1c0/0x200
Sep  9 19:38:45 tienel kernel:  [exit_mmap+144/352] exit_mmap+0x90/0x160
Sep  9 19:38:45 tienel kernel:  [mmput+45/192] mmput+0x2d/0xc0
Sep  9 19:38:45 tienel kernel:  [do_exit+369/1040] do_exit+0x171/0x410
Sep  9 19:38:45 tienel kernel:  [die+380/384] die+0x17c/0x180
Sep  9 19:38:45 tienel kernel:  [do_page_fault+0/1376] do_page_fault+0x0/0x560
Sep  9 19:38:45 tienel kernel:  [do_page_fault+520/1376] do_page_fault+0x208/0x560
Sep  9 19:38:45 tienel kernel:  [find_busiest_queue+145/176] find_busiest_queue+0x91/0xb0
Sep  9 19:38:45 tienel kernel:  [load_balance_newidle+116/144] load_balance_newidle+0x74/0x90
Sep  9 19:38:45 tienel kernel:  [finish_task_switch+59/144] finish_task_switch+0x3b/0x90
Sep  9 19:38:45 tienel kernel:  [schedule+698/1520] schedule+0x2ba/0x5f0
Sep  9 19:38:45 tienel kernel:  [__alloc_pages+552/944] __alloc_pages+0x228/0x3b0
Sep  9 19:38:45 tienel kernel:  [do_page_fault+0/1376] do_page_fault+0x0/0x560
Sep  9 19:38:45 tienel kernel:  [error_code+45/56] error_code+0x2d/0x38
Sep  9 19:38:45 tienel kernel:  [remove_wait_queue+31/112] remove_wait_queue+0x1f/0x70
Sep  9 19:38:45 tienel kernel:  [poll_freewait+36/80] poll_freewait+0x24/0x50
Sep  9 19:38:45 tienel kernel:  [poll_freewait+36/80] poll_freewait+0x24/0x50
Sep  9 19:38:45 tienel kernel:  [do_select+445/704] do_select+0x1bd/0x2c0
Sep  9 19:38:45 tienel kernel:  [__pollwait+0/208] __pollwait+0x0/0xd0
Sep  9 19:38:45 tienel kernel:  [sys_select+686/1184] sys_select+0x2ae/0x4a0
Sep  9 19:38:45 tienel kernel:  [sys_gettimeofday+44/112] sys_gettimeofday+0x2c/0x70
Sep  9 19:38:45 tienel kernel:  [sysenter_past_esp+82/113] sysenter_past_esp+0x52/0x71
Sep  9 19:38:45 tienel kernel:  [schedule+1503/1520] schedule+0x5df/0x5f0
Sep  9 19:38:45 tienel kernel:  [__wake_up_common+55/96] __wake_up_common+0x37/0x60
Sep  9 19:38:45 tienel kernel:  [wait_for_completion+122/224] wait_for_completion+0x7a/0xe0
Sep  9 19:38:45 tienel kernel:  [default_wake_function+0/16] default_wake_function+0x0/0x10
Sep  9 19:38:45 tienel kernel:  [default_wake_function+0/16] default_wake_function+0x0/0x10
Sep  9 19:38:45 tienel kernel:  [call_usermodehelper+176/192] call_usermodehelper+0xb0/0xc0
Sep  9 19:38:45 tienel kernel:  [__call_usermodehelper+0/80] __call_usermodehelper+0x0/0x50
Sep  9 19:38:45 tienel kernel:  [kset_hotplug+418/496] kset_hotplug+0x1a2/0x1f0
Sep  9 19:38:45 tienel kernel:  [sysfs_hash_and_remove+119/225] sysfs_hash_and_remove+0x77/0xe1
Sep  9 19:38:45 tienel kernel:  [kobject_del+15/32] kobject_del+0xf/0x20
Sep  9 19:38:45 tienel kernel:  [class_device_del+136/176] class_device_del+0x88/0xb0
Sep  9 19:38:45 tienel kernel:  [class_device_unregister+8/16] class_device_unregister+0x8/0x10
Sep  9 19:38:45 tienel kernel:  [vcs_remove_devfs+17/36] vcs_remove_devfs+0x11/0x24
Sep  9 19:38:45 tienel kernel:  [con_close+132/144] con_close+0x84/0x90
Sep  9 19:38:45 tienel kernel:  [release_dev+1636/1664] release_dev+0x664/0x680
Sep  9 19:38:45 tienel kernel:  [skb_dequeue+75/96] skb_dequeue+0x4b/0x60
Sep  9 19:38:45 tienel kernel:  [skb_queue_purge+10/64] skb_queue_purge+0xa/0x40
Sep  9 19:38:45 tienel kernel:  [unix_sock_destructor+17/256] unix_sock_destructor+0x11/0x100
Sep  9 19:38:45 tienel kernel:  [dput+30/496] dput+0x1e/0x1f0
Sep  9 19:38:45 tienel kernel:  [unix_release_sock+406/560] unix_release_sock+0x196/0x230
Sep  9 19:38:45 tienel kernel:  [invalidate_inode_buffers+21/160] invalidate_inode_buffers+0x15/0xa0
Sep  9 19:38:45 tienel kernel:  [clear_inode+18/208] clear_inode+0x12/0xd0
Sep  9 19:38:45 tienel kernel:  [tty_release+53/112] tty_release+0x35/0x70
Sep  9 19:38:45 tienel kernel:  [__fput+265/288] __fput+0x109/0x120
Sep  9 19:38:45 tienel kernel:  [filp_close+79/128] filp_close+0x4f/0x80
Sep  9 19:38:45 tienel kernel:  [put_files_struct+89/176] put_files_struct+0x59/0xb0
Sep  9 19:38:45 tienel kernel:  [do_exit+417/1040] do_exit+0x1a1/0x410
Sep  9 19:38:45 tienel kernel:  [die+380/384] die+0x17c/0x180
Sep  9 19:38:45 tienel kernel:  [do_page_fault+0/1376] do_page_fault+0x0/0x560
Sep  9 19:38:45 tienel kernel:  [do_page_fault+520/1376] do_page_fault+0x208/0x560
Sep  9 19:38:45 tienel kernel:  [find_busiest_queue+145/176] find_busiest_queue+0x91/0xb0
Sep  9 19:38:45 tienel kernel:  [load_balance_newidle+116/144] load_balance_newidle+0x74/0x90
Sep  9 19:38:45 tienel kernel:  [finish_task_switch+59/144] finish_task_switch+0x3b/0x90
Sep  9 19:38:45 tienel kernel:  [schedule+698/1520] schedule+0x2ba/0x5f0
Sep  9 19:38:45 tienel kernel:  [__alloc_pages+552/944] __alloc_pages+0x228/0x3b0
Sep  9 19:38:45 tienel kernel:  [do_page_fault+0/1376] do_page_fault+0x0/0x560
Sep  9 19:38:45 tienel kernel:  [error_code+45/56] error_code+0x2d/0x38
Sep  9 19:38:45 tienel kernel:  [remove_wait_queue+31/112] remove_wait_queue+0x1f/0x70
Sep  9 19:38:45 tienel kernel:  [poll_freewait+36/80] poll_freewait+0x24/0x50
Sep  9 19:38:45 tienel kernel:  [poll_freewait+36/80] poll_freewait+0x24/0x50
Sep  9 19:38:45 tienel kernel:  [do_select+445/704] do_select+0x1bd/0x2c0
Sep  9 19:38:45 tienel kernel:  [__pollwait+0/208] __pollwait+0x0/0xd0
Sep  9 19:38:45 tienel kernel:  [sys_select+686/1184] sys_select+0x2ae/0x4a0
Sep  9 19:38:45 tienel kernel:  [sys_gettimeofday+44/112] sys_gettimeofday+0x2c/0x70
Sep  9 19:38:45 tienel kernel:  [sysenter_past_esp+82/113] sysenter_past_esp+0x52/0x71
Sep  9 19:38:45 tienel kernel:  [schedule+1503/1520] schedule+0x5df/0x5f0
Sep  9 19:38:45 tienel kernel:  [__wake_up_common+55/96] __wake_up_common+0x37/0x60
Sep  9 19:38:45 tienel kernel:  [wait_for_completion+122/224] wait_for_completion+0x7a/0xe0
Sep  9 19:38:45 tienel kernel:  [default_wake_function+0/16] default_wake_function+0x0/0x10
Sep  9 19:38:45 tienel kernel:  [default_wake_function+0/16] default_wake_function+0x0/0x10
Sep  9 19:38:45 tienel kernel:  [call_usermodehelper+176/192] call_usermodehelper+0xb0/0xc0
Sep  9 19:38:45 tienel kernel:  [__call_usermodehelper+0/80] __call_usermodehelper+0x0/0x50
Sep  9 19:38:45 tienel kernel:  [kset_hotplug+418/496] kset_hotplug+0x1a2/0x1f0
Sep  9 19:38:45 tienel kernel:  [sysfs_hash_and_remove+119/225] sysfs_hash_and_remove+0x77/0xe1
Sep  9 19:38:45 tienel kernel:  [kobject_del+15/32] kobject_del+0xf/0x20
Sep  9 19:38:45 tienel kernel:  [class_device_del+136/176] class_device_del+0x88/0xb0
Sep  9 19:38:45 tienel kernel:  [class_device_unregister+8/16] class_device_unregister+0x8/0x10
Sep  9 19:38:45 tienel kernel:  [con_close+132/144] con_close+0x84/0x90
Sep  9 19:38:45 tienel kernel:  [release_dev+1636/1664] release_dev+0x664/0x680
Sep  9 19:38:45 tienel kernel:  [skb_dequeue+75/96] skb_dequeue+0x4b/0x60
Sep  9 19:38:45 tienel kernel:  [skb_queue_purge+10/64] skb_queue_purge+0xa/0x40
Sep  9 19:38:45 tienel kernel:  [unix_sock_destructor+17/256] unix_sock_destructor+0x11/0x100
Sep  9 19:38:45 tienel kernel:  [dput+30/496] dput+0x1e/0x1f0
Sep  9 19:38:45 tienel kernel:  [unix_release_sock+406/560] unix_release_sock+0x196/0x230
Sep  9 19:38:45 tienel kernel:  [invalidate_inode_buffers+21/160] invalidate_inode_buffers+0x15/0xa0
Sep  9 19:38:45 tienel kernel:  [clear_inode+18/208] clear_inode+0x12/0xd0
Sep  9 19:38:45 tienel kernel:  [tty_release+53/112] tty_release+0x35/0x70
Sep  9 19:38:45 tienel kernel:  [__fput+265/288] __fput+0x109/0x120
Sep  9 19:38:45 tienel kernel:  [filp_close+79/128] filp_close+0x4f/0x80
Sep  9 19:38:45 tienel kernel:  [put_files_struct+89/176] put_files_struct+0x59/0xb0
Sep  9 19:38:45 tienel kernel:  [do_exit+417/1040] do_exit+0x1a1/0x410
Sep  9 19:38:45 tienel kernel:  [die+380/384] die+0x17c/0x180
Sep  9 19:38:45 tienel kernel:  [do_page_fault+0/1376] do_page_fault+0x0/0x560
Sep  9 19:38:45 tienel kernel:  [do_page_fault+520/1376] do_page_fault+0x208/0x560
Sep  9 19:38:45 tienel kernel:  [find_busiest_queue+145/176] find_busiest_queue+0x91/0xb0
Sep  9 19:38:45 tienel kernel:  [load_balance_newidle+116/144] load_balance_newidle+0x74/0x90
Sep  9 19:38:45 tienel kernel:  [finish_task_switch+59/144] finish_task_switch+0x3b/0x90
Sep  9 19:38:45 tienel kernel:  [schedule+698/1520] schedule+0x2ba/0x5f0
Sep  9 19:38:45 tienel kernel:  [__alloc_pages+552/944] __alloc_pages+0x228/0x3b0
Sep  9 19:38:45 tienel kernel:  [do_page_fault+0/1376] do_page_fault+0x0/0x560
Sep  9 19:38:45 tienel kernel:  [error_code+45/56] error_code+0x2d/0x38
Sep  9 19:38:45 tienel kernel:  [remove_wait_queue+31/112] remove_wait_queue+0x1f/0x70
Sep  9 19:38:45 tienel kernel:  [poll_freewait+36/80] poll_freewait+0x24/0x50
Sep  9 19:38:45 tienel kernel:  [poll_freewait+36/80] poll_freewait+0x24/0x50
Sep  9 19:38:45 tienel kernel:  [do_select+445/704] do_select+0x1bd/0x2c0
Sep  9 19:38:45 tienel kernel:  [__pollwait+0/208] __pollwait+0x0/0xd0
Sep  9 19:38:45 tienel kernel:  [sys_select+686/1184] sys_select+0x2ae/0x4a0
Sep  9 19:38:45 tienel kernel:  [sys_gettimeofday+44/112] sys_gettimeofday+0x2c/0x70
Sep  9 19:38:45 tienel kernel:  [sysenter_past_esp+82/113] sysenter_past_esp+0x52/0x71

-- 
   Psi -- <http://www.iki.fi/pasi.savolainen>

