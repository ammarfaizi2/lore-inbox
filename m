Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422659AbVKZQGs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422659AbVKZQGs (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Nov 2005 11:06:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422660AbVKZQGs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Nov 2005 11:06:48 -0500
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:19771 "EHLO
	pd5mo1so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S1422659AbVKZQGr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Nov 2005 11:06:47 -0500
Date: Sat, 26 Nov 2005 09:06:43 -0700
From: Duane Evenson <duane-maillists@shaw.ca>
Subject: system freezes
To: linux-kernel@vger.kernel.org
Message-id: <43888813.1030402@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; format=flowed; charset=ISO-8859-1
Content-transfer-encoding: 7bit
X-Accept-Language: en-us, en
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My system keeps freezing. This has been an issue since I moved to 2.6.x.
I've tried various 2.6 kernels and various rebuilds.

I don't know enough to know even where the problem is originating
although it seems somewhere in memory management.

Any help would be greatly appreciated!

Here is the kernel log information:
========================================================================
Nov 21 09:03:53 dave kernel: ------------[ cut here ]------------
Nov 21 09:03:53 dave kernel: kernel BUG at include/linux/list.h:165!
Nov 21 09:03:53 dave kernel: invalid operand: 0000 [#1]
Nov 21 09:03:53 dave kernel: Modules linked in: nvidia(U) sd_mod(U)
usb_storage(U) scsi_mod(U) usbhid(U) parport_pc(U) lp(U) parport(U)
md5(U) ipv6(U) w83627hf(U) hwmon_vid(U) hwmon(U) i2c_isa(U)
ipt_TCPMSS(U) ipt_limit(U) ip_nat_irc(U) ip_nat_ftp(U) iptable_mangle(U)
ipt_LOG(U) ipt_TOS(U) ipt_REJECT(U) ip_conntrack_irc(U)
ip_conntrack_ftp(U) ipt_state(U) iptable_filter(U) ipt_MASQUERADE(U)
iptable_nat(U) ip_nat(U) ip_conntrack(U) nfnetlink(U) ip_tables(U)
vfat(U) fat(U) video(U) thermal(U) processor(U) fan(U) button(U)
uhci_hcd(U) tuner(U) tvaudio(U) bttv(U) video_buf(U) firmware_class(U)
v4l2_common(U) btcx_risc(U) tveeprom(U) videodev(U) snd_bt87x(U)
via_agp(U) agpgart(U) i2c_viapro(U) snd_ens1371(U) gameport(U)
snd_rawmidi(U) snd_ac97_codec(U) snd_seq_dummy(U) snd_seq_oss(U)
snd_seq_midi_event(U) snd_seq(U) snd_seq_device(U) snd_pcm_oss(U)
snd_mixer_oss(U) snd_pcm(U) snd_timer(U) snd(U) soundcore(U)
snd_page_alloc(U) snd_ac97_bus(U) sundance(U) 3c59x(U) mii(U) floppy(U)
Nov 21 09:03:53 dave kernel: CPU:    0
Nov 21 09:03:53 dave kernel: EIP:    0060:[<c0144c2b>]    Tainted: P
   VLI
Nov 21 09:03:53 dave kernel: EFLAGS: 00010096   (2.6.14-prep)
Nov 21 09:03:53 dave kernel: EIP is at free_block+0xdb/0xf0
Nov 21 09:03:53 dave kernel: eax: 00556d80   ebx: eab6cb74   ecx:
eab6c000   edx: c43d6000
Nov 21 09:03:53 dave kernel: esi: f7ffdbe0   edi: f7fffc00   ebp:
00000013   esp: f7c35dec
Nov 21 09:03:53 dave kernel: ds: 007b   es: 007b   ss: 0068
Nov 21 09:03:53 dave kernel: Process kswapd0 (pid: 116,
threadinfo=f7c34000 task=c19a9570)
Nov 21 09:03:53 dave kernel: Stack: badc0ded f7d28168 0000003c f7ff9610
f7fffc00 00000286 c43d6904 f7ff9610
Nov 21 09:03:53 dave kernel:        c0144cdb 00000000 f7ff9600 f7ffeb80
0000003c f7ff9600 00000286 c43d6904
Nov 21 09:03:53 dave kernel:        f7c35f7c c0144e9f c43d6934 00000001
f7c35f14 c015e6f4 c015e578 c43d6814
Nov 21 09:03:53 dave kernel: Call Trace:
Nov 21 09:03:53 dave kernel:  [<c0144cdb>] cache_flusharray+0x9b/0xe0
Nov 21 09:03:53 dave kernel:  [<c0144e9f>] kmem_cache_free+0x3f/0x50
Nov 21 09:03:53 dave kernel:  [<c015e6f4>] free_buffer_head+0x14/0x30
Nov 21 09:03:53 dave kernel:  [<c015e578>] try_to_free_buffers+0x48/0x80
Nov 21 09:03:53 dave kernel:  [<c01471fa>] shrink_list+0x3ba/0x440
Nov 21 09:03:53 dave kernel:  [<c014742f>] shrink_cache+0xdf/0x290
Nov 21 09:03:53 dave kernel:  [<c01479f8>] shrink_zone+0x88/0xe0
Nov 21 09:03:53 dave kernel:  [<c0147e5e>] balance_pgdat+0x1fe/0x3e0
Nov 21 09:03:53 dave kernel:  [<c014810c>] kswapd+0xcc/0x110
Nov 21 09:03:53 dave kernel:  [<c012d1a0>] autoremove_wake_function+0x0/0x50
Nov 21 09:03:53 dave kernel:  [<c0148040>] kswapd+0x0/0x110
Nov 21 09:03:53 dave kernel:  [<c0101349>] kernel_thread_helper+0x5/0xc
Nov 21 09:03:53 dave kernel: Code: 84 6f ff ff ff 8b 46 04 89 31 89 4e
04 89 08 89 41 04 e9 77 ff ff ff 2b 47 1c 89 ca 89 46 18 89 f8 e8 4a ef
ff ff e9 63 ff ff ff <0f> 0b a5 00 5f fe 2d c0 eb 8c 0f 0b a6 00 5f fe
2d c0 eb 89 90
Nov 21 09:15:02 dave kernel:  ------------[ cut here ]------------
Nov 21 09:15:02 dave kernel: kernel BUG at include/linux/list.h:165!
Nov 21 09:15:02 dave kernel: invalid operand: 0000 [#2]
Nov 21 09:15:02 dave kernel: Modules linked in: nvidia(U) sd_mod(U)
usb_storage(U) scsi_mod(U) usbhid(U) parport_pc(U) lp(U) parport(U)
md5(U) ipv6(U) w83627hf(U) hwmon_vid(U) hwmon(U) i2c_isa(U)
ipt_TCPMSS(U) ipt_limit(U) ip_nat_irc(U) ip_nat_ftp(U) iptable_mangle(U)
ipt_LOG(U) ipt_TOS(U) ipt_REJECT(U) ip_conntrack_irc(U)
ip_conntrack_ftp(U) ipt_state(U) iptable_filter(U) ipt_MASQUERADE(U)
iptable_nat(U) ip_nat(U) ip_conntrack(U) nfnetlink(U) ip_tables(U)
vfat(U) fat(U) video(U) thermal(U) processor(U) fan(U) button(U)
uhci_hcd(U) tuner(U) tvaudio(U) bttv(U) video_buf(U) firmware_class(U)
v4l2_common(U) btcx_risc(U) tveeprom(U) videodev(U) snd_bt87x(U)
via_agp(U) agpgart(U) i2c_viapro(U) snd_ens1371(U) gameport(U)
snd_rawmidi(U) snd_ac97_codec(U) snd_seq_dummy(U) snd_seq_oss(U)
snd_seq_midi_event(U) snd_seq(U) snd_seq_device(U) snd_pcm_oss(U)
snd_mixer_oss(U) snd_pcm(U) snd_timer(U) snd(U) soundcore(U)
snd_page_alloc(U) snd_ac97_bus(U) sundance(U) 3c59x(U) mii(U) floppy(U)
Nov 21 09:15:02 dave kernel: CPU:    0
Nov 21 09:15:02 dave kernel: EIP:    0060:[<c0144c2b>]    Tainted: P
   VLI
Nov 21 09:15:02 dave kernel: EFLAGS: 00010086   (2.6.14-prep)
Nov 21 09:15:02 dave kernel: EIP is at free_block+0xdb/0xf0
Nov 21 09:15:02 dave kernel: eax: 00322f00   ebx: d9178c64   ecx:
d9178000   edx: ce268000
Nov 21 09:15:02 dave kernel: esi: f7ffdbe0   edi: f7fffc00   ebp:
00000038   esp: c492bd08
Nov 21 09:15:02 dave kernel: ds: 007b   es: 007b   ss: 0068
Nov 21 09:15:02 dave kernel: Process mrtg (pid: 24967,
threadinfo=c492a000 task=c27e5590)
Nov 21 09:15:02 dave kernel: Stack: badc0ded 0000000e 0000003c f7ff9610
f7fffc00 00000292 d9178f04 f7ff9610
Nov 21 09:15:02 dave kernel:        c0144cdb 00000000 f7ff9600 f7ffeb80
0000003c f7ff9600 00000292 d9178f04
Nov 21 09:15:02 dave kernel:        c492be80 c0144e9f d9178f34 00000001
c492be30 c015e6f4 c015e578 d9178f04
Nov 21 09:15:02 dave kernel: Call Trace:
Nov 21 09:15:02 dave kernel:  [<c0144cdb>] cache_flusharray+0x9b/0xe0
Nov 21 09:15:02 dave kernel:  [<c0144e9f>] kmem_cache_free+0x3f/0x50
Nov 21 09:15:02 dave kernel:  [<c015e6f4>] free_buffer_head+0x14/0x30
Nov 21 09:15:02 dave kernel:  [<c015e578>] try_to_free_buffers+0x48/0x80
Nov 21 09:15:02 dave kernel:  [<c01471fa>] shrink_list+0x3ba/0x440
Nov 21 09:15:02 dave kernel:  [<c014759d>] shrink_cache+0x24d/0x290
Nov 21 09:15:02 dave kernel:  [<c01479f8>] shrink_zone+0x88/0xe0
Nov 21 09:15:02 dave kernel:  [<c0147aa7>] shrink_caches+0x57/0x70
Nov 21 09:15:02 dave kernel:  [<c0147b91>] try_to_free_pages+0xd1/0x1a0
Nov 21 09:15:02 dave kernel:  [<c0140af3>] __alloc_pages+0x1e3/0x410
Nov 21 09:15:02 dave kernel:  [<c014b9be>] do_anonymous_page+0x7e/0x160
Nov 21 09:15:02 dave kernel:  [<c014bcc4>] do_no_page+0x224/0x3a0
Nov 21 09:15:02 dave kernel:  [<c014c08c>] __handle_mm_fault+0x15c/0x1a0
Nov 21 09:15:02 dave kernel:  [<c02cecf9>] do_page_fault+0x259/0x65a
Nov 21 09:15:02 dave kernel:  [<c02ceaa0>] do_page_fault+0x0/0x65a
Nov 21 09:15:02 dave kernel:  [<c0103bc7>] error_code+0x4f/0x54
Nov 21 09:15:02 dave kernel: Code: 84 6f ff ff ff 8b 46 04 89 31 89 4e
04 89 08 89 41 04 e9 77 ff ff ff 2b 47 1c 89 ca 89 46 18 89 f8 e8 4a ef
ff ff e9 63 ff ff ff <0f> 0b a5 00 5f fe 2d c0 eb 8c 0f 0b a6 00 5f fe
2d c0 eb 89 90
Nov 21 09:15:37 dave kernel:  <1>Unable to handle kernel paging request
at virtual address 10101014
Nov 21 09:15:37 dave kernel:  printing eip:
Nov 21 09:15:37 dave kernel: c0144bc3
Nov 21 09:15:37 dave kernel: *pde = 00000000
Nov 21 09:15:37 dave kernel: Oops: 0000 [#3]
Nov 21 09:15:37 dave kernel: Modules linked in: nvidia(U) sd_mod(U)
usb_storage(U) scsi_mod(U) usbhid(U) parport_pc(U) lp(U) parport(U)
md5(U) ipv6(U) w83627hf(U) hwmon_vid(U) hwmon(U) i2c_isa(U)
ipt_TCPMSS(U) ipt_limit(U) ip_nat_irc(U) ip_nat_ftp(U) iptable_mangle(U)
ipt_LOG(U) ipt_TOS(U) ipt_REJECT(U) ip_conntrack_irc(U)
ip_conntrack_ftp(U) ipt_state(U) iptable_filter(U) ipt_MASQUERADE(U)
iptable_nat(U) ip_nat(U) ip_conntrack(U) nfnetlink(U) ip_tables(U)
vfat(U) fat(U) video(U) thermal(U) processor(U) fan(U) button(U)
uhci_hcd(U) tuner(U) tvaudio(U) bttv(U) video_buf(U) firmware_class(U)
v4l2_common(U) btcx_risc(U) tveeprom(U) videodev(U) snd_bt87x(U)
via_agp(U) agpgart(U) i2c_viapro(U) snd_ens1371(U) gameport(U)
snd_rawmidi(U) snd_ac97_codec(U) snd_seq_dummy(U) snd_seq_oss(U)
snd_seq_midi_event(U) snd_seq(U) snd_seq_device(U) snd_pcm_oss(U)
snd_mixer_oss(U) snd_pcm(U) snd_timer(U) snd(U) soundcore(U)
snd_page_alloc(U) snd_ac97_bus(U) sundance(U) 3c59x(U) mii(U) floppy(U)
Nov 21 09:15:37 dave kernel: CPU:    0
Nov 21 09:15:37 dave kernel: EIP:    0060:[<c0144bc3>]    Tainted: P
   VLI
Nov 21 09:15:37 dave kernel: EFLAGS: 00010046   (2.6.14-prep)
Nov 21 09:15:37 dave kernel: EIP is at free_block+0x73/0xf0
Nov 21 09:15:37 dave kernel: eax: 10101010   ebx: ce268904   ecx:
ce268000   edx: cebb1000
Nov 21 09:15:37 dave kernel: esi: f7ffdbe0   edi: f7fffc00   ebp:
0000000e   esp: e63e7ba8
Nov 21 09:15:37 dave kernel: ds: 007b   es: 007b   ss: 0068
Nov 21 09:15:37 dave kernel: Process mencoder (pid: 24947,
threadinfo=e63e6000 task=c1a37070)
Nov 21 09:15:37 dave kernel: Stack: badc0ded f7d28168 0000003c f7ff9610
f7fffc00 00000292 cebb1484 f7ff9610
Nov 21 09:15:37 dave kernel:        c0144cdb 00000000 f7ff9600 f7ffeb80
0000003c f7ff9600 00000292 cebb1484
Nov 21 09:15:37 dave kernel:        e63e7d20 c0144e9f cebb14b4 00000001
e63e7cd0 c015e6f4 c015e578 cebb14

========================================================================
Hardware:
	ABit KX7-333R motherboard (VIA KT333, VT8233A, HPT372, W83697HF)
	AMD 2000XP CPU
	nVidia Video (MX420 GPU)
	Conexant Fusion 878A TV capture card
	a couple trouble-free NICs and a few HD's, CDRW, DVDRW, Sound Blaster
PCI 128

System:
	mostly Fedora 4

Kernel:
	currently 2.6.14 (kernel-2.6.14-1.1637_FC4)
	recompiled and optimized for my system (AMD CPU and removing unneeded
drivers).

Other:
	installed nVidia's video drivers for X


