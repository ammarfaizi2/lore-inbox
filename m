Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261202AbVETAk6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261202AbVETAk6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 May 2005 20:40:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261210AbVETAk6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 May 2005 20:40:58 -0400
Received: from c-24-14-93-109.hsd1.il.comcast.net ([24.14.93.109]:7306 "EHLO
	topaz") by vger.kernel.org with ESMTP id S261202AbVETAky (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 May 2005 20:40:54 -0400
To: linux-kernel@vger.kernel.org
Subject: oops with 2.6.12-rc2
From: Narayan Desai <desai@mcs.anl.gov>
Date: Thu, 19 May 2005 19:40:52 -0500
Message-ID: <87d5rmhgq3.fsf@topaz.mcs.anl.gov>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I got the following oops with 2.6.12-rc2. It occurred when I unplugged
a usb audio device while xmms (presumably) had it opened. I
have managed to do this successfully with the xmms closed. Once this
oops occurs, my keyboard is dead, and a reboot is required. The system
isn't hung, and oddly enough, the mouse still works. 
 -nld

May 19 16:33:13 topaz kernel: [5752843.456000] c0257696
May 19 16:33:13 topaz kernel: [5752843.456000] PREEMPT 
May 19 16:33:13 topaz kernel: [5752843.456000] Modules linked in: button uhci_hcd ehci_hcd snd_usb_audio snd_usb_lib snd_rawmidi snd_seq_device nls_iso8859_1 nls_cp437 vfat fat nls_utf8 hfsplus sd_mod usb_storage scsi_mod rfcomm l2c
ap bluetooth binfmt_misc video thermal processor fan ibm_acpi container ac battery ath_pci ath_rate_onoe wlan ath_hal e1000 yenta_socket rsrc_nonstatic pcmcia_core snd_intel8x0m snd_intel8x0 snd_ac97_codec snd_pcm_oss snd_mixer_oss 
snd_pcm snd_timer snd soundcore snd_page_alloc usbcore udf dm_mod ide_cd cdrom evdev
May 19 16:33:13 topaz kernel: [5752843.456000] CPU:    0
May 19 16:33:13 topaz kernel: [5752843.456000] EIP:    0060:[get_kobj_path_length+38/64]    Tainted: P      VLI
May 19 16:33:13 topaz kernel: [5752843.456000] EFLAGS: 00010246   (2.6.12-rc3) 
May 19 16:33:13 topaz kernel: [5752843.456000] EIP is at get_kobj_path_length+0x26/0x40
May 19 16:33:13 topaz kernel: [5752843.456000] eax: 00000000   ebx: 00000000   ecx: ffffffff   edx: f787a888
May 19 16:33:13 topaz kernel: [5752843.456000] esi: 00000001   edi: 00000000   ebp: ffffffff   esp: c1949d64
May 19 16:33:13 topaz kernel: [5752843.456000] ds: 007b   es: 007b   ss: 0068
May 19 16:33:13 topaz kernel: [5752843.456000] Process events/0 (pid: 3, threadinfo=c1948000 task=c190e020)
May 19 16:33:13 topaz kernel: [5752843.456000] Stack: f787a858 f787a864 f6e5fd98 f787a888 c025772f f787a888 c012a0f0 c1949db0 
May 19 16:33:13 topaz kernel: [5752843.456000]        00000000 f787a858 f787a864 f6e5fd98 000003a8 c02c4e34 f787a888 000000d0 
May 19 16:33:13 topaz kernel: [5752843.456000]        00000286 00000282 f7249b60 00000016 ffffffff fffffffd c041c620 00000000 
May 19 16:33:13 topaz kernel: [5752843.456000] Call Trace:
May 19 16:33:13 topaz kernel: [5752843.456000]  [kobject_get_path+31/128] kobject_get_path+0x1f/0x80
May 19 16:33:13 topaz kernel: [5752843.456000]  [__call_usermodehelper+0/112] __call_usermodehelper+0x0/0x70
May 19 16:33:13 topaz kernel: [5752843.456000]  [class_hotplug+308/512] class_hotplug+0x134/0x200
May 19 16:33:13 topaz kernel: [5752843.456000]  [kobject_hotplug+486/784] kobject_hotplug+0x1e6/0x310
May 19 16:33:13 topaz kernel: [5752843.456000]  [class_device_del+127/208] class_device_del+0x7f/0xd0
May 19 16:33:13 topaz kernel: [5752843.456000]  [class_device_unregister+19/48] class_device_unregister+0x13/0x30
May 19 16:33:13 topaz kernel: [5752843.456000]  [pg0+960804305/1068856320] snd_unregister_device+0x81/0xe0 [snd]
May 19 16:33:13 topaz kernel: [5752843.456000]  [pg0+961173376/1068856320] snd_pcm_dev_unregister+0x60/0xf0 [snd_pcm]
May 19 16:33:13 topaz kernel: [5752843.456000]  [pg0+960826361/1068856320] snd_device_free+0xb9/0xe0 [snd]
May 19 16:33:13 topaz kernel: [5752843.456000]  [pg0+960826976/1068856320] snd_device_free_all+0x60/0x70 [snd]
May 19 16:33:13 topaz kernel: [5752843.456000]  [pg0+960806572/1068856320] snd_card_free+0x12c/0x2b0 [snd]
May 19 16:33:13 topaz kernel: [5752843.456000]  [autoremove_wake_function+0/96] autoremove_wake_function+0x0/0x60
May 19 16:33:13 topaz kernel: [5752843.456000]  [autoremove_wake_function+0/96] autoremove_wake_function+0x0/0x60
May 19 16:33:13 topaz kernel: [5752843.456000]  [pg0+960807050/1068856320] snd_card_free_thread+0x5a/0xf0 [snd]
May 19 16:33:13 topaz kernel: [5752843.456000]  [worker_thread+508/720] worker_thread+0x1fc/0x2d0
May 19 16:33:13 topaz kernel: [5752843.456000]  [pg0+960806960/1068856320] snd_card_free_thread+0x0/0xf0 [snd]
May 19 16:33:13 topaz kernel: [5752843.456000]  [default_wake_function+0/32] default_wake_function+0x0/0x20
May 19 16:33:13 topaz kernel: [5752843.456000]  [default_wake_function+0/32] default_wake_function+0x0/0x20
May 19 16:33:13 topaz kernel: [5752843.456000]  [worker_thread+0/720] worker_thread+0x0/0x2d0
May 19 16:33:13 topaz kernel: [5752843.456000]  [kthread+170/176] kthread+0xaa/0xb0
May 19 16:33:13 topaz kernel: [5752843.456000]  [kthread+0/176] kthread+0x0/0xb0
May 19 16:33:13 topaz kernel: [5752843.456000]  [kernel_thread_helper+5/24] kernel_thread_helper+0x5/0x18
May 19 16:33:13 topaz kernel: [5752843.456000] Code: 90 8d 74 26 00 55 bd ff ff ff ff 57 56 be 01 00 00 00 53 8b 54 24 14 31 db 8d b6 00 00 00 00 8d bf 00 00 00 00 8b 3a 89 e9 89 d8 <f2> ae f7 d1 49 8b 52 24 8d 74 31 01 85 d2 75 ea 
5b 89 f0 5e 5f 
