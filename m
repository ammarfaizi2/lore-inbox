Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752298AbWAEXbd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752298AbWAEXbd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 18:31:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752299AbWAEXbd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 18:31:33 -0500
Received: from web26902.mail.ukl.yahoo.com ([217.146.176.91]:37989 "HELO
	web26902.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S1752297AbWAEXbc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 18:31:32 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.fr;
  h=Message-ID:Received:Date:From:Subject:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=sWq0OjG5h2tRtIK89ufRwInky4vBn6f8Iui9CK7jpa7lrsS6lju9UpTQyTpIBvkktLm6TxC4doEKsHESKzwRmtMumWiG5SHwYkGjFXfzh1iZ0IB5QWiKj1Kp0y1yd7vHZ00BafERpXqEWARGVsKcL3HuCAF9pwAKSNAIF7VPzOc=  ;
Message-ID: <20060105233131.25101.qmail@web26902.mail.ukl.yahoo.com>
Date: Fri, 6 Jan 2006 00:31:31 +0100 (CET)
From: Etienne Lorrain <etienne_lorrain@yahoo.fr>
Subject: Re: Re. 2.6.15-mm1
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  I have my own OOPs with 2.6.15-mm1, this kind:

Jan  5 22:40:04 localhost fstab-sync[1919]: added mount point /media/floppy
for /dev/fd0
Jan  5 22:41:37 localhost kernel: Unable to handle kernel NULL pointer
dereference at virtual address 00000010
Jan  5 22:41:37 localhost kernel:  printing eip:
Jan  5 22:41:37 localhost kernel: c013da3a
Jan  5 22:41:37 localhost kernel: *pde = 1d165067
Jan  5 22:41:37 localhost kernel: *pte = 00000000
Jan  5 22:41:37 localhost kernel: Oops: 0000 [#1]
Jan  5 22:41:37 localhost kernel: last sysfs file: /class/vc/vcs7/dev
Jan  5 22:41:37 localhost kernel: Modules linked in: autofs4 pcmcia
ipt_REJECT ipt_state ip_conntrack iptable_filter ip_tables vfat fat
yenta_socket rsrc_nonstatic pcmcia_core uhci_hcd ehci_hcd i2c_viapro
i2c_core snd_via82xx snd_ac97_codec snd_ac97_bus snd_seq_dummy snd_seq_oss
snd_seq_midi_event snd_seq snd_pcm_oss snd_mixer_oss snd_pcm snd_timer
snd_page_alloc snd_mpu401_uart snd_rawmidi snd_seq_device snd soundcore ext3
jbd
Jan  5 22:41:37 localhost kernel: CPU:    0
Jan  5 22:41:37 localhost kernel: EIP:    0060:[<c013da3a>]    Not tainted
VLI
Jan  5 22:41:37 localhost kernel: EFLAGS: 00013256   (2.6.15-mm1)
Jan  5 22:41:37 localhost kernel: EIP is at __audit_inode+0xba/0x190
Jan  5 22:41:37 localhost kernel: eax: 00000008   ebx: 00000000   ecx:
dcbf02c0   edx: d9343268
Jan  5 22:41:37 localhost kernel: esi: d922ef44   edi: d9fd3000   ebp:
dcbf02c0   esp: d922ee88
Jan  5 22:41:37 localhost kernel: ds: 007b   es: 007b   ss: 0068
Jan  5 22:41:37 localhost kernel: Process X (pid: 2192, threadinfo=d922e000
task=d8abcff0)
Jan  5 22:41:37 localhost kernel: Stack: <0>00000003 00000000 dcbf02c0
fffffffe d922ef44 d9fd3000 00000003 c017002c
Jan  5 22:41:37 localhost kernel:        <0>d9fd3000 d9343268 00000101
00000101 00000101 d922ef44 ffffffe9 00000003
Jan  5 22:41:37 localhost kernel:        <0>c0170096 d922e000 00000002
d922ef44 00000006 c017011f d9fd3000 00000001
Jan  5 22:41:38 localhost gdm[2183]: gdm_slave_xioerror_handler: Fatal X
error - Restarting :0
Jan  5 22:41:38 localhost kernel: Call Trace:
Jan  5 22:41:39 localhost kernel:  [<c017002c>] path_lookup+0x1ac/0x1d0
Jan  5 22:41:40 localhost kernel:  [<c0170096>]
__path_lookup_intent_open+0x46/0xa0
Jan  5 22:41:41 localhost kernel:  [<c017011f>] path_lookup_open+0x2f/0x40
Jan  5 22:41:41 localhost kernel:  [<c0170b33>] open_namei+0x73/0x530
Jan  5 22:41:42 localhost kernel:  [<c0144cdd>] __alloc_pages+0x5d/0x390
Jan  5 22:41:42 localhost kernel:  [<c015e8b8>] filp_open+0x38/0x60
Jan  5 22:41:42 localhost kernel:  [<c015eaf0>] get_unused_fd+0xb0/0xe0
Jan  5 22:41:42 localhost kernel:  [<c015ec45>] do_sys_open+0x55/0x100
Jan  5 22:41:42 localhost kernel:  [<c01031a5>] syscall_call+0x7/0xb
Jan  5 22:41:43 localhost kernel: Code: 42 38 89 d8 c1 e0 05 8d 04 98 c7 44
10 3c 00 00 00 00 89 d8 8b 54 24 24 8b 4c 24 08 c1 e0 05 8d 04 98 8d 2c 08
8b 82 c4 00 00 00 <8b> 40 08 89 45 48 0f b7 42 28 66 89 45 4c 8b 42 30 89 45
50 8b
Jan  5 22:44:05 localhost shutdown: shutting down for system reboot
Jan  5 22:44:05 localhost init: Switching to runlevel: 6
Jan  5 22:44:17 localhost shutdown: shutting down for system reboot
Jan  5 22:44:26 localhost dbus: avc:  2 AV entries and 2/512 buckets used,
longest chain length 1
Jan  5 22:44:32 localhost xfs[1848]: terminating
Jan  5 22:44:34 localhost shutdown: shutting down for system reboot
Jan  5 22:44:41 localhost last message repeated 7 times
Jan  5 22:44:58 localhost kernel:  <6>[drm] Initialized drm 1.0.1 20051102
Jan  5 22:44:59 localhost kernel: [drm] Initialized radeon 1.21.0 20051229
on minor 0
Jan  5 22:45:01 localhost kernel: mtrr: 0xd0000000,0x8000000 overlaps
existing 0xd0000000,0x4000000
Jan  5 22:45:01 localhost kernel: agpgart: Found an AGP 3.5 compliant device
at 0000:00:00.0.
Jan  5 22:45:01 localhost kernel: Unable to handle kernel NULL pointer
dereference at virtual address 00000020
Jan  5 22:45:01 localhost kernel:  printing eip:
Jan  5 22:45:01 localhost kernel: c0250b08
Jan  5 22:45:01 localhost kernel: *pde = 1d4d1067
Jan  5 22:45:01 localhost kernel: *pte = 00000000
Jan  5 22:45:01 localhost kernel: Oops: 0000 [#2]
Jan  5 22:45:01 localhost kernel: last sysfs file: /class/drm/card0/dev
Jan  5 22:45:01 localhost kernel: Modules linked in: radeon drm autofs4
pcmcia ipt_REJECT ipt_state ip_conntrack iptable_filter ip_tables vfat fat
yenta_socket rsrc_nonstatic pcmcia_core uhci_hcd ehci_hcd i2c_viapro
i2c_core snd_via82xx snd_ac97_codec snd_ac97_bus snd_seq_dummy snd_seq_oss
snd_seq_midi_event snd_seq snd_pcm_oss snd_mixer_oss snd_pcm snd_timer
snd_page_alloc snd_mpu401_uart snd_rawmidi snd_seq_device snd soundcore ext3
jbd
Jan  5 22:45:01 localhost kernel: CPU:    0
Jan  5 22:45:01 localhost kernel: EIP:    0060:[<c0250b08>]    Not tainted
VLI
Jan  5 22:45:01 localhost kernel: EFLAGS: 00013282   (2.6.15-mm1)
Jan  5 22:45:01 localhost kernel: EIP is at
agp_collect_device_status+0x18/0x130
Jan  5 22:45:01 localhost kernel: eax: 00000058   ebx: df8cd008   ecx:
00003092   edx: 00000058
Jan  5 22:45:01 localhost kernel: esi: 00000032   edi: 00000001   ebp:
ddfb3900   esp: d978ceb4
Jan  5 22:45:01 localhost kernel: ds: 007b   es: 007b   ss: 0068
Jan  5 22:45:01 localhost kernel: Process X (pid: 2266, threadinfo=d978c000
task=db21a960)
Jan  5 22:45:01 localhost kernel: Stack: <0>00000000 00000084 00000004
d978cec4 1f000a07 df8cd008 00000032 00000001
Jan  5 22:45:01 localhost kernel:        <0>ddfb3900 c0250ddd df8cd008
1f000201 1f000a07 d978cef0 ddfb3900 1f000a07
Jan  5 22:45:01 localhost kernel:        <0>da0c6060 e14acd9f df8cd008
1f000201 da0c6060 e14ace09 da0c6060 1f000201
Jan  5 22:45:02 localhost kernel: Call Trace:
Jan  5 22:45:02 localhost kernel:  [<c0250ddd>]
agp_generic_enable+0x8d/0x160
Jan  5 22:45:02 localhost kernel:  [<e14acd9f>] drm_agp_enable+0x3f/0x60
[drm]
Jan  5 22:45:04 localhost kernel:  [<e14ace09>]
drm_agp_enable_ioctl+0x49/0x60 [drm]
Jan  5 22:45:05 localhost kernel:  [<e14acdc0>]
drm_agp_enable_ioctl+0x0/0x60 [drm]
Jan  5 22:45:05 localhost kernel:  [<e14a80ba>] drm_ioctl+0xaa/0x216 [drm]
Jan  5 22:45:05 localhost kernel:  [<c0173c41>] do_ioctl+0x81/0x90
Jan  5 22:45:06 localhost kernel:  [<c0173db0>] vfs_ioctl+0x60/0x1f0
Jan  5 22:45:06 localhost kernel:  [<c0173fc8>] sys_ioctl+0x88/0xa0
Jan  5 22:45:06 localhost kernel:  [<c01031a5>] syscall_call+0x7/0xb
Jan  5 22:45:06 localhost kernel: Code: c4 08 89 f2 5b 5e 0f b6 c2 c3 89 f6
8d bc 27 00 00 00 00 83 ec 24 89 5c 24 14 89 74 24 18 89 7c 24 1c 89 6c 24
20 e8 98 ff ff ff <8b> 15 20 00 00 00 8b 0d 10 00 00 00 8d 6c 24 10 0f b6 c0
83 c0
Jan  5 22:45:07 localhost kernel:  <3>[drm:drm_release] *ERROR* Device busy:
1 0
Jan  5 22:45:15 localhost shutdown: shutting down for system reboot

 But because my command line is:
Jan  5 22:39:29 localhost kernel: Kernel command line:
/boot/linux-2.6.15-mm1a.kgz video=vesa keyboard=uk NumLock=on
mouse=/dev/psaux COLS=160 LINES=64 LANG=en  rhgb ro root=/dev/hda3
ide0=0x1f0,0x3f6,14 ide1=0x170,0x376
 those may not count - even if it is unrelated.

 I have:
Jan  5 22:39:29 localhost kernel: Linux version 2.6.15-mm1
(etienne@localhost.localdomain) (gcc version 4.0.1 20050727 (Red Hat
4.0.1-5)) #1 Thu Jan 5 21:25:17 GMT 2006


 The only other strange thing is:
Jan  5 22:39:29 localhost kernel: PCI: Using IRQ router VIA [1106/3177] at
0000:00:11.0
Jan  5 22:39:29 localhost kernel:
Jan  5 22:39:29 localhost kernel: PCI: IRQ 0 for device 0000:00:06.0 doesn't
match PIRQ mask - try pci=usepirqmask
Jan  5 22:39:29 localhost kernel: PCI: Sharing IRQ 5 with 0000:00:10.1
Jan  5 22:39:29 localhost kernel:
Jan  5 22:39:29 localhost kernel: PCI: IRQ 0 for device 0000:00:11.1 doesn't
match PIRQ mask - try pci=usepirqmask
 but it is not new with -mm1.

  Etienne.


	

	
		
___________________________________________________________________________ 
Nouveau : téléphonez moins cher avec Yahoo! Messenger ! Découvez les tarifs exceptionnels pour appeler la France et l'international.
Téléchargez sur http://fr.messenger.yahoo.com
