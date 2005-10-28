Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030280AbVJ1QKT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030280AbVJ1QKT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 12:10:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030281AbVJ1QKS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 12:10:18 -0400
Received: from xproxy.gmail.com ([66.249.82.197]:58170 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030280AbVJ1QKP convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 12:10:15 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=STPn2v/wZSvw9+4ACZrpZsa26jCdw5+ZDDx1qa+nIfFYhV6B82fWM6j2HK5uNKgoxQjrkPA1PE7mqv0AsjFyUp08+D8W/Z0A9hdJaBORGECOytHnZ0LhtDMX8/m7otkHx7ePpYdNrTHVA0Q7MWbGksAdPgWHllJrkzWaflCWtGc=
Message-ID: <a44ae5cd0510280910v40f16439te92f9a411d25ce19@mail.gmail.com>
Date: Fri, 28 Oct 2005 09:10:14 -0700
From: Miles Lane <miles.lane@gmail.com>
To: LKML <linux-kernel@vger.kernel.org>
Subject: 2.6.14 -- Unable to handle kernel NULL pointer dereference at virtual address 000000b7
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Unable to handle kernel NULL pointer dereference at virtual address 000000b7
 printing eip:
c017cf18
*pde = 00000000
Oops: 0000 [#1]
PREEMPT
Modules linked in: ieee80211_crypt_tkip binfmt_misc acpi_cpufreq
cpufreq_powersave cpufreq_performance cpufreq_conservative pcmcia ipv6
video thermal processor fan container button battery ac af_packet
ohci1394 yenta_socket rsrc_nonstatic pcmcia_core ipw2200 ieee80211
ieee80211_crypt 8139too snd_intel8x0 snd_ac97_codec snd_ac97_bus
snd_pcm_oss snd_mixer_oss snd_pcm snd_timer snd soundcore
snd_page_alloc shpchp pci_hotplug ehci_hcd uhci_hcd usbcore ntfs
nls_iso8859_1 nls_cp437 vfat fat dm_mod sbp2 scsi_mod ieee1394
parport_pc lp parport ide_cd cdrom md_mod
CPU:    0
EIP:    0060:[<c017cf18>]    Not tainted VLI
EFLAGS: 00010206   (2.6.14)
EIP is at __d_lookup+0x62/0x134
eax: 000000b7   ebx: 000000b7   ecx: 14f9c9fe   edx: f0504544
esi: f0504544   edi: f04fb414   ebp: f0c39dc8   esp: f0c39d94
ds: 007b   es: 007b   ss: 0068
Process cupsd (pid: 6393, threadinfo=f0c38000 task=f2a46560)
Stack: f0c39f14 f09e00f4 f24e77a4 14f9c9fe f0504544 f04fb41c f04ffab8 00000001
       00000020 f758302a f758304a f0c39f14 f0c39e44 f0c39dec c0171e69 f04fb414
       f0c39e38 00000001 c18a2240 f758304a f0c39e38 14f9c9fe f0c39e58 c0172751
Call Trace:
 [<c0103e92>] show_stack+0x9a/0xd0
 [<c0104071>] show_registers+0x189/0x21f
 [<c0104284>] die+0xf2/0x18c
 [<c036416a>] do_page_fault+0x1fa/0x661
 [<c0103b3f>] error_code+0x4f/0x54
 [<c0171e69>] do_lookup+0x26/0x94
 [<c0172751>] __link_path_walk+0x87a/0xfa3
 [<c0172ec4>] link_path_walk+0x4a/0xf1
 [<c0173212>] path_lookup+0x9f/0x1ba
 [<c01734bd>] __user_walk+0x2b/0x3f
 [<c016d5ee>] vfs_stat+0x1a/0x4c
 [<c016dbfa>] sys_stat64+0x19/0x32
 [<c010302b>] sysenter_past_esp+0x54/0x75
Code: 9e 8b 0d 84 f2 4c c0 d3 e8 31 c3 23 1d 80 f2 4c c0 01 db 01 db
03 1d 88 f2 4c c0 b8 01 00 00 00 e8 f1 e7 f9 ff 8b 1b 85 db 74 25 <8b>
03 0f 18 00 90 8d 53 e4 89 55 dc 8b 4d d8 3b 4a 28 75 0b 8b
 <6>note: cupsd[6393] exited with preempt_count 1
Debug: sleeping function called from invalid context at
include/linux/rwsem.h:43in_atomic():1, irqs_disabled():0
 [<c0103ee6>] dump_stack+0x1e/0x20
 [<c011c73c>] __might_sleep+0x9e/0xad
 [<c0120dfb>] exit_mm+0x36/0x130
 [<c01218ab>] do_exit+0xe0/0x440
 [<c010431e>] do_divide_error+0x0/0xb3
 [<c036416a>] do_page_fault+0x1fa/0x661
 [<c0103b3f>] error_code+0x4f/0x54
 [<c0171e69>] do_lookup+0x26/0x94
 [<c0172751>] __link_path_walk+0x87a/0xfa3
 [<c0172ec4>] link_path_walk+0x4a/0xf1
 [<c0173212>] path_lookup+0x9f/0x1ba
 [<c01734bd>] __user_walk+0x2b/0x3f
 [<c016d5ee>] vfs_stat+0x1a/0x4c
 [<c016dbfa>] sys_stat64+0x19/0x32
 [<c010302b>] sysenter_past_esp+0x54/0x75
device eth1 entered promiscuous mode
device eth1 left promiscuous mode
device eth1 entered promiscuous mode
Unable to handle kernel NULL pointer dereference at virtual address 000000b7
 printing eip:
c017cf18
*pde = 00000000
Oops: 0000 [#2]
PREEMPT
Modules linked in: ieee80211_crypt_tkip binfmt_misc acpi_cpufreq
cpufreq_powersave cpufreq_performance cpufreq_conservative pcmcia ipv6
video thermal processor fan container button battery ac af_packet
ohci1394 yenta_socket rsrc_nonstatic pcmcia_core ipw2200 ieee80211
ieee80211_crypt 8139too snd_intel8x0 snd_ac97_codec snd_ac97_bus
snd_pcm_oss snd_mixer_oss snd_pcm snd_timer snd soundcore
snd_page_alloc shpchp pci_hotplug ehci_hcd uhci_hcd usbcore ntfs
nls_iso8859_1 nls_cp437 vfat fat dm_mod sbp2 scsi_mod ieee1394
parport_pc lp parport ide_cd cdrom md_mod
CPU:    0
EIP:    0060:[<c017cf18>]    Not tainted VLI
EFLAGS: 00010206   (2.6.14)
EIP is at __d_lookup+0x62/0x134
eax: 000000b7   ebx: 000000b7   ecx: 48cfb62c   edx: f0504544
esi: dc1bff14   edi: dc1bfe44   ebp: dc1bfdc8   esp: dc1bfd94
ds: 007b   es: 007b   ss: 0068
Process updatedb (pid: 6440, threadinfo=dc1be000 task=db059030)
Stack: d7f1e92c fffffff4 f07cf40c 48cfb62c f0504544 c0171bfa f07cf40c 00000001
       0000000a f7582000 f758200a dc1bff14 dc1bfe44 dc1bfdec c0171e69 f05897a4
       dc1bfe38 00000001 c18a2240 f758200a dc1bfe38 48cfb62c dc1bfe58 c0172751
Call Trace:
 [<c0103e92>] show_stack+0x9a/0xd0
 [<c0104071>] show_registers+0x189/0x21f
 [<c0104284>] die+0xf2/0x18c
 [<c036416a>] do_page_fault+0x1fa/0x661
 [<c0103b3f>] error_code+0x4f/0x54
 [<c0171e69>] do_lookup+0x26/0x94
 [<c0172751>] __link_path_walk+0x87a/0xfa3
 [<c0172ec4>] link_path_walk+0x4a/0xf1
 [<c0173212>] path_lookup+0x9f/0x1ba
 [<c01734bd>] __user_walk+0x2b/0x3f
 [<c016d637>] vfs_lstat+0x17/0x49
 [<c016dc2c>] sys_lstat64+0x19/0x32
 [<c010302b>] sysenter_past_esp+0x54/0x75
Code: 9e 8b 0d 84 f2 4c c0 d3 e8 31 c3 23 1d 80 f2 4c c0 01 db 01 db
03 1d 88 f2 4c c0 b8 01 00 00 00 e8 f1 e7 f9 ff 8b 1b 85 db 74 25 <8b>
03 0f 18 00 90 8d 53 e4 89 55 dc 8b 4d d8 3b 4a 28 75 0b 8b
 <6>note: updatedb[6440] exited with preempt_count 1
Debug: sleeping function called from invalid context at
include/linux/rwsem.h:43in_atomic():1, irqs_disabled():0
 [<c0103ee6>] dump_stack+0x1e/0x20
 [<c011c73c>] __might_sleep+0x9e/0xad
 [<c0120dfb>] exit_mm+0x36/0x130
 [<c01218ab>] do_exit+0xe0/0x440
 [<c010431e>] do_divide_error+0x0/0xb3
 [<c036416a>] do_page_fault+0x1fa/0x661
 [<c0103b3f>] error_code+0x4f/0x54
 [<c0171e69>] do_lookup+0x26/0x94
 [<c0172751>] __link_path_walk+0x87a/0xfa3
 [<c0172ec4>] link_path_walk+0x4a/0xf1
 [<c0173212>] path_lookup+0x9f/0x1ba
 [<c01734bd>] __user_walk+0x2b/0x3f
 [<c016d637>] vfs_lstat+0x17/0x49
 [<c016dc2c>] sys_lstat64+0x19/0x32
 [<c010302b>] sysenter_past_esp+0x54/0x75
Unable to handle kernel NULL pointer dereference at virtual address 00000020
 printing eip:
c017cf18
*pde = 00000000
Oops: 0000 [#3]
PREEMPT
Modules linked in: ieee80211_crypt_tkip binfmt_misc acpi_cpufreq
cpufreq_powersave cpufreq_performance cpufreq_conservative pcmcia ipv6
video thermal processor fan container button battery ac af_packet
ohci1394 yenta_socket rsrc_nonstatic pcmcia_core ipw2200 ieee80211
ieee80211_crypt 8139too snd_intel8x0 snd_ac97_codec snd_ac97_bus
snd_pcm_oss snd_mixer_oss snd_pcm snd_timer snd soundcore
snd_page_alloc shpchp pci_hotplug ehci_hcd uhci_hcd usbcore ntfs
nls_iso8859_1 nls_cp437 vfat fat dm_mod sbp2 scsi_mod ieee1394
parport_pc lp parport ide_cd cdrom md_mod
CPU:    0
EIP:    0060:[<c017cf18>]    Not tainted VLI
EFLAGS: 00010202   (2.6.14)
EIP is at __d_lookup+0x62/0x134
eax: 00000020   ebx: 00000020   ecx: f84e478c   edx: f05041b4
esi: dea3bf14   edi: dea3be44   ebp: dea3bdc8   esp: dea3bd94
ds: 007b   es: 007b   ss: 0068
Process ls (pid: 6608, threadinfo=dea3a000 task=db059560)
Stack: d70c5108 fffffff4 d77d00e8 f84e478c f05041b4 d77d2ecc d77d00e8 00000001
       0000000b f756901b f7569026 dea3bf14 dea3be44 dea3bdec c0171e69 d77d2ec4
       dea3be38 00000001 c18a2240 f7569026 dea3be38 f84e478c dea3be58 c0172751
Call Trace:
 [<c0103e92>] show_stack+0x9a/0xd0
 [<c0104071>] show_registers+0x189/0x21f
 [<c0104284>] die+0xf2/0x18c
 [<c036416a>] do_page_fault+0x1fa/0x661
 [<c0103b3f>] error_code+0x4f/0x54
 [<c0171e69>] do_lookup+0x26/0x94
 [<c0172751>] __link_path_walk+0x87a/0xfa3
 [<c0172ec4>] link_path_walk+0x4a/0xf1
 [<c0173212>] path_lookup+0x9f/0x1ba
 [<c01734bd>] __user_walk+0x2b/0x3f
 [<c016d5ee>] vfs_stat+0x1a/0x4c
 [<c016dbfa>] sys_stat64+0x19/0x32
 [<c010302b>] sysenter_past_esp+0x54/0x75
Code: 9e 8b 0d 84 f2 4c c0 d3 e8 31 c3 23 1d 80 f2 4c c0 01 db 01 db
03 1d 88 f2 4c c0 b8 01 00 00 00 e8 f1 e7 f9 ff 8b 1b 85 db 74 25 <8b>
03 0f 18 00 90 8d 53 e4 89 55 dc 8b 4d d8 3b 4a 28 75 0b 8b
 <6>note: ls[6608] exited with preempt_count 1
Debug: sleeping function called from invalid context at
include/linux/rwsem.h:43in_atomic():1, irqs_disabled():0
 [<c0103ee6>] dump_stack+0x1e/0x20
 [<c011c73c>] __might_sleep+0x9e/0xad
 [<c0120dfb>] exit_mm+0x36/0x130
 [<c01218ab>] do_exit+0xe0/0x440
 [<c010431e>] do_divide_error+0x0/0xb3
 [<c036416a>] do_page_fault+0x1fa/0x661
 [<c0103b3f>] error_code+0x4f/0x54
 [<c0171e69>] do_lookup+0x26/0x94
 [<c0172751>] __link_path_walk+0x87a/0xfa3
 [<c0172ec4>] link_path_walk+0x4a/0xf1
 [<c0173212>] path_lookup+0x9f/0x1ba
 [<c01734bd>] __user_walk+0x2b/0x3f
 [<c016d5ee>] vfs_stat+0x1a/0x4c
 [<c016dbfa>] sys_stat64+0x19/0x32
 [<c010302b>] sysenter_past_esp+0x54/0x75
