Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966028AbWKIOWT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966028AbWKIOWT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Nov 2006 09:22:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966029AbWKIOWT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Nov 2006 09:22:19 -0500
Received: from vms040pub.verizon.net ([206.46.252.40]:48176 "EHLO
	vms040pub.verizon.net") by vger.kernel.org with ESMTP
	id S966028AbWKIOWS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Nov 2006 09:22:18 -0500
Date: Thu, 09 Nov 2006 09:22:09 -0500
From: Eric Buddington <ebuddington@verizon.net>
Subject: 2.6.19-rc4-mm2: BUG modprobeing sound driver
To: linux-kernel@vger.kernel.org
Reply-to: eric@buddington.net
Message-id: <20061109142208.GA4291@pool-70-109-251-157.wma.east.verizon.net>
Organization: ECS Labs
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 8BIT
Content-disposition: inline
User-Agent: Mutt/1.4.2.1i
X-Eric-conspiracy: there is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel 2.6.19-rc4-mm2 on an Athlon XP / SiS 741 motherboard chipset

In the process of modprobe-ing all the sound modules to figure out
which I needed (is that kosher? Well, I did it anyway), I got the
following BUG. Share and enjoy.

-Eric

-------------------------------------------
[  673.745969] BUG: unable to handle kernel NULL pointer dereference at virtual address 00000064
[  673.745974]  printing eip:
[  673.745977] c02d1ae5
[  673.745979] *pde = 00000000
[  673.745986] Oops: 0000 [#1]
[  673.745988] PREEMPT 
[  673.745992] last sysfs file: /devices/pci0000:00/0000:00:00.0/class
[  673.745996] Modules linked in: snd_serial_u16550 snd_opl4_synth snd_opl4_lib snd_opl3_synth snd_rtctimer rtc snd_seq_dummy snd_ainstr_iw snd_ainstr_fm snd_ainstr_gf1 snd_seq_midi snd_seq_oss snd_pcm_oss snd_mixer_oss snd_tea6330t snd_ak4117 snd_cs5535audio snd_intel8x0 snd_cs4281 snd_sonicvibes snd_atiixp snd_als4000 snd_sb_common snd_fm801 snd_tea575x_tuner videodev v4l1_compat v4l2_common snd_cmipci snd_ymfpci snd_ice1724 snd_ak4114 snd_pt2258 snd_ali5451 snd_rme96 snd_rme32 snd_es1968 snd_intel8x0m snd_es1938 snd_als300 snd_mixart snd_trident_synth snd_seq_instr snd_ainstr_simple snd_trident snd_via82xx_modem snd_ens1371 snd_ens1370 snd_cs46xx snd_ca0106 snd_au8830 snd_au8820 snd_au8810 snd_indigo snd_echo3g snd_mia snd_layla24 snd_layla20 snd_mona snd_darla24 snd_darla20 snd_gina24 snd_gina20 snd_indigoio snd_indigodj snd_bt87x snd_maestro3 snd_azt3328 snd_emu10k1x snd_emu10k1_synth snd_emux_synth snd_seq_virmidi snd_seq_midi_event snd_seq_midi_emul snd_seq snd_emu10k1 snd_util_mem snd_korg1212 snd_ad1889 snd_rme9652 snd_hdsp snd_hdspm snd_atiixp_modem snd_vx222 snd_vx_lib snd_riptide snd_opl3_lib snd_hwdep snd_pcxhr snd_nm256 snd_hda_intel snd_hda_codec snd_ak4531_codec ppp_synctty ppp_async crc_ccitt ppp_generic slhc r128 softdog keyspan_pda usbserial capability commoncap sch_tbf raw1394 dv1394 ohci1394 ieee1394 snd_ice1712 snd_ice17xx_ak4xxx snd_ak4xxx_adda snd_cs8427 snd_i2c snd_via82xx gameport snd_ac97_codec snd_ac97_bus snd_pcm snd_timer snd_page_alloc snd_mpu401_uart snd_rawmidi snd_seq_device snd soundcore sg usb_storage usbhid ff_memless usbnet ohci_hcd uhci_hcd ehci_hcd ipt_tos ipt_owner iptable_nat ipt_MASQUERADE ip_nat ip_conntrack nfnetlink ipt_TOS iptable_filter tsdev iptable_mangle ip_tables joydev x_tables b44 sis900 8139too mii usbmouse usbcore psmouse via drm via_agp agpgart ide_scsi
[  673.746131] CPU:    0
[  673.746133] EIP:    0060:[<c02d1ae5>]    Not tainted VLI
[  673.746135] EFLAGS: 00010246   (2.6.19-rc4-mm2 #1)
[  673.746150] EIP is at device_del+0x8/0x156
[  673.746154] eax: 00000000   ebx: 00000000   ecx: c1aff240   edx: c1679380
[  673.746159] esi: 00000000   edi: 0000ffff   ebp: d0bd9cd0   esp: d0bd9cc4
[  673.746162] ds: 007b   es: 007b   ss: 0068
[  673.746166] Process modprobe (pid: 5689, ti=d0bd8000 task=f50eb1b0 task.ti=d0bd8000)
[  673.746169] Stack: 00000000 d085ee00 0000ffff d0bd9cdc c02d1c3e d085ee00 d0bd9cf4 f8a196e3 
[  673.746177]        d0bd9cf4 f8a19d5b 00000000 00000000 d0bd9d1c f8a19ea4 ee290000 00000286 
[  673.746185]        ee290000 ffffffed 0000ffff ee290000 ffffffed 0000ffff d0bd9d88 f8c18539 
[  673.746192] Call Trace:
[  673.746212]  [<c02d1c3e>] device_unregister+0xb/0x15
[  673.746220]  [<f8a196e3>] snd_card_do_free+0xe6/0xf5 [snd]
[  673.746264]  [<f8a19ea4>] snd_card_free+0x77/0x81 [snd]
[  673.746283]  [<f8c18539>] snd_serial_probe+0x47a/0x528 [snd_serial_u16550]
[  673.746329]  [<c02d49ee>] platform_drv_probe+0xf/0x11
[  673.746339]  [<c02d3682>] really_probe+0x79/0x105
[  673.746349]  [<c02d37a3>] driver_probe_device+0x95/0xa1
[  673.746357]  [<c02d37b7>] __device_attach+0x8/0xa
[  673.746363]  [<c02d2c5d>] bus_for_each_drv+0x37/0x60
[  673.746371]  [<c02d3830>] device_attach+0x62/0x76
[  673.746377]  [<c02d2bd2>] bus_attach_device+0x21/0x42
[  673.746384]  [<c02d1fa1>] device_add+0x2a8/0x3eb
[  673.746390]  [<c02d4ce1>] platform_device_add+0xee/0x11e
[  673.746398]  [<c02d4ede>] platform_device_register_simple+0x35/0x4b
[  673.746405]  [<f8c18079>] alsa_card_serial_init+0x39/0x7f [snd_serial_u16550]
[  673.746416]  [<c013338f>] sys_init_module+0x14aa/0x167d
[  673.746431]  [<c0102e70>] syscall_call+0x7/0xb
[  673.746441] DWARF2 unwinder stuck at syscall_call+0x7/0xb
[  673.746447] Leftover inexact backtrace:
[  673.746450]  =======================
[  673.746452] Code: 00 00 00 75 09 eb 17 89 f8 e8 b3 ff ff ff 89 f2 03 93 98 00 00 00 83 c6 14 83 3a 00 75 e9 5b 5e 5f c9 c3 55 89 e5 57 56 89 c6 53 <8b> 78 64 85 ff 74 08 8d 40 10 e8 a9 65 11 00 8b 96 d0 00 00 00 
[  673.746481] EIP: [<c02d1ae5>] device_del+0x8/0x156 SS:ESP 0068:d0bd9cc4
[  673.746488]  <7>APIC error on CPU0: 02(02)
[  964.354816] APIC error on CPU0: 02(02)
[ 1072.335683] APIC error on CPU0: 02(02)

