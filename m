Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267772AbUHMXuL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267772AbUHMXuL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Aug 2004 19:50:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267777AbUHMXuK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Aug 2004 19:50:10 -0400
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:54160 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S267772AbUHMXtt convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Aug 2004 19:49:49 -0400
From: Andy Stewart <andystewart@comcast.net>
Reply-To: andystewart@comcast.net
Organization: Worcester Linux Users' Group
To: linux-kernel@vger.kernel.org
Subject: USB kernel oops 2.6.7
Date: Fri, 13 Aug 2004 19:47:45 -0400
User-Agent: KMail/1.6.2
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Message-Id: <200408131947.55873.andystewart@comcast.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


HI everybody,

When I unplugged my Kodak DC4800 USB camera, I noticed this kernel problem 
in /var/log/messages.  I'm running a stock 2.6.7 kernel compiled for SMP.  
The problem is reproduceable.  Please cc me on any replies, and let me know 
if I can perform experiments, etc. to help isolate this problem.

Thanks!

Andy

=====

Aug 13 19:22:28 tux kernel: ------------[ cut here ]------------
Aug 13 19:22:28 tux kernel: kernel BUG at drivers/usb/storage/usb.c:846!
Aug 13 19:22:28 tux kernel: invalid operand: 0000 [#1]
Aug 13 19:22:28 tux kernel: PREEMPT SMP
Aug 13 19:22:28 tux kernel: Modules linked in: nls_utf8 nls_cp437 usb_storage 
vfat fat mga usbserial lp edd joydev s
g st sr_mod ide_cd cdrom nvram snd_seq_oss snd_pcm_oss snd_mixer_oss 
snd_seq_midi snd_seq_midi_event snd_seq snd_ens
1371 snd_rawmidi snd_seq_device snd_pcm snd_page_alloc snd_timer 
snd_ac97_codec snd soundcore gameport ipv6 ohci_hcd
 8139too mii parport_pc via_agp agpgart parport evdev usbcore dm_mod sym53c8xx 
scsi_transport_spi sd_mod reiserfs ai
c7xxx scsi_mod
Aug 13 19:22:28 tux kernel: CPU:    0
Aug 13 19:22:28 tux kernel: EIP:    0060:
[__crc_xfrm_user_policy+483640/835764]    Not tainted
Aug 13 19:22:28 tux kernel: EIP:    0060:[<e1abf881>]    Not tainted
Aug 13 19:22:28 tux kernel: EFLAGS: 00010202   (2.6.7)
Aug 13 19:22:28 tux kernel: EIP is at usb_stor_release_resources+0xb1/0xc0 
[usb_storage]
Aug 13 19:22:28 tux kernel: eax: dfc99200   ebx: c17dce00   ecx: 00001ade   
edx: dfc9928c
Aug 13 19:22:28 tux kernel: esi: e1acbc40   edi: d27e9800   ebp: d27e9824   
esp: dd399f14
Aug 13 19:22:28 tux kernel: ds: 007b   es: 007b   ss: 0068
Aug 13 19:22:28 tux kernel: Process khubd (pid: 1322, threadinfo=dd398000 
task=dd5682b0)
Aug 13 19:22:28 tux /sbin/hotplug-stopped[0]: hotplugging not enabled. Run 
rchotplug start
Aug 13 19:22:28 tux /sbin/hotplug-stopped[0]: hotplugging not enabled. Run 
rchotplug start
Aug 13 19:22:28 tux kernel: Stack: dfc99258 e0fdb0b5 dfc99268 e1acbc60 
c022b0c6 dfc99268 d27e98d0 c022b1bb
Aug 13 19:22:28 tux kernel:        dfc99268 d27e98d0 c022a3e4 00000001 
d27e9800 e0fe1205 d27e9840 ffffffff
Aug 13 19:22:28 tux kernel:        e0fdbb0a dfe232b8 dd893c00 dfe231b8 
00000002 e0fdda7c 00000003 00000003
Aug 13 19:22:28 tux kernel: Call Trace:
Aug 13 19:22:28 tux kernel:  [__crc_gss_mech_register+1541996/7082694] 
usb_unbind_interface+0x55/0x60 [usbcore]
Aug 13 19:22:28 tux kernel:  [<e0fdb0b5>] usb_unbind_interface+0x55/0x60 
[usbcore]
Aug 13 19:22:28 tux kernel:  [device_release_driver+70/80] 
device_release_driver+0x46/0x50
Aug 13 19:22:28 tux kernel:  [<c022b0c6>] device_release_driver+0x46/0x50
Aug 13 19:22:28 tux kernel:  [bus_remove_device+59/112] 
bus_remove_device+0x3b/0x70
Aug 13 19:22:28 tux kernel:  [<c022b1bb>] bus_remove_device+0x3b/0x70
Aug 13 19:22:28 tux kernel:  [device_del+84/160] device_del+0x54/0xa0
Aug 13 19:22:28 tux kernel:  [<c022a3e4>] device_del+0x54/0xa0
Aug 13 19:22:28 tux kernel:  [__crc_gss_mech_register+1566908/7082694] 
usb_disable_device+0xc5/0xe0 [usbcore]
Aug 13 19:22:28 tux kernel:  [<e0fe1205>] usb_disable_device+0xc5/0xe0 
[usbcore]
Aug 13 19:22:28 tux kernel:  [__crc_gss_mech_register+1544641/7082694] 
usb_disconnect+0x9a/0xd0 [usbcore]
Aug 13 19:22:28 tux kernel:  [<e0fdbb0a>] usb_disconnect+0x9a/0xd0 [usbcore]
Aug 13 19:22:28 tux kernel:  [__crc_gss_mech_register+1552691/7082694] 
hub_port_connect_change+0xac/0x2e0 [usbcore]
Aug 13 19:22:28 tux kernel:  [<e0fdda7c>] hub_port_connect_change+0xac/0x2e0 
[usbcore]
Aug 13 19:22:28 tux kernel:  [__crc_gss_mech_register+1553633/7082694] 
hub_events+0x17a/0x360 [usbcore]
Aug 13 19:22:28 tux kernel:  [<e0fdde2a>] hub_events+0x17a/0x360 [usbcore]
Aug 13 19:22:28 tux kernel:  [__crc_gss_mech_register+1554193/7082694] 
hub_thread+0x4a/0xf0 [usbcore]
Aug 13 19:22:28 tux kernel:  [<e0fde05a>] hub_thread+0x4a/0xf0 [usbcore]
Aug 13 19:22:28 tux kernel:  [default_wake_function+0/16] 
default_wake_function+0x0/0x10
Aug 13 19:22:28 tux kernel:  [<c011e1c0>] default_wake_function+0x0/0x10
Aug 13 19:22:28 tux kernel:  [__crc_gss_mech_register+1554119/7082694] 
hub_thread+0x0/0xf0 [usbcore]
Aug 13 19:22:28 tux kernel:  [<e0fde010>] hub_thread+0x0/0xf0 [usbcore]
Aug 13 19:22:28 tux kernel:  [kernel_thread_helper+5/16] 
kernel_thread_helper+0x5/0x10
Aug 13 19:22:28 tux kernel:  [<c0104275>] kernel_thread_helper+0x5/0x10
Aug 13 19:22:28 tux kernel:
Aug 13 19:22:28 tux kernel: Code: 0f 0b 4e 03 3d 68 ac e1 e9 66 ff ff ff 89 f6 
81 ea 00 a9 ac
Aug 13 19:22:29 tux kernel:  <1>Unable to handle kernel paging request at 
virtual address 64003a65
Aug 13 19:22:29 tux kernel:  printing eip:
Aug 13 19:22:29 tux kernel: e1abed6a
Aug 13 19:22:29 tux kernel: *pde = 00000000
Aug 13 19:22:29 tux kernel: Oops: 0002 [#2]
Aug 13 19:22:29 tux kernel: PREEMPT SMP
Aug 13 19:22:29 tux kernel: Modules linked in: nls_utf8 nls_cp437 usb_storage 
vfat fat mga usbserial lp edd joydev s
g st sr_mod ide_cd cdrom nvram snd_seq_oss snd_pcm_oss snd_mixer_oss 
snd_seq_midi snd_seq_midi_event snd_seq snd_ens
1371 snd_rawmidi snd_seq_device snd_pcm snd_page_alloc snd_timer 
snd_ac97_codec snd soundcore gameport ipv6 ohci_hcd
 8139too mii parport_pc via_agp agpgart parport evdev usbcore dm_mod sym53c8xx 
scsi_transport_spi sd_mod reiserfs ai
c7xxx scsi_mod
Aug 13 19:22:29 tux kernel: CPU:    0
Aug 13 19:22:29 tux kernel: EIP:    0060:
[__crc_xfrm_user_policy+480801/835764]    Not tainted
Aug 13 19:22:29 tux kernel: EIP:    0060:[<e1abed6a>]    Not tainted
Aug 13 19:22:29 tux kernel: EFLAGS: 00010002   (2.6.7)
Aug 13 19:22:29 tux kernel: EIP is at usb_stor_control_thread+0xca/0x2e0 
[usb_storage]
Aug 13 19:22:29 tux kernel: eax: 64003a65   ebx: c17dce00   ecx: c17dce00   
edx: 00000001
Aug 13 19:22:29 tux kernel: esi: dfe75c00   edi: 00000000   ebp: d916c000   
esp: d916dfa8
Aug 13 19:22:29 tux kernel: ds: 007b   es: 007b   ss: 0068
Aug 13 19:22:29 tux kernel: Process usb-storage (pid: 6878, 
threadinfo=d916c000 task=ddb1a1d0)
Aug 13 19:22:29 tux kernel: Stack: c17dcf10 c17dcf24 dfe2f0e0 ddb1a1d0 
dfe2bf80 c0105e36 dfe2f0e0 e1abeca0
Aug 13 19:22:29 tux kernel:        00000000 c17dce00 00000000 00000000 
00000000 00000000 e1abeca0 00000000
Aug 13 19:22:29 tux kernel:        00000000 00000000 c0104275 c17dce00 
00000000 00000000
Aug 13 19:22:29 tux kernel: Call Trace:
Aug 13 19:22:29 tux kernel:  [ret_from_fork+6/32] ret_from_fork+0x6/0x20
Aug 13 19:22:29 tux kernel:  [<c0105e36>] ret_from_fork+0x6/0x20
Aug 13 19:22:29 tux kernel:  [__crc_xfrm_user_policy+480599/835764] 
usb_stor_control_thread+0x0/0x2e0 [usb_storage]
Aug 13 19:22:29 tux kernel:  [<e1abeca0>] usb_stor_control_thread+0x0/0x2e0 
[usb_storage]
Aug 13 19:22:29 tux kernel:  [__crc_xfrm_user_policy+480599/835764] 
usb_stor_control_thread+0x0/0x2e0 [usb_storage]
Aug 13 19:22:29 tux kernel:  [<e1abeca0>] usb_stor_control_thread+0x0/0x2e0 
[usb_storage]
Aug 13 19:22:29 tux kernel:  [kernel_thread_helper+5/16] 
kernel_thread_helper+0x5/0x10
Aug 13 19:22:29 tux kernel:  [<c0104275>] kernel_thread_helper+0x5/0x10
Aug 13 19:22:29 tux kernel:
Aug 13 19:22:29 tux kernel: Code: f0 fe 08 0f 88 19 0d 00 00 8b 93 b8 00 00 00 
81 ba 50 01 00
Aug 13 19:22:29 tux kernel:  <6>note: usb-storage[6878] exited with 
preempt_count 1
Aug 13 19:22:32 tux kernel: usbcore: deregistering driver usb-storage

=====


- -- 
Andy Stewart, Founder
Worcester Linux Users' Group
Worcester, MA  USA
http://www.wlug.org
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFBHVMqHl0iXDssISsRAt5GAJ9s704be1KbUsKP20CM09vHdhOJBACfTS8n
QgatHkZ1Gg73dsMIVGEnKRo=
=bv/0
-----END PGP SIGNATURE-----
